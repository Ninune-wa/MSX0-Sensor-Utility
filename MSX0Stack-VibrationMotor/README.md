## MSX0Stackの内蔵振動モーターの動作確認用プログラムです。

内蔵振動モーターを2秒間振動させます。

### 振動モーターに関する仕様
MSX0Stackの振動モーターは、AXP192のLDO3に接続されています。

AXP192 I2C Address： ０x３４

LDO3の制御レジスター: 12H

LDO3の制御: Bit3(0:disable 1:enable)


### Ex.コマンドライン(ワンライナー)
コマンドラインにコピペして動作を確認できます。
- 振動ON
```
DT$="device/i2c_i/34":RG$=CHR$(&H12):_IOTPUT(DT$,RG$):_IOTGET(DT$,V):_IOTPUT(DT$,RG$+CHR$(V OR &B00001000))
```

- 振動OFF
```
DT$="device/i2c_i/34":RG$=CHR$(&H12):_IOTPUT(DT$,RG$):_IOTGET(DT$,V):_IOTPUT(DT$,RG$+CHR$(V AND &B11110111))
```

- 振動ON/OFF（トグル）
```
DT$="device/i2c_i/34":RG$=CHR$(&H12):_IOTPUT(DT$,RG$):_IOTGET(DT$,V):_IOTPUT(DT$,RG$+CHR$(V XOR &B00001000))
```
