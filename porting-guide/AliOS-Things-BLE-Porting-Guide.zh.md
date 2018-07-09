AliOS-Things-BLE-Porting-Guide |中文

# 目录

* [1 协议栈介绍](#1协议栈介绍)
* [2 目录结构](#2目录结构)
* [3 代码移植](#3代码移植)
* [4 链接配置移植](4#链接配置移植)
---

本文档针对需要对aos ble协议栈进行对接需求包括controller HCI层对接，代码编译配置文件。

# 1协议栈介绍
aos ble协议栈支持bt 4.0/4.2/5.0 低功耗核心协议栈，对上提供GAP/GATT层接口提供与云端交互能力,对下提供HCI层和厂商蓝牙芯片controller进行HCI cmd/event/data交互对接。
- 支持蓝牙BLE5.0 
- GAP支持Peripheral，Master，Observer， Adverstiser
- GATT 支持Client, Server
- Connection支持Security Connection
- HCI层抽象，支持物理H4结构和虚拟HCI接口
- 可配置stack，包括ble功能，buffer大小，连接数目等
# 2目录结构
蓝牙协议栈相关的文件目录位于< /aos/kernel/protocols/bluetooth/>下：
```
├── common
│   ├── include
│   │   ├── arch
│   │   ├── common
│   │   ├── linker
│   │   ├── misc
│   │   ├── net
│   │   ├── toolchain
│   │   └── zephyr
│   └── tinycrypt
│       ├── include
│       │   └── tinycrypt
│       └── source
├── controller
│   ├── hal
│   │   └── nrf5
│   ├── hci
│   ├── include
│   ├── ll_sw
│   ├── ticker
│   └── util
├── hci_drivers
├── host
│   └── bt_mesh
├── include
│   ├── bluetooth
│   │   └── mesh
│   └── drivers
│       └── bluetooth
└── port
└── include
```
其中比较重要的有：
- /host  
 ble协议栈，包含了HCI command ,HCI event处理，连接管理，核心协议L2CAP，ATT，SMP的实现
- /controller  
 蓝牙controller的实现，主要是厂商提供，包括，HCI层实现，Linker Layer和Radio射频部分的控制逻辑。
- /include/bluetooth  
 协议栈接口header文件。
- /hci_drivers  
 蓝牙HCI驱动，主要包含H4驱动文件。
- /port/include/  
 蓝牙协议栈配置文件
# 3代码移植
代码移植工作集中在:
- aos kernel
   请参阅wiki相关kernel移植指南
- aos driver
   请参阅已支持的nordic nrf52xxx系列驱动移植事例，代码位于aos/platform/mcu/nrf52xxx目录，包含了常见硬件timer, UART, flash等常用驱动支持。
- controller
   请参阅支持的nordic nrf52xxx系列控制器移植事例，aos/kernel/protocols/bluetooth/controller，厂商实现Link layer层,Radio收发逻辑，以及和HCI层对接
- Host HCI层
   在kernel和driver适配基础上，需要对接HCI层，host部分收发处理接口在host/hci_core.c里:
   - `int bt_recv(struct net_buf *buf)`  
     包含了HCI接收函数，根据hci数据类型调用对应的hci_acl()或者hci_event()
   - `int bt_hci_driver_register(const struct bt_hci_driver *drv)`  
     注册hci层回调函数，在controller的HCI接口中调用  
     根据HCI适配不同，有两种HCI driver实现：  
     1. 实际物理层HCI比如UART H4接口的controller请参考bluetooth/hci_drivers/h4.c H4接口的实现事例,
      ```
      static struct bt_hci_driver drv = {
          .name       = "H:4",
          .bus        = BT_HCI_DRIVER_BUS_UART,
          .open       = h4_open,
          .send       = h4_send,
      };
      ```
     2. 虚拟HCI接口，一般针对SOC类型蓝牙controller，通过虚拟HCI层实现Link Layer层对协议栈对接，可参考controller/hci/hci_driver.c下nrf52xxx系列实现  
     ```
        static const struct bt_hci_driver drv = {
                .name   = "Controller",
                .bus    = BT_HCI_DRIVER_BUS_VIRTUAL,
                .open   = hci_driver_open,
                .send   = hci_driver_send,
        };
        ```
        - hci_driver_open除初始化hci，LL以外，还会开启两个aos task:prio_recv_thread_data和recv_thread_data 任务： prio_recv_thread_data对number of complete,cmd status,cmd complet event进行优先处理 ； recv_thread_data调用协议栈接口int bt_recv(struct net_buf *buf) 
        - hci_driver_send会根据hci数据类型对接controller的linker layer对应的 *hci_acl_handle* 和*hci_cmd_handle* 

# 4连接配置移植

蓝牙依赖的主要组件：

- 协议栈bluetooth.a : /aos/kernel/protocols/bluetooth/bluetooth.mk
- 控制器controller.a: /aos/kernel/protocols/bluetooth/controller/controller.mk
- 驱动pca10040.a  :/ aos/platform/mcu/nrf52xx/nrf52832.mk

移植到不同的平台需要对控制器和驱动对应的makefile文件修改和配置。
