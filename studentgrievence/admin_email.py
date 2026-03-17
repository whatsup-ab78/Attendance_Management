"""
Admin attendance summary email functionality
Sends daily attendance report to admin upon login
"""
from django.core.mail import send_mail
from django.conf import settings
from studentgrievence.models import students, student_attendance
from datetime import date
from collections import defaultdict


def generate_admin_attendance_summary(summary_date=None):
    """
    Generate attendance summary for admin
    
    Args:
        summary_date: Date to generate summary for (defaults to today)
    
    Returns:
        Dictionary with summary data
    """
    if summary_date is None:
        summary_date = date.today()
    
    # Get all students
    all_students = students.objects.all()
    total_students = all_students.count()
    
    # Track attendance stats
    present_students = []
    absent_students = []
    late_students = []
    
    slot_times = {
        1: "9:00-10:00 AM",
        2: "10:00-11:00 AM",
        3: "11:00-12:00 PM",
        4: "12:00-1:00 PM",
        5: "2:00-3:00 PM",
        6: "3:00-4:00 PM"
    }
    
    for student in all_students:
        # Get attendance records for the date
        records = student_attendance.objects.filter(
            st_id=str(student.id),
            date=summary_date
        )
        
        # Track which slots have entries
        slots_present = set()
        has_late_entry = False
        
        for record in records:
            if record.status.lower() == 'entry' and record.slot:
                # Check if entry was on time
                from datetime import datetime
                late_cutoff_times = {
                    1: "09:10", 2: "10:10", 3: "11:10",
                    4: "12:10", 5: "14:10", 6: "15:10"
                }
                
                entry_time = record.time
                late_cutoff = datetime.strptime(late_cutoff_times[record.slot], "%H:%M").time()
                
                if entry_time <= late_cutoff:
                    slots_present.add(record.slot)
                else:
                    has_late_entry = True
        
        # Categorize student
        present_count = len(slots_present)
        
        if present_count >= 5:
            present_students.append({
                'name': student.st_name,
                'slots': present_count,
                'department': student.st_department
            })
        else:
            absent_students.append({
                'name': student.st_name,
                'slots': present_count,
                'department': student.st_department
            })
            
        if has_late_entry:
            late_students.append(student.st_name)
    
    # Calculate percentages
    present_count = len(present_students)
    absent_count = len(absent_students)
    attendance_percentage = (present_count / total_students * 100) if total_students > 0 else 0
    
    return {
        'date': summary_date,
        'total_students': total_students,
        'present_count': present_count,
        'absent_count': absent_count,
        'late_count': len(late_students),
        'attendance_percentage': round(attendance_percentage, 1),
        'present_students': present_students,
        'absent_students': absent_students,
        'late_students': late_students
    }


def send_admin_attendance_email(admin_email, summary_date=None):
    """
    Send attendance summary email to admin
    
    Args:
        admin_email: Admin's email address
        summary_date: Date to generate summary for (defaults to today)
    
    Returns:
        Boolean indicating success
    """
    try:
        summary = generate_admin_attendance_summary(summary_date)
        
        # Format present students list
        present_list = "\n".join([
            f"  • {s['name']} ({s['department']}) - {s['slots']}/6 slots"
            for s in summary['present_students'][:10]  # Show first 10
        ])
        
        if len(summary['present_students']) > 10:
            present_list += f"\n  ... and {len(summary['present_students']) - 10} more"
        
        # Format absent students list
        absent_list = "\n".join([
            f"  • {s['name']} ({s['department']}) - {s['slots']}/6 slots"
            for s in summary['absent_students'][:10]  # Show first 10
        ])
        
        if len(summary['absent_students']) > 10:
            absent_list += f"\n  ... and {len(summary['absent_students']) - 10} more"
        
        # Create email subject
        subject = f"Daily Attendance Summary - {summary['date']}"
        
        # Create email message
        message = f"""
Daily Attendance Summary Report
================================

Date: {summary['date']}
Generated: {date.today()} (Login Time)

OVERVIEW
--------
Total Students: {summary['total_students']}
Present: {summary['present_count']} ({summary['attendance_percentage']}%)
Absent: {summary['absent_count']}
Late Entries: {summary['late_count']}

PRESENT STUDENTS ({summary['present_count']})
{'-' * 40}
{present_list if present_list else '  None'}

ABSENT STUDENTS ({summary['absent_count']})
{'-' * 40}
{absent_list if absent_list else '  None'}

ATTENDANCE CRITERIA
-------------------
• Present: 5 or more slots attended (out of 6)
• Absent: Less than 5 slots attended
• Late: Entry more than 10 minutes after slot start

SLOT TIMINGS
------------
Slot 1: 9:00-10:00 AM
Slot 2: 10:00-11:00 AM
Slot 3: 11:00-12:00 PM
Slot 4: 12:00-1:00 PM
Slot 5: 2:00-3:00 PM
Slot 6: 3:00-4:00 PM

This is an automated report sent upon admin login.

---
Attendance Management System
"""
        
        # Send email
        send_mail(
            subject=subject,
            message=message,
            from_email=settings.DEFAULT_FROM_EMAIL,
            recipient_list=[admin_email],
            fail_silently=False,
        )
        
        print(f"[OK] Admin attendance summary sent to {admin_email}")
        return True
        
    except Exception as e:
        print(f"[ERROR] Failed to send admin email: {str(e)}")
        return False


def get_admin_email():
    """
    Get admin email from settings or database
    You can modify this to fetch from database or settings
    """
    # Option 1: From settings (add ADMIN_EMAIL to settings.py)
    admin_email = getattr(settings, 'ADMIN_EMAIL', 'admin@example.com')
    
    # Option 2: Hardcode for now (replace with actual admin email)
    # admin_email = 'your-admin-email@gmail.com'
    
    return admin_email
