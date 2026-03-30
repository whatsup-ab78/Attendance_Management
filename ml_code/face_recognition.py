# -*- coding: utf-8 -*-

import cv2
import pickle
import datetime
import os
import mysql.connector

# load labels
label = list(os.listdir('ml_code/database'))


# ==========================
# DATABASE FUNCTION
# ==========================

# Define 6 time slots
SLOTS = {
    1: {"start": "09:00", "end": "10:00", "late_cutoff": "09:10"},
    2: {"start": "10:00", "end": "11:00", "late_cutoff": "10:10"},
    3: {"start": "11:00", "end": "12:00", "late_cutoff": "11:10"},
    4: {"start": "12:00", "end": "13:00", "late_cutoff": "12:10"},
    5: {"start": "14:00", "end": "15:00", "late_cutoff": "14:10"},
    6: {"start": "15:00", "end": "16:00", "late_cutoff": "15:10"},
}


def get_current_slot(time_str):
    """Determine which slot the current time belongs to"""
    from datetime import datetime
    current_time = datetime.strptime(time_str, "%H:%M:%S").time()
    
    for slot_num, slot_info in SLOTS.items():
        start_time = datetime.strptime(slot_info["start"], "%H:%M").time()
        end_time = datetime.strptime(slot_info["end"], "%H:%M").time()
        
        if start_time <= current_time < end_time:
            return slot_num
    
    return None


def mark_attendance(stud_id, date, time, status):
    """
    Mark entry or exit attendance for current slot.
    Allows multiple entry/exit per day (one per slot).
    """
    
    mydb = mysql.connector.connect(
        host="localhost",
        user="root",
        password="",
        database="student"
    )

    cursor = mydb.cursor()
    
    # Determine current slot
    slot_num = get_current_slot(time)
    
    if slot_num is None:
        print(f"[INFO] Time {time} is outside of any slot - attendance not marked")
        cursor.close()
        mydb.close()
        return None
    
    # Check if already marked this status for this slot today
    check_sql = """
    SELECT id FROM studentgrievence_student_attendance
    WHERE st_id=%s AND date=%s AND status=%s AND slot=%s
    """
    cursor.execute(check_sql, (stud_id, date, status, slot_num))
    
    if cursor.fetchone() is None:
        # Insert attendance record with slot number
        insert_sql = """
        INSERT INTO studentgrievence_student_attendance
        (st_id, date, time, status, slot)
        VALUES (%s, %s, %s, %s, %s)
        """
        cursor.execute(insert_sql, (stud_id, date, time, status, slot_num))
        mydb.commit()
        print(f"[INFO] Slot {slot_num} - {status.upper()} marked for {stud_id} at {time}")
    else:
        print(f"[INFO] Slot {slot_num} - {status.upper()} already marked for {stud_id}")
    
    cursor.close()
    mydb.close()
    return slot_num


# ==========================
# FACE RECOGNITION FUNCTION
# ==========================
def face_recognize(status, expected_uid=None):

    base_dir = "ml_code/"

    cam = cv2.VideoCapture(0)
    
    if not cam.isOpened():
        print("[ERROR] Could not open camera for face recognition.")
        return {"status": "error", "message": "Camera not found or could not be accessed."}

    model = cv2.face.LBPHFaceRecognizer_create()
    model.read(base_dir + 'model.xml')

    faceD = cv2.CascadeClassifier(
        base_dir + "haarcascade_frontalface_default.xml"
    )

    with open(base_dir + 'model.pkl', 'rb') as f:
        ids = pickle.load(f)

    last_marked = {}  # {(user_id, date, slot, status): True}
    
    start_time_cam = datetime.datetime.now()

    while cam.isOpened():
        
        # Max out running time to 15 seconds if nothing happens, to avoid hanging
        if (datetime.datetime.now() - start_time_cam).seconds > 15:
            print("[INFO] Camera timeout reached (15 seconds). Closing.")
            cam.release()
            cv2.destroyAllWindows()
            return {"status": "warning", "message": "Camera timed out before recognizing a face."}

        ret, frame = cam.read()
        if not ret:
            continue

        gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
        faces = faceD.detectMultiScale(gray, 1.3, 5)

        for (x, y, w, h) in faces:

            face = gray[y:y + h, x:x + w]
            face = cv2.resize(face, (130, 100))

            result = model.predict(face)
            confidence = result[1]

            if confidence < 100:

                uid = ids[int(result[0])]
                
                # Validation check against logged in user
                if expected_uid and str(uid) != str(expected_uid):
                    cv2.putText(frame, "Face Mismatch!", (x, y + h + 30), cv2.FONT_HERSHEY_SIMPLEX, 0.8, (0, 0, 255), 2)
                    cv2.imshow("Face Attendance", frame)
                    cv2.waitKey(2000)
                    cam.release()
                    cv2.destroyAllWindows()
                    return {"status": "error", "message": "Face does not match the logged-in student account."}

                now = datetime.datetime.now()
                date = now.strftime("%Y-%m-%d")
                time = now.strftime("%H:%M:%S")
                
                # Get current slot
                slot_num = get_current_slot(time)

                # draw rectangle & name
                cv2.rectangle(frame, (x, y), (x + w, y + h), (0, 255, 0), 2)
                
                # Display slot info
                display_text = f"{uid} - Slot {slot_num}" if slot_num else f"{uid} - No Slot"
                cv2.putText(
                    frame,
                    display_text,
                    (x, y - 10),
                    cv2.FONT_HERSHEY_SIMPLEX,
                    0.8,
                    (0, 255, 0),
                    2
                )

                # mark attendance once per slot per status
                if slot_num and last_marked.get((uid, date, slot_num, status)) != True:
                    marked_slot = mark_attendance(uid, date, time, status)
                    if marked_slot:
                        last_marked[(uid, date, slot_num, status)] = True
                        cv2.putText(frame, "Attendance Marked", (x, y + h + 30), cv2.FONT_HERSHEY_SIMPLEX, 0.8, (0, 255, 0), 2)
                        cv2.imshow("Face Attendance", frame)
                        cv2.waitKey(2000)
                        cam.release()
                        cv2.destroyAllWindows()
                        return {"status": "success", "message": f"Attendance marked successfully for Slot {slot_num}."}

            else:
                cv2.putText(
                    frame,
                    "Unknown",
                    (x, y - 10),
                    cv2.FONT_HERSHEY_SIMPLEX,
                    0.8,
                    (0, 0, 255),
                    2
                )

        cv2.imshow("Face Attendance", frame)

        if cv2.waitKey(1) & 0xFF == ord('q'):
            break

    cam.release()
    cv2.destroyAllWindows()
    return {"status": "warning", "message": "Attendance marking closed manually."}


# ==========================
# START PROGRAM
# ==========================
#face_recognize("attendance_marked")
