100 'SAVE "M5U_ENC.BAS"
110 'Test Code: M5 Unit Encoder for MSX0
120 'https://docs.m5stack.com/ja/unit/encoder
130 'Init
140   CLS
150   SCREEN 1:DEFINT A-Z:KEY OFF:WIDTH 32:COLOR 15,0,0
160   WE$="":WB$="":L=0
170   _IOTFIND("device/i2c_a",C)
180   IF C=0 THEN 220
190   _IOTFIND("device/i2c_a",A$(0),C)
200   C$="40" 'Device number
210   FOR I I=0 TO C-1:IF A$(I)=C$ THEN 230 ELSE NEXT I
220   PRINT "M5 Unit Encoder is not found...":END
230   D$="device/i2c_a/"+A$(I)
240 'Init device
250   GOSUB 490
260 'Main loop
270   LOCATE 0,11:GOSUB 300'Print & Read Button status
280   LOCATE 0,12:GOSUB 370'Print & Read encoder value
290   GOTO 260
300 'Print & Read Button status: REG,BTN STATUS
310   C$=CHR$(&H20)
320   _IOTPUT(D$,C$):_IOTGET(D$,S$)
330   IF WB$=S$ THEN GOTO 360 ELSE WB$=S$
340   BS$=HEX$(ASC(MID$(S$,1,1))):IF BS$="0" THEN GOSUB 510:BS$="Press" ELSE GOSUB 490:BS$="-----"
350   PRINT "BUTTON : ";BS$
360   RETURN
370 'Print & Read encoder value: REG,VALUE_L,VALUE_H
380   C$=CHR$(&H10)
390   _IOTPUT(D$,C$):_IOTGET(D$,S$)
400   IF WE$=S$ THEN GOSUB 490:GOTO 470 ELSE WE$=S$
410   L$=HEX$(ASC(MID$(S$,1,1))):IF LEN(L$)=1 THEN L$="0"+L$
420   H$=HEX$(ASC(MID$(S$,2,1))):IF LEN(H$)=1 THEN H$="0"+H$
430   E=VAL("&H"+H$+L$)
440   IF L>E THEN GOSUB 550 ELSE GOSUB 530
450   L=E
460   PRINT "ENCODER:";E
470   RETURN
480 'Set LED number & LED color(RGB)
490   'Init       - both OFF
500   N$=CHR$(&H0):R$=CHR$(&H0):G$=CHR$(&H0):B$=CHR$(&H0):GOTO 570
510   'Button     - both BLUE
520   N$=CHR$(&H0):R$=CHR$(&H0):G$=CHR$(&H0):B$=CHR$(&HFF):GOTO 570
530   'Left turn  - led1 RED
540   N$=CHR$(&H1):R$=CHR$(&HFF):G$=CHR$(&H0):B$=CHR$(&H0):GOTO 570
550   'Right turn - led1 GREEN
560   N$=CHR$(&H2):R$=CHR$(&H0):G$=CHR$(&HFF):B$=CHR$(&H0):GOTO 570
570 'Control RGB LED Color: REG,LED index,RED,GREEN,BLUE
580   C$=CHR$(&H30):C$=C$+N$+R$+G$+B$
590   C$=C$+N$+R$+G$+B$
600   _IOTPUT(D$,C$)
610   RETURN
