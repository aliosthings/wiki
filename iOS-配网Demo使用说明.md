# XLink Demo APP 使用
## 配网路径
* 打开 WiFi和蓝牙
* 打开 LinkDemo APP
* 注册登录
* 选择“调试”Tab-> “配网测试入口，测试” ->"统一配网" -"蓝牙辅助配网"
* 输入PK(productKey)，PID( productID)，点击开始配网，按提示输入SSID & 设备进入配网模式
* 查看 APP 界面显示的配网结果，以及设备是否配网成功

## APP 界面


![Frame.png | center | 827x489](https://cdn.nlark.com/lark/0/2018/png/6296/1540281144856-f2abc418-7154-4d17-b94f-199f322f1144.png "")




![Frame1.png | center | 562x491](https://cdn.nlark.com/lark/0/2018/png/6296/1540281158135-80d267fd-377e-47c1-a490-11b2fd8e6716.png "")



## 常见问题
### 配网失败超时
__现象__：界面显示 “配网失败，错误信息：Error Domain = com.alibaba.IMSDeviceCenter Code =10167 'provision time out'....”
__分析__：配网超时，没有扫描到和二维码对应PI的蓝牙设备，导致超时失败。
可以看到如下SDK日志：
10-23 15:57:02.096 | AWSS - IMLAddDeviceBiz:368 | 101607(ble provision fail, 配网超时)


