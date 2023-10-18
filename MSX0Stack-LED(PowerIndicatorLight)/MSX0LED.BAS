100 'SAVE "MSX0LED.BAS
110 'Test Code: MSX0Stack LED(Green power indicator light)
120 'Init
130   CLS:SCREEN 1:DEFINT A-Z:KEY OFF:WIDTH 32:COLOR 15,0,0
140   IA$="34" 'I2C Address for Unit Encoder
150   DT$="device/i2c_i" 'Device Tree
160   RG$=CHR$(&H94) 'REG 94H:GPIO 2:0  signal status set and monitor
170 'Device Check
180   _IOTFIND(DT$,C)
190   IF C=0 THEN PRINT "Internal I2C device not found...":BEEP:END
200   DT$=DT$+"/"+IA$ 'Device Tree for AXP192
210 'Main
220   GOSUB 290'LED ON/OFF
230   GOSUB 250"Wait
240   GOTO 210
250 'Wait
260   TIME=0
270   IF TIME<30 THEN 270
280   RETURN
290 'LED ON/OFF
300   _IOTGET(DT$,GV)
310   'PRINT "REG(";HEX$(ASC(RG$));"H):&H";HEX$(GV)
320   _IOTPUT(DT$,RG$+CHR$(GV XOR &B00000010))
330   RETURN
