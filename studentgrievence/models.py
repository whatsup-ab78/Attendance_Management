from django.db import models


class students(models.Model):
    st_name=models.CharField(max_length=150)
    st_email=models.CharField(max_length=150)
    st_department=models.CharField(max_length=150)
    st_semester=models.CharField(max_length=150)
    st_phone=models.CharField(max_length=150)
    st_password=models.CharField(max_length=150)
    st_fathername=models.CharField(max_length=150)
    parent_email=models.CharField(max_length=150, blank=True, null=True)
    
class student_attendance(models.Model):
    st_id = models.CharField(max_length=150)   # session uid
    date = models.DateField()
    time = models.TimeField()
    status = models.CharField(max_length=150)  # 'entry' or 'exit'
    slot = models.IntegerField(null=True, blank=True)  # 1-6 for time slots

    def __str__(self):
        return f"{self.st_id} - {self.date} {self.time}"

class stdcomplaint(models.Model):
    complaint=models.CharField(max_length=150)
    status=models.CharField(max_length=150)
    uid=models.CharField(max_length=150)
    hod=models.CharField(max_length=150)

class pcomplaint(models.Model):
    complaint=models.CharField(max_length=150)
    status=models.CharField(max_length=150)
    uid=models.CharField(max_length=150)
    princy=models.CharField(max_length=150)
    
class staffcomplaint(models.Model):
    complaint=models.CharField(max_length=150)
    status=models.CharField(max_length=150)
    uid=models.CharField(max_length=150)
    princy=models.CharField(max_length=150) 
    
class principals(models.Model):
    name=models.CharField(max_length=150)
    phone=models.CharField(max_length=150)
    email=models.CharField(max_length=150)
    password=models.CharField(max_length=150)

class prodetails(models.Model):
    p_name=models.CharField(max_length=150)
    p_age=models.CharField(max_length=150)
    p_email=models.CharField(max_length=150)
    p_phone=models.CharField(max_length=150)
    p_password=models.CharField(max_length=150)    

    
class hod(models.Model):
    p_name=models.CharField(max_length=150)
    p_age=models.CharField(max_length=150)
    p_email=models.CharField(max_length=150)
    p_phone=models.CharField(max_length=150)
    p_password=models.CharField(max_length=150)    


class acknowledgement(models.Model):
    ack=models.CharField(max_length=150)
    status=models.CharField(max_length=150)
    date=models.CharField(max_length=150)
    cid=models.CharField(max_length=150)
    apid=models.CharField(max_length=150)


class assign(models.Model):
    name=models.CharField(max_length=150)
    date=models.CharField(max_length=150)
    cmpid=models.CharField(max_length=150)

class teachers(models.Model):
    t_name=models.CharField(max_length=150)
    t_email=models.CharField(max_length=150)
    t_department=models.CharField(max_length=150)
    t_semester=models.CharField(max_length=150)
    t_password=models.CharField(max_length=150)


class ChatMessage(models.Model):
    sender = models.CharField(max_length=150)   # name (student / HOD / teacher)
    role = models.CharField(max_length=50)      # 'student', 'hod', 'teacher', 'admin'
    message = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ['created_at']
