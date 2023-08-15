10 'SAVE "M5U_ENC.BAS"
20 'Test Code: M5 Unit Encoder for MSX0
30 'https://docs.m5stack.com/ja/unit/encoder
40 'Init
50   CLS
60   DEFINT C,I:WE$="":WB$="":LV%=0
70   _IOTFIND("device/i2c_a",C)
80   IF C=0 THEN 120
90   _IOTFIND("device/i2c_a",A$(0),C)
100   C$="40" 'Device number
110   FOR I I=0 TO C-1:IF A$(I)=C$ THEN 130 ELSE NEXT I
120   PRINT "M5 Unit Encoder is not found...":END
130   N$="device/i2c_a/"+A$(I)
140 'Init device
150    GOSUB 390
160 'Main loop
170   LOCATE 0,11:GOSUB 200'Print & Read Button status
180   LOCATE 0,12:GOSUB 270'Print & Read encoder value
190   GOTO 160
200 'Print & Read Button status: REG,BTN STATUS
210   C$=CHR$(&H20)
220   _IOTPUT(N$,C$):_IOTGET(N$,S$)
230   IF WB$=S$ THEN GOTO 260 ELSE WB$=S$
240   BS$=HEX$(ASC(MID$(S$,1,1))):IF BS$="0" THEN GOSUB 410:BS$="Press" ELSE GOSUB 390:BS$="-----"
250   PRINT "BUTTON : ";BS$
260   RETURN
270 'Print & Read encoder value: REG,VALUE_L,VALUE_H
280   C$=CHR$(&H10)
290   _IOTPUT(N$,C$):_IOTGET(N$,S$)
300   IF WE$=S$ THEN GOSUB 390:GOTO 370 ELSE WE$=S$
310   L$=HEX$(ASC(MID$(S$,1,1))):IF LEN(L$)=1 THEN L$="0"+L$
320   H$=HEX$(ASC(MID$(S$,2,1))):IF LEN(H$)=1 THEN H$="0"+H$
330   EV%=VAL("&H"+H$+L$)
340   IF LV%>EV% THEN GOSUB 450 ELSE GOSUB 430
350   LV%=EV%
360   PRINT "ENCODER:";EV%
370   RETURN
380 'Control RGB LED Color: REG,LED index,RED,GREEN,BLUE
390   'Init       - both OFF
400   C$=CHR$(&H30)+CHR$(&H0)+CHR$(&H0)+CHR$(&H0)+CHR$(&H0):GOTO 470
410   'Button     - both BLUE
420   C$=CHR$(&H30)+CHR$(&H0)+CHR$(&H0)+CHR$(&H0)+CHR$(&HFF):GOTO 470
430   'Left turn  - led1 RED
440   C$=CHR$(&H30)+CHR$(&H1)+CHR$(&HFF)+CHR$(&H0)+CHR$(&H0):GOTO 470
450   'Right turn - led1 GREEN
460   C$=CHR$(&H30)+CHR$(&H2)+CHR$(&H0)+CHR$(&HFF)+CHR$(&H0):GOTO 470
470   _IOTPUT(N$,C$)
480   RETURN
