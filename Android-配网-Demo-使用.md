# XLink Demo APP 使用
## 配网路径
* 打开 WiFi和蓝牙
* 打开 XLinkSdkDemo APP
* 注册登录
* 选择“统一配网”-> “扫码方式配网”
* 扫描二维码开始配网 & 设备进入配网模式
* 查看 APP 界面显示的配网结果，以及设备是否配网成功

## 二维码数据格式
二维码格式（pk必选，蓝牙辅助配网pi也必选，dn如果不知道不要填写这个key和value）：
{"pk":"xxx","dn":"xxx","type":"5","pi":"xxx","pwd":"xxx"}
备注：pk-productKey， dn-deviceName， pi-productId， type-配网方式 5代表蓝牙辅助配网，pwd当前wifi密码

## APP 界面

![android_demo1](https://img.alicdn.com/tfs/TB1uNCSoCzqK1RjSZFjXXblCFXa-3360-1991.png)

![android_demo_2](https://img.alicdn.com/tfs/TB1D.9TowHqK1RjSZJnXXbNLpXa-3360-1991.png)

## 常见问题
### 配网失败超时
**现象**：界面显示 “配网结果：失败 provisionTimeout IDLE[BLE_SCANNING]”
**分析**：配网超时，没有扫描到和二维码对应PI的蓝牙设备，导致超时失败。
可以看到如下SDK日志：
09-21 11:13:36.592 27249-29959/com.aliyun.iot.linksdk.demox E/AWSS-AddDeviceBiz: state=AddStateProvisionOver,isSuccess=false,info=null,error=DCErrorCode [code:101617, subcode:0, codeName:PROVISION_TIMEOUT, message:provisionTimeout IDLE[BLE_SCANNING], extra:null]
### 配网失败-异常指令 
**现象**：界面显示 “配网结果：失败 BLE close connection, received un-match message.code=2147483647”
**分析**：待配置的蓝牙设备配置协议和手机端的不匹配或该蓝牙设备不支持该蓝牙辅助配网。
可以看到如下SDK日志：
09-21 20:16:17.369 18928-18928/com.aliyun.iot.linksdk.demox E/AWSS-AddDeviceBiz: state=AddStateProvisionOver,isSuccess=false,info=null,error=DCErrorCode [code:101608, subcode:60209, codeName:DEVICE_FAIL, message:BLE close connection, received un-match message.code=2147483647, extra:STARTED[BLE_CLOSE_CONNECTION]]

### 配网失败-连接断开 
**现象**：界面显示 “ 配网结果：失败 BLE error, disconnected.”
**分析**：蓝牙连接被断开了，有可能是连接认证失败或者设备端端开了或者底层蓝牙自己断开了。
可以看到如下SDK日志：
09-21 20:11:36.223 18928-18928/com.aliyun.iot.linksdk.demox E/AWSS-AddDeviceBiz: state=AddStateProvisionOver,isSuccess=false,info=null,error=DCErrorCode [code:101604, subcode:60207, codeName:SDK_ERROR, message:BLE error, disconnected., extra:PREPARING[BLE_DISCONNECTED]]
