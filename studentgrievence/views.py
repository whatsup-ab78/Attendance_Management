from django.shortcuts import render
from django.shortcuts import redirect
from django.conf import settings
from django.contrib import messages
from ml_code.create_db import create_data
from ml_code.train_db import train_faces
from ml_code.face_recognition import face_recognize
from . models import *
from .utils import (
    calculate_daily_hours_with_status, 
    calculate_daily_hours_teacher, 
    calculate_slot_attendance, 
    calculate_slot_attendance_teacher
)
from .email_notifications import send_absence_notification





def index(request):
    return render(request,'index.html')
def indexx(request):
    return render(request,'index.html')
def studentregister(request):
    return render(request,'studentregister.html')
 
def markattendence(request):
    expected_uid = request.session.get('uid')
    result = face_recognize("entry", expected_uid)
    if result:
        if result.get('status') == 'success':
            messages.success(request, result.get('message'))
        elif result.get('status') == 'error':
            messages.error(request, result.get('message'))
        else:
            messages.warning(request, result.get('message'))
    return redirect(index) 

def markattendence2(request):
    expected_uid = request.session.get('uid')
    result = face_recognize("exit", expected_uid)
    if result:
        if result.get('status') == 'success':
            messages.success(request, result.get('message'))
        elif result.get('status') == 'error':
            messages.error(request, result.get('message'))
        else:
            messages.warning(request, result.get('message'))
    return redirect(index) 


def regstudent(request):
    if request.method=='POST':
        st_name=request.POST.get('st_name')
        st_gender=request.POST.get('st_department')
        st_email=request.POST.get('st_email')
        st_college=request.POST.get('st_semester')
        st_phone=request.POST.get('st_phone')
        st_password=request.POST.get('st_password')
        st_repassword=request.POST.get('st_repassword')
        st_fathername=request.POST.get('fathername')
        parent_email=request.POST.get('parent_email')

        if st_password != st_repassword:
            messages.error(request, 'Passwords do not match!')
            return render(request, 'studentregister.html')

        if students.objects.filter(st_email=st_email).exists():
            messages.error(request, 'Email already exists! Please use a different email.')
            return render(request, 'studentregister.html')

        log=students(st_name=st_name,st_department=st_gender,st_email=st_email,st_semester=st_college,st_phone=st_phone,st_password=st_password,st_fathername=st_fathername,parent_email=parent_email)
        log.save()
        # Use the saved object directly instead of querying by email (avoids MultipleObjectsReturned error)
        result = create_data(str(log.id))
        
        # Check if the camera timeout or failure occurred
        if result and result.get('status') == 'error':
            log.delete() # Revert the saving so they can try again
            messages.error(request, result.get('message'))
            return render(request, 'studentregister.html')
            
        train_faces()
        messages.success(request, 'Registration successful! You can now log in.')
        return render(request,'studentregister.html')
    return render(request, 'studentregister.html')

def studentlogin(request):
    return render(request,'studentlogin.html') 

'''def login(request):
    if request.method=='POST':
        st_name=request.POST.get('st_name')
        st_password=request.POST.get('st_password')
        log=students(st_name=st_name,st_password=st_password)
        if email=='admin@gmail.com' and password=='admin':
            request.session['adminemail']=email
            request.session['logint']='admin'
            return render(request,'admin/index.html')  
        else if students.objects.filter(st_email=email,st_password=password).exit():
            userdetails=students.objects.filter(st_email=email,st_password=password)
            request.session['userid']=userdetails.id
            request.session['logint']='student'
            return render(request,'student/index.html')  
        else:
            return render(request,'studentlogin.html')'''
              
