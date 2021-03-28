# BIBLIOTECAS UTILIZADAS
import numpy as np
import cv2
import queue


#####################################################################
# FUNÇÕES AUXILIARES
#####################################################################

def getCommon(q,sec):
    
    if q.full():
        f1 = None
        f2 = None
        f3 = None
        f4 = None
        f5 = None
        i=1
        for f in q.queue:
            if i == 1:
                f1 = f
            elif i == 2:
                f2 = f
            elif i == 3:
                f3 = f
            elif i == 4:
                f4 = f
            elif i == 5:
                f5 = f
            i+=1

        # Calculo Mediana das frames
        sequence = np.stack((f1,f2,f3,f4,f5),axis = 3)
        res = np.median(sequence,axis =3).astype(np.uint8)
        
        if sec:
            return res

        # Conversão do Background para gray
        bckGrnd_gray_frame=cv2.cvtColor(res,cv2.COLOR_BGR2GRAY)
        bckGrnd_gray_frame=cv2.GaussianBlur(bckGrnd_gray_frame,(25,25),0)
        cv2.imshow('Background Gray Scale',bckGrnd_gray_frame)
        return bckGrnd_gray_frame

#####################################################################

#####################################################################
# INICIALIZAÇÃO DE VARIÁVEIS
#####################################################################
i = 0
q1 = queue.Queue(5)
q2 = queue.Queue(5)
q3 = queue.Queue(5)
cap = cv2.VideoCapture(0)
frame_width = int(cap.get(3))
frame_height = int(cap.get(4))
ret, frame1 = cap.read()
out = cv2.VideoWriter('output.avi',cv2.VideoWriter_fourcc('M','J','P','G'), 10, (frame_width,frame_height))
ret, frame1 = cap.read()
frame2 = None

median1 = None
median2 = None
#####################################################################

#####################################################################
# CICLO PRINCIPAL DE EXECUÇÃO
#####################################################################
while(True):
    orig = np.copy(frame1)
    bckGrnd_gray_frame=cv2.cvtColor(frame1,cv2.COLOR_BGR2GRAY)
    bckGrnd_gray_frame=cv2.GaussianBlur(bckGrnd_gray_frame,(25,25),0)

    if frame2 is None:
        frame2=bckGrnd_gray_frame
        continue

    # Calcular diferença entre frame atual e Background
    delta=cv2.absdiff(frame2,bckGrnd_gray_frame)

    # Sinalizar diferenças num frame puro preto e branco
    threshold=cv2.threshold(delta,35,255, cv2.THRESH_BINARY)[1]

    # Encontrar contornos da diferença
    (contours,_)=cv2.findContours(threshold,cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

    # Desenhar Sinalizações
    movement = False
    j = 1
    for contour in contours:
        
        if cv2.contourArea(contour) < 5000:
            continue

        movement = True
        (x, y, w, h)=cv2.boundingRect(contour)
        cv2.rectangle(frame1, (x, y), (x+w, y+h), (0,255,0), 1)
        cv2.putText(frame1,"Change {}".format(j),(x,y-5),cv2.FONT_HERSHEY_PLAIN,1,(0,255,0),2)
        cv2.putText(frame1,"Status: Changes detected",(5,30),cv2.FONT_HERSHEY_SIMPLEX,1,(0,0,255),2)
        j += 1
    
    if not movement:
        cv2.putText(frame1,"Status: No changes detected",(5,30),cv2.FONT_HERSHEY_SIMPLEX,1,(0,255,0),2)

    # Atualizar Frames
    cv2.imshow("Main Frame Gray Scale",bckGrnd_gray_frame)
    cv2.imshow("Delta Frame",delta)
    cv2.imshow("Threshold Frame",threshold)
    cv2.imshow("Main Frame",frame1)
    out.write(frame1)
    
    if i % 5 == 0:
        if q3.full():
            q3.get()
        
        q3.put(orig)

        if q3.full():
            median1 = getCommon(q3,True)

    if i % 25 == 0 and i != 0:
        if q2.full():
            q2.get()
        
        q2.put(median1)

        if q2.full():
            median2 = getCommon(q2,True)
            

    
    if i % 125 == 0 and i != 0:
        if q1.full():
            q1.get()

        q1.put(median2)

        if q1.full():
            frame2 = getCommon(q1,False)
        
        i = 0
    
    ret, frame1 = cap.read()


    # Inputs
    key = cv2.waitKey(1)
    if  key == ord('q'):
        break
    elif key == ord('r'):
        frame2=bckGrnd_gray_frame
        while not q1.empty():
            q1.get()
        while not q2.empty():
            q2.get()
    
    i+=1

#####################################################################

#####################################################################
# SAIDA DO PROGRAMA
#####################################################################

cap.release()
cv2.destroyAllWindows()

#####################################################################

# Instruções Teclado:
# Q/q -> Sair do progrma
# R/r -> Reset Background
