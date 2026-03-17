"""
Management command to add 14 test students with sample attendance data
"""
from django.core.management.base import BaseCommand
from studentgrievence.models import students, student_attendance
from datetime import date, time, timedelta
import random


class Command(BaseCommand):
    help = 'Add 14 test students with sample attendance data'

    def handle(self, *args, **kwargs):
        # Sample student data
        test_students = [
            {'name': 'Rahul Kumar', 'dept': 'Computer Science', 'semester': 'Semester 6', 'email': 'rahul.kumar@test.com', 'phone': '9876543210', 'father': 'Mr. Kumar'},
            {'name': 'Priya Sharma', 'dept': 'Computer Science', 'semester': 'Semester 6', 'email': 'priya.sharma@test.com', 'phone': '9876543211', 'father': 'Mr. Sharma'},
            {'name': 'Amit Patel', 'dept': 'Information Technology', 'semester': 'Semester 6', 'email': 'amit.patel@test.com', 'phone': '9876543212', 'father': 'Mr. Patel'},
            {'name': 'Sneha Reddy', 'dept': 'Computer Science', 'semester': 'Semester 6', 'email': 'sneha.reddy@test.com', 'phone': '9876543213', 'father': 'Mr. Reddy'},
            {'name': 'Vikram Singh', 'dept': 'Information Technology', 'semester': 'Semester 6', 'email': 'vikram.singh@test.com', 'phone': '9876543214', 'father': 'Mr. Singh'},
            {'name': 'Anjali Gupta', 'dept': 'Computer Science', 'semester': 'Semester 6', 'email': 'anjali.gupta@test.com', 'phone': '9876543215', 'father': 'Mr. Gupta'},
            {'name': 'Rohan Verma', 'dept': 'Information Technology', 'semester': 'Semester 6', 'email': 'rohan.verma@test.com', 'phone': '9876543216', 'father': 'Mr. Verma'},
            {'name': 'Kavya Nair', 'dept': 'Computer Science', 'semester': 'Semester 6', 'email': 'kavya.nair@test.com', 'phone': '9876543217', 'father': 'Mr. Nair'},
            {'name': 'Arjun Mehta', 'dept': 'Information Technology', 'semester': 'Semester 6', 'email': 'arjun.mehta@test.com', 'phone': '9876543218', 'father': 'Mr. Mehta'},
            {'name': 'Pooja Desai', 'dept': 'Computer Science', 'semester': 'Semester 6', 'email': 'pooja.desai@test.com', 'phone': '9876543219', 'father': 'Mr. Desai'},
            {'name': 'Karan Joshi', 'dept': 'Information Technology', 'semester': 'Semester 6', 'email': 'karan.joshi@test.com', 'phone': '9876543220', 'father': 'Mr. Joshi'},
            {'name': 'Divya Iyer', 'dept': 'Computer Science', 'semester': 'Semester 6', 'email': 'divya.iyer@test.com', 'phone': '9876543221', 'father': 'Mr. Iyer'},
            {'name': 'Siddharth Rao', 'dept': 'Information Technology', 'semester': 'Semester 6', 'email': 'siddharth.rao@test.com', 'phone': '9876543222', 'father': 'Mr. Rao'},
            {'name': 'Neha Kapoor', 'dept': 'Computer Science', 'semester': 'Semester 6', 'email': 'neha.kapoor@test.com', 'phone': '9876543223', 'father': 'Mr. Kapoor'},
        ]

        # Slot timings
        slot_times = {
            1: {'entry': time(9, 0), 'exit': time(9, 55), 'late_entry': time(9, 15)},
            2: {'entry': time(10, 0), 'exit': time(10, 55), 'late_entry': time(10, 15)},
            3: {'entry': time(11, 0), 'exit': time(11, 55), 'late_entry': time(11, 15)},
            4: {'entry': time(12, 0), 'exit': time(12, 55), 'late_entry': time(12, 15)},
            5: {'entry': time(14, 0), 'exit': time(14, 55), 'late_entry': time(14, 15)},
            6: {'entry': time(15, 0), 'exit': time(15, 55), 'late_entry': time(15, 15)},
        }

        self.stdout.write(self.style.SUCCESS('Creating 14 test students...'))

        created_students = []
        for student_data in test_students:
            # Check if student already exists
            if students.objects.filter(st_email=student_data['email']).exists():
                self.stdout.write(self.style.WARNING(f"Student {student_data['name']} already exists, skipping..."))
                student = students.objects.filter(st_email=student_data['email']).first()
            else:
                student = students.objects.create(
                    st_name=student_data['name'],
                    st_department=student_data['dept'],
                    st_semester=student_data['semester'],
                    st_email=student_data['email'],
                    st_phone=student_data['phone'],
                    st_password='test123',
                    st_fathername=student_data['father']
                )
                self.stdout.write(self.style.SUCCESS(f"[OK] Created student: {student_data['name']}"))
            
            created_students.append(student)

        # Generate attendance data for last 7 days
        self.stdout.write(self.style.SUCCESS('\nGenerating attendance data for last 7 days...'))
        
        today = date.today()
        
        for day_offset in range(7):
            attendance_date = today - timedelta(days=day_offset)
            
            # Skip weekends (optional)
            if attendance_date.weekday() >= 5:  # Saturday = 5, Sunday = 6
                continue
            
            self.stdout.write(f"\nDate: {attendance_date}")
            
            for student in created_students:
                # Randomly determine attendance pattern
                attendance_pattern = random.choice([
                    'full',      # All 6 slots
                    'partial',   # 4-5 slots
                    'late',      # Some late entries
                    'absent'     # Less than 4 slots
                ])
                
                if attendance_pattern == 'full':
                    slots_to_attend = [1, 2, 3, 4, 5, 6]
                elif attendance_pattern == 'partial':
                    slots_to_attend = random.sample([1, 2, 3, 4, 5, 6], k=random.randint(4, 5))
                elif attendance_pattern == 'late':
                    slots_to_attend = [1, 2, 3, 4, 5, 6]
                else:  # absent
                    slots_to_attend = random.sample([1, 2, 3, 4, 5, 6], k=random.randint(0, 3))
                
                for slot in slots_to_attend:
                    # Determine if late
                    is_late = (attendance_pattern == 'late' and random.random() > 0.5)
                    
                    entry_time = slot_times[slot]['late_entry'] if is_late else slot_times[slot]['entry']
                    exit_time = slot_times[slot]['exit']
                    
                    # Add some random variation (±5 minutes)
                    entry_minutes = entry_time.hour * 60 + entry_time.minute + random.randint(-5, 5)
                    exit_minutes = exit_time.hour * 60 + exit_time.minute + random.randint(-5, 5)
                    
                    entry_time = time(entry_minutes // 60, entry_minutes % 60)
                    exit_time = time(exit_minutes // 60, exit_minutes % 60)
                    
                    # Check if entry already exists
                    if not student_attendance.objects.filter(
                        st_id=str(student.id),
                        date=attendance_date,
                        slot=slot,
                        status='entry'
                    ).exists():
                        # Create entry record
                        student_attendance.objects.create(
                            st_id=str(student.id),
                            date=attendance_date,
                            time=entry_time,
                            status='entry',
                            slot=slot
                        )
                    
                    # Check if exit already exists
                    if not student_attendance.objects.filter(
                        st_id=str(student.id),
                        date=attendance_date,
                        slot=slot,
                        status='exit'
                    ).exists():
                        # Create exit record
                        student_attendance.objects.create(
                            st_id=str(student.id),
                            date=attendance_date,
                            time=exit_time,
                            status='exit',
                            slot=slot
                        )
                
                slots_attended = len(slots_to_attend)
                self.stdout.write(f"  {student.st_name}: {slots_attended}/6 slots")

        self.stdout.write(self.style.SUCCESS('\n[OK] Test data creation complete!'))
        self.stdout.write(self.style.SUCCESS(f'[OK] Created {len(created_students)} students'))
        self.stdout.write(self.style.SUCCESS('[OK] Generated attendance data for last 7 days'))
        self.stdout.write(self.style.WARNING('\nDefault password for all test students: test123'))
