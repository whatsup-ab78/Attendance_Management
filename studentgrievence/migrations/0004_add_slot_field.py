# Generated migration for 6-slot attendance system

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('studentgrievence', '0003_student_attendance_time'),
    ]

    operations = [
        # Add slot field to student_attendance
        migrations.AddField(
            model_name='student_attendance',
            name='slot',
            field=models.IntegerField(blank=True, null=True),
        ),
    ]
