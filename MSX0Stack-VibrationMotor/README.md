## MSX0Stackの内蔵振動モーターの動作確認用プログラムです。

内蔵振動モーターを2秒間振動させます。

### 振動モーターに関する仕様
MSX0Stackの振動モーターは、AXP192のLDO3に接続されています。
AXP192 I2C Address：０x３４
LDO3の制御レジスター:12H
LDO3の制御:Bit3(0:disable 1:enable)

### Ex.コマンドライン(ワンライナー)
コマンドラインにコピペして動作を確認できます。
- 振動ON
```
D$="device/i2c_i/34":RG$=CHR$(&H12):_IOTPUT(D$,RG$):_IOTGET(D$,S):_IOTPUT(D$,RG$+CHR$(S OR &B00001000))
```

- 振動OFF
```
D$="device/i2c_i/34":RG$=CHR$(&H12):_IOTPUT(D$,RG$):_IOTGET(D$,S):_IOTPUT(D$,RG$+CHR$(S AND &B11110111))
```

- 振動ON/OFF（トグル）
```
D$="device/i2c_i/34":RG$=CHR$(&H12):_IOTPUT(D$,RG$):_IOTGET(D$,S):_IOTPUT(D$,RG$+CHR$(S XOR &B00001000))
```
