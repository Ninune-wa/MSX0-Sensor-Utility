Link:
[https://github.com/Ninune-wa/MSX0-Sensor-Utility/tree/main/M5Unit-DUAL_BUTTON](https://github.com/Ninune-wa/MSX0-Sensor-Utility/tree/main/M5Unit-DUAL_BUTTON)

.dsk:
[https://github.com/Ninune-wa/MSX0-Sensor-Utility/blob/main/MSX0-Sensor-Utility.dsk](https://github.com/Ninune-wa/MSX0-Sensor-Utility/blob/main/MSX0-Sensor-Utility.dsk)
## M5 DUAL BUTTON UNITの動作確認用プログラムです。

### [プログラム１]

*注 DUAL BUTTON UNITはPORT.Bで青ボタンのIN（白）、赤ボタンのIN(黄)となっているが、2024/5時点のMSX0Stackのファームウェア(ver:0.05.04)では、PORT.BのIN(白),OUT(黄)のGPIOピンが固定されてしまっており変更もできないため、製品をMSX0StackにPORT.Bに接続しても青のボタンしか反応しません。

このプログラムは、抵抗を4つ使用したR-２Rラダー回路をDUAL BUTTON UNITとMSX0Stackの間に取り付けを行った前提で２つのボタンを判定しています。R-２Rラダー回路の制作は後半に記載しています。

PORT.B(ANALOG)に接続したM5 DUAL BUTTON UNITの押したボタンに応じて画面描写をします。

赤ボタン：LCD左側に赤四角

青ボタン：LCD右側に青四角


### BASICプログラム
- [M5D-BTN.BAS](https://github.com/Ninune-wa/MSX0-Sensor-Utility/blob/main/M5Unit-ANGLE/M5D-BTN.BAS)

### R-2Rラダー回路の追加(改造Groveケーブル)
材料：

Grove ケーブル 20cm　１個

10KΩ抵抗 1個

20KΩ抵抗 3個


### 製品情報
- M5 DUAL BUTTON UNIT
- SKU:U025

https://docs.m5stack.com/ja/unit/angle
