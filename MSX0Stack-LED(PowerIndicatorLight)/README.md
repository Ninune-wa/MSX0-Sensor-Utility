## MSX0StackのPower Indicator Light(Green LED)の動作確認用プログラムです。

0.5秒間隔でLEDを点灯/消灯します。

### Power Indicator Lightに関する仕様
MSX0StackのPower Indicator Lightは、AXP192のGPIO1に接続されています。[AXP192 Dataseet](https://github.com/m5stack/M5-Schematic/blob/master/Core/AXP192%20Datasheet_v1.1_en_draft_2211.pdf)

AXP192 I2C Address: ０x３４

GPIO1の制御レジスター: 94H

GPIO1の制御: Bit1(1:disable 0:enable)


### Ex.コマンドライン(ワンライナー)
コマンドラインにコピペして動作を確認できます。
- LED ON
```
DT$="device/i2c_i/34":RG$=CHR$(&H94):_IOTPUT(DT$,RG$):_IOTGET(DT$,V):_IOTPUT(DT$,RG$+CHR$(V AND &B11111101))
```

- LED OFF
```
DT$="device/i2c_i/34":RG$=CHR$(&H94):_IOTPUT(DT$,RG$):_IOTGET(DT$,GV):_IOTPUT(DT$,RG$+CHR$(GV OR &B00000010))
```

- LED ON/OFF（トグル）
```
DT$="device/i2c_i/34":RG$=CHR$(&H94):_IOTPUT(DT$,RG$):_IOTGET(DT$,GV):_IOTPUT(DT$,RG$+CHR$(GV XOR &B00000010))
```