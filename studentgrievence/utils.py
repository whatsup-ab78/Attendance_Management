import datetime
from collections import defaultdict
from .models import *

MIN_HOURS = 6.5

# Define 6 time slots with 10-minute late tolerance
SLOTS = {
    1: {"start": "09:00", "end": "10:00", "late_cutoff": "09:10", "name": "9:00-10:00"},
    2: {"start": "10:00", "end": "11:00", "late_cutoff": "10:10", "name": "10:00-11:00"},
    3: {"start": "11:00", "end": "12:00", "late_cutoff": "11:10", "name": "11:00-12:00"},
    4: {"start": "12:00", "end": "13:00", "late_cutoff": "12:10", "name": "12:00-13:00"},
    5: {"start": "14:00", "end": "15:00", "late_cutoff": "14:10", "name": "14:00-15:00"},
    6: {"start": "15:00", "end": "16:00", "late_cutoff": "15:10", "name": "15:00-16:00"},
}


def calculate_slot_attendance(uid):
    """
    Calculate attendance for 6 slots based on entry/exit times per slot.
    Students can enter and exit multiple times per day (once per slot).
    """
    records = (
        student_attendance.objects
        .filter(st_id=uid)
        .order_by('date', 'slot', 'time')
    )

    # Group records by date and slot
    daily_slot_data = defaultdict(lambda: defaultdict(lambda: {'entries': [], 'exits': []}))

    for r in records:
        if isinstance(r.date, str):
            date_obj = datetime.datetime.strptime(r.date, "%Y-%m-%d").date()
        else:
            date_obj = r.date

        time_obj = r.time
        slot = r.slot if r.slot else 0

        if r.status.lower() == 'entry':
            daily_slot_data[date_obj][slot]['entries'].append(time_obj)
        elif r.status.lower() == 'exit':
            daily_slot_data[date_obj][slot]['exits'].append(time_obj)

    # Calculate slot attendance for each day
    slot_report = []
    
    for date in sorted(daily_slot_data.keys()):
        slots_status = {}
        present_count = 0
        
        for slot_num in range(1, 7):  # Slots 1-6
            slot_info = SLOTS[slot_num]
            late_cutoff = datetime.datetime.strptime(slot_info["late_cutoff"], "%H:%M").time()
            
            slot_data = daily_slot_data[date].get(slot_num, {'entries': [], 'exits': []})
            
            if slot_data['entries']:
                entry_time = min(slot_data['entries'])
                exit_time = max(slot_data['exits']) if slot_data['exits'] else None
                
                # Check if late (more than 10 minutes after slot start)
                if entry_time <= late_cutoff:
                    status = 'Present'
                    present_count += 1
                else:
                    status = 'Absent (Late)'
                
                slots_status[slot_num] = {
                    'status': status,
                    'entry': entry_time.strftime("%H:%M:%S"),
                    'exit': exit_time.strftime("%H:%M:%S") if exit_time else 'Not marked'
                }
            else:
                slots_status[slot_num] = {
                    'status': 'Absent',
                    'entry': '-',
                    'exit': '-'
                }
        
        # Get overall entry and exit times for the day
        all_entries = []
        all_exits = []
        for slot_num in range(1, 7):
            slot_data = daily_slot_data[date].get(slot_num, {'entries': [], 'exits': []})
            all_entries.extend(slot_data['entries'])
            all_exits.extend(slot_data['exits'])
        
        first_entry = min(all_entries).strftime("%H:%M:%S") if all_entries else '-'
        last_exit = max(all_exits).strftime("%H:%M:%S") if all_exits else '-'
        
        slot_report.append({
            'date': date,
            'entry_time': first_entry,
            'exit_time': last_exit,
            'slots': slots_status,
            'present_count': present_count,
            'total_slots': 6,
            'overall_status': 'Present' if present_count >= 5 else 'Absent'  # Need 5/6 slots
        })

    return slot_report


def calculate_daily_hours_with_status(uid):
    """Legacy function for hour-based calculation"""
    records = (
        student_attendance.objects
        .filter(st_id=uid)
        .order_by('date', 'time')
    )

    daily_seconds = defaultdict(int)
    entry_time = None
    current_date = None

    for r in records:
        if isinstance(r.date, str):
            date_obj = datetime.datetime.strptime(r.date, "%Y-%m-%d").date()
        else:
            date_obj = r.date

        time_obj = r.time

        if r.status.lower() == 'entry':
            entry_time = datetime.datetime.combine(date_obj, time_obj)
            current_date = date_obj

        elif r.status.lower() == 'exit' and entry_time:
            exit_time = datetime.datetime.combine(date_obj, time_obj)
            diff = (exit_time - entry_time).total_seconds()
            if diff > 0:
                daily_seconds[current_date] += diff
            entry_time = None
            current_date = None

    daily_report = []
    for day, seconds in daily_seconds.items():
        hours = round(seconds / 3600, 2)
        status = "Present" if hours >= MIN_HOURS else "Absent"
        daily_report.append({
            "date": day,
            "hours": hours,
            "status": status
        })

    return daily_report



