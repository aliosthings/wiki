EN| [中文](AliOS-Things内核驱动移植指导) 

本文主要介绍如何将AliOS
Things内核移植到一个新开发板上。主要内容包括目录结构介绍、内核移植说明、hal抽象层移植点。通过本文的介绍可以完成内核基本功能、内核功能认证相关的工作。本文不包含具体中间件和协议栈适配相关内容。

AliOS Things参考版本：AOS-R-2.0.0

参考示例单板：

board: aaboard_demo ;

mcu:   aamcu_demo;

arch:  Cortex-M4

1、基本介绍
===========

1.1 目录结构介绍
----------------

下述为新增一个单板支持，必须关注的几个目录项：

| 目录名         | 介绍                                                             |
|----------------|------------------------------------------------------------------|
| app/example   | 通用用户运行实例，如helloworld实例，可直接使用，无特殊情况不修改 |
| test/develop  | 用户自定义特殊运行实例，满足某一特定场景时添加                   |
| board          | 用户需要适配、可配置board级代码，系统启动相关代码                |
| platform/arch | 该CPU架构内核调度适配接口，可直接使用                            |
| platform/mcu  | 该MCU通用SDK以及对应的hal适配层                                  |

注意：platform/arch下已经适配了目前主流的CPU架构。其他目录结构，如build目录存放了通用的编译体系，用户一般情况下不需要修改；kernel目录下为内核代码，对于移植来说不需要修改。

1.2 编译环境相关介绍
--------------------

### 1.2.1 编译环境安装

使用AliOS Things的编译体系需要安装python和aos cube插件。

环境搭建参考github链接：<https://github.com/alibaba/AliOS-Things/wiki/AliOS-Things-Environment-Setup>

上述链接详细描述了不同的PC环境下，编译环境的搭建指导。

### 1.2.2 编译命令

在 AliOS Things 源码的目录下面，运行

| \$ aos make helloworld\@aaboard_demo |
|--------------------------------------|


其中“helloworld”代表编译的example名，” aaboard_demo”代表编译的board名。

### 1.2.3 编译生成件

编译后，会自动在主目录下生成out目录，其中主要关注下面几个文件。

| 生成文件                             | 介绍                   |
|--------------------------------------|------------------------|
| config.mk                            | 编译工程所有的配置选项 |
| binary/helloworld\@aaboard_demo.bin | 可执行bin文件          |
| binary/helloworld\@aaboard_demo.elf | 可执行elf文件          |
| binary/helloworld\@aaboard_demo.map | 生成map文件            |

2、移植指导及规范
=================

按照上述章节描述，对于移植工作主要涉及四个模块的内容，可以概述为移植四要素：CPU、MCU、board以及example。在移植中由于存在依赖关系，实际会依次按照这四个模块来进行适配。

