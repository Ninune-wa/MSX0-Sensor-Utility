100 'SAVE"M5D-BTN.BAS
110 'Test Code: M5 UNIT Dual-BUTTON for MSX0
120 'https://docs.m5stack.com/en/unit/dual_button
130 'To use this unit with MSX0, cable modifications are required.
140   CLS:SCREEN 5:COLOR 15,0,0
150 'Init
160   NP=2560 '00:Not  Pressed
170   RP=1490 '01:Red  Pressed
180   BP=560  '10:Blue Pressed
190   BT=0    '11:BoTh pressed
200   RG=200  '+-RanGe
210   _IOTPUT("device/analog/out",0) 'Output Noise Disable
220 'Main
230   _IOTGET("device/analog/in",GI)
240   IF GI>RP-RG AND GI<RP+RG THEN GOSUB 320 'Red  Button
250   IF GI>BP-RG AND GI<BP+RG THEN GOSUB 300 'Blue Button
260   IF GI=BT THEN GOSUB 340                 'Both Button
270   IF GI>NP-RG AND GI<NP+RG THEN CLS
280   GOTO 220
290 END
300 'Red Button
310   LINE(128,0)-(256,212),4,BF:RETURN
320 'Blue Button
330   LINE(0,0)-(128,212),8,BF:RETURN
340 'Both Button
350   GOSUB 300:GOSUB 320:RETURN
