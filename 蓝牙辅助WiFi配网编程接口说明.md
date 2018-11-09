用户可以通过调用蓝牙辅助WiFi配网SDK提供的接口来启动和完成WiFi设备的配网。AliOS Things中提供了参考代码，位于app/example/comboapp/目录下。

下面是蓝牙辅助WiFi配网的编程接口列表：

### void breeze\_awss\_init(apinfo\_ready\_cb cb, breeze\_dev\_info\_t \*info)
<span data-type="color" style="color:#262626">该接口对蓝牙配网SDK进行初始化。在用户业务逻辑初始化阶段调用。</span>
参数说明如下：
* cb：为设备完成WiFi信息（SSID、密码）获取后的回调函数，由用户定义/提供，并由SDK完成调用。该回调函数的参数为SDK获取到的AP信息（SSID、密码、BSSID）。一般用户在该回调函数中处理WiFi连接、AP连接通告、Link Kit连云等操作，细节可以参考AliOS Things中提供的参考代码。
* info：为设备信息，包括ProductID，Product Key，Product Secret，Device Name，Device Secret等字段，由用户提供。

### void breeze\_awss\_start()
<span data-type="color" style="color:#262626">该接口启动蓝牙配网。</span>

### 用户接口代码示例

<div data-type="alignment" data-value="center" style="text-align:center">
  <div data-type="p">
    <div id="of7yuu" data-type="image" data-display="block" data-align="" data-src="https://cdn.nlark.com/lark/0/2018/png/63251/1540890078710-c7a215f5-215a-4544-8d17-9520f4fb60f7.png" data-width="747">
      <img src="https://cdn.nlark.com/lark/0/2018/png/63251/1540890078710-c7a215f5-215a-4544-8d17-9520f4fb60f7.png" width="747" />
    </div>
  </div>
</div>