def login(request):
    if request.method != 'POST':
        # If not POST, just show the login page
        return render(request, 'studentlogin.html')
    
    email = request.POST.get('email')
    password = request.POST.get('password')
    print(email)
    print(password)
    
    if not email or not password:
        return render(request, 'studentlogin.html', {'status': 'Please enter both email and password'})
    
    if email == 'admin@gmail.com' and password =='admin':
        request.session['logintdetail'] = email
        request.session['admin'] ='admin'
        
        # Send current day's attendance summary to admin
        try:
            from studentgrievence.admin_email import send_admin_attendance_email
            from datetime import date
            
            # Send today's attendance summary
            admin_email = email  # Use the logged-in admin's email
            send_admin_attendance_email(admin_email, summary_date=date.today())
            print(f"[INFO] Attendance summary sent to admin: {admin_email}")
        except Exception as e:
            print(f"[ERROR] Failed to send admin attendance email: {str(e)}")
            # Don't block login if email fails
        
        return render(request,'index.html')

    elif students.objects.filter(st_email=email,st_password=password).exists():
        userdetails=students.objects.filter(st_email=request.POST['email'],st_password=password).first()
        if userdetails.st_password == request.POST['password']:
            request.session['uid'] = userdetails.id
            request.session['uname'] = userdetails.st_name

            request.session['uemail'] = email

            request.session['user'] = 'user'


            return render(request,'index.html')

    elif hod.objects.filter(p_email=email,p_password=password).exists():
        userdetails=hod.objects.filter(p_email=request.POST['email'],p_password=password).first()
        if userdetails.p_password == request.POST['password']:
            request.session['pid'] = userdetails.id
            request.session['pname'] = userdetails.p_name

            request.session['uemail'] = email

            request.session['user'] = 'user'

            
            return render(request,'index.html') 

  

    elif teachers.objects.filter(t_email=email,t_password=password).exists():
        userdetails=teachers.objects.filter(t_email=request.POST['email'],t_password=password).first()
        if userdetails.t_password == request.POST['password']:
            request.session['tid'] = userdetails.id
            request.session['name'] = userdetails.t_name

            request.session['email'] = email

            request.session['user'] = 'user'

            
            return render(request,'index.html')  

    else:
        return render(request, 'studentlogin.html', {'status': 'Invalid email or password'})


def chat(request):
    """
    Simple group chat page where all logged‑in users (student, HOD, teacher, admin)
    can send messages visible to everyone.
    """
    # Determine current user name and role from session
    if request.session.get('uid'):
        sender_name = request.session.get('uname', 'Student')
        role = 'student'
    elif request.session.get('pid'):
        sender_name = request.session.get('pname', 'HOD')
        role = 'hod'
    elif request.session.get('tid'):
        sender_name = request.session.get('name', 'Teacher')
        role = 'teacher'
    elif request.session.get('admin'):
        sender_name = 'Admin'
        role = 'admin'
    else:
        # Not logged in: redirect to login
        return redirect(studentlogin)

    if request.method == 'POST':
        message = request.POST.get('message', '').strip()
        if message:
            ChatMessage.objects.create(
                sender=sender_name,
                role=role,
                message=message
            )
        return redirect('chat')

    messages = ChatMessage.objects.all()
    return render(request, 'chat.html', {'messages': messages, 'sender_name': sender_name, 'role': role})


def addcomplaint(request):
    a=request.session['uname']
    if request.method=='POST':
        hoddd=request.POST.get('hod')

        complaint=request.POST.get('complaint')
        status=request.POST.get('status')
        log=stdcomplaint(complaint=complaint,status=status,uid=a,hod=hoddd)
        log.save()
        return render(request,'complaint.html')

def princycomplaint(request):
    a=request.session['uname']
    if request.method=='POST':
        hoddd=request.POST.get('hod')

        complaint=request.POST.get('complaint')
        status=request.POST.get('status')
        log=pcomplaint(complaint=complaint,status=status,uid=a,princy=hoddd)
        log.save()
        return render(request,'princomplaint.html')

def teachercomplaint(request):
    a=request.session['uname']
    if request.method=='POST':
        hoddd=request.POST.get('hod')

        complaint=request.POST.get('complaint')
        status=request.POST.get('status')
        log=staffcomplaint(complaint=complaint,status=status,uid=a,princy=hoddd)
        log.save()
        return render(request,'tcomplaint.html')

def complaintsss(request):
    return render(request,'vcomplaint.html') 

def hodd(request):
    # Safely fetch a HOD record (id=1) if it exists
    user = hod.objects.filter(id=1).first()
    return render(request, 'complaint.html', {'result': user})  
def staff(request):
    user=teachers.objects.all()

    return render(request,'tcomplaint.html',{'result':user})    
    


def viewattendence(request):
    uid = request.session['uid']

    slot_report = calculate_slot_attendance(uid)

    return render(
        request,
        'viewattendence.html',
        {'slot_report': slot_report}
    )

