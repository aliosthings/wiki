## 概述
提供了把 WiFi 设备配置上家庭路由器以及局域网内已联网设备的发现能力，具体方案包括一键广播配网（P2P）、手机热点配网、蓝牙辅助配网、智能路由器配网以及设备间相互配网等。

| 依赖SDK | 概述 |
| :--- | :--- |
| [API 通道](https://g.alicdn.com/aic/ilop-docs/2018.10.31/mobile-android-sdk-apiclient.html) | 提供云端 API 通道能力 |
| [身份认证](https://g.alicdn.com/aic/ilop-docs/2018.10.31/mobile-android-sdk-iotcredential.html) | 提供云端 API 通道身份认证 |
| [Breeze SDK](https://g.alicdn.com/aic/ilop-docs/2018.10.31/mobile-android-sdk-ble.html) | 提供蓝牙辅助配网支持 |


## 初始化

配网SDK 的初始化依赖[ 身份认证](https://g.alicdn.com/aic/ilop-docs/2018.10.31/mobile-android-sdk-iotcredential.html) 模块的初始化，请参见：[身份认证 - 初始化](https://g.alicdn.com/aic/ilop-docs/2018.10.31/mobile-android-sdk-iotcredential.html#%E5%88%9D%E5%A7%8B%E5%8C%96) （包含API通道初始化和账号初始化）。

## 使用方式
本配网 SDK 对外主要提供设备发现，设备配网，以及获取设备端 token 的能力。
### 设备发现
提供局域网内发现已配网的设备，包括 WiFi 设备以及以太网设备，以及局域网内已上电的待配设备（前提是当前局域网内已经有一个已配好网的智能设备，且该设备具有发现待配网设备的能力）的能力。
关于设备发现相关 API，请参见：[LocalDeviceMgr](http://gaic.alicdn.com/ztms/ld-android-sdk-api-references-v2/com/aliyun/alink/business/devicecenter/api/discovery/LocalDeviceMgr.html) 。

#### 启动设备发现
发现本地的已配网设备，或者零配、路由器发现的待配设备。发现的待配设备信息可以作为后续设备配网的入参信息。如果需要对已发现的已配网设备做过滤（如过滤已绑定的设备，不支持的设备等），可以参考[产品过滤接口](https://g.alicdn.com/aic/ilop-docs/2018.10.31/frzuro.html#%E6%9C%AC%E5%9C%B0%E5%8F%91%E7%8E%B0%E8%AE%BE%E5%A4%87%E5%88%97%E8%A1%A8%E4%BF%A1%E6%81%AF%E8%BF%87%E6%BB%A4)。
```java
// 开始发现设备
LocalDeviceMgr.getInstance().startDiscovery(context, new IDiscoveryListener() {
    @Override
    public void onLocalDeviceFound(DeviceInfo deviceInfo) {
        // 已配网设备
    }

    @Override
    public void onEnrolleeDeviceFound(List<DeviceInfo> devices) {
        //待配网设备
    }
});
```

#### 停止发现设备
停止发现本地已配和线上待配设备，调用该接口会清除已发现设备列表，确保与 startDiscovery 成对调用。
```java
// 停止设备发现
LocalDeviceMgr.getInstance().stopDiscovery();
```


### 设备配网
关于设备配置添加相关 API 说明： [AddDeviceBiz](http://gaic.alicdn.com/ztms/ld-android-sdk-api-references-v2/com/aliyun/alink/business/devicecenter/api/add/AddDeviceBiz.html)。
#### 设置待配网设备信息
```java
DeviceInfo deviceInfo = new DeviceInfo();
deviceInfo.productKey = "xx"; // 商家后台注册的 productKey，不可为空
deviceInfo.deviceName = "xxx";// 设备名, 可为空
deviceInfo.productId = "xxx";// 产品 ID， 蓝牙辅助配网必须
deviceInfo.linkType = "ForceAliLinkTypeNone"; // 默认一键配网  蓝牙辅助配网 ForceAliLinkTypeBLE

//设置待添加设备的基本信息
AddDeviceBiz.getInstance().setDevice(DeviceInfo deviceinfo);
```
配网时，指定的配网方式 linkType，请参见 [LinkType](http://gaic.alicdn.com/ztms/ld-android-sdk-api-references-v2/com/aliyun/alink/business/devicecenter/api/add/LinkType.html)；
设备信息相关实体类，请参见 [DeviceInfo](http://gaic.alicdn.com/ztms/ld-android-sdk-api-references-v2/com/aliyun/alink/business/devicecenter/api/add/DeviceInfo.html)。

#### 开始设备配网
上述设置好待添加设备信息，进入配网。调用 startAddDevice 接口进入配网流程。如 linkType= "ForceAliLinkTypePhoneAP", 需要用户确保应用已具备了 WRITE\_SETTINGS 权限，该应用需要 APP 动态申请。
```java
// 开始添加设备
AddDeviceBiz.getInstance().startAddDevice(context， new IAddDeviceListener(){
    @Override
    public void onPreCheck(boolean b, DCErrorCode dcErrorCode) {
        // 参数检测回调 
    }

    @Override
    public void onProvisionPrepare(int prepareType) {
        // 热点配网、一键配网、蓝牙辅助配网会走到该流程，零配和智能路由器配网不会走到该流程
        // prepareType = 1提示用户输入账号密码
        // prepareType = 2提示用户手动开启指定热点 aha 12345678
        // 执行完上述操作之后，调用toggleProvision接口继续执行配网流程
    }

    @Override
    public void onProvisioning() {
        // 配网中
    }

    @Override 
    @Deprecated
    public void onProvisionStatus(ProvisionStatus provisionStatus) {
    }

    @Override
    public void onProvisionedResult(boolean b, DeviceInfo deviceInfo, DCErrorCode dcErrorCode) {
        // 配网结果
    }
});
```

配网回调接口，请参见 [IAddDeviceListener](http://gaic.alicdn.com/ztms/ld-android-sdk-api-references-v2/com/aliyun/alink/business/devicecenter/api/add/IAddDeviceListener.html)。

#### 输入账号密码 
在收到 onProvisionPrepare 回调后，引导用户输入 ssid 和 password ，并调用此方法传入 ssid、password、timeout 信息启动配网。 只有广播配网场景下，才会触发 onProvisionPrepare 回调。如果出现部分手机一直无法获取到 SSID，可以打开 GPS 再获取 SSID（部分手机需要开启 GPS 才能获取到）。
```java
String ssid = "ssid";// 热点配网的时候注意 要先获取ssid，然后再开启热点，否则无法正确获取到SSID
String ssid = "xxxxxxxx";
int timeout = 60;//单位秒
AddDeviceBiz.getInstance().toggleProvision(ssid, password, timeout);
```

#### __停止配网__
```java
// 停止配网
AddDeviceBiz.getInstance().stopAddDevice(context);
```

#### 设置配网模式
```java
String linkType = "ForceAliLinkTypeBroadcast"; 
// 设置配网模式
AddDeviceBiz.getInstance().setAliProvisionMode(linkType);
```

#### 恢复手机 WiFi 连接
收到设备端返回的切换 WiFi 的成功回调之后调用恢复 WiFi 的接口。
```java
// 关闭热点 恢复 WiFi 连接
HotspotHelper.getInstance().recoverWiFiConnect(context);
```
恢复手机 WiFi 连接之后，直接调用 startAddDevice 接口进入设备配网监听，并在 onProvisionedResult 回调结果中接收是否配网成功的回调。

## 混淆配置
```
-keep public class com.aliyun.alink.business.devicecenter.** {*;}
-keep public class com.aliyun.alink.linksdk.alcs.coap.**{*;}
```

## 更多功能
### 获取设备绑定 Token
设备绑定的时候除了需要 productKey、deviceName，还需要一个设备端的 token，该接口提供从设备端获取绑定 token 的功能。WiFi 设备或者以太网设备均可以使用该接口获取绑定需要的 Token。以太网设备需要先获取到设备的 productKey、deviceName，可以参考使用 startDiscovery 接口去获取。
```java
// 获取设备绑定 token
LocalDeviceMgr.getInstance().getDeviceToken(context, productKey, deviceName, 60*1000, new IOnDeviceTokenGetListener() {
            @Override
            public void onSuccess(String token) {
                // TODO bind
            }

            @Override
            public void onFail(String reason) {
            }
        });
```

### SDK 依赖
#### Maven仓库地址
> ```
> // 阿里云仓库地址，包括了IOT事业部开发的SDK
> maven {
>     url "http://maven.aliyun.com/nexus/content/repositories/releases/"
> }
> ```

Gradle 依赖
> ```
> compile ('com.aliyun.alink.linksdk:ilop-devicecenter:1.4.0'){
>     transitive = true
> }
> ```
### 在插件中使用配网能力
如果需要在插件中使用配网能力，需要向 BoneMobile 容器中注册配网 API，请在插件加载前，调用如下注册代码：
```java
BonePluginRegistry.register("BoneAddDeviceBiz",BoneAddDeviceBiz.class);
BonePluginRegistry.register("BoneLocalDeviceMgr",BoneLocalDeviceMgr.class);
BonePluginRegistry.register("BoneHotspotHelper",BoneHotspotHelper.class);
```

