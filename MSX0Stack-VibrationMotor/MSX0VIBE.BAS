100 'SAVE "MSX0VIBE.BAS"
110 'Test Code: MSX0Stack Vibration motor
120 'Init
130   CLS:SCREEN 1:DEFINT A-Z:KEY OFF:WIDTH 32:COLOR 15,0,0
140   IA$="34" 'I2C Address for Unit Encoder
150   DT$="device/i2c_i" 'Device Tree
160   RG$=CHR$(&H12) 'REG 12H:DC-DC1/3 & LDO2/3 output control
170 'Device Connect Check
180   _IOTFIND(DT$,FI)
190   IF FI=0 THEN PRINT "Internal I2C device not found...":BEEP:END
200   _IOTFIND(DT$,FS$(0),FI)
210   DT$=DT$+"/"+IA$ 'Device Tree for AXP192
220   FOR I=0 TO FI-1:IF FS$(I)=IA$ THEN 240 ELSE NEXT I
230   PRINT "AXP192 is not found...":BEEP:END
240 'Main
250   GOSUB 290'VIBE ON
260   GOSUB 430'Wait
270   GOSUB 360'VIBE OFF
280   END
290 'Vibration ON :REG 12H LDO3 switch cotrol Bit3 (1:enable)
300   PRINT "Vibration ON"
310   _IOTPUT(DT$,RG$):_IOTGET(DT$,GI)
320   'print "REG(";rg$;"):&H";hex$(gi)
330   PS$=RG$+CHR$(GI OR &B00001000)
340   _IOTPUT(DT$,PS$)
350   RETURN
360 'Vibration OFF:REG 12H LDO3 switch cotrol Bit3 (0:disable)
370   PRINT "Vibration OFF"
380   _IOTPUT(DT$,RG$):_IOTGET(DT$,GI)
390   'print "REG(";rg$;"):&H";hex$(gi)
400   PS$=RG$+CHR$(GI AND &B11110111)
410   _IOTPUT(DT$,PS$)
420   RETURN
430 'Wait n Second
440   TIME=0
450   N=2'n Second
460   WT=N*60
470   PRINT "Wait";N;"Second"
480   IF TIME<WT THEN 480
490   RETURN
