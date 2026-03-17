"""
Add specific test attendance - Student present in slots 2 and 3 only
"""
from django.core.management.base import BaseCommand
from studentgrievence.models import students, student_attendance
from datetime import date, time


class Command(BaseCommand):
    help = 'Add test attendance for student present in slots 2 and 3 only'

    def handle(self, *args, **kwargs):
        # Get the first student
        student = students.objects.first()
        
        if not student:
            self.stdout.write(self.style.ERROR('No students found. Please add students first.'))
            return
        
        test_date = date.today()
        
        self.stdout.write(f'Adding test attendance for {student.st_name} on {test_date}')
        self.stdout.write('Student will be present in Slot 2 (10-11 AM) and Slot 3 (11-12 PM) only')
        
        # Delete existing attendance for today
        student_attendance.objects.filter(st_id=str(student.id), date=test_date).delete()
        self.stdout.write('Cleared existing attendance for today')
        
        # Add Slot 2 attendance (10-11 AM)
        student_attendance.objects.create(
            st_id=str(student.id),
            date=test_date,
            time=time(10, 2),  # Entry at 10:02 (on time)
            status='entry',
            slot=2
        )
        student_attendance.objects.create(
            st_id=str(student.id),
            date=test_date,
            time=time(10, 55),  # Exit at 10:55
            status='exit',
            slot=2
        )
        self.stdout.write(self.style.SUCCESS('[OK] Added Slot 2 attendance (10:02 - 10:55)'))
        
        # Add Slot 3 attendance (11-12 PM)
        student_attendance.objects.create(
            st_id=str(student.id),
            date=test_date,
            time=time(11, 5),  # Entry at 11:05 (on time)
            status='entry',
            slot=3
        )
        student_attendance.objects.create(
            st_id=str(student.id),
            date=test_date,
            time=time(11, 58),  # Exit at 11:58
            status='exit',
            slot=3
        )
        self.stdout.write(self.style.SUCCESS('[OK] Added Slot 3 attendance (11:05 - 11:58)'))
        
        self.stdout.write(self.style.SUCCESS(f'\n[OK] Test attendance created!'))
        self.stdout.write(f'Student: {student.st_name}')
        self.stdout.write(f'Date: {test_date}')
        self.stdout.write(f'Present in: Slot 2 and Slot 3 only (2/6 slots)')
        self.stdout.write(f'Overall Status: Absent (needs 5/6 slots for Present)')
        self.stdout.write(f'\nLogin with: {student.st_email} / Password: {student.st_password}')
