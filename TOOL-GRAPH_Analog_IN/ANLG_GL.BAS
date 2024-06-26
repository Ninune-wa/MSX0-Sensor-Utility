100 'SAVE"ANLG_GL.BAS"
110 'Graphs analog inputs
120 'Init
130   SCREEN 5:COLOR 15,0,0:DEFINT A-Z
140   _IOTPUT("msx/me/pm/cpu/percent",200) 'Kaio-ken x2
150   ON STOP GOSUB 490:STOP ON
160   TH=1 'topIsHigh 1:true 0:false
170   TD=0:BD=204:X=5 'Top Display,Bottom Display ,X:magnification
180   NX=0:NY=8:MX=256:MY=202 'Canvas Size: miN X,Y / Max X,Y
190   NV=0:MV=4095 ' miN Value / Max Value
200   ST#=0:SC=0:AG=0 ' Sampling Total / Sampling Count / AveraGe
210   OPEN "GRP:" AS #1
220   _IOTPUT("device/analog/out",0) 'Output Noise Disable
230 'Display Clear
240   CLS:DX=0
250   IF TH=1 THEN TD=0:BD=204:ZY=MY:OY=0 ELSE TD=204:BD=0:ZY=0:OY=NY
260   PSET(0,TD),0:PRINT #1,"HIGH(4095)"
270   PSET(0,BD),0:PRINT #1,"LOW(0)"
280   NV=4095:MV=0:ST#=0:SC=0
290 'Main
300   _IOTGET("device/analog/in",GI):VL=GI
310   DY=ABS(ZY-VL/4095*(MY-NY))+OY
320   IF DX=0 THEN PSET(DX,DY) ELSE LINE(BX,BY)-(DX,DY),15
330   BX=DX:BY=DY 'Backup Display X,Y
340   SN=5-LEN(STR$(VL)):PSET(110,TD),0:PRINT #1,VL;SPC(SN)
350   PSET(55,BD),0:PRINT #1,"x";X
360   DX=DX+X
370   IF VL>MV THEN MV=VL:SN=5-LEN(STR$(VL)):PSET(190,TD),0:PRINT #1,"MAX";MV;SPC(SN)
380   IF VL<NV THEN NV=VL:SN=5-LEN(STR$(VL)):PSET(190,BD),0:PRINT #1,"MIN";NV;SPC(SN)
390   ST#=ST#+VL:SC=SC+1:AG=ST#/SC
400   SN=5-LEN(STR$(AG)):PSET(110,BD),0:PRINT #1,"AVG";AG;SPC(SN)
410 'Key or Touch
420   PF=0
430   IF PAD(4)=-1 THEN PX=PAD(5):IF PX<55 THEN PF=1 ELSE IF PX<200 THEN PF=2 ELSE PF=3
440   IF STRIG(0)=-1 OR PF=2 THEN TH=TH XOR 1:GOTO 230
450   IF STICK(0)=3 OR PF=3 THEN IF X<>10 THEN X=X+1
460   IF STICK(0)=7 OR PF=1 THEN IF X<>1 THEN X=X-1
470   IF DX>=256 THEN 230
480   GOTO 290
490 'End of Kaio-ken
500   _IOTPUT("msx/me/pm/cpu/percent",100)
510 END
