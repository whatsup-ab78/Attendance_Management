
import cv2
import os

def create_data(contents):
    base_dir="ml_code/"
    """
    f=open(base_dir+"input.txt", "r")
    contents =f.read()"""
    print(contents)



    database = base_dir+'database'
    dataset = contents
    path = os.path.join(database,dataset)
    if not os.path.isdir(path):
        os.mkdir(path)

    # create objects
    cam = cv2.VideoCapture(0)
    
    if not cam.isOpened():
        print("[ERROR] Could not open camera.")
        return {"status": "error", "message": "Camera not found or could not be accessed."}
        
    faceD = cv2.CascadeClassifier(base_dir+"haarcascade_frontalface_default.xml")
    count = 1
    
    import datetime
    start_time_cam = datetime.datetime.now()
    
    while (cam.isOpened()):
        
        # Max out running time to 15 seconds if nothing happens, to avoid hanging
        if (datetime.datetime.now() - start_time_cam).seconds > 15:
            print("[INFO] Camera timeout reached (15 seconds) during registration. Closing.")
            cam.release()
            cv2.destroyAllWindows()
            return {"status": "error", "message": "Camera timed out before detecting a face properly. Please ensure you are visible."}
            
        ret, frame = cam.read()
        if not(ret):
            continue
        gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
        faces = faceD.detectMultiScale(gray, 1.3, 5)
        for (x,y,w,h) in faces:
            cv2.rectangle(frame,(x,y),(x+w,y+h),(255,0,0),2)
            face = gray[y:y+h,x:x+w]
            face = cv2.resize(face,(130,100))
            cv2.imwrite('{}/{}.png'.format(path,count), face)
            count+=1
            if count==31:
                cam.release()
                cv2.destroyAllWindows()
                return {"status": "success", "message": "Face captured successfully."}

        cv2.imshow("video", frame)
        if cv2.waitKey(1) & 0xFF == ord("q"):
            cam.release()
            cv2.destroyAllWindows()
            return {"status": "warning", "message": "Manual cancellation."}
            
    return {"status": "error", "message": "Camera closed unexpectedly."}
			
#fun1('2')