![](https://i.imgur.com/b8Zxxt9.png)

移植一个新单板，需要先考虑其属于哪种CPU架构，来适配对应的CPU调度接口；第二步添加该MCU通用的设备驱动；然后在board模块下添加相应的板级、外设驱动程序；最后按照需要编写该单板需要运行的example实例。

如果移植依赖的某个要素已经存在，则可直接使用，比如要新增一个stm32f429zi单板，其基于Cortex-M4的CPU架构，而Platform/arch已经有相关实现，则可直接使用。

以下章节按照移植顺序，说明新增一个单板涉及到的所有模块适配工作。

2.1新增CPU架构
--------------

涉及目录：platform/arch

### 2.1.1 已支持CPU架构

arch目录下已经实现了基本通用的CPU架构的porting，如果新增单板的CPU架构在此列表中，则跳过本章节进入新增MCU描述。

下面是支持的arch列表：

| CPU Arch | Processor series |
|----------|------------------|
| ARM      | ARM9             |
|          | Cortex-M0/M0+   |
|          | Cortex-M3        |
|          | Cortex-M4        |
|          | Cortex-M7        |
|          | Cortex-A5        |
|          | Cortex-A7        |
|          | Cortex-A9        |
| xtensa   | LX6              |
|          | LX106            |
| c-sky    | cskyv2-l         |
| renesas  | RL78             |
|          | RX600            |
| mips     | mips32           |
|          | mips-I           |
| linux    |                  |
| Risc-v   | risc_v32I        |

### 2.1.2 新增CPU适配点

对于系统中已经支持的CPU架构，可以直接使用对应的platform/arch模块，如果需要新增CPU架构支持，需要适配下面几个接口，其对所有CPU架构通用：

| CPU Porting接口      | 说明                                                                                                       |
|----------------------|------------------------------------------------------------------------------------------------------------|
| cpu_intrpt_save      | 关中断                                                                                                     |
| cpu_intrpt_restore   | 开中断                                                                                                     |
| cpu_intrpt_switch    | 中断退出切换（在中断处理函数尾部使用，需要确保被打断的上下文正确保存，中断退出后，回到当前最高优先级任务） |
| cpu_task_switch      | 任务切换（需要保存老任务上下文、获取最高优先级任务、恢复新任务上下文）                                     |
| cpu_first_task_start | 进入第一个任务调度                                                                                         |
| cpu_task_stack_init  | 任务栈初始化                                                                                               |
| cpu_cur_get          | 获取当前核号                                                                                               |

涉及到新CPU架构移植，可联系相关支持人员。

### 2.1.3 CPU arch目录规范

**规范**：新增CPU架构规范，以ARM体系为例

| 一级目录 CPU arch | 二级目录 Process arch | 三级目录(具体情况可选) Compiler Type | 四级目录(具体情况可选) Process series |
|-------------------|-----------------------|--------------------------------------|---------------------------------------|
| ARM               | armv5                 | armcc/gcc/iccarm                   |                                       |
|                   | armv6m                | armcc/gcc/iccarm                   | m0                                    |
|                   | armv7m                | armcc/gcc/iccarm                   | m3                                    |
|                   |                       |                                      | m4                                    |
|                   |                       |                                      | m7                                    |
|                   | armv7a                | armcc/gcc/iccarm                   | a5                                    |
|                   |                       |                                      | a7                                    |
|                   |                       |                                      | a9                                    |

三级和四级目录按照具体情况可选。对于三级目录，如果此架构的演化只会使用一套编译体系即gcc，则不需要分此目录；如果二级目录可以区分不同的处理器系列或架构类型，则按照具体情况不需要添加。

规范：arch需要包含下面几个文件

| arch文件  | 介绍                                         |
|-----------|----------------------------------------------|
| k_types.h | 基本数据类型定义，无特殊情况可沿用           |
| port.h    | CPU接口头文件                                |
| port_c.c  | CPU适配.c文件，主要是cpu_task_stack_init适配 |
| port_s.S  | CPU适配.s文件，相关汇编实现                  |

章节2.2.2列出的CPU的适配接口按照实际情况在port_c.c
或者port_s.S中实现。其他CPU架构相关的文件需要放在arch目录下，可以按照实际需求安放。

### 2.1.4 arch mk文件编写

**规范**： 没有例外情况，统一在二级Process arch目录添加对应的编译mk文件。

arch mk添加规范如下（以armv7m为例）：

```
NAME := armv7m                            #Process arch名  
$(NAME)_MBINS_TYPE := kernel              #多bin情况下，归属kernel还是app
$(NAME)_VERSION    := 0.0.1.0             #menuconfig版本号
$(NAME)_SUMMARY    := arch for armv7m     #描述              
$(NAME)_SOURCES       +=                  #组件包含.c文件
GLOBAL_INCLUDES       +=                  #包含头文件   
ifeq ($(COMPILER),armcc)                  #区分编译器
ifeq ($(HOST_ARCH),Cortex-M4)             #区分Process serie
```
2.2新增mcu
----------

涉及目录：platform/mcu。

mcu目录存放其原始SDK驱动文件，以及hal驱动对接层。

外设驱动以及用户对于单板的配置代码不放入此目录，以便该SDK能支持该MCU下所有系列单板。

### 2.2.1 mcu目录规范

主要目录结构：
```
Dir\File                          Description                       Necessary for kernel run
|-- drivers                # board peripheral driver                           Y
|-- hal                    # hal API layer, hal uart is necessary              Y
|-- aos.mk                 # mcu makefile                                      Y
|-- Config.in              # menuconfig component config                       Y
|-- ucube.py               # aos build system file(for scons)                  N
|-- README.md                                                                  Y
```
### 2.2.2 mcu mk文件编写

mcu的mk文件，其描述了当前mcu组件需要的编译文件和编译选项。

如果该系列MCU能实现一个通用mk文件则使用一个即可；如果该MCU体系下存在多种MCU子系列，那么需要添加子mcu的mk文件，在其中放置不同的属性定义。aos.mk作为主mk，主要放置公共的属性配置，并使用HOST_MCU_NAME来分别引用对应的子mcu。不同的mcu子系列主要是由于其链接的驱动文件或者编译选项等不同，需要通过不同的mk来区分实现。

示例：
```
aamcu_demo                              #mcu主目录                         
    |-- aos.mk                          # 该mcu主mk
    |-- aamcu1_demo.mk                  # aamcu1_demo
    |-- aamcu2_demo.mk                  # aamcu2_demo
```
在对应board如aaboard_demo的aos.mk文件引用此mcu模块名时，使用格式：

示例：
```
HOST_MCU_FAMILY    := aamcu_demo
HOST_MCU_NAME      := aamcu1_demo
```
在mcu的主aos.mk中需要分别对子mcu进行引用，使用格式：
```
ifeq ($(HOST_MCU_NAME), aamcu1_demo)
include $(SOURCE_ROOT)platform/mcu/$(PLATFORM_MCU_BOARD)/aamcu1_demo.mk
else ifeq ($(HOST_MCU_NAME),aamcu2_demo)
include $(SOURCE_ROOT)platform/mcu/$(PLATFORM_MCU_BOARD)/aamcu2_demo.mk
endif
```
**aos**.mk其他必须包含项：
```
NAME := mcu_aamcu_demo                     #主MCU名，需要和目录名一致  
$(NAME)_MBINS_TYPE  := kernel              #多bin情况下，归属kernel还是app
$(NAME)_VERSION     := 0.0.1               #menuconfig组件版本号
$(NAME)_SUMMARY     := driver & sdk        #描述               
$(NAME)_SOURCES     +=                     #MCU组件包含.c文件
$(NAME)_COMPONENTS  +=                     #依赖其他组件名
GLOBAL_INCLUDES     +=                     #头文件
GLOBAL_CFLAGS       +=                     #c文件编译选项 
GLOBAL_ASMFLAGS     +=                     #汇编编译选项 
GLOBAL_LDFLAGS      +=                     #链接选项
GLOBAL_DEFINES      +=                     #用户自定义宏   
```
### 2.2.3 关联对应CPU

每个mcu都需要关联对应的CPU，通过在mk中增加引用cpu arch模块来进行关联。

例如对于Cortex-M4：
```
$(NAME)_COMPONENTS += platform/arch/arm/armv7m   
```
2.3新增board
------------

涉及目录：board

board中主要存放外设驱动，板级初始化、以及用户对该board的驱动适配文件。

### 2.3.1 board目录规范

board取名需要使用官方通用名，能方便检索到相关信息

board目录下文件结构部署和命名需要遵循下面布局规则，以aaboard_demo单板为例：
```
Dir\File                          Description                                       Necessary for kernel run
|-- drivers                  # board peripheral driver                                         N
|-- config
|   |-- board.h              # board config file, define for user, such as uart port num       Y
|   |-- k_config.c           # user's kernel hook and mm memory region define                  Y
|   |-- k_config.h           # kernel config file .h                                           Y
|   |-- partition_conf.c     # board flash config file                                         N
|-- startup
|   |-- board.c              # board_init implement                                            Y
|   |-- startup.c            # main entry file                                                 Y
|   |-- startup_gcc.s        # board startup assember for gcc                                  Y
|   |-- startup_iar.s        # board startup assember for iar                                  Y
|   |-- startup_keil.s       # board startup assember for keil                                 Y
|-- aaboard_demo.icf         # linkscript file for iar                                         Y
|-- aaboard_demo.ld          # linkscript file for gcc                                         Y
|-- aaboard_demo.sct         # linkscript file for sct                                         Y
|-- aos.mk                   # board makefile                                                  Y
|-- Config.in                # menuconfig component config                                     Y
|-- ucube.py                 # aos build system file(for scons)                                N
|-- README.md                                                                                  Y

```

board相关初始化使用的函数名需规范统一，参照如下：

| **文件**         | **函数名**                                                                                                                                           |
|------------------|------------------------------------------------------------------------------------------------------------------------------------------------------|
| k_config.c       | 实现样例单板aaboard_demo该文件内所有对接接口                                                                                                         |
| partition_conf.c | 统一分区初始化接口：flash_partition_init                                                                                                             |
| board.c          | 统一单板初始化接口：board_init                                                                                                                       |
| startup.c        | 无特殊情况统一C程序主入口为main； 内部调用单板初始化board_init; 内部调用krhino接口初始化内核； 内部创建主任务入口sys_init。 （具体见初始化流程规范） |

### 2.3.2 board mk文件编写

以下列出mk文件中需要修改的关键点：
```
NAME := board_aaboard_demo                #board_+单板名                   
$(NAME)_MBINS_TYPE := kernel              #在多bin情况下，归属kernel还是app
$(NAME)_VERSION    :=                     #组件版本号
$(NAME)_SUMMARY    :=                     #描述
MODULE             := 1062                #固定
HOST_ARCH          := Cortex-M4           #CPU arch
HOST_MCU_FAMILY    := aamcu_demo          #归属MCU系列，需要对应platform\mcu
SUPPORT_MBINS      := no                  #是否支持app\kernel的bin分离
HOST_MCU_NAME      := aamcu1_demo         #MCU子系列类型
ENABLE_VFP         := 1                   #是否支持浮点数
$(NAME)_SOURCES       +=                  #board组件包含.c文件
$(NAME)_COMPONENTS    +=                  #依赖其他组件名
GLOBAL_INCLUDES       +=                  #头文件
GLOBAL_CFLAGS         +=                  #c文件编译选项 
GLOBAL_ASMFLAGS       +=                  #汇编编译选项 
GLOBAL_LDFLAGS        +=                  #链接选项
GLOBAL_DEFINES        +=                  #用户自定义宏   
注意：
（1）、其中HOST_MCU_FAMILY的定义需要对应platform/mcu下具体某mcu目录名。HOST_MCU_NAME表示具体的mcu子系列。
（2）、用户可以通过GLOBAL_DEFINES定义宏，如GLOBAL_DEFINES += CONFIG_AOS_CLI_BOARD或者GLOBAL_DEFINES += CONFIG_AOS_KV_BLK_BITS=14。当然也可以直接在编译选项 GLOBAL_CFLAGS使用-D定义。

```
### 2.3.3 关联对应MCU

每个board需要关联其从属的MCU，通过在其mk中添加HOST_MCU_FAMILY定义来指定。同时，如果存在子MCU，则还需要设置具体的HOST_MCU_NAME。

例如对于aaboard_demo单板，其要关联MCU是aamcu_demo系列下的aamcu1_demo，在aaboard_demo目录下的aos.mk设置如下：
```
HOST_MCU_FAMILY   := aamcu_demo
HOST_MCU_NAME     := aamcu1_demo
```
2.4新增example
--------------

涉及目录：app/example 和 test/develop

example目录主要存放用户实际需要运行的程序，默认用户app统一入口为application_start。

原则上不建议新增example，除非目前的example不能满足功能需求。app/example下为通用运行实例，test/develop为某些特定场景的实例；如果需要增加实例，无特殊情况，都优先往test/develop中添加。

### 2.4.1 example目录规范

以helloworld目录为例：
```
helloworld
|-- helloworld.c       # helloworld source code, including app entry ”application_start”
|-- Config.in          # menuconfig config file
|-- aos.mk             # aos build system file(for make)
|-- k_app_config.h     # aos app config file, has higher priority than k_config.h
|-- ucube.py           # aos build system file(for scons)
|-- README.md
```

### 2.4.2 example mk文件编写
```
NAME := helloworld                          #example名，和目录统一
$(NAME)_MBINS_TYPE := app                   #在多bin情况下，归属kernel还是app
$(NAME)_VERSION    := 1.0.0                 #menuconfig组件版本号
$(NAME)_SUMMARY    := Hello World           #描述                  
$(NAME)_SOURCES       +=                    #example.c文件
$(NAME)_COMPONENTS    +=                    #依赖其他组件名
GLOBAL_INCLUDES       +=                    #全局头文件
GLOBAL_DEFINES        +=                    #全局宏定义
```

3、代码适配修改点说明
=====================

上一章节按照目录结构来说明适配新单板关注的目录结构，此章节针对特定移植点来说明具体关键特性的实现。对于一项移植工作，建立完相应的目录结构，并完成或者核对相关适配点的修改后，才能完成适配工作。此章节还可以对适配工作后的核对工作提供参考。

以下具体列出新单板适配的关键特性点。

3.1 CPU arch
------------

第一项关键移植特性点就是CPU的架构支持。对于系统中已经支持的CPU架构，可以直接使用对应的platform/arch模块，如果需要新增CPU架构支持，参考章节2.1。

3.2 系统tick
------------

Tick相关的需要有两处修改：

### 3.2.1 tick中断挂接

在tick中断处理接口内部需要调用krhino_tick_proc，并且在处理前后需要加入krhino_intrpt_enter和krhino_intrpt_exit。krhino_intrpt_exit中会使用cpu_intrpt_switch发起新的任务调度。

样例：
```
krhino_intrpt_enter();
krhino_tick_proc();
krhino_intrpt_exit();
```
修改位置：

参考board/aaboard_demo/startup/board.c中SysTick_Handler实现。

可按照实际情况在对应驱动代码中直接修改。

### 3.2.2 tick频率配置

需要将tick中断的频率配置给相应的寄存器。AliOS Things
在k_config.h中有相关RHINO_CONFIG_TICKS_PER_SECOND的设定。

修改位置：

参考board/aaboard_demo/tartup/board.c中board_init的实现，通过RHINO_CONFIG_TICKS_PER_SECOND配置时钟频率。

可按照实际情况对应驱动代码中修改。

3.3 基本串口打印
----------------

系统需要支持基本的串口打印功能，库函数_write_r已经对接到hal_uart_send接口，因此对接相应的hal接口即可。

修改位置：

参考platform/mcu/aamcu_demo/hal/hal_uart.c

3.4 内核可配置项（k_config.h）
------------------------------

k_config.h文件中包含了所有内核裁剪配置，包括模块裁剪、内存裁剪。可以根据不同的模块需求，以及内存大小来进行修改裁剪。k_config.h统一规范放在对应board的config目录下，参考：board/aaboard_demo/config/k_config.h

### 3.4.1 内核模块裁剪

k_config.h中定义了一系列内核相关的宏定义，主要包括模块的使能、栈的大小以及任务的优先级等等的配置。

对于内核模块的裁剪来说，需要运行的上层app直接影响了具体哪些内核模块需要打开。有一个简单有效的方式来选取合适的k_config.h作为基础参考版：

每个board的目录下，都放有一个ucube.py文件，内部通过linux_only_targets定义了该单板支持的运行实例，如helloworld、udataapp、linkkitapp。如果新增单板需要支持的运行实例和已有单板类似，则可直接拷贝其k_config.h过来作为基础版本。

### 3.4.2 内核内存裁剪

对于内存裁剪，不同的CPU由于需要保存的栈上下文有区别，所以在不同的平台上会有区别。基本考虑点是任务的上下文大小，任务内部的处理需要的大致栈大小。这里给出参考的较小任务栈配置，用户需要按照自身资源的情况来调整。
```
RHINO_CONFIG_TIMER_TASK_STACK_SIZE  128
RHINO_CONFIG_K_DYN_TASK_STACK       128
RHINO_CONFIG_IDLE_TASK_STACK_SIZE   100
RHINO_CONFIG_CPU_USAGE_TASK_STACK   100

需要运行上层协议栈时，
打开RHINO_CONFIG_WORKQUEUE项配置栈大小，内核运行时，此项不需要打开：
#define RHINO_CONFIG_WORKQUEUE            1               
#define RHINO_CONFIG_WORKQUEUE_STACK_SIZE 512 
```
可以使用krhino_task_stack_min_free接口来获取某任务的空闲栈大小。如果系统支持了cli，可以使用tasklist命令来输出所有的任务栈信息。下图
“MinFreesize”,
表示该任务运行到目前为止未使用的栈空间，单位都是cpu_stack_t（4字节）。

![](https://i.imgur.com/AYZBfhX.png)

3.5 内核堆配置（k_config.c）
----------------------------

k_config.c
中定义g_mm_region结构体来内核的堆空间。内核初始化时，会自动调用该内存空间。

如果要使用内存申请功能，则需要打开RHINO_CONFIG_MM_TLF宏，来使能k_mm模块，并且配置对应的堆空间。

堆空间定义有三种方式：链接脚本定义、汇编定义、数组定义。**推荐方式：链接脚本定义**。

其基本原则是要预留一个内存空间作为堆使用，并将其交给g_mm_region管理。

参考文件board/aaboard_demo/config/k_config.c关于堆空间的说明。

### 3.5.1 链接脚本定义（建议方式）

链接脚本中定义堆空间：
```
PROVIDE (heap_start = __stack);                 //end of stack
__heap_limit = ORIGIN(RAM) + LENGTH(RAM);
PROVIDE (heap_end = __heap_limit);
PROVIDE (heap_len = heap_end - heap_start);
```
堆的起点heap_start定义为栈的结尾，堆的结尾heap_end定义为RAM的结尾，这样剩余RAM的空间都交给OS管理。

对应的krhino的堆空间初始化为：
```
k_mm_region_t g_mm_region[] = {{(uint8_t *) &heap_start, (size_t) &heap_len}};
```

**注意**：这段内存分配给堆使用，并不是表示内存都耗尽了，而是将其交给OS管理，用户通过malloc出来的内存都是从其中申请。

### 3.5.2 汇编定义

汇编中定义堆空间：
```
heap_len      EQU     0x200
AREA    HEAP, NOINIT, READWRITE, ALIGN=3
heap_start
Heap_Mem        SPACE   heap_len
heap_end
```
此方式并没有将剩余RAM的空间都直接交给OS管理，需要用户自己来调整大小。

对应的krhino的堆空间初始化为：
```
k_mm_region_t g_mm_region[] = {{(uint8_t *) &heap_start, (size_t) & heap_len }};
```
### 3.5.3 数组定义

直接定义一个数组：
```
#define HEAP_BUFFER_SIZE 1024*30
uint8_t g_heap_buf[HEAP_BUFFER_SIZE];
```
此方式也没有将剩余RAM的空间都直接交给OS管理，需要用户自己来调整大小。

对应的krhino的堆空间初始化为：
```
k_mm_region_t g_mm_region[] = {{g_heap_buf, HEAP_BUFFER_SIZE}};
```
3.6 系统初始化（startup.c）
---------------------------

### 3.6.1 初始化相关规范流程

系统从复位启动到main函数入口的流程使用该board通用的启动汇编来实现，此处关注进入main函数内的系统启动流程。

主要包括：board初始化，内核模块初始化krhino_init，创建主任务krhino_task_dyn_create

，内核启动krhino_start。

![](https://i.imgur.com/GGQFu3u.png)

主任务会在krhino_start开始调度后进入，如果不创建主任务，则系统会默认进入OS自身创建的其他任务运行，比如idle任务。

注意事项：

(1)、单板初始化接口统一使用board_init；**由于此接口调用时，内核尚未初始化，此初始化阶段不能激活中断处理，否则会触发中断调度;**

(2)、内核初始化统一使用krhino接口，如krhino_init和krhino_start;

(3)、krhino_init前不调用malloc、printf函数。原因是此类库函数被内核重定向，会调用内核接口aos_malloc，依赖内核的初始化;

(4)、内核初始化本身只会创建内部任务，如idle/timer任务；初始化流程中需要创建主任务，供用户app运行。统一通过krhino接口如krhino_task_dyn_create来创建主任务；主任务的入口统一为**sys_init;**

(5)、在sys_init中，可以添加相关中断激活程序的驱动，比如开始tick计数并触发可能的tick中断，具体实现参考对应单板；如果需要初始化相关中间件和协议栈模块，使用aos_components_init接口；最后，在非多bin的情况下，统一调用application_start进入上层app入口；多bin情况下，由aos_components_init内部分发处理。

### 3.6.2 系统初始化示例

**参考代码**（board/aaboard_demo/startup/startup.c）**：**

**系统初始化示例：**
```
int main(void)
{
    /*irq initialized is approved here.But irq triggering is forbidden, which will enter CPU scheduling.
    Put them in sys_init which will be called after aos_start.
    Irq for task schedule should be enabled here, such as PendSV for cortex-M4.
    */
    board_init();   //including aos_heap_set();  flash_partition_init();
    /*kernel init, malloc can use after this!*/
    krhino_init();
    /*main task to run */
    krhino_task_dyn_create(&g_main_task, "main_task", 0, OS_MAIN_TASK_PRI, 0, OS_MAIN_TASK_STACK, (task_entry_t)sys_init, 1);
    /*kernel start schedule!*/
    krhino_start();
    /*never run here*/
    return 0;
}   
```
**主任务初始化示例**：
```
static void sys_init(void)
{
    /* user code start*/
    /*insert driver to enable irq for example: starting to run tick time.
     drivers to trigger irq is forbidden before aos_start, which will start core schedule.
    */
    /*user_trigger_irq();*/  //for example
    /*aos components init including middleware and protocol and so on !*/
    aos_components_init(&kinit);
    #ifndef AOS_BINS
    application_start(kinit.argc, kinit.argv);  /* jump to app/example entry */
    #endif
} 
```
**用户app入口示例**（参考app/example/helloworld/helloworld.c）**：**
```
int application_start(int argc, char *argv[])
{
    int count = 0;
    printf("nano entry here!\r\n");
    while(1) {
        printf("hello world! count %d \r\n", count++);
        aos_msleep(1000);
    };
}
```
4、内核测试认证指导
===================

AliOS
Things提供了基本的内核测试用例集，用于内核移植后的测试验证，所有移植的平台都需要运行该测试样例，确保内核功能的正确性。

内核测试集目录：test/testcase/certificate_test

在上面目录下提供了两个测试文件rhino_test.c和aos_test.c。其中rhino_test.c针对于纯内核rhino的测试，aos_test.c针对于至少包含AOS
API层的移植，其测试任务主要参考下面的《AliOS Things Kernel 测试指南参考》。

目前主要的认证项都会通过aos层，如果只关注rhino_test.c相关纯内核的验证，需要做以下修改：

-   修改rhino_test.c配置项，如：
```
/*以下字符定义可任取名字，不能为空*/
#define SYSINFO_ARCH        " MIPS"                    
#define SYSINFO_MCU         " RDA"
#define SYSINFO_DEVICE_NAME " RDA8955"
#define SYSINFO_APP_VERSION "2.0.0"

/*kv和yloop不属于纯krhino模块，需要关闭*/
#define TEST_CONFIG_KV_ENABLED                  (0)
#define TEST_CONFIG_YLOOP_ENABLED               (0)
```
-   将rhino_test.c和cut.c/cut.h加入编译体系

可以将test/testcase/certificate_test目录下此三个直接拷贝到对应mcu下，新建一个test目录并加入到makefile；其他IDE直接添加编译文件。

-   在主任务中调用test_certificate执行测试用例认证直到用例通过即可。

上面属于纯rhino内核的测试方式，如果带aos接口层的测试请参考，

AliOS Things Kernel
测试指南：<https://github.com/alibaba/AliOS-Things/wiki/Manual-API>

5、代码合入整体原则
===================

5.1、公共代码修改
-----------------

公共代码原则上避免修改，以影响其他单板。通用文件修改后，需要确认不影响其他工程的编译和运行。如果影响公共代码，需要清晰说明：是修复bug、增加新特性、或是改进功能，并介绍如何完成的。

公共代码范围：目前除新增board目录、新增mcu目录，新增test/develop目录，其他目录或者文件都视为公共文件，包括app/example目录。修改后，都可能影响其他单板。

5.2、License准则
----------------

-   原创为主尊重版权，请作者的标明自己的 copyright
    信息，并签署[CLA](https://cla-assistant.io/alibaba/AliOS-Things)

-   禁止合入这些 license 的代码:
    [AGPL](http://www.gnu.org/licenses/agpl-3.0.html),
    [CPAL](http://opensource.org/licenses/CPAL-1.0),
    [OSL](http://opensource.org/licenses/OSL-3.0) 等严格开源许可证

-   谨慎处理 GPL/LGPL 等强制开源许可证的代码，考虑以下替代方案

>   （1）将 GPL/LGPL 或类似许可证源码编译为二进制程序，作为独立软件使用

>   （2）将 LGPL 或类似许可证源码编译为动态连接库，并以动态连接方式调用

>   （3）将 LGPL
>   或类似许可证源码编译为静态链接库与应用程序相结合发布，但同时提供整个应用程序(含
>   LGPL 静态连接库)的目标代码和 LGPL 库源码

-   允许使用的 license: BSD, MIT, Apache License Version 2.0, Zlib, CDDL
    等宽松开源许可证

5.3、CI验证通过
---------------

-   Build: 代码 autobuild, PV build 通过

-   Test: PV 测试通过(目前暂无此步骤)

-   Agreement: [CLA](https://cla-assistant.io/alibaba/AliOS-Things) 已签署
