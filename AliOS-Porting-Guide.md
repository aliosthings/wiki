## [1 AliOS Porting Rhino Guide](https://github.com/alibaba/AliOS/wiki/AliOS-Porting-Rhino-Guide)
AliOS提供了内核Rhino，可通过该文档完成最小系统的移植。
## [2 AliOS Porting HAL Guide](https://github.com/alibaba/AliOS/wiki/AliOS-Porting-HAL-Guide)
AliOS提供了驱动接口框架，可通过该文档完成外设驱动的移植。
## [3 AliOS Porting WiFi Guide](https://github.com/alibaba/AliOS/wiki/AliOS-Porting-WiFi-Guide)
AliOS定义了完整的WiFi硬件抽象接口，通过这些WiFi HAL接口可以很好的操作WiFi设备。开发者移植新硬件平台时，需要实现WiFi HAL层的接口。
## [4 AliOS Porting FOTA Guide](https://github.com/alibaba/AliOS/wiki/AliOS-Porting-FOTA-Guide)
AliOS提供原生FOTA功能，已完成对Alink、MQTT等协议通道的支持，开发者移植新硬件平台时，只需对底层flash操作接口进行适配封装即可。
## [5 AliOS Porting LwIP Guide](https://github.com/alibaba/AliOS/wiki/AliOS-Porting-LWIP-Guide)
AliOS提供LwIP协议栈支持，并且已经完成与AliOS对接。默认条件下，开发者仅需要完成网卡驱动对接，即可开始无缝使用AliOS提供的LwIP协议栈。
## [6 AliOS Porting BINS Guide](https://github.com/alibaba/AliOS/wiki/AliOS-Porting-BINS-Guide)
AliOS提供多bin编译功能，支持kernel bin、app bin的单独编译、烧录能力，尤其节省了ota资源。开发者移植新硬件平台时，只需对平台链接脚本及编译脚本进行适配封装即可。