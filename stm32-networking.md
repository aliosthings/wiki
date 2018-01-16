# 手把手教你stm32上如何使用mqtt上云

本文基于[Alios Things](https://github.com/alibaba/AliOS-Things) 1.2.0版本，手把手教你如何在stm32L475上使用mqtt上云。

## 1、硬件环境搭建

1、STM32L475开发板一块

![](https://img.alicdn.com/tfs/TB1J6KLmZLJ8KJjy0FnXXcFDpXa-3968-2976.jpg)

2、庆科MK3060通信模组一块

![](https://img.alicdn.com/tfs/TB1HYMxmRfH8KJjy1XbXXbLdXXa-2976-3968.jpg)

3、双公头杜邦线三根

4、连接方法：

将STM32L475 D0--->MK3060 UART TX， STM32L475 D1--->MK3060 UART RX， STM32L475 GND--->MK3060 GND。具体连接方式如下图所示；两个开发板中相同颜色的点通过杜邦线连接起来即可(红色对红色，白色对白色，黄色对黄色)。

![](https://img.alicdn.com/tfs/TB1k.Sfm3DD8KJjy0FdXXcjvXXa-3968-2976.jpg)



## 2、接入阿里云物联网套件

使用mqttapp快速接入阿里云。请参考[阿里云物联网设备接入准备](https://help.aliyun.com/document_detail/42714.html?spm=5176.doc30530.2.5.eofHfK)和[设备接入](https://help.aliyun.com/document_detail/30530.html?spm=5176.doc42714.2.7.LjopzI)

### 2.1、在云端主要包括以下几步：

1、注册一个阿里云账号

2、开通物联网套件

3、创建产品，拿到`ProductKey`

4、创建设备，拿到`DeviceName`和`DeviceSecret`

5、定义Topic`$(PRODECT_KEY)/$(DEVICE_NAME)/data`，并设置权限为：设备具有发布和订阅

### 2.2、设备端参数修改

mqttapp程序所在源码为`AliOS-Things/example/mqttapp/`[mqtt-example.c](https://github.com/alibaba/AliOS-Things/blob/master/example/mqttapp/mqtt-example.c)。此时在云端获取的三个参数`ProductKey`，`DeviceName`和`DeviceSecret`分别对应代码中的`PRODUCT_KEY`，`DEVICE_NAME`和`DEVICE_SECRET`三个宏。

```
#if defined(MQTT_ID2_AUTH) && defined(TEST_ID2_DAILY)
/*
    #define PRODUCT_KEY             "OvNmiEYRDSY"
    #define DEVICE_NAME             "sh_online_sample_mqtt"
    #define DEVICE_SECRET           "v9mqGzepKEphLhXmAoiaUIR2HZ7XwTky"
*/
#else
   // TODO: 在以下段落替换下列宏定义为你在IoT控制台申请到的设备信息
/*
    #define PRODUCT_KEY             "yfTuLfBJTiL"
    #define DEVICE_NAME             "TestDeviceForDemo"
    #define DEVICE_SECRET           "fSCl9Ns5YPnYN8Ocg0VEel1kXFnRlV6c"
*/
    #define PRODUCT_KEY             "UclsWI7AEBM"
    #define DEVICE_NAME             "stm32bl475e"
    #define DEVICE_SECRET           "sM7YOzNRdVIWPhxNr3r4MA4qzsPycxdP" 

#endif
```

## 3、Alios Things Mqttapp编译

基于目前Alios Things mqttapp编译命令行如下：

aos make mqttapp@b_l475e

在该命令执行完成后可在`out/mqttapp@b_l475e/binary/` 目录找到生成的bin文件和hex文件。

## 4、固件烧入

### 4.1、庆科MK3060固件烧入

请到庆科官方提供的MK3060 [AT固件](http://developer.mxchip.com/developer/md/bWljby1oYW5kYm9vay9Eb3dubG9hZC8zLTIuTWlDT19BVF92Mi4wX0NNRC5tZA)下载网址，请选择型号为MOC108/EMW3060对应的固件。烧写方法请参考 [MK3060固件烧入指导](http://developer.mxchip.com/handbooks/63)中“1.更新应用程序固件”部分

### 4.2、STM固件烧入

使用STM32固件烧入工具[ST-LINK](http://www.st.com/content/st_com/en/products/development-tools/software-development-tools/stm32-software-development-tools/stm32-programmers/stsw-link004.html)进行固件烧入。烧入步骤按下图所示

![](https://img.alicdn.com/tfs/TB1QprXm46I8KJjy0FgXXXXzVXa-937-241.jpg)

## 5、Alios Things配网及数据连接阿里云

经过以上4步以后相应的mqttapp binary已经正常烧入到stm32L475开发板中，启动串口打印如下图所示：

通过命令行使得wifi模组能正确连接到对应的AP。

`netmgr connect *ssid* *password* *open|wep|wpa|wpa2*`

正常联网后，mqttapp会真正开始运行。下图为mqtt运行日志截图：

![](https://img.alicdn.com/tfs/TB1_9CBm8DH8KJjSspnXXbNAVXa-1708-284.jpg)

进一步在云端查询到设备相关的日志信息如下所示

![](https://img.alicdn.com/tfs/TB1kk_ImZLJ8KJjy0FnXXcFDpXa-1875-833.jpg)

