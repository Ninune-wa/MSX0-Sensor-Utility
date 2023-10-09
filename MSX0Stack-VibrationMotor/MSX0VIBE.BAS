100 'SAVE "MSX0VIBE.BAS"
110 'Test Code: MSX0Stack Vibration motor
120 'https://github.com/m5stack/M5-Schematic/blob/master/Core/AXP192 20Datasheet_v1.1_en_draft_2211.pdf
130 'Init
140   CLS:SCREEN 1:DEFINT A-Z:KEY OFF:WIDTH 32:COLOR 15,0,0
150   DT$="device/i2c_i/34" 'Device Tree for AXP192
160   RG$=CHR$(&H12) 'REG 12H:DC-DC1/3 & LDO2/3 output control
170 'Main
180   GOSUB 220'VIBE ON
190   GOSUB 360'Wait
200   GOSUB 290'VIBE OFF
210   END
220 'Vibration ON :REG 12H LDO3 switch cotrol Bit3 (1:enable)
230   PRINT "Vibration ON"
240   _IOTPUT(DT$,RG$):_IOTGET(DT$,GV)
250   'PRINT "REG(";RG$;"):&H";HEX$(GV)
260   PV$=RG$+CHR$(GV OR &B00001000)
270   _IOTPUT(DT$,PV$)
280   RETURN
290 'Vibration OFF:REG 12H LDO3 switch cotrol Bit3 (0:disable)
300   PRINT "Vibration OFF"
310   _IOTPUT(DT$,RG$):_IOTGET(DT$,GV)
320   'PRINT "REG(";RG$;"):&H";HEX$(GV)
330   PV$=RG$+CHR$(GV AND &B11110111)
340   _IOTPUT(DT$,PV$)
350   RETURN
360 'Wait n Second
370   TIME=0
380   N=2'n Second
390   WT=N*60
400   PRINT "Wait";N;"Second"
410   IF TIME<WT THEN 410
420   RETURN