def viewattendence_tch(request):
    from datetime import datetime, timedelta
    
    # Check if a teacher is logged in
    teacher_dept = None
    if 'tid' in request.session:
        try:
            teacher_obj = teachers.objects.get(id=request.session['tid'])
            teacher_dept = teacher_obj.t_department
        except teachers.DoesNotExist:
            pass
            
    # Get students for the dropdown (filtered by department)
    student_list = students.objects.all()
    if teacher_dept:
        student_list = student_list.filter(st_department=teacher_dept)
        
    # Get filter parameters
    start_date = request.GET.get('start_date')
    end_date = request.GET.get('end_date')
    student_id = request.GET.get('student_id')
    
    # Convert to date objects if provided
    filter_start = None
    filter_end = None
    
    if start_date:
        try:
            filter_start = datetime.strptime(start_date, '%Y-%m-%d').date()
        except ValueError:
            filter_start = None
    
    if end_date:
        try:
            filter_end = datetime.strptime(end_date, '%Y-%m-%d').date()
        except ValueError:
            filter_end = None
    
    # If no dates specified, default to last 7 days
    if not filter_start and not filter_end:
        filter_end = datetime.now().date()
        filter_start = filter_end - timedelta(days=6)
    elif filter_start and not filter_end:
        filter_end = datetime.now().date()
    elif filter_end and not filter_start:
        filter_start = filter_end - timedelta(days=6)
    
    report = calculate_slot_attendance_teacher(
        start_date=filter_start, 
        end_date=filter_end,
        department=teacher_dept,
        student_id=student_id
    )

    # Get email status from session and clear it
    email_status = request.session.pop('email_status', None)
    email_error = request.session.pop('email_error', None)

    return render(
        request,
        'viewattendence2.html',
        {
            'report': report,
            'students': student_list,
            'start_date': filter_start,
            'end_date': filter_end,
            'selected_student': int(student_id) if student_id else None,
            'teacher_dept': teacher_dept,
            'email_status': email_status,
            'email_error': email_error
        }
    )
    
def princ(request):
    user=principals.objects.get(id=1)
    return render(request,'princomplaint.html',{'result':user}) 
def logout(request):
    session_keys = list(request.session.keys())
    for key in session_keys:
        del request.session[key]
    return redirect(index)
    
def addprincy(request):
    if request.method=='POST':
        name=request.POST.get('name')
        phone=request.POST.get('phone')
        email=request.POST.get('email')
        password=request.POST.get('password')
        log=principals(name=name,phone=phone,email=email,password=password)
        log.save()
        return render(request,'addpricipal.html')
def     pricyy(request):
    return render(request,'addpricipal.html') 

def prodetailss (request):
    return render(request,'prodetails.html')

def addprodetial(request):
    if request.method=='POST':
        p_name=request.POST.get('p_name')
        p_age=request.POST.get('p_age')
        p_email=request.POST.get('p_email')
        p_phone=request.POST.get('p_phone')
        p_password=request.POST.get('p_password')
        print(p_name)
        print(p_age)
        print(p_email)
        print(p_phone)
        print(p_password)
        log=prodetails(p_name=p_name,p_age=p_age,p_email=p_email,p_phone=p_phone,p_password=p_password)
        log.save()
        return render(request,'prodetails.html')



def view(request):
    user=stdcomplaint.objects.filter(status='pending')
    return render(request,'view.html',{'result':user})

def approved(request,id):
    upview=stdcomplaint.objects.get(id=id)
    a=upview.complaint
    c=upview.uid
    d=upview.hod
    id=upview.id
    
    ins=stdcomplaint(complaint=a,uid=c,hod=d,status='approved',id=id)
    print(ins)
    ins.save()
    return render(request,'ack.html',{'result':upview,'id':id}) 
def ack(request):
    return render(request,'ack.html') 

def ackupload(request):
    a= request.session['pid'] 
    if request.method=='POST':
        ack=request.POST.get('ack')
        status=request.POST.get('status')
        date=request.POST.get('date')
        log=acknowledgement(ack=ack,status=status,date=date,cid=a)
        log.save()
    return redirect(view)

def admincview(request):
    return render(request,'admincview.html') 

def admincviewadd(request):
    cview=stdcomplaint.objects.all()
    return render(request,'admincview.html',{'result':cview}) 