def calculate_slot_attendance_teacher(start_date=None, end_date=None, department=None, student_id=None):
    """
    Calculate slot-based attendance for students (teacher view).
    If department is provided, only students from that department are included.
    If student_id is provided, only that student's records are included.
    
    Args:
        start_date: Start date for filtering (optional)
        end_date: End date for filtering (optional)
        department: Department to filter students by (optional)
        student_id: Specific student ID to filter (optional)
    """
    # Filter students by department if provided
    student_query = students.objects.all()
    if department:
        student_query = student_query.filter(st_department=department)
    
    if student_id:
        student_query = student_query.filter(id=student_id)
    
    # Get IDs of relevant students
    student_ids = [str(s.id) for s in student_query]
    
    query = student_attendance.objects.filter(st_id__in=student_ids)
    
    # Apply date filters if provided
    if start_date:
        query = query.filter(date__gte=start_date)
    if end_date:
        query = query.filter(date__lte=end_date)
    
    records = query.order_by('st_id', 'date', 'slot', 'time')


    # Group by student, date, and slot
    student_daily_slot_data = defaultdict(
        lambda: defaultdict(
            lambda: defaultdict(lambda: {'entries': [], 'exits': []})
        )
    )

    for r in records:
        if isinstance(r.date, str):
            date_obj = datetime.datetime.strptime(r.date, "%Y-%m-%d").date()
        else:
            date_obj = r.date

        time_obj = r.time
        slot = r.slot if r.slot else 0

        if r.status.lower() == 'entry':
            student_daily_slot_data[r.st_id][date_obj][slot]['entries'].append(time_obj)
        elif r.status.lower() == 'exit':
            student_daily_slot_data[r.st_id][date_obj][slot]['exits'].append(time_obj)

    # Get student names from our filtered list
    student_names = {
        str(s.id): s.st_name for s in student_query
    }

    # Calculate slot attendance
    report = []
    
    for st_id, dates in student_daily_slot_data.items():
        for date, slots_data in sorted(dates.items()):
            slot_statuses = {}
            present_count = 0
            
            # Get entry/exit times for display
            all_entries = []
            all_exits = []
            
            for slot_num in range(1, 7):
                slot_info = SLOTS[slot_num]
                late_cutoff = datetime.datetime.strptime(slot_info["late_cutoff"], "%H:%M").time()
                
                slot_data = slots_data.get(slot_num, {'entries': [], 'exits': []})
                
                if slot_data['entries']:
                    all_entries.extend(slot_data['entries'])
                    all_exits.extend(slot_data['exits'])
                    
                    entry_time = min(slot_data['entries'])
                    
                    # Check if late
                    if entry_time <= late_cutoff:
                        slot_statuses[slot_num] = 'P'  # Present
                        present_count += 1
                    else:
                        slot_statuses[slot_num] = 'L'  # Late (counts as absent)
                else:
                    slot_statuses[slot_num] = 'A'  # Absent
            
            first_entry = min(all_entries).strftime("%H:%M") if all_entries else '-'
            last_exit = max(all_exits).strftime("%H:%M") if all_exits else '-'
            
            # Determine which slots were absent
            absent_slots = [num for num, status in slot_statuses.items() if status in ('A', 'L')]
            
            report.append({
                'student': student_names.get(str(st_id), st_id),
                'st_id': st_id,
                'date': date,
                'entry': first_entry,
                'exit': last_exit,
                'slot_1': slot_statuses.get(1, 'A'),
                'slot_2': slot_statuses.get(2, 'A'),
                'slot_3': slot_statuses.get(3, 'A'),
                'slot_4': slot_statuses.get(4, 'A'),
                'slot_5': slot_statuses.get(5, 'A'),
                'slot_6': slot_statuses.get(6, 'A'),
                'absent_slots': absent_slots,
                'present_count': present_count,
                'status': 'Present' if present_count >= 5 else 'Absent'
            })

    return report


def calculate_daily_hours_teacher():
    """Legacy function for teacher view with hours"""
    records = (
        student_attendance.objects
        .all()
        .order_by('st_id', 'date', 'time')
    )

    data = defaultdict(lambda: defaultdict(int))
    entry_map = {}

    for r in records:
        if isinstance(r.date, str):
            date_obj = datetime.datetime.strptime(r.date, "%Y-%m-%d").date()
        else:
            date_obj = r.date

        time_obj = r.time
        key = (r.st_id, date_obj)

        if r.status.lower() == 'entry':
            entry_map[key] = datetime.datetime.combine(date_obj, time_obj)
        elif r.status.lower() == 'exit' and key in entry_map:
            exit_time = datetime.datetime.combine(date_obj, time_obj)
            diff = (exit_time - entry_map[key]).total_seconds()
            if diff > 0:
                data[r.st_id][date_obj] += diff
            del entry_map[key]

    student_names = {
        str(s.id): s.st_name for s in students.objects.all()
    }

    report = []
    for st_id, days in data.items():
        for day, seconds in days.items():
            hours = round(seconds / 3600, 2)
            status = "Present" if hours >= MIN_HOURS else "Absent"
            report.append({
                "student": student_names.get(str(st_id), st_id),
                "date": day,
                "hours": hours,
                "status": status
            })

    return report



