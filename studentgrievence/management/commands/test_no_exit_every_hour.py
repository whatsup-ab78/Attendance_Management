"""
Test case: Student enters for slots but doesn't exit every hour
Only exits when actually leaving (e.g., lunch break, going home)
"""
from django.core.management.base import BaseCommand
from studentgrievence.models import students, student_attendance
from datetime import date, time


class Command(BaseCommand):
    help = 'Test: Student enters for each slot but only exits when leaving classroom'

    def handle(self, *args, **kwargs):
        student = students.objects.first()
        
        if not student:
            self.stdout.write(self.style.ERROR('No students found'))
            return
        
        test_date = date.today()
        
        self.stdout.write(f'Testing attendance for {student.st_name} on {test_date}')
        self.stdout.write('Scenario: Student enters for each slot, but only exits when leaving\n')
        
        # Clear existing attendance
        student_attendance.objects.filter(st_id=str(student.id), date=test_date).delete()
        
        # Slot 1 (9-10): Enter, no exit (stays in class)
        student_attendance.objects.create(
            st_id=str(student.id), date=test_date,
            time=time(9, 2), status='entry', slot=1
        )
        self.stdout.write('Slot 1 (9-10): ENTRY at 9:02 - No exit (student stays in class)')
        
        # Slot 2 (10-11): Enter, no exit (stays in class)
        student_attendance.objects.create(
            st_id=str(student.id), date=test_date,
            time=time(10, 3), status='entry', slot=2
        )
        self.stdout.write('Slot 2 (10-11): ENTRY at 10:03 - No exit (student stays in class)')
        
        # Slot 3 (11-12): Enter, no exit (stays in class)
        student_attendance.objects.create(
            st_id=str(student.id), date=test_date,
            time=time(11, 1), status='entry', slot=3
        )
        self.stdout.write('Slot 3 (11-12): ENTRY at 11:01 - No exit (student stays in class)')
        
        # Slot 4 (12-1): Enter and EXIT (leaving for lunch)
        student_attendance.objects.create(
            st_id=str(student.id), date=test_date,
            time=time(12, 0), status='entry', slot=4
        )
        student_attendance.objects.create(
            st_id=str(student.id), date=test_date,
            time=time(12, 58), status='exit', slot=4
        )
        self.stdout.write('Slot 4 (12-1): ENTRY at 12:00, EXIT at 12:58 (leaving for lunch)')
        
        # Slot 5 (2-3): Enter, no exit (stays in class)
        student_attendance.objects.create(
            st_id=str(student.id), date=test_date,
            time=time(14, 5), status='entry', slot=5
        )
        self.stdout.write('Slot 5 (2-3): ENTRY at 14:05 - No exit (student stays in class)')
        
        # Slot 6 (3-4): Enter and EXIT (going home)
        student_attendance.objects.create(
            st_id=str(student.id), date=test_date,
            time=time(15, 2), status='entry', slot=6
        )
        student_attendance.objects.create(
            st_id=str(student.id), date=test_date,
            time=time(15, 55), status='exit', slot=6
        )
        self.stdout.write('Slot 6 (3-4): ENTRY at 15:02, EXIT at 15:55 (going home)')
        
        self.stdout.write(self.style.SUCCESS('\n[OK] Test case created!'))
        self.stdout.write(f'\nResult:')
        self.stdout.write(f'- All 6 slots marked PRESENT (based on entry time)')
        self.stdout.write(f'- Only 2 exits recorded (lunch break and going home)')
        self.stdout.write(f'- Other slots show "Not marked" for exit')
        self.stdout.write(f'- Overall Status: PRESENT (6/6 slots)')
        self.stdout.write(f'\nLogin: {student.st_email} / Password: {student.st_password}')
