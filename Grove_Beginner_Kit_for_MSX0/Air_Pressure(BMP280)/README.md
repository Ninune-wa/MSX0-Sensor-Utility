Link:
[https://github.com/Ninune-wa/MSX0-Sensor-Utility/tree/main/Grove_Beginner_Kit_for_MSX0/Air_Pressure(BMP280)](https://github.com/Ninune-wa/MSX0-Sensor-Utility/tree/main/Grove_Beginner_Kit_for_MSX0/Air_Pressure(BMP280))

.dsk:
[https://github.com/Ninune-wa/MSX0-Sensor-Utility/blob/main/MSX0-Sensor-Utility.dsk](https://github.com/Ninune-wa/MSX0-Sensor-Utility/blob/main/MSX0-Sensor-Utility.dsk)
## Grove Begginner Kit for MSX0　の温度・気圧センサー（BMP280）の動作確認用プログラムです。

BMP280から、温度・気圧・簡易高度を表示します。

0.センサーを切り離さないで使用するには、事前に中央のArduinoに空のスケッチを書き込む等で、無効化する必要があります。(I2Cが正しく動作しないため)
１.センサーはMSX0のPort.A(赤)に接続します。

ANK表示
-----BMP280-----
temperature :   **.** degrees C
Pressure    : ****.** hPa
Approx altit:   ***.** m
----------------

漢字表示
気温：℃
気圧：　hPa
高度(簡易)：　m

※ANKと漢字の表示はKJを０と1で切り替えできます。
1060   KJ=1 ' 0:ANK mode 1:KANJI mode


### BASICプログラム
- [KTBMP280.BAS](https://github.com/Ninune-wa/MSX0-Sensor-Utility/blob/main/Grove_Beginner_Kit_for_MSX0/Air_Pressure(BMP280)/KTBMP280.BAS)

