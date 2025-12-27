100 'SAVE "0LED_RBW.BAS"
110 'Controls the 10 full-color LEDs on both sides with rainbow colors.
120 'Init
130   CLS:DEFINT A-Z:ON STOP GOSUB 530:STOP ON
140   GOSUB 480 'All LEDs off
150   _IOTPUT("device/leds/trans_ms",10)
160   R=0:G=0:B=0:N=1 'R,G,B: 4bit color values, N: Number of controlled LEDs
170   'Load preset colors
180   FOR I=0 TO 9
190   READ R,G,B
200   G=G*&H10:N=1*&H10 '4-bit left shift
210   LE$(I)=CHR$(G+B)+CHR$(N+R)
220   NEXT I
230   'Expand color data into PS$ (IoT PutString)
240   PS$=""
250   FOR J=0 TO 9
260   PS$=PS$+LE$(J)
270   NEXT J
280 'Main
290   _IOTPUT("device/leds/data",PS$)
300   'Rotate LED pattern
310   PS$=MID$(PS$,3,18)+LEFT$(PS$,2)
320   _IOTPUT("device/leds/data",PS$)
330   'Wait
340   TIME=0
350   IF TIME<2 THEN 350
360   GOTO 300 'Loop
370 'Rainbow Colors
380   DATA 15,0,0
390   DATA 15,9,0
400   DATA 12,15,0
410   DATA 3,15,0
420   DATA 0,15,6
430   DATA 0,15,15
440   DATA 0,6,15
450   DATA 3,0,15
460   DATA 12,0,15
470   DATA 15,0,9
480 'All LEDs off
490   _IOTPUT("device/leds/data",0)
520   RETURN
530 'Reinitialize console
540   COLOR 15,4,7
550   GOSUB 480 'All LEDs off
560   END