def about(request):
    return render(request,'about.html') 
       






def pprof(request):
    tem=request.session['prid']
    vpro=principals.objects.get(id=tem)
    return render(request,'pprofile.html',{'result':vpro})



 
    
    
def logout(request):
    session_keys = list(request.session.keys())
    for key in session_keys:
        del request.session[key]
    return redirect(index)
    
def addprincy(request):
    if request.method=='POST':
        name=request.POST.get('name')
        phone=request.POST.get('phone')
        email=request.POST.get('email')
        password=request.POST.get('password')
        log=principals(name=name,phone=phone,email=email,password=password)
        log.save()
        return render(request,'addpricipal.html')
def     pricyy(request):
    return render(request,'addpricipal.html') 

def prodetailss (request):
    return render(request,'prodetails.html')

def addprodetial(request):
    if request.method=='POST':
        p_name=request.POST.get('p_name')
        p_age=request.POST.get('p_age')
        p_email=request.POST.get('p_email')
        p_phone=request.POST.get('p_phone')
        p_password=request.POST.get('p_password')
        print(p_name)
        print(p_age)
        print(p_email)
        print(p_phone)
        print(p_password)
        log=hod(p_name=p_name,p_age=p_age,p_email=p_email,p_phone=p_phone,p_password=p_password)
        log.save()
        return render(request,'prodetails.html')



def view(request):
    user=stdcomplaint.objects.all()

    return render(request,'view.html',{'result':user})

def approved(request,id):
    upview=stdcomplaint.objects.get(id=id)
    a=upview.complaint
    c=upview.uid
    d=upview.hod
    ins=stdcomplaint(complaint=a,status='approved',uid=c,hod=d,id=id)
    ins.save()
    return render(request,'ack.html',{'result':upview}) 

def ack(request):
    return render(request,'ack.html')


def ackupload(request):
    request.session['pid']
    if request.method=='POST':
        ack=request.POST.get('ack')
        status=request.POST.get('status')
        date=request.POST.get('date')
        log=acknowledgement(ack=ack,status=status,date=date)
        log.save()
        return redirect(view)


def assignupload(request):
    a=request.session['pid']
    if request.method=='POST':
        name=request.POST.get('name')
        date=request.POST.get('date')
        cmpid=request.POST.get('cmpid')
        print(name)
        print(date)
        log=assign(name=name,date=date,cmpid=cmpid,apid=a)
        log.save()
        return redirect(view)

def assignn(request,id):
    upview=stdcomplaint.objects.get(id=id)
    temp=principals.objects.all()

    return render(request,'assign.html',{'result':upview,'res':temp})


def priview(request):
    tem=request.session['prid']
    pro= principals.objects.get(id=tem)
    return render(request,'pprofile.html',{'result':pro})
def proprof(request):
    tem=request.session['pid']
    pro= hod.objects.get(id=tem)
    return render(request,'proprofile.html',{'result':pro})

def pcview(request):
    user=stdcomplaint.objects.all()

    return render(request,'pcview.html',{'result':user})


def pcapp(request):
    user=pcomplaint.objects.filter(status='pending')

    return render(request,'pview.html',{'result':user})

def pack(request):
    return render(request,'pack.html')

def packupload(request):
    a=request.session['prid']
    if request.method=='POST':
        ack=request.POST.get('ack')
        status=request.POST.get('status')
        date=request.POST.get('date')
        cid=request.POST.get('cid')

        print(ack)
        print(status)
        print(date)
        log=acknowledgement(ack=ack,status=status,date=date,apid=a,cid=cid)
        log.save()
        return redirect(pcapp)

def prcapproved(request,id):
    upd=pcomplaint.objects.get(id=id)
    a=upd.complaint
    c=upd.uid
    d=upd.princy
    ins=pcomplaint(complaint=a,status='approved',uid=c,princy=d,id=id)
    ins.save()
    return render(request,'pack.html',{'result':upd}) 

def addteacher (request):
    return render(request,'addteacher.html')

def addtdetial(request):
    if request.method=='POST':
        t_name=request.POST.get('t_name')
        t_email=request.POST.get('t_email')
        t_department=request.POST.get('t_department')
        t_semester=request.POST.get('t_semester')
        t_password=request.POST.get('t_password')
        print(t_name)
        print(t_email)
        print(t_department)
        print(t_semester)
        print(t_password)
        log=teachers(t_name=t_name,t_email=t_email,t_department=t_department,t_semester=t_semester,t_password=t_password)
        log.save()
        return render(request,'addteacher.html')


