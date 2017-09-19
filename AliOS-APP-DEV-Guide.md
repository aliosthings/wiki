---
> * 1 概述
> * 2 硬件环境准备
> * 3 开发环境搭建
> * 4 AliOS应用开发步骤
> * 5 第一个AliOS应用
> * 6 AliOS开发组件介绍
> * 7 总结
---

# 1 概述
本文将描述如何基于AliOS源码进行应用开发，涉及的内容包括：软硬件环境搭建、如何创建第一个应用程序、AliOS重要开发组件的使用等。

# 2 硬件环境准备
AliOS可以运行在各种硬件平台上。开发应用的硬件环境包括开发板、串口、调试器、烧录器等，详细的硬件环境搭建请参考[AliOS Environment Setup](https://github.com/alibaba/AliOS/wiki/AliOS-Environment-Setup)

# 3 开发环境搭建
AliOS的开发支持IDE（AliOS Studio）和命令行工具，AliOS开发环境的搭建请参照：[AliOS Environment Setup](https://github.com/alibaba/AliOS/wiki/AliOS-Environment-Setup)

# 4 AliOS应用开发步骤
基于AliOS可以很方便地进行应用开发。基于AliOS创建应用，在IDE环境下可以通过导入应用模版的方式，在非IDE环境下可以手动创建各种工程目录和文件。
## 4.1 在非IDE环境中进行应用开发
非IDE环境中的应用开发步骤主要包括工程目录的创建、工程Makefile编写、源码编写、工程编译、程序烧录、调试等步骤。
### 4.1.1 创建工程目录
AliOS的应用工程一般放在“example”目录下，用户也可以根据需要在其他目录下创建应用工程的目录。
### 4.1.2 添加Makefile
Makefile用于指定应用的名称、使用到的源文件、依赖的组件、全局符号等。下面是sample.mk样例文件的内容：
```
NAME := helloworld  ## 指定应用名称
$(NAME)_SOURCES := helloworld.c  ## 指定使用的源文件
$(NAME)_COMPONENTS += cli  ## 指定依赖的组件，本例使用cli组件
GLOBAL_DEFINES += YOS_NO_WIFI ## 定义全局符号
```
### 4.1.3 添加源码
所有的源码文件放置在应用工程目录下，开发者可以根据自行组织源码文件/目录。AliOS的应用程序入口为：
`int application_start(int argc, char *argv[]);`

所有的应用程序都必须包含`application_start`入口函数，应用程序的逻辑从该入口函数开始。
### 4.1.4 编译工程
非IDE环境下的编译，请参照：`待添加`
### 4.1.5 烧录程序
非IDE环境下的烧录，请参照：`待添加`
### 4.1.6 程序调试
非IDE环境下的调试，请参照：`待添加`
## 4.2 在AliOS Studio IDE中进行应用开发
AliOS提供了AliOS Studio集成开发环境，基于AliOS Studio进行应用开发非常方便、快捷。AliOS提供了可供导入的应用模版，用户可以基于导入的模版进行应用开发。在AliOS Sutdio IDE中，也可以很方便地进行编译、烧录、调试等
### 4.2.1 创建应用项目
关于如何在AliOS Studio中创建应用，请参考[使用AliOS Studio创建应用](https://github.com/alibaba/AliOS/wiki/AliOS-Studio#22-创建-app-项目)。创建完项目后，用户可以在AliOS Studio中添加、编辑应用代码。
### 4.2.2 编译
[使用AliOS Studio编译](https://github.com/alibaba/AliOS/wiki/AliOS-Studio#3-编译)
### 4.2.3 烧录
[使用AliOS Studio烧写](https://github.com/alibaba/AliOS/wiki/AliOS-Studio#4-烧写)
### 4.2.4 调试
[使用AliOS Studio调试](https://github.com/alibaba/AliOS/wiki/AliOS-Studio#5-调试)

# 5 第一个AliOS应用
本节以helloworld工程为例来说明如何创建一个AliOS应用（基于非IDE环境）。
## 5.1 创建工程目录
在“example”目录下添加helloworld工程目录。

## 5.2 创建Makefile
在hellworld工程目录下，创建helloworld.mk文件，并添加Makefile内容：
```
NAME := helloworld
$(NAME)_SOURCES := helloworld.c
```
## 5.3 创建源文件
在hellworld工程目录下，创建helloworld.c文件，并添加以下源代码：
```c
#include <aos/aos.h>

static void app_delayed_action(void *arg)
{
    printf("%s:%d %s\r\n", __func__, __LINE__, aos_task_name());
    aos_post_delayed_action(5000, app_delayed_action, NULL);
}

int application_start(int argc, char *argv[])
{
    aos_post_delayed_action(1000, app_delayed_action, NULL);
    aos_loop_run();
}
```

## 5.4 编译、烧录和运行
请按照前述章节对helloworld应用进行编译和烧录。烧录完成后启动开发板，应用程序会被自动执行。helloworld应用启动后串口打印如下：

![](https://img.alicdn.com/tfs/TB11fSrdwMPMeJjy1XdXXasrXXa-231-161.png)

# 6 AliOS开发组件介绍
AliOS提供了丰富的组件来支持IoT应用的开发。
## 6.1 yloop
yloop是基于事件监听机制实现的异步框架组件，主要负责管理系统各类事件的分发处理。yloop支持监听本地事件和网络事件，支持延时调用，支持workqueue处理耗时事件。yloop提供了注册，发送事件的接口。开发者可以用这些接口编写基于事件监听机制的程序，以及和系统其他组件的消息通信。更多关于yloop组件的介绍，请参考：[yloop介绍](https://github.com/alibaba/AliOS/wiki/AliOS-API-YLOOP-Guide)
## 6.2 kernel
kernel是AliOS最核心的组件之一，通过kernel对芯片提供了实时操作系统的能力。AliOS kernel实现了多任务机制，多个任务之间的调度，任务之间的同步、通讯、互斥、事件，内存分配，trace功能，多核等等的机制。开发者可以利用kernel提供的api来实现一个rtos所具备的能力。开发者可以利用现有已移植的cpu体系架构来达到快速的移植能力。更多关于kernel各组件的信息，请参考：[kernel介绍](https://github.com/alibaba/AliOS/wiki/AliOS-API-KERNEL-Guide)
## 6.3 alink
alink组件提供开放丰富安全可靠的云服务，可以用于alink上云连接服务，如配网、数据上报alink等。借助alink组件，用户可以很方便的实现实现用户与设备、设备与设备、设备与用户之间的互联互动。关于alink组件详细的介绍以及接口的定义，请参考：[alink介绍](https://github.com/alibaba/AliOS/wiki/AliOS-API-ALINK-Guide)
## 6.4 硬件抽象层（HAL）
HAL是AliOS最核心的组件之一，最主要的目的是为了屏蔽底下不同的芯片平台的差异，从而使上面的应用软件不会因为不同的芯片而改变。目前ALiOS定义了全面的hal抽象层，芯片公司或者用户只要对接相应的hal接口既能满足控制芯片的控制器，从而达到控制硬件外设的目的。HAL包含的功能有adc，flash， gpio，i2c，pwm，rng，rtc，sd，spi，timer，uart，wdg。开发者可以利用HAL的API来快速达到控制硬件外设的能力。由于目前的HAL层是非常标准的API，开发者可以参考现有移植的HAL层的开发，来达到快速移植的能力。更多关于kernel组件的介绍，请参考：[kernel介绍](https://github.com/alibaba/AliOS/wiki/AliOS-API-KERNEL-Guide)
## 6.5 kv
`待添加`。更多关于kv组件的介绍，请参照：[kv介绍](https://github.com/alibaba/AliOS/wiki/AliOS-API-KV-Guide)
## 6.6 vfs
`待添加`。更多关于vfs组件的介绍，请参考：[vfs介绍](https://github.com/alibaba/AliOS/wiki/AliOS-API-VFS-Guide)
## 6.7 uMesh
uMesh是AliOS核心组件之一，模组之间通过uMesh能够形成自组织网络。uMesh实现了mesh链路管理、mesh路由、6LoWPAN、AES-128数据加解密等。它能够支持mesh原始数据包、IPv4或IPv6多种数据传输方式。开发者可以使用熟悉的socket编程，利用uMesh提供的自组织网络实现智能设备的开发和互连，能够使用在智能照明，智能抄表，智能家居等场景。开发者也可以通过实现uMesh提供的mesh HAL层接口，将uMesh移植到不同的通信介质，如WiFi，802.15.4, BLE等。
## 6.8 cli
AliOS应用开发中可以支持命令行，并且可以添加用户自定义命令。当需要注册或撤销自定义命令时，可以借助“cli”组件。更多关于cli组件的介绍，请参考：[cli介绍](https://github.com/alibaba/AliOS/wiki/AliOS-API-CLI-Guide)

下图展示了一个实际示例应用中的命令列表。

![](https://img.alicdn.com/tfs/TB1ETiGdwMPMeJjy1XcXXXpppXa-447-367.png)
## 6.8 log
使用log组件可以定义和使用不同级别的日志打印。更多关于log组件的介绍和接口定义，请参考：[log介绍](https://github.com/alibaba/AliOS/wiki/AliOS-API-LOG-Guide)

# 7 总结
本文描述了基于AliOS的应用模型，介绍了软硬件开发环境的搭建、应用开发的基本步骤。以helloworld为例，展示了如何基于AliOS进行应用开发。本文最后，还介绍了AliOS提供的丰富组件和接口，以及如何利用这个组件进行应用开发。
想了解AliOS更详细的信息，请访问[AliOS Github主页](https://github.com/alibaba/AliOS)。