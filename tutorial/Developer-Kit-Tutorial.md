## 介绍
* Develoeprkit开发板由[诺行](www.notioni.com)负责设计/生产，需参照下述文档熟悉板载资源和硬件自测确保板子无任何硬件问题，如有疑问可在[诺行开发板钉钉群](https://i.imgur.com/rqjjjA0.jpg)沟通。  
    * [板子硬件资源](https://github.com/alibaba/AliOS-Things/wiki/AliOS-Things-Developer-Kit-Hardware-Guide)  
    * [硬件自测文档](https://github.com/alibaba/AliOS-Things/wiki/AliOS-Things-Developer-Kit-User-Basic-Operation-Guide)
    * [开发板原理图和生产软件bin文件](http://www.notioni.com/#/source)，恢复出厂设置方法：烧录出厂bin文件  

* 基于AliOS Things提供了相关的应用示例，有关于OS的相关问题可在[github issue](https://github.com/alibaba/AliOS-Things/issues)提问，也可在[AliOS Things 技术交流钉钉群](https://img.alicdn.com/tfs/TB1wjmehmzqK1RjSZFjXXblCFXa-877-1268.jpg)进行技术交流。

## 板载硬件资源
![board_res](https://img.alicdn.com/tfs/TB17oEJgQvoK1RjSZFNXXcxMVXa-674-508.png)  
**主要模块(自上而下):**
* 传感器(上图从左到右):
     - 加速度计acc 和 陀螺仪gyro，LSM6DSLTR, vendor:ST
     - 压力presure，BMP280，vendor:bosch
     - 光强light和接近光proximity，LTR-553ALS-WA, vendor:LITE-ON
     - 湿度Humi和温度Temp, SHTC1, vendor:Sensirion
     - IR Detector, PT26-21B/CT, vendor:Everlight 
     - IR Emitter, IR26-61C/L510/R/2G(MI), vendor:Everlight 
     - 磁力计mag，MMC3680KJ，vendor:Memsic
* 摄像头：0.3M Pixels, YL-F170066-0329, vendor:深圳影领  
* TFT LCD: 1.3', 240*240pixels, SPI，H13TS43A 深圳汉禹  
* Audio Codec:  Cortex-M0, 145KB EPROM,12KB SRAM,up to 50MHz, 芯唐电子  
* MCU：STM32L496VGTx, Cortex-M4, 最高主频80Mhz，320KB SRAM,1MB Flash, vendor: ST  
* 按键*3，分别是按键A, M, B
* WIFI模组：BK7231。vendor:Beken  

## AliOS Things开发准备
* [开发环境搭建](https://linkdevelop.aliyun.com/device-doc#dev-prepare.html)，注：可使用IDE，也可以使用命令行。
* 应用示例
    >注：
     完成上述环境搭建后会了解到下面的命令，其中example是指具体的demo名称  
      * 编译命令 `aos make example@developerkit`   
      * 烧录命令`aos upload example@developerkit`    


| **Demos/Examples** | **Comments** | **Status** |
| --------       | -------- | -------- |
| helloworld       | 入门，串口打印log | [文档介绍](https://github.com/alibaba/AliOS-Things/tree/developer/example/helloworld) |
| developerkitgui       | LCD显示 | developer分支 |
| qr               | 二维码     | developer分支，功能：如果扫到二维码后，串口会将二维码打印出来。按B键可以在LCD上显示二维码    |
| udataapp               | sensor相关     | developer分支     |
| mqttapp               | mqtt测试    | developer分支     |
| linkkitapp      | 一键配网  | developer分支  |
| simple_mqtt               | 升级版helloworld     | developer分支，[文档](https://linkdevelop.aliyun.com/device-doc#aos-helloworld.html)     |
| ldapp      | LCD，传感器，云端  | developer分支，[文档](https://github.com/alibaba/AliOS-Things/tree/developer/example/ldapp/README.md)  |
| linkdevelop.env_monitor | 环境监控   | developer分支，[文档](https://linkdevelop.aliyun.com/device-doc#aos-env_monitor.html)  |
| linkdevelop.device_ctrl | 设备控制  | developer分支，[文档](https://linkdevelop.aliyun.com/device-doc#aos-device_control.html)  |
| linkdevelop.hmi  | 人机交互  | developer分支，[文档](https://linkdevelop.aliyun.com/device-doc#aos-hmi.html)  |


## 附录
#### 参考视频教程

* 1-Developer Kit开发板基本介绍	http://v.youku.com/v_show/id_XMzc2MDk2MDQ2OA==.html
* 2-Developer Kit Interface介绍	http://v.youku.com/v_show/id_XMzc2MDk3NTI5Ng==.html
* 3-Developer Kit 开发环境搭建 http://v.youku.com/v_show/id_XMzc2MDk3NTE3Ng==.html
* 4-Developer Kit LinkKit Demo演示	http://v.youku.com/v_show/id_XMzc2MDk3NTMwNA==.html
* 5-Developer Kit代码讲解和问题答疑	http://v.youku.com/v_show/id_XMzc2MDk4NzY3Ng==.html
* 6-WIFI模组MW31实战操作	http://v.youku.com/v_show/id_XMzc2MDg4MDgwMA==.html
* 7-Developer Kit板载WIFI升级指导	https://v.youku.com/v_show/id_XMzc1NjE4NzI2MA==.html?spm=a2hzp.8253869.0.0   
 