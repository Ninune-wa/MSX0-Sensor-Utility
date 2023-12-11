100 'SAVE "M5ANGLE.BAS"
110 'Test Code: M5 Unit ANGLE for MSX0
120 'https://docs.m5stack.com/en/unit/angle
130   CLS:SCREEN 1:DEFINT A-Z:KEY OFF:WIDTH 32:COLOR 15,0,0
140   _IOTPUT("device/analog/out",0) 'Noise Reduction
150   _IOTGET("device/analog/in",A) 'A= MIN:0, MAX:4095
160   LOCATE 0,12:PRINT USING "VALUE:######";A
170   GOTO 150
