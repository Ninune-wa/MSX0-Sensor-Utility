100 'SAVE "M5TOF.BAS
110 'Test Code: M5 UNIT ToF
120 'Init
130   CLS:SCREEN 1:DEFINT A-Z:KEY OFF:WIDTH 32:COLOR 15,0,0
140   DIM GB(16),DB$(16) 'GetString Buffer,Debug Buffer
150   DEF FN HEX0$(VI)=RIGHT$("0"+HEX$(VI),2)'Function: "0" + HEX$
160   IL=6:DL=16 'Infomation Locate:Debug Locate
170   IA$="29" 'I2C Address for Unit ToF
180   DT$="device/i2c_a" 'Device Tree
190 'Device Check
200   _IOTFIND(DT$,FI)
210   IF FI=0 THEN PRINT "Internal I2C device not found...":BEEP:END
220   _IOTFIND(DT$,FS$(0),FI)
230   DT$=DT$+"/"+IA$ 'Device Tree for Unit ToF
240   FOR I=0 TO FI-1:IF FS$(I)=IA$ THEN 260 ELSE NEXT I
250   PRINT "Unit ToF is not found...":BEEP:END
260 'Main
270   LOCATE 5,0:PRINT "VLX53LOX Example"
280   RG$=CHR$(&H0)'VL53L0X_REG_SYSRANGE_START
290   PS$=RG$+CHR$(&H1):_IOTPUT(DT$,PS$)'ToF START
300   TIME=0
310   RG$=CHR$(&H14)'VL53L0X_REG_RESULT_RANGE_STATUS
320   PS$=RG$:_IOTPUT(DT$,PS$)'
330   'Time out
340   IF TIME > 60 THEN LOCATE 0,22:PRINT "not redy":GOTO 260
350   _IOTGET(DT$,GS$):VA=ASC(LEFT$(GS$,1))
360   IF (VA AND &H1) <> 1 THEN 340
370   LOCATE 0,22:PRINT "redy    "
380   'Buffering
390   _IOTPUT(DT$,PS$):_IOTGET(DT$,GS$)
400   FOR I=0 TO 15:GB(I)=ASC(MID$(GS$,I+1,1)):NEXT I
410 '  GOSUB 560 'Debug print
420   'Generate values
430   L$=FN HEX0$(GB(7)) :H$=FN HEX0$(GB(6)) :AC=VAL("&H"+H$+L$)'Ambient Count:
440   L$=FN HEX0$(GB(9)) :H$=FN HEX0$(GB(8)) :SC=VAL("&H"+H$+L$)'Signal Count:
450   L$=FN HEX0$(GB(11)):H$=FN HEX0$(GB(10)):DC=VAL("&H"+H$+L$)'Distance:
460   ST=(GB(0) AND &H78) / 8                                   'DeviceRangeStatusInternal
470 'Print
480   LOCATE 0,IL  :PRINT "Ambient Count: ";AC;"     "
490   LOCATE 0,IL+1:PRINT "Signal  Count: ";SC;"     "
500   LOCATE 0,IL+2:PRINT "Distance [mm]: ";DC;"     "
510   LOCATE 0,IL+3:PRINT "DeviceStatus : ";ST;"     "
520   'Wait
530   TIME=0
540   IF TIME < 10 THEN 540
550   GOTO 260 'Return Main
560 'Debug print
570   FOR I=0 TO 15:DB$(I)=FN HEX0$(GB(I)):NEXT I
580   LOCATE 0,DL  :PRINT DB$(0) ;":";DB$(1) ;":";DB$(2) ;":";DB$(3) ;":";DB$(4) ;":";DB$(5) ;":";DB$(6) ;":";DB$(7)
590   LOCATE 0,DL+1:PRINT DB$(8) ;":";DB$(9) ;":";DB$(10);":";DB$(11);":";DB$(12);":";DB$(13);":";DB$(14);":";DB$(15)
600   RETURN
