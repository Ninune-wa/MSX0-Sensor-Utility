## MSX0Stackの内蔵振動モーターの動作確認用プログラムです。

内蔵振動モーターを2秒間振動させます。

### コマンドライン(ワンライナー)

振動ON
```
D$="device/i2c_i/34":RG$=CHR$(&H12):_IOTPUT(D$,RG$):_IOTGET(D$,S):_IOTPUT(D$,RG$+CHR$(S OR &B00001000))
```

振動OFF
```
D$="device/i2c_i/34":RG$=CHR$(&H12):_IOTPUT(D$,RG$):_IOTGET(D$,S):_IOTPUT(D$,RG$+CHR$(S AND &B11110111))
```

振動ON/OFF（トグル）
```
D$="device/i2c_i/34":RG$=CHR$(&H12):_IOTPUT(D$,RG$):_IOTGET(D$,S):_IOTPUT(D$,RG$+CHR$(S XOR &B00001000))
```