def tprofile(request):
    tem=request.session['tid']
    vpro= teachers.objects.get(id=tem)
    return render(request,'tprofile.html',{'result':vpro})

def tcview(request):
    # Show complaints that students sent to teachers
    user = staffcomplaint.objects.all()
    return render(request, 'tcview.html', {'result': user})
def tack(request):
    return render(request,'tack.html')

def tackupload(request):
    if request.method=='POST':
        ack=request.POST.get('ack')
        status=request.POST.get('status')
        date=request.POST.get('date')
        cid=request.POST.get('cid')
        i_id=request.POST.get('i_id')
       
        print(ack)
        print(status)
        print(date)
        log=acknowledgement(ack=ack,status=status,date=date,apid=i_id,cid=cid)
        log.save()
        return redirect(tcview)
def tcapproved(request,id):
    up=staffcomplaint.objects.get(id=id)
    a=up.complaint
    c=up.uid
    d=up.princy
    ins=staffcomplaint(complaint=a,status='approved',uid=c,princy=d,id=id)
    ins.save()
    
    return render(request,'tack.html',{'result':up}) 


def manual_student_attendance(request):
    """View to allow teachers to manually mark student attendance"""
    if 'tid' not in request.session:
        return redirect('studentlogin')
        
    from datetime import datetime
    
    # Fetch teacher's department
    teacher_dept = None
    try:
        teacher_obj = teachers.objects.get(id=request.session['tid'])
        teacher_dept = teacher_obj.t_department
    except teachers.DoesNotExist:
        pass
        
    # Filter students by department
    student_list = students.objects.all()
    if teacher_dept:
        student_list = student_list.filter(st_department=teacher_dept)
    
    context = {
        'students': student_list,
        'today': datetime.now().date().strftime('%Y-%m-%d'),
        'teacher_dept': teacher_dept
    }
    
    if request.method == 'POST':
        student_id = request.POST.get('student_id')
        attendance_date = request.POST.get('attendance_date')
        attendance_time = request.POST.get('time')
        status = request.POST.get('status')
        slot = request.POST.get('slot')
        
        try:
            student_attendance.objects.create(
                st_id=student_id,
                date=attendance_date,
                time=attendance_time,
                status=status,
                slot=slot
            )
            context['message'] = "Attendance recorded successfully!"
            context['message_type'] = "success"
            context['message_icon'] = "check-circle"
        except Exception as e:
            context['message'] = f"Error recording attendance: {str(e)}"
            context['message_type'] = "danger"
            context['message_icon'] = "exclamation-triangle"
            
    return render(request, 'manual_student_attendance.html', context)


def send_absence_email_view(request):
    """
    Handle request to send absence notification email
    """
    if 'tid' not in request.session and not request.session.get('admin'):
        return redirect('login')
        
    student_id = request.GET.get('student_id')
    date_str = request.GET.get('date')
    absent_slots_str = request.GET.get('slots') # e.g. "1,2,3"
    
    if not all([student_id, date_str, absent_slots_str]):
        return redirect('viewattendence_tch')
        
    try:
        from datetime import datetime
        # Handle both formats YYYY-MM-DD (input) and MMM. DD, YYYY (display)
        try:
            attendance_date = datetime.strptime(date_str, '%Y-%m-%d').date()
        except ValueError:
            # Try parsing the display format "Feb. 10, 2026"
            import datetime as dt
            # Date formatting in Django template is often like: Feb. 10, 2026
            # We'll just pass the string if it's already a date object or string representation
            attendance_date = date_str
            
        slots_absent = [int(s) for s in absent_slots_str.split(',') if s]
        
        success = send_absence_notification(student_id, attendance_date, slots_absent)
        
        if success:
            request.session['email_status'] = "Notification sent successfully!"
        else:
            request.session['email_error'] = "Failed to send email. Check if parent email is set."
            
    except Exception as e:
        request.session['email_error'] = f"Error: {str(e)}"
        
    return redirect(request.META.get('HTTP_REFERER', 'viewattendence_tch'))

