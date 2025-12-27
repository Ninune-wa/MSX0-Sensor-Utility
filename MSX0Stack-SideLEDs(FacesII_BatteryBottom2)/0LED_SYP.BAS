100 'SAVE "0LED_SYP.BAS"
110 'Controls the 10 full-color LEDs on both sides with cyberpunk colors.
120 'Init
130   CLS:DEFINT A-Z:ON STOP GOSUB 550:STOP ON
140   GOSUB 520 'All LEDs off
150   _IOTPUT("device/leds/trans_ms",500)
160   R=0:G=0:B=0:N=1 'R,G,B: 4bit color values, N: Number of controlled LEDs
170   'Load preset colors
180   FOR I=0 TO 9
190   READ R,G,B
200   G=G*&H10:N=&HA*&H10 '4-bit left shift
210   LE$(I)=CHR$(G+B)+CHR$(N+R)
220   NEXT I
230 'Main
240   FOR J=0 TO 9
250   PS$=LE$(J):_IOTPUT("device/leds/data",PS$)
260   'Wait
270   TIME=0
280   IF TIME<90 THEN 280
290   NEXT J
300   GOTO 230
310 'Cyberpunk Colors
320  'Neon Pink
330   DATA 15,0,8
340  'Hot Magenta
350   DATA 15,0,15
360  'Acid Purple
370   DATA 10,0,15
380  'Electric Blue
390   DATA 0,4,15
400  'Cyan Blue
410   DATA 0,10,15
420  'Neon Cyan
430   DATA 0,15,15
440  'Teal
450   DATA 0,15,8
460  'Neon Green
470   DATA 4,15,0
480  'Cyber Green
490   DATA 0,15,0
500  'Deep Purple
510   DATA 8,0,12
520 'All LEDs off
530   _IOTPUT("device/leds/data",0)
540   RETURN
550 'Reinitialize console
560   COLOR 15,4,7
570   GOSUB 520 'All LEDs off
580   END
