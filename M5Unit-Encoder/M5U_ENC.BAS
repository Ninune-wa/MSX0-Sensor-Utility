100 'SAVE "M5U_ENC.BAS"
110 'Test Code: M5 Unit Encoder for MSX0
120 'https://docs.m5stack.com/ja/unit/encoder
130 'Init
140   CLS
150   DEFINT A-Z
155   WE$="":WB$="":L=0
160   _IOTFIND("device/i2c_a",C)
170   IF C=0 THEN 210
180   _IOTFIND("device/i2c_a",A$(0),C)
190   C$="40" 'Device number
200   FOR I I=0 TO C-1:IF A$(I)=C$ THEN 220 ELSE NEXT I
210   PRINT "M5 Unit Encoder is not found...":END
220   N$="device/i2c_a/"+A$(I)
230 'Init device
240   GOSUB 480
250 'Main loop
260   LOCATE 0,11:GOSUB 290'Print & Read Button status
270   LOCATE 0,12:GOSUB 360'Print & Read encoder value
280   GOTO 250
290 'Print & Read Button status: REG,BTN STATUS
300   C$=CHR$(&H20)
310   _IOTPUT(N$,C$):_IOTGET(N$,S$)
320   IF WB$=S$ THEN GOTO 350 ELSE WB$=S$
330   BS$=HEX$(ASC(MID$(S$,1,1))):IF BS$="0" THEN GOSUB 500:BS$="Press" ELSE GOSUB 480:BS$="-----"
340   PRINT "BUTTON : ";BS$
350   RETURN
360 'Print & Read encoder value: REG,VALUE_L,VALUE_H
370   C$=CHR$(&H10)
380   _IOTPUT(N$,C$):_IOTGET(N$,S$)
390   IF WE$=S$ THEN GOSUB 480:GOTO 460 ELSE WE$=S$
400   L$=HEX$(ASC(MID$(S$,1,1))):IF LEN(L$)=1 THEN L$="0"+L$
410   H$=HEX$(ASC(MID$(S$,2,1))):IF LEN(H$)=1 THEN H$="0"+H$
420   E=VAL("&H"+H$+L$)
430   IF L>E THEN GOSUB 540 ELSE GOSUB 520
440   L=E
450   PRINT "ENCODER:";E
460   RETURN
470 'Control RGB LED Color: REG,LED index,RED,GREEN,BLUE
480   'Init       - both OFF
490   C$=CHR$(&H30)+CHR$(&H0)+CHR$(&H0)+CHR$(&H0)+CHR$(&H0):GOTO 560
500   'Button     - both BLUE
510   C$=CHR$(&H30)+CHR$(&H0)+CHR$(&H0)+CHR$(&H0)+CHR$(&HFF):GOTO 560
520   'Left turn  - led1 RED
530   C$=CHR$(&H30)+CHR$(&H1)+CHR$(&HFF)+CHR$(&H0)+CHR$(&H0):GOTO 560
540   'Right turn - led1 GREEN
550   C$=CHR$(&H30)+CHR$(&H2)+CHR$(&H0)+CHR$(&HFF)+CHR$(&H0):GOTO 560
560   _IOTPUT(N$,C$)
570   RETURN
