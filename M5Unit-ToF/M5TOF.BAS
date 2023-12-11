100 'SAVE "M5TOF.BAS"
110 'Test Code: M5 UNIT ToF for MSX0
120 'https://docs.m5stack.com/en/unit/tof
130 'Init
140   CLS:SCREEN 1:DEFINT A-Z:KEY OFF:WIDTH 32:COLOR 15,0,0
150   DIM GB(16),DB$(16) 'GetString Buffer,Debug Buffer
160   DEF FN HEX0$(VI)=RIGHT$("0"+HEX$(VI),2)'Function: "0" + HEX$
170   IL=6:DL=16 'Infomation Locate:Debug Locate
180   IA$="29" 'I2C Address for Unit ToF
190   DT$="device/i2c_a" 'Device Tree
200 'Device Check
210   _IOTFIND(DT$,FI)
220   IF FI=0 THEN PRINT "Internal I2C device not found...":BEEP:END
230   _IOTFIND(DT$,FS$(0),FI)
240   DT$=DT$+"/"+IA$ 'Device Tree for Unit ToF
250   FOR I=0 TO FI-1:IF FS$(I)=IA$ THEN 270 ELSE NEXT I
260   PRINT "Unit ToF is not found...":BEEP:END
270 'Main
280   LOCATE 5,0:PRINT "VLX53LOX Example"
290   RG$=CHR$(&H0)'VL53L0X_REG_SYSRANGE_START
300   PS$=RG$+CHR$(&H1):_IOTPUT(DT$,PS$)'ToF START
310   TIME=0
320   RG$=CHR$(&H14)'VL53L0X_REG_RESULT_RANGE_STATUS
330   PS$=RG$:_IOTPUT(DT$,PS$)'
340   'Time out
350   IF TIME > 60 THEN LOCATE 0,22:PRINT "not redy":GOTO 270
360   _IOTGET(DT$,GS$):VA=ASC(LEFT$(GS$,1))
370   IF (VA AND &H1) <> 1 THEN 350
380   LOCATE 0,22:PRINT "redy    "
390   'Buffering
400   _IOTPUT(DT$,PS$):_IOTGET(DT$,GS$)
410   FOR I=0 TO 15:GB(I)=ASC(MID$(GS$,I+1,1)):NEXT I
420 '  GOSUB 570 'Debug print
430   'Generate values
440   L$=FN HEX0$(GB(7)) :H$=FN HEX0$(GB(6)) :AC=VAL("&H"+H$+L$)'Ambient Count:
450   L$=FN HEX0$(GB(9)) :H$=FN HEX0$(GB(8)) :SC=VAL("&H"+H$+L$)'Signal Count:
460   L$=FN HEX0$(GB(11)):H$=FN HEX0$(GB(10)):DC=VAL("&H"+H$+L$)'Distance:
470   ST=(GB(0) AND &H78) / 8                                   'DeviceRangeStatusInternal
480 'Print
490   LOCATE 0,IL  :PRINT USING "Ambient Count:#### ";AC
500   LOCATE 0,IL+1:PRINT USING "Signal  Count:#### ";SC
510   LOCATE 0,IL+2:PRINT USING "Distance [mm]:#### ";DC
520   LOCATE 0,IL+3:PRINT USING "DeviceStatus :#### ";ST
530   'Wait
540   TIME=0
550   IF TIME < 10 THEN 550
560   GOTO 270 'Return Main
570 'Debug print
580   FOR I=0 TO 15:DB$(I)=FN HEX0$(GB(I)):NEXT I
590   LOCATE 0,DL  :PRINT USING "@:@:@:@:@:@:@:@";DB$(0) ;DB$(1) ;DB$(2) ;DB$(3) ;DB$(4) ;DB$(5) ;DB$(6) ;DB$(7)
600   LOCATE 0,DL+1:PRINT USING "@:@:@:@:@:@:@:@";DB$(8) ;DB$(9) ;DB$(10);DB$(11);DB$(12);DB$(13);DB$(14);DB$(15)
610   RETURN
