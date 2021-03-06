# 蓝牙辅助WiFi配网简介

WiFi设备需要连接WiFi热点（WiFi AP）之后才能与其它设备进行IP通信，对于没有键盘、没有触摸屏、没有Web Server的WiFi IoT设备而言，如何获取WiFi热点的SSID/密码是实现设备远程管理的第一个关键步骤。

我们将WiFi设备获取到WiFi热点的SSID/密码的步骤称为WiFi配网，蓝牙辅助WiFi配网方案**适用于同时支持蓝牙BLE以及WiFi的设备**，该方案通过蓝牙BLE通道将WiFi热点的SSID/密码发送给WiFi设备，从而让WiFi设备可以连接到WiFi AP（通常为WiFi无线路由器）。蓝牙辅助WiFi配网的工作原理示意图如下：

![ble_1](https://img.alicdn.com/tfs/TB1gEGdowDqK1RjSZSyXXaxEVXa-554-133.png)

蓝牙辅助配网的步骤如下：
* 用户在手机APP上选择需要配网的WiFi设备的产品型号
* 用户在手机APP上输入上网WiFi热点的SSID/密码
* 用户启动设备的蓝牙辅助WiFi配网功能，SDK将会返回第一个发现的指定型号的设备
* 手机APP建立与指定设备的蓝牙连接，并通过该连接发送WiFi热点的SSID/密码
* WiFi设备使用接收到的SSID/密码连接指定的AP

# 蓝牙辅助WiFi配网的构成
* 蓝牙辅助配网设备端SDK

需要支持蓝牙辅助配网功能的WiFi模组/设备需要集成蓝牙辅助配网设备端SDK，以实现从手机APP接收WiFi热点的SSID/密码

* 配网手机端SDK

若手机APP希望通过蓝牙辅助配网将WiFi热点的SSID/密码发送给WiFi设备，需要集成支持了蓝牙辅助配网的手机端配网SDK

* 蓝牙辅助配网Demo APP

设备开发厂商通过该APP调试蓝牙辅助配网功能，以确定WiFi设备上的蓝牙辅助配网功能是否已正常工作

# 开发过程说明

## 模组商/设备商开发过程
如果您是一个WiFi的模组商或者设备商，您的模组/设备支持蓝牙BLE以及WiFi并且希望集成阿里云IoT提供的蓝牙辅助WiFi配网功能，那么可以按照下面的过程进行模组/设备开发：

![ble_2](https://img.alicdn.com/tfs/TB1a.ejoAvoK1RjSZPfXXXPKFXa-585-56.png)

**说明：**
* 模组商/设备商在开发模组/设备时需要在阿里云IoT生活物联网平台进行产品定义，产品定义时“通讯方式”选择“WIFI”；
* 设备需要与阿里云IoT生活物联网平台进行通信，因此设备上除了需要具有蓝牙辅助配网功能外，还需要集成阿里云IoT提供的其它软件模块，至少需要包含的软件模块包括MQTT连云、物模型、蓝牙辅助配网、AliOS Kernel，其它软件模块根据产品的需要进行选择；
* 模组商/设备商在集成蓝牙辅助WiFi配网功能时，需要对蓝牙辅助WiFi配网功能模块的HAL进行适配
* 模组商/设备商需要设备的WiFi配网启动、关闭与蓝牙辅助配网的用户编程接口进行对接
* 使用阿里云IoT事业部提供的Demo App进行蓝牙辅助WiFi功能验证


# 手机APP开发商开发过程

如果您的手机APP需要对支持蓝牙辅助WiFi配网的设备进行配网，那么手机APP需要集成阿里云IoT提供的支持蓝牙辅助配网的手机SDK，过程如下所示：

![ble_3](https://img.alicdn.com/tfs/TB1qCCfoxTpK1RjSZFKXXa2wXXa-581-61.png)

**注：**
* 手机配网SDK支持多种配网方式，手机APP开发者需要知道设备支持哪些配网方式，并可自行决定使用哪种配网方式对设备发起WiFi配网

# 开发说明

## 设备端开发说明

### 代码获取
点击获取[AliOS Things最新代码](https://github.com/alibaba/AliOS-Things)，其中包含了Link Kit SDK（设备连接阿里云的多个软件功能模块）、蓝牙辅助WiFi配网。
* 蓝牙辅助WiFi配网模块目录：network/bluetooth/breeze
* Link Kit SDK：middleware/linkkit

### HAL接口适配
请点击查看蓝牙辅助WiFi配网的[HAL定义以及说明](https://github.com/alibaba/AliOS-Things/wiki/蓝牙辅助WiFi配网HAL说明)。

### 用户接口编程指南
本节描述如何对蓝牙配网进行初始化，以及如何使用该模块提供的[蓝牙辅助WiFi配网编程接口说明](https://github.com/alibaba/AliOS-Things/wiki/蓝牙辅助WiFi配网编程接口说明)。


# 手机端开发说明
## 安卓
### 编程指南系统
请阅读[android配网SDK开发说明](https://github.com/alibaba/AliOS-Things/wiki/Android-配网SDK开发说明)了解如何使用手机端配网SDK，该文档描述了所有的配网方案（包含蓝牙辅助配网）。蓝牙辅助配网和其它配网在使用方式上有以下几点区别：
* APP需要先开启手机蓝牙
* 配网参数需要增加ProductID，该参数可以在智能生活平台的商家后台获取
* 配网linkType设置为ForceAliLinkTypeBLE

### 调试
设备厂商可以使用[DemoAPP](https://github.com/alibaba/AliOS-Things/wiki/Android-配网-Demo-使用)调试设备是否正确集成了蓝牙配网参考。


## iOS系统

### 编程指南
请阅读[iOS配网开发说明](https://github.com/alibaba/AliOS-Things/wiki/iOS配网开发说明)了解如何使用手机端配网SDK，该文档描述了所有的配网方案。蓝牙辅助配网和其它配网使用方式上有以下几点区别：
* APP需要先开启手机蓝牙
* 设置待添加设备信息中，IMLCandDeviceModel 需要传入productId，并指定linkType 为ForceAliLinkTypeBLE

### 调试

设备厂商可以使用[DemoAPP使用](https://github.com/alibaba/AliOS-Things/wiki/iOS-配网Demo使用说明)设备是否正确集成了蓝牙配网参考
