100 'SAVE "M5U_ENC.BAS"
110 'Test Code: M5 Unit Encoder for MSX0
120 'https://docs.m5stack.com/ja/unit/encoder
130 'Init
140   CLS:SCREEN 1:DEFINT A-Z:KEY OFF:WIDTH 32:COLOR 15,0,0
150   IA$="40" 'I2C Address for Unit Encoder
160   DT$="device/i2c_a" 'Device Tree
170   WE$="":WB=0:EV=0:LV=0
180 'Device Connect Check
190   _IOTFIND(DT$,FI)
200   IF FI=0 THEN PRINT "PORT.A is device not found...":BEEP:END
210   _IOTFIND(DT$,FS$(0),FI)
220   DT$=DT$+"/"+IA$ 'Device Tree for Unit Encorder
230   FOR I I=0 TO FI-1:IF FS$(I)=IA$ THEN 250 ELSE NEXT I
240   PRINT "M5 Unit Encoder is not found...":BEEP:END
250 'Init device
260   GOSUB 500 'LED ALL OFF
270 'Main loop
280   LOCATE 0,11:GOSUB 310'Print & Read Button status
290   LOCATE 0,12:GOSUB 380'Print & Read Encoder value
300   GOTO 270
310 'Print & Read Button status: REG,BTN STATUS
320   RG$=CHR$(&H20)
330   _IOTPUT(DT$,RG$):_IOTGET(DT$,GI)
340   IF WB=GI THEN GOTO 370 ELSE WB=GI
350   IF GI=0 THEN GOSUB 520:BS$="Press" ELSE GOSUB 500:BS$="-----"
360   PRINT "BUTTON : ";BS$
370   RETURN
380 'Print & Read encoder value: REG,VALUE_L,VALUE_H
390   RG$=CHR$(&H10)
400   _IOTPUT(DT$,RG$):_IOTGET(DT$,GS$)
410   IF WE$=GS$ THEN GOSUB 500:GOTO 480 ELSE WE$=GS$
420   L$=RIGHT$("0"+HEX$(ASC(LEFT$(GS$,1))),2)
430   H$=RIGHT$("0"+HEX$(ASC(MID$(GS$,2,1))),2)
440   EV=VAL("&H"+H$+L$)
450   IF LV>EV THEN GOSUB 560 ELSE GOSUB 540
460   LV=EV
470   PRINT "ENCODER:";EV
480   RETURN
490 'Set LED Index & LED Color(RGB)
500   'Init       - LED All OFF
510   LI$=CHR$(&H0):R$=CHR$(&H0):G$=CHR$(&H0):B$=CHR$(&H0):GOTO 580
520   'Button     - LED All BLUE
530   LI$=CHR$(&H0):R$=CHR$(&H0):G$=CHR$(&H0):B$=CHR$(&HFF):GOTO 580
540   'Left turn  - LED 1 RED
550   LI$=CHR$(&H1):R$=CHR$(&HFF):G$=CHR$(&H0):B$=CHR$(&H0):GOTO 580
560   'Right turn - LED 2 GREEN
570   LI$=CHR$(&H2):R$=CHR$(&H0):G$=CHR$(&HFF):B$=CHR$(&H0):GOTO 580
580 'Control RGB LED Color: REG,LED index,RED,GREEN,BLUE
590   RG$=CHR$(&H30)
600   PS$=RG$+LI$+R$+G$+B$
610   _IOTPUT(DT$,PS$)
620   RETURN
