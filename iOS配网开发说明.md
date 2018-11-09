## 概述
提供了把 WiFi 设备配置上家庭路由器以及局域网内已联网设备的发现能力，具体方案包括一键广播配网、手机热点配网、智能路由器配网以及设备间相互配网等。

| 依赖SDK | 概述 |
| :--- | :--- |
| [日志](https://lark.alipay.com/ilopdoc/guide/mobile-ios-sdk-log) | 基础依赖SDK，提供客户端统一日志打印，日志等级控制，分模块日志隔离等能力 |
| [API 通道](https://lark.alipay.com/ilopdoc/guide/mobile-ios-sdk-apiclient) | 提供API通道能力，和基础环境配置信息 |
| Breeze SDK | 提供蓝牙辅助配网支持 |


## 初始化

配网SDK 的初始化依赖 API 通道的初始化，请参见：[API 通道 - 初始化](https://lark.alipay.com/ilopdoc/guide/mobile-ios-sdk-apiclient#%E5%88%9D%E5%A7%8B%E5%8C%96)

## 使用说明

### 设备发现
提供获取局域网内已经配网的设备，包括 WiFi 设备以及以太网设备，以及局域网内已上电的待配设备（前提是当前局域网内内已经有一个已配好网的智能设备，且该设备支持未待配设备进行配网的能力）。

#### 启动发现设备
<span data-type="color" style="color:rgb(38, 38, 38)"><span data-type="background" style="background-color:rgb(255, 255, 255)">发现本地的已配网设备，或者已配网设备、路由器发现的待配设备。发现的待配设备信息可以作为后续设备配网的入参信息。</span></span>
```objectivec
// 引入头文件
#import <IMSDeviceCenter/IMLDeviceCenter.h>

// 本地发现入口
[[IMLLocalDeviceMgr sharedMgr] startDiscovery:^(NSArray *devices, NSError *err) {
        if (devices && [devices count] > 0) {
            IMSLifeLogVerbose(@"发现本地设备: %@", devices);
            // 将与用户没有绑定关系的设备显示在本地发现设备中
            for (IMLCandDeviceModel *device in devices) {
                if (![self checkBindWithLocalDevice:device]) {
                    [wSelf.localDeviceList addObject:device];
                }
            }
            [wSelf.tableView reloadData];
        } else if (err) {
            IMSLifeLogError(@"本地发现设备出错: %@", err);
        }
    }];
```
#### 获取所有已发现设备
```objectivec
// 引入头文件
#import <IMSDeviceCenter/IMLDeviceCenter.h>

NSArray *allLanDevicesArray = [kLKLocalDeviceMgr getLanDevices];
```

#### 终止发现设备
停止发现本地已配和线上待配设备，调用该接口会清除已发现设备列表，确保和startDiscovery成对调用。
```objectivec
// 引入头文件
#import <IMSDeviceCenter/IMLDeviceCenter.h>

// 停止发现设备
[kLKLocalDeviceMgr stopDiscovery];
```
### 
### 通用配网流程
#### 设置待添加设备信息
待添加设备信息来源可以为上面本地发现的待配设备，也可以通过扫码等其他途径获取待配设备信息

```objectivec
// 引入头文件
#import <IMSDeviceCenter/IMLDeviceCenter.h>

// 选取本地发现的待配设备
IMLCandDeviceModel *model = self.localDeviceList[index];
[kLkAddDevBiz setDevice:model];
```

备注：其中（IMLCandDeviceModel \*）model 为本地发现待配设备或者云端拉取产品列表组装的model
本地发现设备参见：本文下面 [设备发现](https://lark.alipay.com/ilopdoc/guide/mobile-ios-sdk-add-device#%E8%AE%BE%E5%A4%87%E5%8F%91%E7%8E%B0) 章节内容

其中 IMLCandDeviceModel 属性说明：

| 属性 | 类型 | 是否必选 | 描述 | 备注 |
| :--- | :--- | :--- | :--- | :--- |
| productKey | NSString | 是 | 设备productKey |  |
| deviceName | NSString | 否 | 设备名称 |  |
| linkType | assign | 否 | 指定配网方式 | ForceAliLinkTypeHotspot 为手机热点配网；ForceAliLinkTypeBLE 为蓝牙辅助配网 |
| productId | NSString | 否 | 设备产品ID，若是蓝牙辅助配网，则需要 |  |


#### 设置配网模式
```objectivec
// 引入头文件
#import <IMSDeviceCenter/IMLDeviceCenter.h>

[kLkAddDevBiz setAliProvisionMode:ForceAliLinkTypeHotspot]; // 设置为手机热点配网模式

[kLkAddDevBiz setAliProvisionMode:ForceAliLinkTypeBLE]; // 设置为蓝牙辅助配网模式

```

#### 开始设备配网
上述设置好待添加设备信息，进入配网。<span data-type="color" style="color:rgb(38, 38, 38)"><span data-type="background" style="background-color:rgb(255, 255, 255)">调用 startAddDevice 接口进入配网流程，并实现监听的协议方法</span></span>
```objectivec
// 引入头文件
#import <IMSDeviceCenter/IMLDeviceCenter.h>

[kLkAddDevBiz startAddDevice:self];

其中 self 为配网过程中 notifier 监听回调对象（代理）
- (void)notifyPrecheck:(BOOL)success withError:(NSError *)err
{
    NSLog(@"notifyPrecheck callback err : %@", err);
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.addVC notifyProgress:LKAddStatePrechecking result:nil withError:err];
    });
}

// 用户引导页（一键配网、热点配网和蓝牙辅助配网会有相关回调，指引用户接入相关操作）
- (void)notifyProvisionPrepare:(LKPUserGuideCode)guideCode
{
    NSLog(@"notifyProvisionPrepare callback guide code : %ld", guideCode);
    if(guideCode == LKPGuideCodeOnlyInputPwd){
        // TODO:一键广播配网或蓝牙辅助配网相关引导
    } else if(guideCode == LKPGuideCodeWithUserGuide){
        // TODO:热点配网相关引导
    }
    
}

-(void)notifyProvisioning 
{
    NSLog(@"notifyProvisioning callback(正在进行配网...) ");
}

- (void)notifyProvisionStatus:(LKProvisonStatus)provisionStatus boolSuccess:(BOOL)boolSuccess;
{
    NSLog(@"notifyProvisionStatus callback provisionStatus:%d boolSuccess:%d", provisionStatus, boolSuccess);
    if(provisionStatus == LKProvisonStatusSwitchAP){
        // 设备回复 switch ap 请求，提示用户切换回之前的 wifi
        NSLog(@"请立即切换回开启热点之前的 wifi 网络");
    }
}

- (void)notifyProvisionResult:(IMLCandDeviceModel *)candDeviceModel withProvisionError:(NSError *)provisionError
{
    NSLog(@"配网成功：%@",candDeviceModel);
}
```

#### __输入配网 wifi 名称以及密码信息__
在收到 - (void)notifyProvisionPrepare:(LKPUserGuideCode)guideCode 回调引导完成相关操作（一键广播指引用户输入 ssid 和密码，热点配网指引用户开启热点，输入 ssid 和密码等）后，调用 - (void)toggleProvision:(NSString \*)ssid pwd:(NSString \*)pwd timeout:(int)timeout 方法，传入 WiFi 的 ssid 及 password 信息。 注：一键广播配网和热点配网才会有 notifyProvisionPrepare 回调。
```objectivec
// 引入头文件
#import <IMSDeviceCenter/IMLDeviceCenter.h>

- (void)notifyProvisionPrepare:(LKPUserGuideCode)guideCode
{
    NSLog(@"notifyProvisionPrepare callback guide code : %ld", guideCode);
    [self inputSsidAndPassword];
}

- (void)inputSsidAndPassword
{
    NSSstring *ssid = @"example ssid";
    NSString *password = @"1qaz@WSX";
    NSInterger timeout = 60;(单位秒,s);
    [kLkAddDevBiz toggleProvision:ssid pwd:password timeout:timeout];
}
```

#### 配网过程关键节点监听处理
针对热点配网必须监听该回调
```objectivec
// 引入头文件
#import <IMSDeviceCenter/IMLDeviceCenter.h>

- (void)notifyProvisionStatus:(LKProvisonStatus)provisionStatus boolSuccess:(BOOL)boolSuccess;
{
    NSLog(@"notifyProvisionStatus callback provisionStatus:%d boolSuccess:%d", provisionStatus, boolSuccess);
    if(provisionStatus == LKProvisonStatusSwitchAP){
        // 设备回复 switch ap 请求，提示用户切换回之前的 wifi
        NSLog(@"请立即切换回开启热点之前的 wifi 网络");
    }
}
```

#### 配网结果监听
```objectivec
- (void)notifyProvisionResult:(IMLCandDeviceModel *)candDeviceModel withProvisionError:(NSError *)provisionError
{
    if(candDeviceModel != nil){
        NSLog(@"配网成功：%@",candDeviceModel);
    } else{
        NSLog(@"配网失败，错误信息:%@", provisionError);
    }
    
}
```

#### __停止配网__
```objectivec
// 引入头文件
#import <IMSDeviceCenter/IMLDeviceCenter.h>

[kLkAddDevBiz stopAddDevice];
```

### __设备绑定__
设备绑定的时候除了需要 productKey、deviceName，还需要一个设备端的 token，该接口提供从设备端获取绑定 token 的功能。WiFi 设备或者以太网设备均可以使用该接口获取绑定需要的 Token。以太网设备需要先获取到设备的 productKey、deviceName，可以参考使用 startDiscovery 接口去获取。

```objectivec
// 引入头文件
#import <IMSDeviceCenter/IMLDeviceCenter.h>

// self.productKey 和 self.deviceName 是配网成功后返回的设备模型中的 productKey 和 deviceName
[[IMLLocalDeviceMgr sharedMgr] getDeviceToken:self.productKey deviceName:self.deviceName timeout:20 resultBlock:^(NSString *token, BOOL boolSuccess) {
    NSLog(@"主动获取设备token：%@，boolSuccess：%d", token, boolSuccess);
    if(token){
    // 调用绑定接口进行设备绑定
    } else{
        NSLog(@"获取token失败(超时)");
    }
}];
```
### 

## 使用配网插件
配网插件基于Bone容器实现了完整的配网逻辑，因此在接入Bone容器的前提下，可以直接打开配网插件来完成配网逻辑，然后再自行处理配网之后的逻辑；

目前配网插件Id为：
插件Id 国内版：<span data-type="color" style="color:rgb(25, 31, 37)"><span data-type="background" style="background-color:rgb(255, 255, 255)">a123kfz2KdRdrfYc</span></span>
插件Id 国际版：<span data-type="color" style="color:rgb(25, 31, 37)"><span data-type="background" style="background-color:rgb(255, 255, 255)">a223c2beCJQ2Xpk2</span></span>

<span data-type="color" style="color:rgb(55, 61, 65)"><span data-type="background" style="background-color:rgb(245, 246, 250)">插件Id的具体使用方式，参考见Bone容器部分。也可以参考下面文档对应的</span></span>调用平台提供的配网插件部分，[https://lark.alipay.com/ilopdoc/guide/yzqy0q#8vpydz](https://lark.alipay.com/ilopdoc/guide/yzqy0q#8vpydz)



![Screen Shot 2018-05-22 at 10.11.48.png | left | 747x437](https://cdn.yuque.com/lark/0/2018/png/21369/1526955121756-d694a280-56e7-44ea-810e-538b33723cfa.png "")

