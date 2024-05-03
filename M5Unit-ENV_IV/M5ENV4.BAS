1000 'SAVE "M5ENV4.BAS"
1010 'Test Code: M5 UNIT ENV.IV for MSX0
1020 'https://docs.m5stack.com/en/unit/ENV%E2%85%A3%20Unit
1030 'Init
1040   _IOTPUT("msx/me/pm/cpu/percent",200) 'Kaio-ken x2
1050   SCREEN 1:DEFINT A-Z:KEY OFF:WIDTH 32:COLOR 15,4,7
1060   KJ=1 ' 0:ANK mode 1:KANJI mode
1070   IF KJ=0 THEN CLS:ON STOP GOSUB 2730 ELSE _KANJI:_CLS:ON STOP GOSUB 2710
1080   STOP ON
1090   DEF FN HEX0$(VI)=RIGHT$("0"+HEX$(VI),2)'Function: "0" + HEX$
1100   DIM GB(16),DB$(16) 'GetString Buffer,Debug Buffer
1110   DIM IA$(10) ' I2C Address Array
1120   DIM DT$(5) ' Device Tree Name Array
1130   EC=0 'Error Counter
1140   DA$="device/i2c_a" 'Device Tree(PORT.A)
1150   DI$="device/i2c_i" 'Device Tree(Internal)
1160   IL=3:DL=16 'Infomation Locate:Debug Locate
1170   IA$(0)="44" '0x44:I2C Address for Unit ENV.IV(SHT40)
1180   IA$(1)="76" '0x76:I2C Address for Unit ENV.IV(BMP280)
1190   DT$(0)=DA$+"/"+IA$(0) 'Device Tree for Unit ENV.IV(SHT40)
1200   DT$(1)=DA$+"/"+IA$(1) 'Device Tree for Unit ENV.IV(BMP280)
1210 'Device Check(PORT.A)
1220   _IOTFIND(DA$,FI)
1230   IF FI=0 THEN PRINT "(PORT.A) I2C Device not found...":BEEP:END
1240   _IOTFIND(DA$,FS$(0),FI)
1250   FOR J=0 TO 9
1260    IF VAL(IA$(J))=0 THEN 1280 ELSE FOR I=0 TO FI-1:IF FS$(I)=IA$(J) THEN 1280 ELSE NEXT I
1270    PRINT "(PORT.A)I2C Device ID 0x";IA$(J);"is not found...":EC=EC+1
1280   NEXT J
1290   IF EC<>0 THEN BEEP:END
1300 'Device Init(BMP280)
1310  'BMP280:readCoefficients();
1320   RG$=CHR$(&H88):_IOTPUT(DT$(1),RG$):_IOTGET(DT$(1),GS$):GOSUB 2620:T1!=(GB(1)*256)+GB(0)                        'BMP280_REGISTER_DIG_T1 = 0x88
1330   RG$=CHR$(&H8A):_IOTPUT(DT$(1),RG$):_IOTGET(DT$(1),GS$):GOSUB 2620:T2=VAL("&H"+FN HEX0$(GB(1))+FN HEX0$(GB(0))) 'BMP280_REGISTER_DIG_T2 = 0x8A
1340   RG$=CHR$(&H8C):_IOTPUT(DT$(1),RG$):_IOTGET(DT$(1),GS$):GOSUB 2620:T3=VAL("&H"+FN HEX0$(GB(1))+FN HEX0$(GB(0))) 'BMP280_REGISTER_DIG_T3 = 0x8C
1350   RG$=CHR$(&H8E):_IOTPUT(DT$(1),RG$):_IOTGET(DT$(1),GS$):GOSUB 2620:P1!=(GB(1)*256)+GB(0)                        'BMP280_REGISTER_DIG_P1 = 0x8E
1360   RG$=CHR$(&H90):_IOTPUT(DT$(1),RG$):_IOTGET(DT$(1),GS$):GOSUB 2620:P2=VAL("&H"+FN HEX0$(GB(1))+FN HEX0$(GB(0))) 'BMP280_REGISTER_DIG_P2 = 0x90
1370   RG$=CHR$(&H92):_IOTPUT(DT$(1),RG$):_IOTGET(DT$(1),GS$):GOSUB 2620:P3=VAL("&H"+FN HEX0$(GB(1))+FN HEX0$(GB(0))) 'BMP280_REGISTER_DIG_P3 = 0x92
1380   RG$=CHR$(&H94):_IOTPUT(DT$(1),RG$):_IOTGET(DT$(1),GS$):GOSUB 2620:P4=VAL("&H"+FN HEX0$(GB(1))+FN HEX0$(GB(0))) 'BMP280_REGISTER_DIG_P4 = 0x94
1390   RG$=CHR$(&H96):_IOTPUT(DT$(1),RG$):_IOTGET(DT$(1),GS$):GOSUB 2620:P5=VAL("&H"+FN HEX0$(GB(1))+FN HEX0$(GB(0))) 'BMP280_REGISTER_DIG_P5 = 0x96
1400   RG$=CHR$(&H98):_IOTPUT(DT$(1),RG$):_IOTGET(DT$(1),GS$):GOSUB 2620:P6=VAL("&H"+FN HEX0$(GB(1))+FN HEX0$(GB(0))) 'BMP280_REGISTER_DIG_P6 = 0x98
1410   RG$=CHR$(&H9A):_IOTPUT(DT$(1),RG$):_IOTGET(DT$(1),GS$):GOSUB 2620:P7=VAL("&H"+FN HEX0$(GB(1))+FN HEX0$(GB(0))) 'BMP280_REGISTER_DIG_P7 = 0x9A
1420   RG$=CHR$(&H9C):_IOTPUT(DT$(1),RG$):_IOTGET(DT$(1),GS$):GOSUB 2620:P8=VAL("&H"+FN HEX0$(GB(1))+FN HEX0$(GB(0))) 'BMP280_REGISTER_DIG_P8 = 0x9C
1430   RG$=CHR$(&H9E):_IOTPUT(DT$(1),RG$):_IOTGET(DT$(1),GS$):GOSUB 2620:P9=VAL("&H"+FN HEX0$(GB(1))+FN HEX0$(GB(0))) 'BMP280_REGISTER_DIG_P9 = 0x9E
1440 'BMP280:setSampling();
1450  'sensor_sampling(SS)
1460 ' SS=&H0 'SAMPLING_NONE = 0x00
1470 ' SS=&H1 'SAMPLING_X1 = 0x01
1480   TS=&H2 'SAMPLING_X2 = 0x02
1490 ' SS=&H3 'SAMPLING_X4 = 0x03
1500 ' SS=&H4 'SAMPLING_X8 = 0x04
1510   PS=&H5 'SAMPLING_X16 = 0X05
1520  'sensor_mode(SM)
1530 ' SM=&H0 'MODE_SLEEP = 0x00
1540 ' SM=&H1 'MODE_FORCED = 0x01
1550   SM=&H3 'MODE_NORMAL = 0x03
1560 ' SM=&HB6 'MODE_SOFT_RESET_CODE = 0xB6
1570  'sensor_filter(SF)
1580 ' SF=&H0 'FILTER_OFF = 0x00
1590 ' SF=&H1 'FILTER_X2 = 0x01
1600 ' SF=&H2 'FILTER_X4 = 0x02
1610 ' SF=&H3 'FILTER_X8 = 0x03
1620   SF=&H4 'FILTER_X16 = 0x04
1630  'standby_duration(SD)
1640 ' SD=&H0 'STANDBY_MS_1 = 0x00
1650 ' SD=&H1 'STANDBY_MS_63 = 0x01
1660 ' SD=&H2 'STANDBY_MS_125 = 0x02
1670 ' SD=&H3 'STANDBY_MS_250 = 0x03
1680   SD=&H4 'STANDBY_MS_500 = 0x04
1690 ' SD=&H5 'STANDBY_MS_1000 = 0x05
1700 ' SD=&H6 'STANDBY_MS_2000 = 0x06
1710 ' SD=&H7 'STANDBY_MS_4000 = 0x07
1720  '_measReg
1730   MD=SM '.mode = mode
1740   OT=TS '.osrs_t = tempSampling
1750   OP=PS '.osrs_p = pressSampling
1760  '_configReg
1770   FR=SF '.filter = filter
1780   TB=SD '.t_sb = duration
1790   RG$=CHR$(&HF5) 'BMP280_REGISTER_CONFIG = 0xF5
1800   PS$=RG$+CHR$(TB*32 OR FR*4 OR 0):_IOTPUT(DT$(1),PS$)
1810   RG$=CHR$(&HF4) 'BMP280_REGISTER_CONTROL = 0xF4
1820   PS$=RG$+CHR$(OT*32 OR OP*4 OR MD):_IOTPUT(DT$(1),PS$)
1830 'Main
1840   GOSUB 2580 'delay(1000);
1850 'SHT40:temperature, humidity
1860   RG$=CHR$(&HFD) '0xFD: measure T & RH with high   precision
1870 ' RG$=CHR$(&HF6) '0xF6: measure T & RH with medium precision
1880 ' RG$=CHR$(&HE0) '0xE0: measure T & RH with lowest precision
1890   PS$=RG$:_IOTPUT(DT$(0),PS$)
1900   _IOTGET(DT$(0),GS$)
1910   IF LEN(GS$)=0 THEN 1900 'Wait until value is entered
1920   GOSUB 2620 'GetString(GS$) to Array(GB)
1930   'Generate values
1940   CT!=(GB(0)*256)+GB(1)
1950   RH!=(GB(3)*256)+GB(4)
1960   TP!=-45+(175 * CT!)/65535! ' Celsius Temperature
1970   RH=-6+(125*RH!)/65535! ' Relative Humidity
1980   IF RH<0 THEN RH=0 ELSE IF RH>100 THEN RH=100
1990 'BMP280:readTemperature
2000   RG$=CHR$(&HFA):PS$=RG$ 'BMP280_REGISTER_TEMPDATA = 0xFA
2010   _IOTPUT(DT$(1),PS$)
2020   _IOTGET(DT$(1),GS$)
2030   IF LEN(GS$)=0 THEN 2020
2040   GOSUB 2620 'GetString(GS$) to Array(GB)
2050   AT#=(GB(0)*65536!)+(GB(1)*256)+GB(2)
2060   AT#=AT#/(2^4):AT#=INT(AT#)
2070   V1!=((INT(AT#/(2^3))-(T1!*2))*T2)/(2^11):V1!=INT(V1!)
2080   V2!=(INT(((INT(AT#/(2^4))-T1!)*(INT(AT#/(2^4))-T1!))/(2^12))*T3)/(2^14):V2!=INT(V2!)
2090   TF#=V1!+V2!: TF#=INT(TF#)
2100   CT!=((TF#*5)+128)/(2^8)
2110   CT!=CT!/100
2120 'BMP280:readPressure
2130   RG$=CHR$(&HF7):PS$=RG$ 'BMP280_REGISTER_PRESSUREDATA = 0xF7
2140   _IOTPUT(DT$(1),PS$)
2150   _IOTGET(DT$(1),GS$)
2160   IF LEN(GS$)=0 THEN 2150
2170   GOSUB 2620 'GetString(GS$) to Array(GB)
2180   AP#=(GB(0)*65536!)+(GB(1)*256)+GB(2)
2190   AP#=AP#/(2^4):AP#=INT(AP#)
2200   V1#=TF#-128000!:V1#=INT(V1#)
2210   V2#=V1#*V1#*P6
2220   V2#=V2#+((V1#*P5)*(2^17))
2230   V2#=V2#+(P4*(2^35))
2240   V1#=(INT(V1#*V1#*P3)/(2^8))+((V1#*P2)*(2^12))
2250   V1#=((1*(2^47)+V1#)*P1!)/(2^33):V1#=INT(V1#)
2260   P#=1048576#-AP#
2270   P#=(((P#*(2^31))-V2#)*3125)/V1#:P#=INT(P#)
2280   V1#=(P9*INT(P#/(2^13))*INT(P#/(2^13)))/(2^25):V1#=INT(V1#)
2290   V2#=(P8*P#)/(2^19):V2#=INT(V2#)
2300   P#=INT((P#+V1#+V2#)/(2^8))+(P7*(2^4))
2310   P#=INT(P#/256)
2320   HP#=P#/100
2330 'BMP280::readAltitude
2340   P#=P#/100
2350   AL#=44330!*(1-((P#/1013.25)^.1903))
2360 'Print
2370   IF KJ=1 THEN 2500
2380 'Print ANK
2390   LOCATE 0,IL  :GET DATE DA$:PRINT USING "&          &: @";"DATE";DA$
2400   LOCATE 0,IL+1:GET TIME TM$:PRINT USING "&          &: @";"TIME";TM$
2410   LOCATE 0,IL+3:PRINT "-----SHT4X-----"
2420   LOCATE 0,IL+4:PRINT USING "&          &:#####.## degrees C";"temperature";TP!
2430   LOCATE 0,IL+5:PRINT USING "&          &:#####.## % rH";"humidity";RH
2440   LOCATE 0,IL+6:PRINT "-----BMP280-----"
2450   LOCATE 0,IL+7:PRINT USING "&          &:#####.## degrees C";"temperature";CT!
2460   LOCATE 0,IL+8:PRINT USING "&          &:#####.## hPa";"Pressure";HP#
2470   LOCATE 0,IL+9:PRINT USING "&          &:#####.## m";"Approx altitude";AL#
2480   LOCATE 0,IL+10:PRINT "----------------"
2490   GOTO 1830 'Return Main
2500 'Print KANJI
2510   LOCATE 0,IL  :GET DATE DA$:PRINT USING "&          &: @";"うれおt";DA$
2520   LOCATE 0,IL+1:GET TIME TM$:PRINT USING "&          &: @";"ょせゅっ";TM$
2530   LOCATE 0,IL+3:PRINT USING "&          &:#####.## ♥ょ";"ぅキうx";TP!
2540   LOCATE 0,IL+4:PRINT USING "&          &:#####.## %";"ょシうx";RH
2550   LOCATE 0,IL+5:PRINT USING "&          &:#####.## hPa";"ぉCぃウ";HP#
2560   LOCATE 0,IL+6:PRINT USING "&          &:#####.## m";"ゅ♣うx(ぇネぃユ)";AL#
2570   GOTO 1830 'Return Main
2580 'delay(1000);
2590   TIME=0
2600   IF TIME<60 THEN 2600
2610   RETURN
2620 'GetString(GS$) to Array(GB)
2630   FOR I=0 TO 15:GB(I)=ASC(MID$(GS$,I+1,1)):NEXT I
2640   RETURN
2650 'Debug print
2660   FOR I=0 TO 15:GB(I)=ASC(MID$(GS$,I+1,1)):NEXT I
2670   FOR I=0 TO 15:DB$(I)=FN HEX0$(GB(I)):NEXT I
2680   LOCATE 0,DL  :PRINT USING "@:@:@:@:@:@:@:@";DB$(0) ;DB$(1) ;DB$(2) ;DB$(3) ;DB$(4) ;DB$(5) ;DB$(6) ;DB$(7)
2690   LOCATE 0,DL+1:PRINT USING "@:@:@:@:@:@:@:@";DB$(8) ;DB$(9) ;DB$(10);DB$(11);DB$(12);DB$(13);DB$(14);DB$(15)
2700   RETURN
2710 'Reinitialize console
2720   _ANK:_IOTINIT():COLOR 15,4,7
2730 'End of Kaio-ken
2740   _IOTPUT("msx/me/pm/cpu/percent",100)
2750 END
