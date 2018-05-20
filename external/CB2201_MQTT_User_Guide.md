# 手把手教你在Hobbit1\_2上使用mqtt通道上云

本文基于 [AliOS Things](https://github.com/alibaba/AliOS-Things) 1.3.x版本，手把手教你如何在Hobbit1\_2上使用mqtt上云

## **1 硬件环境搭建**

**1.1 开发板准备**

1、Hobbit1\_2 YMC2HQFNR1A（赤焰剑）开发板介绍

**①** 赤焰剑开发板是杭州中天微全自主设计一款用于开发IoT 应用的开发板。板上集成的中天微设计的基于中天微CK802 CPU核的SOC芯片；集成了CPU调试器CKLink，只需要一根USB线就可以供电、调试、下载等操作。

**②** 基于C-SKY SoC芯片CKM02Y181103A-F64，芯片内部集成C-SKY CK802 CPU核，集成AES,SHA,CRC,TRNG等安全相关模块。

**③** 超低功耗设计，低功耗模式下，芯片核心电流小于3uA，QFP-64-0.4mm封装。

**④** 集成两个外设接口，每个外设接口中都集成了UART/SPI/IIC/ADC/PWM/GPIO等接口，可以连接各类接口兼容的功能子板，包括中天微设计的ENC28J60 SPI有线网卡子板，ESP8266-WiFi子板，传感器子板等。

![Hobbit1_2_evb](https://raw.githubusercontent.com/chenlf123/MarkdownPhotos/master/AliOS-Things/Hobbit1_2_evb.png)

2、ESP8266 WiFi子板一块

![ESP8266_evb](https://raw.githubusercontent.com/chenlf123/MarkdownPhotos/master/AliOS-Things/ESP8266_evb.png)

**1.2 开发板连接方法**

1、WiFi子板连接

![Hobbit1_evb_ESP8266_evb](https://raw.githubusercontent.com/chenlf123/MarkdownPhotos/master/AliOS-Things/Hobbit1_evb_ESP8266_evb.png)

2、串口线连接

![USB_Serial](https://raw.githubusercontent.com/chenlf123/MarkdownPhotos/master/AliOS-Things/USB_Serial.png)

3、电源连接

通过USB线供电，图略

## **2 云端和通道环境搭建**

**2.1 在云端主要包括以下几步**

参考链接（https://github.com/alibaba/AliOS-Things/wiki/Manual-Channel-MQTT），做如下操作：

1、创建阿里云账号

2、创建测试产品，拿到ProductKey

3、创建测试设备，拿到DeviceName和DeviceSecret

4、下载测试工具

注意：请无视该文档中关于linuxhost的示例，编译方式请参考下面章节。

**2.2 三要素设置**

修改./framework/protocol/linkkit/iotkit/sdk-encap/imports/iot\_import\_product.h 三个参数宏定义，修改为上一步骤中创建产品和设备时拿到的3个参数。

***#elif  MQTT\_TEST***

***#define PRODUCT\_KEY &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;......&quot;***

***#define DEVICE\_NAME &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;......&quot;***

***#define DEVICE\_SECRET &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;......&quot;***

***#define PRODUCT\_SECRET &nbsp;&nbsp; &quot;&quot;***

***#else***

注：mqttapp程序所在源码为AliOS-Things/example/mqttapp/ [mqtt-example.c](https://github.com/alibaba/AliOS-Things/blob/master/example/mqttapp/mqtt-example.c)。此时在云端获取的三个参数ProductKey，DeviceName和DeviceSecret分别对应代码中的PRODUCT\_KEY，DEVICE\_NAME和DEVICE\_SECRET三个宏。

## **3 mqttapp编译**

AliOS-Things支持开发方式：命令行和AliOS-Things IDE，详见下面说明。

**3.1 命令行编译**

1、命令行环境搭建：

参考https://github.com/alibaba/AliOS-Things/wiki/Quick-Start

2、命令行编译方式如下：

$ aos make clean

$ aos make mqttapp@hobbit1\_evb

build完成后可在out/mqttapp@hobbit1\_evb/binary/ 目录找到生成的bin文件和hex文件。

**3.2 AliOS-Things IDE编译**

1、AliOS-Things IDE环境搭建：

  参考https://github.com/alibaba/AliOS-Things/wiki/Starter-Kit-Tutorial

2、开发环境搭建好后，导入Alios-Things源码
3、Build如下图，选中mqttapp@hobbit1\_evb，点击右侧&quot;√&quot;


build完成后可在out/mqttapp@hobbit1\_evb/binary/ 目录找到生成的bin文件。

## **4 固件烧录**

**4.1 安装烧录软件**

1、烧录软件获取：链接：https://pan.baidu.com/s/1fWUThsODomSQIj99Ja1Bag 密码：wkbb

2、解压后，双击CSKYFlashProgrammer.exe

**4.2 烧录**

参考下面两张图片配置好，点击 ![](data:image/*;base64,iVBORw0KGgoAAAANSUhEUgAAABkAAAAbCAIAAAAGQ7M/AAAAA3NCSVQICAjb4U/gAAAACXBIWXMAAA7EAAAOxAGVKw4bAAABlklEQVRIia3VPUvDQBgH8LvLUYkFS5dcSsdigtA24jdoC4qTJKnoR3BwFURwFNzFTfwCxclBxNHFUVCQQN+gLSliaTUQCPZyDgq+NWmS5hmPyy9P/vcSyBgDMRUGAFiWZZqmbduU0rDPcxzH87woiqlUCluW1Wq1crkcxjhCjxBC13WbzabrutAwjGw2y3FcWOVnMcYajQaybRtjPAv02Z3jOIhSGlf8aOJoNH2yBQBw3p2woqe1f7lnPBuhOE+r/9bfre1c3NeCcz4ryKhLT29P6i91TdElQWaMQQijWV91/XTVG3VVRS8tliP39V2P5kPvtdsbdTWlmpxLek3zzAuAX58ztIfnd2fHN0djOo5g/Y08nymUpQqHPE9b0NOztrSuFjVJkH3in26l59NqUfdPKpCVzxQ0RS9Jlamv9LegLMgHq4fighgE8rM2Cmp1eRNzIa4jz6lbK9v+u/x/ee6JsBAAACE0gYsAAQAQz/Ox3KuJRAIRQtrt9oxQp9MhhEDG2GAwME3TcZzIHRFCBEGAMf63PwDOMpi5vO/+lwAAAABJRU5ErkJggg==)烧写


## **5 WiFi配网及数据连接阿里云**

**5.1 WiFi配网**

烧录完成后，点击复位键启动串口打印如下图所示：

在串口命令行中敲入如下配网命令：

netmgr connect &lt;ssid&gt;  &lt;password&gt;

![PeiWang](https://raw.githubusercontent.com/chenlf123/MarkdownPhotos/master/AliOS-Things/PeiWang.png)

正常联网后，mqttapp会真正开始运行。下图为mqttapp运行日志截图：

![mqttapp_log](https://raw.githubusercontent.com/chenlf123/MarkdownPhotos/master/AliOS-Things/mqttapp_log.png)

**5.2 查看设备是否在线**

点击下面链接，登录阿里云账户查看：

[http://iot.console.aliyun.com/#/product/newlist/region/cn-shanghai](http://iot.console.aliyun.com/#/product/newlist/region/cn-shanghai)

## **6 调试**

**6.1 CskyDebugServer安装和使用**

1、获取CskyDebugServer（若已安装CDS/CDK，则可略过1和2的步骤）

链接：https://pan.baidu.com/s/1aXN3wIysVVthEN4QaPvRww 密码：ecs9

2、安装

  解压后双击默认安装

3、端口设置，如下图：

![CskyDebugserver_port](https://raw.githubusercontent.com/chenlf123/MarkdownPhotos/master/AliOS-Things/CskyDebugServer_port.png)

4、连接开发板

![CskyDebugServer_connect](https://raw.githubusercontent.com/chenlf123/MarkdownPhotos/master/AliOS-Things/CskyDebugServer_connect.png)

点击 ![](data:image/*;base64,iVBORw0KGgoAAAANSUhEUgAAAB0AAAAXCAIAAAB4atM+AAAAA3NCSVQICAjb4U/gAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAAb0lEQVQ4je3VsQ1AIQgEUDT2uP8UNxpu8AsTWw8ChcmnsjBPI6c2M5OC6hWoiHQAqprvpotvuoOZpHPuwaLD49vvWSDZ5enI+TJ0sG9XOuheGxhxmVS4XTJqPpfPL3UveO7Ua+/D7+5qRf/mAFDhfgMdG/HIlDNIAAAAAElFTkSuQmCC)按钮，连接成功后，如下图


**6.2 VS Code调试设置**

根据已编译并烧录的app@board信息，更新 AliOS-Things/.vscode/launch.json 调试配置文件，比如：已编译并烧录 mqttapp@hobbit1\_2以后，更改相关配置：

![VSCode_launch](https://raw.githubusercontent.com/chenlf123/MarkdownPhotos/master/AliOS-Things/VSCode_launch.png)

**6.3 开始调试**

1、点击 ![](data:image/*;base64,iVBORw0KGgoAAAANSUhEUgAAADMAAAA2CAIAAADlDjbOAAAAA3NCSVQICAjb4U/gAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAEKklEQVRoge2YrXarShTHd25vW5OpuEeB7+BDVU2oaQyomiQPAKoq+PIAxFVc5gHIA8ADENOYElXDuBpG5YrD+Fyx15nFoqcNpOk6FfmrZBiG3+zZX9AzTRO+mX7+rADgrz+N8a6OZN11JOuuI1l3Hcm66/uS/b33naZpDodDSqmu67quA0BRFFVVcc7TNOWcf5Kst0fdtG3bdV2keU9lWTLG0jTdgwnrZjcySunDw4NhGPg3z3MhRFEUaCG0n2VZmqbhhKIofN8XQnwtmWmaYRgSQgCAcz6fz/M8/+1My7ImkwmuXFWV7/vvzTwAmWmaURQBgJQyiqLFYgEAmqaheYQQbw0zmUw8z+v3+wDgeV57uA5dEKU0DEP8vd1u1TNM0/R9nzGWJImarGkapRQAFouFbdt40GEYqiNuqVZkQRAQQqSUUkpCSBRF+Ow0TefzeWOy4ziz2Qx/SylnsxnepfZ2MDLbtpEjjmPXdRtwOyWEcF0XAAzDsG37kGSe5+EDGGOc8w/gNE0bj8eDwaCxAmY4AEDEw5CZpon+oU6tAYcjAEApDYLA9/2rqytK6b+/pOwNALqut7T0bjLLsgBASpllmRqsw4VhOJ/POedRFKkwJ4T0er31er1er6uqwltwA47jHIYMt1gURWP8LdxyuaxPSJKEMcYYU9mkLEu1YBvtqJtYgnC7pmlut1t1SUrpui5jDOHQHdHHsyyr21htxrIsTG8HIEMnK8vSdd23/hsEgYKLogjhhsMhY0xK2ZiMx6oq2061yme4aJ7nV7+EsRYEAaW0HhBxHC+XyziOn2vqmmNbkaGX6LqeJIkKT03TVGYKgmAymTTgGi0GukTdMdpox2mWZalpmq7r9cqIAauE4dY4VlWvVD1A30fzf6wfP/6BnTbDLV5eXtYHsd1owDUsV1VVnud5nsdxjFGJHtbeZjvIMMQMw6hH+29XdxyHEPK2QqRpKoRQUVmv/Z8iw94QAKbTaR0XuyAl5VjvlS88UyFEe5udfNw0A0BVVZZlUUqzLNtsNji4Wq0QmnP++Pi4WCxc10XzbDabp6en0WhECLm9vV2tVnd3d+iaWC12M52cQMvOMY5jSmlVVdPp9L3W+fn5ud4eUkoZY/1+H12eEMI5rxv+A52enkLLfFbvsVom8fqxYm+ngrSlWpEJIXBdwzCSJBmPx/Wr2Fm8vatezVzX7fqestvPFFye5zc3N4SQ6+vrwWBQVdXr6ysAnJ2dXVxc5Hmu4gBfGkaj0fn5uZTy/v7+5eWlA1N7P1PCJkxFXFmWWZaVZalaNMwvqjhyzmezWVdroZ/t+Sbsed7H1VAIEUXRfm/C+5OhKKWO41BKCSFoRc45fj1IkuQzXw8+S/Z16pA1/oiOZN11JOuuI1l3Hcm6a/9v21+nzeY/+M42O5J11/cl+x+RV5C9biVtugAAAABJRU5ErkJggg==)按钮，进入调试界面

2、选择CSKY DEBUG： ![](data:image/*;base64,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)

3、点击左上方的 ![](data:image/*;base64,iVBORw0KGgoAAAANSUhEUgAAABYAAAAZCAIAAAC6gEm5AAAAA3NCSVQICAjb4U/gAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAAuklEQVQ4jWNUVVVjoAwwUah/OBnBIi4uRqkRDAwML1++Ilu/uLjY4AgL7EYIKwpSaoRXg4eqozJFRrBzs9ln29hlW7NxsZJpBASoOap4N3oQ9BSB4BRWFPKqd8fvKcIxws7Djt9TxEYqHk+RkC7+4xBnIVL/rf13Tsw/9evbb3KM+Pn114kFp27vv4tLAQEj3tx/d3jakbf33+NRg88IPI4nbARBxxM2YlvDDvyORwbYI5V4/TiNIAkAAMDAPaU/ePLBAAAAAElFTkSuQmCC)按钮(或F5)启动调试

4、启动调试以后会自动转到已设置的断点 application\_start 函数处，同时上方会出现调试工具栏，提供常用的单步调试功能

![VSCode_debug](https://raw.githubusercontent.com/chenlf123/MarkdownPhotos/master/AliOS-Things/VSCode_debug.png)

