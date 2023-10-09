100 'SAVE "MSX0LED.BAS
110 'Test Code: MSX0Stack LED(Green power indicator light)
120 'https://github.com/m5stack/M5-Schematic/blob/master/Core/AXP192 20Datasheet_v1.1_en_draft_2211.pdf
130 'Init
140   CLS:SCREEN 1:DEFINT A-Z:KEY OFF:WIDTH 32:COLOR 15,0,0
150   DT$="device/i2c_i/34" 'Device Tree for AXP192
160   RG$=CHR$(&H94) 'REG 94H:GPIO 2:0  signal status set and monitor
170 'Main
180   GOSUB 250'LED ON/OFF
190   GOSUB 210"Wait
200   GOTO 170
210 'Wait
220   TIME=0
230   IF TIME<30 THEN 230
240   RETURN
250 'LED ON/OFF
260   _IOTGET(DT$,GV)
270   'PRINT "REG(";HEX$(ASC(RG$));"H):&H";HEX$(GV)
280   _IOTPUT(DT$,RG$+CHR$(GV XOR &B00000010))
290   RETURN
