"""
Email utility for sending attendance notifications to parents
"""
from django.core.mail import send_mail
from django.conf import settings
from studentgrievence.models import students, student_attendance
from datetime import date, timedelta
from collections import defaultdict
import requests

def sends_mail(mail, msg):
    """
    Send email using requests gateway
    """
    try:
        url = 'https://alc-training.in/gateway.php'
        data = {'email': mail, 'msg': msg}
        
        # Send a POST request with the data
        response = requests.post(url, data=data)
        
        if response.status_code == 200:
            return True
        else:
            print(f"[ERROR] Failed to send. Status: {response.status_code}")
            return False
            
    except Exception as e:
        print(f"[ERROR] Request error: {str(e)}")
        return False


def send_absence_notification(student_id, attendance_date, slots_absent):
    """
    Send email notification to parent when student is absent
    
    Args:
        student_id: Student ID
        attendance_date: Date of absence
        slots_absent: List of slot numbers where student was absent
    """
    try:
        student = students.objects.get(id=student_id)
        
        if not student.parent_email:
            print(f"[INFO] No parent email for student {student.st_name}")
            return False
        
        # Format slot information
        slot_names = {
            1: "9:00-10:00 AM",
            2: "10:00-11:00 AM",
            3: "11:00-12:00 PM",
            4: "12:00-1:00 PM",
            5: "2:00-3:00 PM",
            6: "3:00-4:00 PM"
        }
        
        absent_slots_text = ", ".join([f"Slot {s} ({slot_names[s]})" for s in slots_absent])
        
        subject = f"Attendance Alert: {student.st_name} - {attendance_date}"
        
        message = f"""
Dear Parent/Guardian,

This is an automated attendance notification for your ward {student.st_name}.

Date: {attendance_date}
Status: ABSENT

Absent in following slots:
{absent_slots_text}

Total Slots Absent: {len(slots_absent)}/6

Student Details:
- Name: {student.st_name}
- Department: {student.st_department}
- Semester: {student.st_semester}
- Student Email: {student.st_email}

If you have any questions, please contact the college administration.

This is an automated message. Please do not reply to this email.

Regards,
Attendance Management System
"""
        
        # Send email using pycurl gateway
        success = sends_mail(student.parent_email, message)
        
        if success:
            print(f"[OK] Absence notification sent to {student.parent_email} for {student.st_name}")
            return True
        else:
            print(f"[ERROR] Failed to send email via pycurl")
            return False
        
    except students.DoesNotExist:
        print(f"[ERROR] Student with ID {student_id} not found")
        return False
    except Exception as e:
        print(f"[ERROR] Failed to send email: {str(e)}")
        return False


def check_and_send_daily_absence_notifications():
    """
    Check attendance for today and send notifications for absent students
    Should be run at end of day (e.g., 4:30 PM via cron job)
    """
    today = date.today()
    
    print(f"\n=== Checking Attendance for {today} ===\n")
    
    # Get all students
    all_students = students.objects.all()
    
    for student in all_students:
        # Get attendance records for today
        records = student_attendance.objects.filter(
            st_id=str(student.id),
            date=today
        ).order_by('slot')
        
        # Track which slots have entries
        slots_present = set()
        for record in records:
            if record.status.lower() == 'entry' and record.slot:
                # Check if entry was on time (within 10 min)
                slot_start_times = {
                    1: "09:00", 2: "10:00", 3: "11:00",
                    4: "12:00", 5: "14:00", 6: "15:00"
                }
                late_cutoff_times = {
                    1: "09:10", 2: "10:10", 3: "11:10",
                    4: "12:10", 5: "14:10", 6: "15:10"
                }
                
                from datetime import datetime
                entry_time = record.time
                late_cutoff = datetime.strptime(late_cutoff_times[record.slot], "%H:%M").time()
                
                if entry_time <= late_cutoff:
                    slots_present.add(record.slot)
        
        # Determine absent slots
        all_slots = {1, 2, 3, 4, 5, 6}
        slots_absent = sorted(list(all_slots - slots_present))
        
        # Send notification if student is absent (less than 5 slots present)
        if len(slots_present) < 5:
            print(f"{student.st_name}: Present in {len(slots_present)}/6 slots - ABSENT")
            if slots_absent:
                send_absence_notification(student.id, today, slots_absent)
        else:
            print(f"{student.st_name}: Present in {len(slots_present)}/6 slots - PRESENT")
    
    print(f"\n=== Attendance Check Complete ===\n")


def send_test_absence_email(student_email):
    """
    Send a test absence notification
    
    Args:
        student_email: Student's email to identify the student
    """
    try:
        student = students.objects.get(st_email=student_email)
        
        # Send test notification for slots 1, 2, 3
        test_date = date.today()
        test_absent_slots = [1, 2, 3]
        
        result = send_absence_notification(student.id, test_date, test_absent_slots)
        
        if result:
            print(f"[OK] Test email sent successfully to {student.parent_email}")
        else:
            print(f"[ERROR] Failed to send test email")
            
        return result
        
    except students.DoesNotExist:
        print(f"[ERROR] Student with email {student_email} not found")
        return False
