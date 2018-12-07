# 背景介绍
Breeze是AliOS Thing OS提供基于蓝牙链路连接阿里云的安全通道和服务，除提供蓝牙辅助配网功能外还提供OTA升级功能。功能组件组成如下图:

![Breeze](https://img.alicdn.com/tfs/TB1g8mgupzqK1RjSZSgXXcpAVXa-1094-728.png)

说明：
* 通道为必选功能，认证以及应用层的OTA，辅助配网可以选择使能。
* HAL层提供了对接第三方ble stack和OS,安全的接口抽象。

# 应用事例
AliOS提供典型事例:breezeapp演示breeze的基本能力和服务。
## 测试环境
* Nordic 官方开发板pca10056(基于nRF52840)，或者pca10040(基于nRF52832)。
* 预装有Alibaba提供的XlinkDemo的Android或者IOS手机(请联系Ali获取)。
## 软件代码
* AliOS things代码仓库，在编译环境使用app/example/bluetooth/breezeapp事例。
* 编译命令aos make bluetooth.breezeapp@pca10056
## 测试步骤
以IOS应用为例:
* 烧录编译的固件之pca10056。
* 登录XlinkDemo(注意环境需要与设备端五元组信息匹配)，打开主界面并且扫描蓝牙设备。
* 点击并连接,界面会有连接成功和安全通道建立提示。
* 通过手机端发送数据，设备端回传数据，手机界面会有提示和hex数据显示。

![phone_app_1](https://img.alicdn.com/tfs/TB1DZ9muAvoK1RjSZFwXXciCFXa-936-1620.png)

![phone_app_2](https://img.alicdn.com/tfs/TB1gc9juwHqK1RjSZFgXXa7JXXa-928-1616.png)

## 测试结果
手机界面会相应提示和数据显示。


# 编程手册
请参阅[Breeze用户编程接口说明](https://github.com/alibaba/AliOS-Things/wiki/Breeze-用户编程接口说明)