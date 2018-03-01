EN | [中文](AliOS-Things-Porting-Guide.zh)

As shown below, AliOS Things is a layered and component-based architecture that can be easily ported to many kinds of MCU and SoC.
![block_digram](https://img.alicdn.com/tfs/TB1fKQMihrI8KJjy0FpXXb5hVXa-2330-1292.png)


## Typical porting process
### CPU support
It contains supports for various CPU frameworks such as ARM Cortex-M and C-Sky 80x. AliOS Things kernel team is mainly responsible for these part of work, but all of you are welcomed to develop new support based on [Rhino Porting Guide](https://github.com/alibaba/AliOS-Things/wiki/AliOS-Things-Rhino-Porting-Guide), and share in github.

### BSP/HAL
This part mainly contains development of chips and docking with the AliOS Things HAL.

Please refer to [HAL Porting Guide](https://github.com/alibaba/AliOS-Things/wiki/AliOS-Things-HAL-Porting-Guide) for more details.

### CLI
CLI is AliOS Things command line component. It can assist developers to develop and debug, and we strongly suggest you to use it as the first step of porting.
CLI depends on UART HAL, and when porting is completed, developers can interact with AliOS Things by command line to view the state of system.

### Network
According to connective capability of chips, devices that can connect to IP network can be divided as:

1. chips with built-in connective capability, such as WiFi, which can be connected to [WiFi HAL](https://github.com/alibaba/AliOS-Things/wiki/AliOS-Things-WiFi-Porting-Guide) and [LwIP协议栈](https://github.com/alibaba/AliOS-Things/wiki/AliOS-Things-LwIP-Porting-Guide).


2. externally-connected communication modules, for which a standard Socket environment can be provided through SAL



For non-IP devices, please refer to:

- LoRaWAN

- BLE


More about network architecture of AliOS Things can refer to [technical blogs in yq](https://yq.aliyun.com/articles/327862).

### More capabilities
Porting guide for others can refer to appendix.

## Appendix
  * [2.1 Rhino Porting Guide](https://github.com/alibaba/AliOS-Things/wiki/AliOS-Things-Rhino-Porting-Guide)
  * [2.2 HAL Porting Guide](https://github.com/alibaba/AliOS-Things/wiki/AliOS-Things-HAL-Porting-Guide)
  * [2.3 Flash Porting Guide](https://github.com/alibaba/AliOS-Things/wiki/Flash-and-KV-Storage-Porting-Guide)
  * [2.4 WiFi Porting Guide](https://github.com/alibaba/AliOS-Things/wiki/AliOS-Things-WiFi-Porting-Guide)
  * [2.5 LwIP Porting Guide](https://github.com/alibaba/AliOS-Things/wiki/AliOS-Things-LwIP-Porting-Guide)
  * [2.6 SAL Porting Guide](https://github.com/alibaba/AliOS-Things/tree/master/device/sal/README.md)  
  * [2.7 FOTA Porting Guide](https://github.com/alibaba/AliOS-Things/wiki/AliOS-Things-FOTA-Porting-Guide)
  * [2.8 BINS Porting Guide](https://github.com/alibaba/AliOS-Things/wiki/AliOS-Things-BINS-Porting-Guide)
  * [2.9 VFS Porting Guide](https://github.com/alibaba/AliOS-Things/wiki/AliOS-Things-VFS-Porting-Guide)
