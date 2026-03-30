from django.test import TestCase, Client
from django.urls import reverse
from datetime import datetime
from .models import students, student_attendance
from unittest.mock import patch
from .utils import calculate_slot_attendance, SLOTS

class SystemTests(TestCase):
    def setUp(self):
        self.client = Client()
        # Create a student
        self.student = students.objects.create(
            st_name="Test Student",
            st_email="test1@example.com",
            st_department="CSE",
            st_semester="6",
            st_phone="1234567890",
            st_password="Password123!",
            st_fathername="Test Father",
            parent_email="parent@example.com"
        )
        # Create a duplicate student to simulate the old database schema problem
        self.duplicate_student = students.objects.create(
            st_name="Duplicate Student",
            st_email="test1@example.com",
            st_department="IT",
            st_semester="6",
            st_phone="0987654321",
            st_password="Password123!",
            st_fathername="Test Father 2",
            parent_email="parent2@example.com"
        )

    def test_login_duplicate_emails(self):
        """Test that login handles MultipleObjectsReturned condition using .first()"""
        # If it uses .get(), this will throw an exception
        response = self.client.post('/login', {
            'email': 'test1@example.com',
            'password': 'Password123!'
        })
        
        # After successful login, it correctly sets the session
        self.assertEqual(self.client.session.get('uemail'), 'test1@example.com')
        # It logs in the first matching user
        self.assertEqual(self.client.session.get('uid'), self.student.id)
        
    @patch('studentgrievence.views.create_data')
    @patch('studentgrievence.views.train_faces')
    def test_registration_camera_failure(self, mock_train, mock_create):
        """Test registration when camera fails to detect face"""
        mock_create.return_value = {"status": "error", "message": "Camera timed out"}
        
        response = self.client.post('/regstudent', {
            'st_name': 'New Student',
            'st_department': 'CSE',
            'st_email': 'new@example.com',
            'st_semester': '1',
            'st_phone': '1111111111',
            'st_password': 'Pass123!@#',
            'st_repassword': 'Pass123!@#',
            'fathername': 'Father',
            'parent_email': 'parent@example.com'
        })
        
        # Should not have created a permanent record if camera failed
        self.assertFalse(students.objects.filter(st_email='new@example.com').exists())
        # Train faces should not be called
        mock_train.assert_not_called()
        
    @patch('studentgrievence.views.create_data')
    @patch('studentgrievence.views.train_faces')
    def test_registration_success(self, mock_train, mock_create):
        """Test registration when camera successfully detects face"""
        mock_create.return_value = {"status": "success", "message": "Face captured"}
        
        response = self.client.post('/regstudent', {
            'st_name': 'New Student 2',
            'st_department': 'CSE',
            'st_email': 'new2@example.com',
            'st_semester': '1',
            'st_phone': '1111111111',
            'st_password': 'Pass123!@#',
            'st_repassword': 'Pass123!@#',
            'fathername': 'Father',
            'parent_email': 'parent@example.com'
        })
        
        # Should have created the record
        self.assertTrue(students.objects.filter(st_email='new2@example.com').exists())
        # Train faces should be called
        mock_train.assert_called_once()
        
    def test_slot_attendance_out_of_bounds_time(self):
        """Test that out of bound times (e.g. 16:30) are not incorrectly mapped to slot 6"""
        # Create an attendance record outside of any slot bounds
        date_obj = datetime.now().date()
        time_obj = datetime.strptime("16:30:00", "%H:%M:%S").time()
        
        # Simulating it was saved with slot=None
        student_attendance.objects.create(
            st_id=self.student.id,
            date=date_obj,
            time=time_obj,
            status="entry",
            slot=None
        )
        
        # Simulating another saved with slot=0
        time_obj2 = datetime.strptime("08:00:00", "%H:%M:%S").time()
        student_attendance.objects.create(
            st_id=self.student.id,
            date=date_obj,
            time=time_obj2,
            status="entry",
            slot=0
        )
        
        report = calculate_slot_attendance(self.student.id)
        self.assertEqual(len(report), 1)
        slots_status = report[0]['slots']
        
        # Since times were outside slots 1-6 bounds (mapped to 0), slot 6 should NOT be marked Present.
        self.assertEqual(slots_status[6]['status'], 'Absent')
        self.assertEqual(slots_status[1]['status'], 'Absent')
