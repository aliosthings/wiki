EN | [中文](AliOS-Things-FreeRTOS-Porting-Guide.zh)

本文主要指导如何将已经运行FreeRTOS的系统切换到AliOS
Things上。此文档包括了详细的OS目录结构对比、CPU移植必要点，以及OS接口替换指导。适用于指导在通用CPU体系上，FreeRTOS系统向AliOS
Things的整体迁移。

参考版本：

FreeRTOS：FreeRTOSv10.0.1

AliOS Things：AOS-R-1.3.2
## 目录  

- [一 主要特性对比](#一主要特性对比)
	- [1.1 内核功能](#11内核功能)
	- [1.2 实时性](#12实时性)
	- [1.3 代码体积以及占用的RAM大小](#13代码体积以及占用的ram大小)

- [二 通用CPU移植修改点](#二通用cpu移植修改点)
	- [2.1 已经支持的CPU移植](#21已经支持的cpu移植)
	- [2.2 尚不支持的CPU移植](#22尚不支持的cpu移植)
		- [2.2.1 CPU porting](#221-cpu-porting)
		- [2.2.2 系统tick](#222-系统tick)
		- [2.2.3 C库](#223-c库)
		- [2.2.4 基本输入输出](#224-基本输入输出)
		- [2.2.5 运行示例example](#225-运行示例example)
		- [2.2.6 内核可配置项](#226-内核可配置项)
		- [2.2.7 系统初始化](#227-系统初始化)
- [三 AOS API适配指导](#三aos-api适配指导)  
	- [3.1 AOS Task API](#31-aos-task-api)
	- [3.2 AOS Queue API](#32-aos-queue-api)
	- [3.3 AOS Sem API](#33-aos-sem-api)
	- [3.4 AOS Mutex API](#34-aos-mutex-api)
	- [3.5 AOS Timer API](#35-aos-timer-api)
	- [3.6 AOS Event API](#36-aos-event-api)
	- [3.7 AOS Work API](#37-aos-work-api)
	- [3.8 AOS Mem API](#38-aos-mem-api)
	- [3.9 其他系统相关接口](#39-其他系统相关接口)  

- [四 内核API对比参考](#四内核api对比参考)  
	- [4.1 Task API](#41task-api)
	- [4.2 Buf Queue API](#42buf-queue-api)
	- [4.3 Queue API](#43queue-api)
	- [4.4 Semaphore & Mutex API](#44semaphore--mutex-api)
	- [4.5 Timer API](#45timer-api)
	- [4.6 Event API](#46event-api)
	- [4.7 Mem API](#47-mem-api)
	- [4.8 Co-routines API](#48co-routines-api)
	- [4.9 smp多核 API](#49smp多核-api)
	- [4.10 内核头文件包含](#410内核头文件包含)

- [五 编译方式说明](#五编译方式说明)
	- [5.1 内核涉及文件部署](#51内核涉及文件部署)
	- [5.2 Keil\iar\e2studio相关IDE](#52Keiliare2studio相关ide)
	- [5.3 Gcc(linux\vscode) 编译命令说明](#53gcclinuxvscode-编译命令说明)

- [六 内核移植认证](#六内核移植认证)  
- [七 移植问题反馈途径](#七移植问题反馈途径)

一、主要特性对比
================

以下三个方面和FreeRTOS对比:

-   内核功能

-   实时性

-   代码体积以及占用的RAM大小

基本功能点，接口层面的见第后续章节

1.1、内核功能
-------------

AliOS Things的内核rhino模块和FreeRTOS的相应模块功能基本能够对应上。AliOS
Things在内核架构上，提供了aos层的接口封装，其封装了内核涉及到的主要功能接口。内核自身以及bsp驱动、hal层相关都使用rhino层的内核接口，其他相关模块，包括协议栈、framwork、APP层都需要统一使用aos层的对应内核接口。

| 功能模块          | FreeRTOS                                               | AliOS Things（rhino）                                       | AliOS Things（aos层接口） |
|-------------------|--------------------------------------------------------|-------------------------------------------------------------|---------------------------|
| Task任务          | Source\\tasks.c                                        | kernel\\rhino\\core\\k_task.c                               | Aos_task\*                |
| Buf Queue数据队列 | Source\\queue.c Source\\include\\queue.h               | kernel\\rhino\\core\\k_buf_queue.c                          | Aos_queue\*               |
| Queue地址队列     | 无                                                     | kernel\\rhino\\core\\k_queue.c                              | 无                        |
| Semaphore & Mutex | Source\\queue.c Source\\include\\semphr.h              | kernel\\rhino\\core\\k_sem.c kernel\\rhino\\core\\k_mutex.c | Aos_sem\* Aos_mutex\*     |
| Timer             | Source\\timers.c Source\\include\\timers.h             | kernel\\rhino\\core\\k_timer.c                              | Aos_timer\*               |
| Event事件         | Source\\event_groups.c Source\\include\\event_groups.h | kernel\\rhino\\core\\k_event.c                              | Aos_event\*               |
| Co-routines       | Source\\croutine.c Source\\include\\croutine.h         | 目前业务上不需要co-routine                                  | 无                        |
| Smp               | 无                                                     | kernel\\rhino\\core\\k_task.c 宏RHINO_CONFIG_CPU_NUM区分    | 无                        |
| config配置项      | FreeRTOSConfig.h                                       | K_config.h                                                  | 不相关                    |
| CPU Arch          | Source\\portable\\                                     | platform\\arch                                              | 不相关                    |

1.2、实时性
-----------

| BenchMark         | Rhino    | FreeRTOS               |
|-------------------|----------|------------------------|
| Interrupt delay   | 1.543us  | 2.9us                  |
| Max disable sched | 0us      | 内存管理使用关调度实现 |
| Task Preemption   | 15.534us | 17.603us               |
| Task Yield        | 11.675us | 9.432us                |
| Semaphore notify  | 30.3us   | 26.532us               |
| Mutex notify      | 34.353us | 32.972us               |

注：Basing on CK802T , 20M HZ, 256KB RAM

-   Interrupt Delay、Max disable sched和Task
    Preemption是最重要的几个实时性指标，Interrupt Delay相比FreeRTOS性能提高一倍,
    Task Preemption比FreeRROS优2us。rhino
    所有系统API都不会关调度，保证优先级高的任务能够随时抢占

-   Task Yield 比FreeRTOS慢2us

-   信号量通知的性能比FreeRTOS慢3.5us

-   Mutex 通知的功能比起FreeRTOS稍差

以上数据对比来自中天微公司的实测。

从实时操作系统的指标来看，Interrupt
delay是最重要的实时性指标，是实时操作系统的硬实时的标准，各家
rtos主推的实时性指标也是这一个。如果Interrupt
delay时间大的话，在一些高实时性的领域，比如工业，医疗，航空等领域，就会不符合要求。其次的一个实时性指标是Max
disable
sched，这是决定一个实时操作系统的软实时性的指标，从上表中可以看出rhino这块的时间为0，整个系统不关抢占，而freertos的设计比如分配内存等采用了关内核抢占的形式，所以这个时间是比较大的。从这两个实时性指标来看，rhino均占优势。

1.3、代码体积以及占用的RAM大小
------------------------------

**最小配置情况下（只运行一个idle task）**

| Size | Rhino     | Freertos  |
|------|-----------|-----------|
| ROM  | 1900 Byte | 2943 Byte |
| RAM  | 900 Byte  | 1180 Byte |
| TCB  | 64 Byte   | 60 Byte   |

注:

-   Rhino 的Footprint比FreeRTOS整体占优

TCB多出的4个字节是因为Rhino为了解决优先级反转嵌套而引入，FreeRTOS没有完善解决此问题。完整的系统级的优先级反转解决能力是rhino相比其它rtos的一大竞争力所在。

二、通用CPU移植修改点
=====================

对于CPU移植项，主要是针对内核rhino的移植，aos层不涉及。对于AliOS
Things已经支持的CPU，相关的arch\\cpu文件可以直接使用，只需要加入编译体系即可；对于尚未支持的CPU，只需要对照相关移植点修改即可。

AliOS Things支持硬件列表

| CPU Arch | Processor series     | MCU series                   |
|----------|----------------------|------------------------------|
| ARM      | ARM968E-S            | MXCHIP MOC108 MK3060         |
|          | ARM Cortex-M0        | STM32L073RZ-Nucleo           |
|          |                      | MXCHIP EML3047               |
|          |                      | NXP FRDM-KL27Z(MKL27Z64VLH4) |
|          | ARM Cortex-M3        | MXCHIP MX1101                |
|          | ARM Cortex-M4        | STM32L432KC-Nucleo           |
|          |                      | STM32L433RC-Nucleo           |
|          |                      | STM32L475VG                  |
|          |                      | STM32L476RG-Nucleo           |
|          |                      | STM32L496G-DISCO             |
|          |                      | NXP LPC5410x LPCXpresso54102 |
|          |                      | GigaDevice GD32 F4           |
|          |                      | Eastsoft ES8P508x            |
|          |                      | MXCHIP MK3166                |
|          |                      | MXCHIP MK3239                |
|          | ARM Cortex-M7        | STM32F769I-DISCO             |
| xtensa   | LX6                  | ESP32                        |
|          | LX106                | ESP8266                      |
| c-sky    | CK802                | Hobbit1_evb                  |
| renesas  | RL78                 | r5f100lea                    |
|          | RX600                | r5f565ne                     |
| mips     | mips32               | Ats3503                      |
|          | mips-I               | RDA8955                      |
|          |                      | RDA5841                      |
| linux    | User mode simulation | linuxhost                    |

上述支持列表以实际版本中支持的为准。

具体可以按照下面目录结构查找实际版本支持的单板情况：

| Board单板支持 | CPU arch支持       | MCU支持       | IDE样例工程（keil等） |
|---------------|--------------------|---------------|-----------------------|
| Board目录     | platform\\arch目录 | platform\\mcu | projects              |

2.1、已经支持的CPU移植
----------------------

对于此类型CPU，AliOS Things工程内，已经支持了OS在该平台上运行所需的CPU
arch代码，因此不需要额外的CPU架构相关的移植工作，可以跳过2.2.1 CPU
porting章节，进行mcu相关的适配。

2.2、尚不支持的CPU移植
----------------------

对于新增一个CPU类型（包括arch、mcu相关），我们需要关注几个重要移植点。完成这些移植点后，AliOS
Things就能适配上一个新的CPU。

主要移植点：

### 2.2.1 CPU porting

如果需要新增CPU架构支持，在platform\\arch目录下增加相应目录。相应的文件参考已有命名和部署。

主要涉及的适配接口包括：

| AliOS Things（CPU接口） | FreeRTOS对应参考接口                          | 说明                                                                                                       |
|-------------------------|-----------------------------------------------|------------------------------------------------------------------------------------------------------------|
| cpu_intrpt_save         | portDISABLE_INTERRUPTS                        | 关中断                                                                                                     |
| cpu_intrpt_restore      | portENABLE_INTERRUPTS                         | 开中断                                                                                                     |
| cpu_intrpt_switch       | portYIELD_FROM_ISR                            | 中断退出切换（在中断处理函数尾部使用，需要确保被打断的上下文正确保存，中断退出后，回到当前最高优先级任务） |
| cpu_task_switch         | portYIELD                                     | 任务切换（需要保存老任务上下文、获取最高优先级任务、恢复新任务上下文）                                     |
| cpu_first_task_start    | 参考xPortStartScheduler或vPortStartFirstTask  | 进入第一个任务调度                                                                                         |
| cpu_task_stack_init     | pxPortInitialiseStack                         | 任务栈初始化                                                                                               |
| cpu_cur_get             | 无。单核统一使用0，多核按照具体寄存器实际获取 | 当前核号                                                                                                   |

### 2.2.2 系统tick

Tick相关的需要有两处修改：

#### 2.2.2.1 tick中断挂接

在tick中断处理接口内部需要调用krhino_tick_proc，并且在处理前后需要加入krhino_intrpt_enter和krhino_intrpt_exit

样例：

| krhino_intrpt_enter(); krhino_tick_proc(); krhino_intrpt_exit(); |
|------------------------------------------------------------------|


对应FreeRTOS中xPortSysTickHandler或FreeRTOS_Tick_Handler处理。

#### 2.2.2.2 tick频率配置

需要将tick中断的频率配置给相应的寄存器。AliOS Things
在k_config.h中有相关RHINO_CONFIG_TICKS_PER_SECOND的设定。对应替换configTICK_RATE_HZ的设置即可。

| Tick频率 | Rhino                         | Freertos           |
|----------|-------------------------------|--------------------|
| 宏设定   | RHINO_CONFIG_TICKS_PER_SECOND | configTICK_RATE_HZ |

### 2.2.3 C库

OS内已经实现了分别针对armcc、gcc、iar三种编译体系的C库函数对接。

| Armcc                                            | Gcc                           | iar                                        |
|--------------------------------------------------|-------------------------------|--------------------------------------------|
| utility\\libc\\compilers\\armlibc\\ armcc_libc.c | utility\\libc\\ newlib_stub.c | utility\\libc\\compilers\\iar\\ iar_libc.c |

对于keil\\iar等IDE平台，只需要将对应的文件加入编译体系，对于gcc，只需要将对应的组件libc加入makefile体系即可。

比如platform\\mcu\\stm32l475\\ stm32l475.mk中设定了\$(NAME)_COMPONENTS += libc

### 2.2.4 基本输入输出

OS运行后，需要有基本的打印输出功能，即printf能工作；对于需要能在串口执行命令的需求下，还需要有获取串口字符串功能。一般通过重构下述接口实现:

|            | 参考接口          | 说明                                                                                     |
|------------|-------------------|------------------------------------------------------------------------------------------|
| 格式化打印 | PUTCHAR_PROTOTYPE | 参考内部调用hal_uart_send； Hal_uart为hal抽象层； 也可以根据特殊情况简化基本打印功能     |
| 字符获取   | GETCHAR_PROTOTYPE | 参考内部调用hal_uart_recv_II； 内部必须实现**中断异步字符接收，禁止死循环查询，阻塞CPU** |

也可以参考上述“C库”章节，重定向对应的底层库接口，比如newlibc_stub.c的_read_r和_write_r。

### 2.2.5 运行示例example

在目录example下提供了各种OS上app运行实例，对于基本的内核移植，可以参考example\\rhinorun将该实例运行起来，即表示内核基本的任务、tick中断能够正常运行。对于需要使用aos上层应用的移植，参考起点为将example\\helloworld运行起来。

| Aos层基本运行样例   | 内核rhino层基本运行样例 |
|---------------------|-------------------------|
| example\\helloworld | example\\rhinorun       |

### 2.2.6 内核可配置项

K_config.h文件中包含了所有内核裁剪配置，包括模块裁剪、内存裁剪。可以根据不同的模块需求，以及内存大小来进行修改裁剪。

#### 2.2.6.1 内核模块裁剪

| 内核模块裁剪 | 参考配置                                   | 说明                 |
|--------------|--------------------------------------------|----------------------|
| 纯krhino版本 | STM32L073RZ-Nucleo\\helloworld\\k_config.h | 内核运行必要的配置项 |
| 联网上云版本 | Board\\b_l475e\\k_config.h                 | 通用参考配置         |

#### 2.2.6.2 内核内存裁剪

对于内存裁剪，不同的CPU由于需要保存的栈上下文有区别，所以在不同的平台上会有区别。基本考虑点是任务的上下文大小，任务内部的处理需要的大致栈大小。参考缩减任务栈配置：

| RHINO_CONFIG_TIMER_TASK_STACK_SIZE 128 RHINO_CONFIG_K_DYN_TASK_STACK 128 RHINO_CONFIG_IDLE_TASK_STACK_SIZE 100 RHINO_CONFIG_CPU_USAGE_TASK_STACK 100 需要运行上层协议栈时， 打开RHINO_CONFIG_WORKQUEUE项配置栈大小： \#define RHINO_CONFIG_WORKQUEUE_STACK_SIZE 512 |   |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---|


上述栈大小是系统运行的建议大小，尚不是系统极限能运行的大小。如果在一个系统中，对于内存使用需要使用到极致，可以按照两个步骤来估算极限值：

1.  直接估算法：

（1）、计算实际任务上下文。根据不同的CPU，如ARM\\MIPS\\XTENSA需要保存的寄存器不一样，不同的配置项，比如开不开浮点数等计算需要保存的现场栈大小；

（2）、估算任务处理接口内部开栈大小

B、实际运行检测调整

下述图中“StackSize”表示任务栈总大小，“MinFreesize”表示该任务运行到目前为止未使用的栈，单位都是cpu_stack_t（4字节）；

如果系统未支持cli命令，可以使用krhino_task_stack_min_free接口来获取某任务的“MinFreesize”。

![](https://i.imgur.com/Lk4YbI3.png)

#### 2.2.6.3 内核使用堆的配置

如果要使用内存申请功能，则需要打开RHINO_CONFIG_MM_TLF宏，来使能k_mm模块，并且配置对应的堆空间。

堆空间定义有三种方式：链接脚本定义、汇编定义、数组定义。**推荐方式：链接脚本定义**。

其基本原则是要预留一个内存空间作为堆使用，并将其交给g_mm_region管理。

##### 2.2.6.3.1 链接脚本定义（建议方式）

（参考文件：platform\\mcu\\nrf52xxx\\ nrf52_common.ld）

![](https://i.imgur.com/IlZq8jB.png)

堆的起点heap_start定义为栈的结尾，堆的结尾heap_end定义为RAM的结尾，这样剩余RAM的空间都交给OS管理。

对应的krhino的堆空间初始化为：

| k_mm_region_t g_mm_region[] = {{(uint8_t \*) &heap_start, (size_t) \&heap_len}}; |
|----------------------------------------------------------------------------------|


**注意**：这段内存分配给堆使用，并不是表示内存都耗尽了，而是将其交给OS管理，用户通过malloc出来的内存都是从其中申请。

##### 2.2.6.3.2 汇编定义

（参考文件：platform\\mcu\\stm32l4xx\\src\\STM32L496G-Discovery\\startup_stm32l496xx_keil.s）

![](https://i.imgur.com/GyZwsmE.png)

此方式并没有将剩余RAM的空间都直接交给OS管理，需要用户自己来调整大小。

对应的krhino的堆空间初始化为：

| k_mm_region_t g_mm_region[] = {{(uint8_t \*) &__heap_base, (size_t) \&Heap_Size}}; |
|------------------------------------------------------------------------------------|


##### 2.2.6.3.3 数组定义

（参考文件：platform\\mcu\\nrf52xxx\\aos\\ soc_impl.c）

直接定义一个数组：

| \#define HEAP_BUFFER_SIZE 1024\*20 uint8_t g_heap_buf[HEAP_BUFFER_SIZE]; |   |
|--------------------------------------------------------------------------|---|


此方式也没有将剩余RAM的空间都直接交给OS管理，需要用户自己来调整大小。

对应的krhino的堆空间初始化为：

| k_mm_region_t g_mm_region[] = {{g_heap_buf, HEAP_BUFFER_SIZE}}; |
|-----------------------------------------------------------------|


### 2.2.7 系统初始化

#### 2.2.7.1 硬件初始化

| FreeRTOS                                             | AliOS Things                                       | 初始化流程（按序）                                                                                                                                  |
|------------------------------------------------------|----------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------|
| 按照实际不同MCU                                      | 按照实际不同MCU                                    | 硬件复位、段拷贝、库初始化到main函数（也可能其他函数名）                                                                                            |
| prvSetupHardware                                     | 建议参考其他单板，修改为board_init，也可以直接使用 | 系统基本C相关初始化 注意： 不能有 printf、不能激活中断； 原因参考下面内核初始化描述                                                                 |
| vApplicationSetupTimerInterrupt 或其他需要激活的中断 | 可以直接使用该函数                                 | 1、中断相关触发硬件初始化操作，目前主要是tick； 2、需要在主任务入口处sys_init调用，即任务调度被激活之后才能触发中断，因为中断处理后会使用调度功能。 |

#### 2.2.7.2 内核初始化

| FreeRTOS            | AliOS Things         | 说明                                                                                                                                     |
|---------------------|----------------------|------------------------------------------------------------------------------------------------------------------------------------------|
| vTaskStartScheduler | aos_init + aos_start | 对于只关注内核时，接口使用为：krhino_init + krhino_start； FreeRTOS在vTaskStartScheduler内部进行了相关的初始化；形式不同，内部实现类似。 |

初始化的流程都大同小异，其中CPU本身的启动加载按照不同板子的实际情况处理，此处仅说明OS部分的初始化。

主要包括：内核模块初始化aos_init;创建主任务aos_task_new;内核启动aos_start。

![](https://i.imgur.com/1x1r9gy.png)

主任务会在aos_start开始调度后进入，如果不创建主任务，则系统会默认进入OS自身创建的其他任务运行，比如idle任务。主任务入口一般初始化内核运行需要的相关硬件寄存器，比如tick时钟，串口等等。一些硬件初始化也可以放在aos_init之前，但是需要注意在内核初始化前，禁止启动和内核相关的操作，主要包括激活带内核处理的中断，比如tick\\uart，依赖内核的库函数：

（1）、aos_start前不能有OS相关的中断处理。原因是如果在内核运行前触发了某个中断，并且该中断使用了krhino_intrpt_exit处理，则会进入任务切换，而此时内核尚未开始调度；

（2）、printf、malloc相关的接口，在内核初始化后才能使用。原因是此类库函数被内核重定向，会调用内核接口aos_malloc，依赖内核的初始化。

三、AOS API适配指导
===================

AliOS
Things和FreeRTOS同为嵌入式OS系统，双方在接口使用上虽然存在着一些差别，但是由于其定位类似，所以大部分功能接口都能找到对应的处理，或者通过简单的功能组合来实现。

AliOS
Things的内核模块使用带krhino_的接口，此接口一般是内核本身或者纯内核的软件系统使用；对于需要集成协议栈或应用的系统，统一提供AOS
API内核抽象接口。Aos_rhino.c内抽象出了上层所需要使用的内核功能，并且尽可能将参数精简，以达到用户使用方便的目的。

另外，通过AOS
API层，还可以封装其他如FreeRTOS、posix的接口，可参考aos_freertos.c和aos_posix.c文件。尤其对于FreeRTOS的切换来说，可以重点参考aos_freertos.c，其内部已经完成了AOS
API和相关FreeRTOS的对接。此章节作为AOS API的使用参考以及和FreeRTOS的对应关系。

以下列出AOS
API相关接口的具体描述以及其和FreeRTOS的对应接口关系。Rhino层面的接口描述见下章节。

3.1 AOS Task API
----------------

### 3.1.1 整体API对比

| AOS API              | FreeRTOS                           | 说明                                                 |
|----------------------|------------------------------------|------------------------------------------------------|
| aos_task_new         | xTaskCreate                        | 动态创建任务                                         |
|                      | xTaskCreateStatic                  | 静态创建任务                                         |
| aos_task_new_ext     | xTaskCreate                        | 动态创建任务，任务句柄可获取                         |
|                      | xTaskCreateStatic                  | 静态创建任务，任务句柄可获取                         |
| aos_task_exit        | vTaskDelete                        | 删除任务                                             |
| aos_task_name        | pcTaskGetName                      | 得到任务名字                                         |
| aos_task_key_create  | 无                                 | 任务私有区索引，FreeRTOS用户自己制定索引位置，不分配 |
| aos_task_key_delete  | 无                                 | 任务私有区索引，FreeRTOS用户自己制定索引位置，不分配 |
| aos_task_setspecific | vTaskSetThreadLocalStoragePointer  | 设置任务的私有属性                                   |
| aos_task_getspecific | pvTaskGetThreadLocalStoragePointer | 得到任务的私有属性                                   |
| aos_msleep           | vTaskDelay                         | 任务睡眠多少ticks                                    |

### 3.1.2 具体接口详述

#### 3.1.2.1 aos_task_new

>   定义描述：

| 函数原型 | int aos_task_new(const char \*name, void (\*fn)(void \*), void \*arg, int stack_size)                                                |
|----------|--------------------------------------------------------------------------------------------------------------------------------------|
| 描述     | 动态创建一个任务，任务句柄不返回，创建完后自动运行； 采用默认优先级AOS_DEFAULT_APP_PRI（32） 受宏RHINO_CONFIG_KOBJ_DYN_ALLOC开关控制 |
| 返回值   | 类型：int 返回成功或失败;                                                                                                            |
| 入参     | name：任务名                                                                                                                         |
|          | fn：任务处理函数                                                                                                                     |
|          | Arg: 任务处理函数参数                                                                                                                |
|          | stack_size：任务栈大小（单位：字节）                                                                                                 |

#### 3.1.2.2 aos_task_new_ext

>   定义描述：

| 函数原型 | int aos_task_new_ext(aos_task_t \*task, const char \*name, void (\*fn)(void \*), void \*arg, int stack_size, int prio) |
|----------|------------------------------------------------------------------------------------------------------------------------|
| 描述     | 动态创建一个任务，传入任务句柄，并指定优先级，创建完后自动运行 受宏RHINO_CONFIG_KOBJ_DYN_ALLOC开关控制                 |
| 返回值   | 类型：int 返回成功或失败;                                                                                              |
| 入参     | Task：任务句柄                                                                                                         |
|          | name：任务名                                                                                                           |
|          | fn：任务处理函数                                                                                                       |
|          | arg: 任务处理函数参数                                                                                                  |
|          | stack_size：任务栈大小（单位：字节）                                                                                   |
|          | Prio:任务运行优先级 （范围：0\~ RHINO_CONFIG_PRI_MAX-2; RHINO_CONFIG_PRI_MAX-1为idle任务）                             |

#### 3.1.2.3 aos_task_exit

>   定义描述：

| 函数原型 | void aos_task_exit(int code)                           |
|----------|--------------------------------------------------------|
| 描述     | 任务自动退出； 受宏RHINO_CONFIG_KOBJ_DYN_ALLOC开关控制 |
| 返回值   | 无                                                     |
| 入参     | code：参数无作用                                       |

#### 3.1.2.4 aos_task_name

>   定义描述：

| 函数原型 | char \*aos_task_name(void) |
|----------|----------------------------|
| 描述     | 返回任务名                 |
| 返回值   | 类型：char \*；任务名      |
| 入参     | 无                         |

#### 3.1.2.5 aos_task_key_create

>   定义描述：

| 函数原型 | int aos_task_key_create(aos_task_key_t \*key)                                                          |
|----------|--------------------------------------------------------------------------------------------------------|
| 描述     | 返回任务私有数据区域的空闲块索引                                                                       |
| 返回值   | 类型：int；成功或失败                                                                                  |
| 出参     | Key: 任务私有数据区域的空闲块索引； 范围0\~RHINO_CONFIG_TASK_INFO_NUM-1； 每索引块可存放一个void\*地址 |

#### 3.1.2.6 aos_task_key_delete

>   定义描述：

| 函数原型 | void aos_task_key_delete(aos_task_key_t key)                              |
|----------|---------------------------------------------------------------------------|
| 描述     | 删除任务私有数据区域的空闲块索引                                          |
| 返回值   | 无                                                                        |
| 入参     | Key: 任务私有数据区域的空闲块索引； 范围0\~RHINO_CONFIG_TASK_INFO_NUM-1； |

#### 3.1.2.7 aos_task_setspecific

>   定义描述：

| 函数原型 | int aos_task_setspecific(aos_task_key_t key, void \*vp)                         |
|----------|---------------------------------------------------------------------------------|
| 描述     | 设置当前任务私有数据区域的某索引空闲块内容； 受宏RHINO_CONFIG_TASK_INFO开关控制 |
| 返回值   | Int:成功或失败                                                                  |
| 入参     | Key: 当前任务私有数据区域的空闲块索引； 范围0\~RHINO_CONFIG_TASK_INFO_NUM-1；   |
|          | Vp: 需要存放进入任务私有空闲区域的地址指针                                      |

#### 3.1.2.8 aos_task_getspecific

>   定义描述：

| 函数原型 | void \*aos_task_getspecific(aos_task_key_t key)                                 |
|----------|---------------------------------------------------------------------------------|
| 描述     | 获取当前任务私有数据区域的某索引数据块内容； 受宏RHINO_CONFIG_TASK_INFO开关控制 |
| 返回值   | Void\*:私有区域某索引内容                                                       |
| 入参     | Key: 任务私有数据区域的空闲块索引； 范围0\~RHINO_CONFIG_TASK_INFO_NUM-1；       |

#### 3.1.2.9 aos_msleep

>   定义描述：

| 函数原型 | void aos_msleep(int ms) |
|----------|-------------------------|
| 描述     | 将当前任务睡眠ms数      |
| 返回值   | 无                      |
| 入参     | Ms：睡眠ms数            |

3.2 AOS Queue API
-----------------

### 3.2.1 整体API对比

| AOS API            | FreeRTOS                                                    | 说明                          |
|--------------------|-------------------------------------------------------------|-------------------------------|
| aos_queue_new      | [xQueueCreate](http://www.freertos.org/a00116.html)         | 动态创建queue                 |
|                    | xQueueCreateStatic                                          | 静态创建queue                 |
| aos_queue_free     | vQueueDelete                                                | 删除queue                     |
| aos_queue_send     | xQueueSend                                                  | 发送元素到queue               |
|                    | xQueueSendFromISR                                           | 从中断发送元素到queue         |
|                    | xQueueSendToBack                                            | 发送元素到queue尾部           |
|                    | xQueueSendToBackFromISR                                     | 从中断发送元素到queue尾部     |
| aos_queue_recv     | [xQueueReceive](http://www.freertos.org/a00118.html)        | 从queue接收一个消息           |
|                    | [xQueueReceiveFromISR](http://www.freertos.org/a00120.html) | 从中断中queue接收一个消息     |
| aos_queue_is_valid |                                                             | 判断queue是否有效             |
| aos_queue_buf_ptr  |                                                             | 获取一个队列queue的缓冲区起点 |

### 3.2.2 具体接口详述

整体受宏RHINO_CONFIG_BUF_QUEUE开关控制

#### 3.2.2.1、aos_queue_new

>   定义描述：

| 函数原型 | int aos_queue_new(aos_queue_t \*queue, void \*buf, unsigned int size, int max_msg) |
|----------|------------------------------------------------------------------------------------|
| 描述     | 创建一个队列，指定缓冲区大小，以及最大数据单元大小                                 |
| 返回值   | 类型：int 返回成功或失败;                                                          |
| 入参     | queue：queue队列描述结构体指针；需要用户定义一个queue结构体                        |
|          | buf:此queue队列的缓冲区起点                                                        |
|          | Size：此queue队列的缓冲区大小                                                      |
|          | max_msg：一次存入缓冲区的最大数据单元                                              |

#### 3.2.2.2、aos_queue_free

>   定义描述：

| 函数原型 | void aos_queue_free(aos_queue_t \*queue) |
|----------|------------------------------------------|
| 描述     | 删除一个队列，并释放阻塞在其中的任务     |
| 返回值   | 无                                       |
| 入参     | queue：queue队列描述结构体指针；         |

#### 3.2.2.3、aos_queue_send

>   定义描述：

| 函数原型 | int aos_queue_send(aos_queue_t \*queue, void \*msg, unsigned int size) |
|----------|------------------------------------------------------------------------|
| 描述     | 向queue内发送数据，并唤醒存在的第一个高优先级阻塞任务                  |
| 返回值   | 类型：int 返回成功或失败;                                              |
| 入参     | queue：queue队列描述结构体指针；                                       |
|          | Msg：发送数据起始内存                                                  |
|          | Size：发送数据大小                                                     |

#### 3.2.2.4、aos_queue_recv

>   定义描述：

| 函数原型 | int aos_queue_recv(aos_queue_t \*queue, unsigned int ms, void \*msg, unsigned int \*size) |
|----------|-------------------------------------------------------------------------------------------|
| 描述     | 从queue内收取数据，如没有数据则阻塞当前任务等待                                           |
| 返回值   | 类型：int 返回成功或失败; 超时返回RHINO_BLK_TIMEOUT                                       |
| 入参     | queue：queue队列描述结构体指针；                                                          |
|          | ms：传入0表示不超时，立即返回；AOS_WAIT_FOREVER表示永久等待；其他数值表示超时时间，单位ms |
| 出参     | Msg：返回获取到的数据的内存指针                                                           |
|          | Size：返回获取到的数据大小                                                                |

#### 3.2.2.5、aos_queue_is_valid

>   定义描述：

| 函数原型 | int aos_queue_is_valid(aos_queue_t \*queue) |
|----------|---------------------------------------------|
| 描述     | 判断一个队列queue是否有效                   |
| 返回值   | 类型：int 返回1表示有效，0表示无效          |
| 入参     | queue：队列结构体指针；                     |

#### 3.2.2.6、aos_queue_buf_ptr

>   定义描述：

| 函数原型 | void \*aos_queue_buf_ptr(aos_queue_t \*queue) |
|----------|-----------------------------------------------|
| 描述     | 获取一个队列queue的缓冲区起点                 |
| 返回值   | 类型：void\* 返回队列queue的缓冲区起点        |
| 入参     | queue：队列结构体指针；                       |

3.3 AOS Sem API
---------------

### 3.3.1 整体API对比

| AOS API            | FreeRTOS                       | 说明                                  |
|--------------------|--------------------------------|---------------------------------------|
| aos_sem_new        | xSemaphoreCreateCounting       | 动态创建信号量                        |
|                    | xSemaphoreCreateCountingStatic | 静态创建信号量                        |
| aos_sem_free       | vSemaphoreDelete               | 删除信号量                            |
| aos_sem_wait       | xSemaphoreTake                 | 信号量获得                            |
|                    | xSemaphoreTakeRecursive        |                                       |
| aos_sem_signal     | xSemaphoreGive                 | 给还信号量                            |
|                    | xSemaphoreGiveFromISR          | 中断中给还信号量                      |
| aos_sem_is_valid   |                                | 信号量是否有效                        |
| aos_sem_signal_all |                                | 释放一个sem信号量，并唤醒所有阻塞任务 |

### 3.3.2 具体接口详述

>   整体受宏RHINO_CONFIG_KOBJ_DYN_ALLOC和RHINO_CONFIG_SEM开关控制

#### 3.3.2.1、aos_sem_new

>   定义描述：

| 函数原型 | int aos_sem_new(aos_sem_t \*sem, int count)                                    |
|----------|--------------------------------------------------------------------------------|
| 描述     | 动态创建一个sem信号量                                                          |
| 返回值   | 类型：int 返回成功或失败;                                                      |
| 入参     | sem：信号量结构体指针；需要用户定义一个sem结构体                               |
|          | Count:此sem的初始计数值，此值大于0，才能获取到信号量，获取一次，count计数减1； |

#### 3.3.2.2、aos_sem_free

>   定义描述：

| 函数原型 | void aos_sem_free(aos_sem_t \*sem) |
|----------|------------------------------------|
| 描述     | 释放一个sem信号量                  |
| 返回值   | 无                                 |
| 入参     | sem：信号量结构体指针；            |

#### 3.3.2.3、aos_sem_wait

>   定义描述：

| 函数原型 | int aos_sem_wait(aos_sem_t \*sem, unsigned int timeout)                                        |
|----------|------------------------------------------------------------------------------------------------|
| 描述     | 获取一个sem信号量；获取不到信号量，当前任务阻塞                                                |
| 返回值   | 类型：int 返回成功或失败; 超时返回RHINO_BLK_TIMEOUT                                            |
| 入参     | sem：信号量结构体指针；                                                                        |
|          | Timeout：传入0表示不超时，立即返回；AOS_WAIT_FOREVER表示永久等待；其他数值表示超时时间，单位ms |

#### 3.3.2.4、aos_sem_signal

>   定义描述：

| 函数原型 | void aos_sem_signal(aos_sem_t \*sem)          |
|----------|-----------------------------------------------|
| 描述     | 释放一个sem信号量，并唤醒一个高优先级阻塞任务 |
| 返回值   | 无                                            |
| 入参     | sem：信号量结构体指针；                       |

#### 3.3.2.5、aos_sem_is_valid

>   定义描述：

| 函数原型 | int aos_sem_is_valid(aos_sem_t \*sem) |
|----------|---------------------------------------|
| 描述     | 判断一个信号量sem是否有效             |
| 返回值   | 类型：int 返回1表示有效，0表示无效    |
| 入参     | sem：信号量结构体指针；               |

#### 3.3.2.6、aos_sem_signal_all

>   定义描述：

| 函数原型 | void aos_sem_signal_all(aos_sem_t \*sem) |
|----------|------------------------------------------|
| 描述     | 释放一个sem信号量，并唤醒所有阻塞任务    |
| 返回值   | 无                                       |
| 入参     | sem：信号量结构体指针；                  |

3.4 AOS Mutex API
-----------------

### 3.4.1 整体API对比

| AOS API            | FreeRTOS                       | 说明                    |
|--------------------|--------------------------------|-------------------------|
| aos_mutex_new      | xSemaphoreCreateMutex          | 动态创建mutex           |
|                    | xSemaphoreCreateMutexStatic    | 静态创建mutex           |
|                    | xSemCreateRecursiveMutex       | 动态创建可嵌套mutex     |
|                    | xSemCreateRecursiveMutexStatic | 静态动态创建可嵌套mutex |
| aos_mutex_free     | vQueueDelete                   | 释放mutex               |
| aos_mutex_lock     | xSemaphoreTakeRecursive        | 加锁mutex               |
| aos_mutex_unlock   | xSemaphoreGiveRecursive        | 可嵌套释放mutex锁       |
| aos_mutex_is_valid |                                | 判断mutex是否有效       |

### 3.4.2 具体接口详述

>   整体受RHINO_CONFIG_KOBJ_DYN_ALLOC开关控制

#### 3.4.2.1、aos_mutex_new

>   定义描述：

| 函数原型 | int aos_mutex_new(aos_mutex_t \*mutex)               |
|----------|------------------------------------------------------|
| 描述     | 动态创建一个mutex互斥锁                              |
| 返回值   | 类型：int 返回成功或失败;                            |
| 入参     | mutex：互斥锁结构体指针；需要用户定义一个mutex结构体 |

#### 3.4.2.2、aos_mutex_free

>   定义描述：

| 函数原型 | void aos_mutex_free(aos_mutex_t \*mutex) |
|----------|------------------------------------------|
| 描述     | 释放一个mutex互斥锁                      |
| 返回值   | 无                                       |
| 入参     | mutex：互斥锁结构体指针；                |

#### 3.4.2.3、aos_mutex_lock

>   定义描述：

| 函数原型 | int aos_mutex_lock(aos_mutex_t \*mutex, unsigned int timeout)                                  |
|----------|------------------------------------------------------------------------------------------------|
| 描述     | 加锁一个mutex互斥锁，并设置超时时间；获取不到锁，当前任务阻塞                                  |
| 返回值   | 类型：int 返回成功或失败;超时返回RHINO_BLK_TIMEOUT                                             |
| 入参     | mutex：互斥锁结构体指针；                                                                      |
|          | Timeout：传入0表示不超时，立即返回；AOS_WAIT_FOREVER表示永久等待；其他数值表示超时时间，单位ms |

#### 3.4.2.4、aos_mutex_unlock

>   定义描述：

| 函数原型 | int aos_mutex_unlock(aos_mutex_t \*mutex)       |
|----------|-------------------------------------------------|
| 描述     | 解锁一个mutex互斥锁，并唤醒一个高优先级阻塞任务 |
| 返回值   | 类型：int 返回成功或失败;                       |
| 入参     | mutex：互斥锁结构体指针；                       |

#### 3.4.2.5、aos_mutex_is_valid

>   定义描述：

| 函数原型 | int aos_mutex_is_valid(aos_mutex_t \*mutex) |
|----------|---------------------------------------------|
| 描述     | 判断一个mutex互斥锁是否有效                 |
| 返回值   | 类型：int 返回1表示有效，0表示无效          |
| 入参     | mutex：互斥锁结构体指针；                   |

3.5 AOS Timer API
-----------------

### 3.5.1 整体API对比

| AOS API                       | FreeRTOS                  | 说明                                                   |
|-------------------------------|---------------------------|--------------------------------------------------------|
| aos_timer_new                 | xTimerCreate              | 动态创建软件定时器                                     |
|                               | xTimerCreateStatic        | 静态创建软件定时器                                     |
| aos_timer_new_ext             | xTimerCreate              | 动态创建软件定时器                                     |
|                               | xTimerCreateStatic        | 静态创建软件定时器                                     |
| aos_timer_start               | xTimerStart               | 软件定时器启动                                         |
|                               | xTimerStartFromISR        | 软件定时器在中断中启动。FreeRTOS此设计值得商榷         |
| aos_timer_stop                | xTimerStop                | 软件定时器停止                                         |
|                               | xTimerStopFromISR         | 软件定时器在中断中停止 FreeRTOS此设计值得商榷          |
| aos_timer_change              | xTimerChangePeriod        | 改变软件定时器的周期                                   |
|                               | xTimerChangePeriodFromISR | 软件定时器在中断中改变软件周期。FreeRTOS此设计值得商榷 |
| aos_timer_free                | xTimerDelete              | 删除软件定时器                                         |
| aos_timer_stop aos_timer_free | xTimerReset               | 重置软件定时器                                         |

### 3.5.2 具体接口详述

整体受宏RHINO_CONFIG_TIMER开关控制

#### 3.5.2.1、aos_timer_new

>   定义描述：

| 函数原型 | int aos_timer_new(aos_timer_t \*timer, void (\*fn)(void \*, void \*),void \*arg, int ms, int repeat) |
|----------|------------------------------------------------------------------------------------------------------|
| 描述     | 创建一个定时器，并自动运行                                                                           |
| 返回值   | 类型：int 返回成功或失败;                                                                            |
| 入参     | timer：timer描述结构体指针；需要用户定义一个timer结构体                                              |
|          | fn: 定时器处理函数                                                                                   |
|          | arg：定时器处理参数                                                                                  |
|          | ms：定时器超时时间（单位ms）                                                                         |
|          | Repeat：周期或单次（1：周期，0：单次）                                                               |

#### 3.5.2.2、aos_timer_new_ext

>   定义描述：

| 函数原型 | int aos_timer_new_ext(aos_timer_t \*timer, void (\*fn)(void \*, void \*),void \*arg, int ms, int repeat, unsigned char auto_run) |
|----------|----------------------------------------------------------------------------------------------------------------------------------|
| 描述     | 创建一个定时器，并设置是否自动运行                                                                                               |
| 返回值   | 类型：int 返回成功或失败;                                                                                                        |
| 入参     | timer：timer描述结构体指针；需要用户定义一个timer结构体                                                                          |
|          | fn: 定时器处理函数                                                                                                               |
|          | arg：定时器处理参数                                                                                                              |
|          | ms：定时器超时时间（单位ms）                                                                                                     |
|          | Repeat：周期或单次（1：周期，0：单次）                                                                                           |
|          | auto_run：1表示自动运行，0表示需要调用start                                                                                      |

#### 3.5.2.3、aos_timer_free

>   定义描述：

| 函数原型 | void aos_timer_free(aos_timer_t \*timer) |
|----------|------------------------------------------|
| 描述     | 释放一个定时器                           |
| 返回值   | 无                                       |
| 入参     | timer：定时器描述结构体指针；            |

#### 3.5.2.4、aos_timer_start

>   定义描述：

| 函数原型 | int aos_timer_start(aos_timer_t \*timer) |
|----------|------------------------------------------|
| 描述     | 启动一个定时器                           |
| 返回值   | 类型：int 返回成功或失败;                |
| 入参     | timer：定时器描述结构体指针；            |

#### 3.5.2.5、aos_timer_stop

>   定义描述：

| 函数原型 | int aos_timer_stop(aos_timer_t \*timer) |
|----------|-----------------------------------------|
| 描述     | 停止一个定时器                          |
| 返回值   | 类型：int 返回成功或失败;               |
| 入参     | timer：定时器描述结构体指针；           |

#### 3.5.2.6、aos_timer_change

>   定义描述：

| 函数原型 | int aos_timer_change(aos_timer_t \*timer, int ms) |
|----------|---------------------------------------------------|
| 描述     | 修改一个定时器周期                                |
| 返回值   | 类型：int 返回成功或失败;                         |
| 入参     | timer：定时器描述结构体指针；                     |
|          | Ms：新的定时器周期，单位ms                        |

3.6 AOS Event API
-----------------

### 3.6.1 整体API对比

| Aos接口        | FreeRTOS                    | 说明                  |
|----------------|-----------------------------|-----------------------|
| aos_event_new  | xEventGroupCreate           | 动态创建even group    |
|                | xEventGroupCreateStatic     | 静态创建even group    |
| aos_event_free | vEventGroupDelete           | 删除event group       |
| aos_event_get  | xEventGroupWaitBits         | 等待event的位         |
| aos_event_set  | xEventGroupSetBits          | 设置event的位         |
|                | xEventGroupSetBitsFromISR   | 从中断中设置event的位 |
|                | xEventGroupClearBits        | 清掉event的位         |
|                | xEventGroupClearBitsFromISR | 中断中清掉event的位   |

### 3.6.2 具体接口详述

整体受宏RHINO_CONFIG_EVENT_FLAG开关控制

#### 3.6.2.1、aos_event_new

>   定义描述：

| 函数原型 | int aos_event_new(aos_event_t \*event, unsigned int flags)     |
|----------|----------------------------------------------------------------|
| 描述     | 创建一个事件                                                   |
| 返回值   | 类型：int 返回成功或失败;                                      |
| 入参     | event：event事件描述结构体指针；需要用户定义一个event结构体    |
|          | flags: 此event事件的初始状态；通过int的32个bit的组合来表示事件 |

#### 3.6.2.2、aos_event_free

>   定义描述：

| 函数原型 | void aos_event_free(aos_event_t \*event) |
|----------|------------------------------------------|
| 描述     | 释放一个事件                             |
| 返回值   | 无                                       |
| 入参     | event：事件描述结构体指针；              |

#### 3.6.2.3、aos_event_get

>   定义描述：

| 函数原型 | int aos_event_get( aos_event_t \*event, unsigned int flags, unsigned char opt, unsigned int \*actl_flags, unsigned int timeout )                                                                                                                                                                                                                          |
|----------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 描述     | 获取一个事件，根据其是否满足flags标志；获取不到事件，当前任务阻塞                                                                                                                                                                                                                                                                                         |
| 返回值   | 类型：int 返回成功或失败; 超时返回RHINO_BLK_TIMEOUT                                                                                                                                                                                                                                                                                                       |
| 入参     | event：event事件描述结构体指针；                                                                                                                                                                                                                                                                                                                          |
|          | Flags：期望获取的事件标志，和opt参数关联                                                                                                                                                                                                                                                                                                                  |
|          | Opt：事件获取策略； RHINO_AND 0x02u：AND策略，Flags的每个非0bit位都在event中存在； RHINO_AND_CLEAR 0x03u: AND并清除策略，Flags的每个非0bit位都在event中存在；并清除event对应原始Flags数据； RHINO_OR：0x00u: OR策略，Flags中任意非0bit在event中存在； RHINO_OR_CLEAR：0x01u：OR并清除策略，Flags中任意非0bit在event中存在；并清除event对应原始Flags数据； |
|          | Timeout：传入0表示不超时，立即返回；AOS_WAIT_FOREVER表示永久等待；其他数值表示超时时间，单位ms                                                                                                                                                                                                                                                            |
| 出参     | actl_flags：如果返回成功，此参数表示该event的原始flag信息                                                                                                                                                                                                                                                                                                 |

#### 3.6.2.4、aos_event_set

>   定义描述：

| 函数原型 | int aos_event_set(aos_event_t \*event, unsigned int flags, unsigned char opt)                                                                  |
|----------|------------------------------------------------------------------------------------------------------------------------------------------------|
| 描述     | 设置一个事件的flags标志；成功会释放阻塞任务                                                                                                    |
| 返回值   | 类型：int 返回成功或失败; 如果设置事件的新flags标志后，会唤醒等待该标志事件的阻塞任务                                                          |
| 入参     | event：event事件描述结构体指针；                                                                                                               |
|          | Flags：设置的事件值                                                                                                                            |
|          | Opt：事件获取策略； RHINO_AND 0x02u：AND策略，event中的flags与入参flags取与操作； RHINO_OR：0x00u: OR策略，event中的flags与入参flags取或操作； |

3.7 AOS Work API
----------------

### 3.7.1 整体API对比

| Aos接口              | FreeRTOS | 说明                                       |
|----------------------|----------|--------------------------------------------|
| aos_workqueue_create | 无       | 创建一个工作队列                           |
| aos_work_init        |          | 初始化一个work                             |
| aos_work_destroy     |          | 删除一个work                               |
| aos_work_run         |          | 运行一个work，使其在某worqueue内调度执行   |
| aos_work_sched       |          | 运行一个work，使其在默认工作队列内调度执行 |
| aos_work_cancel      |          | 取消一个work                               |

### 3.7.2 具体接口详述

整体受宏RHINO_CONFIG_WORKQUEUE开关控制

#### 3.7.2.1、aos_workqueue_create

>   定义描述：

| 函数原型 | Int aos_workqueue_create(aos_workqueue_t \*workqueue, int pri, int stack_size) |
|----------|--------------------------------------------------------------------------------|
| 描述     | 创建一个工作队列，内部会创建一个任务关联workqueue                              |
| 返回值   | 类型：int 返回成功或失败;                                                      |
| 入参     | workqueue：工作队列描述结构体指针；需要用户定义一个workqueue结构体             |
|          | pri: 工作队列优先级，实际是关联任务优先级                                      |
|          | stack_size：栈大小，单位：byte字节                                             |

#### 3.7.2.2、aos_work_init

>   定义描述：

| 函数原型 | int aos_work_init(aos_work_t \*work, void (\*fn)(void \*), void \*arg, int dly) |
|----------|---------------------------------------------------------------------------------|
| 描述     | 初始化一个work，暂不执行                                                        |
| 返回值   | 类型：int 返回成功或失败;                                                       |
| 入参     | work：work工作描述结构体指针；需要用户定义一个work结构体                        |
|          | fn: work回调处理函数                                                            |
|          | Arg：work回调处理参数                                                           |
|          | Dly：延迟处理时间，单位ms，0表示不延迟                                          |

#### 3.7.2.3、aos_work_destroy

>   定义描述：

| 函数原型 | void aos_work_destroy(aos_work_t \*work) |
|----------|------------------------------------------|
| 描述     | 删除一个work                             |
| 返回值   | 无                                       |
| 入参     | work：work工作描述结构体指针；           |

#### 3.7.2.4、aos_work_run

>   定义描述：

| 函数原型 | int aos_work_run(aos_workqueue_t \*workqueue, aos_work_t \*work) |
|----------|------------------------------------------------------------------|
| 描述     | 运行一个work，使其在某worqueue内调度执行                         |
| 返回值   | 类型：int 返回成功或失败;                                        |
| 入参     | workqueue：工作队列描述结构体指针；                              |
|          | work：需要执行的工作描述结构体指针；                             |

#### 3.7.2.5、aos_work_sched

>   定义描述：

| 函数原型 | int aos_work_sched(aos_work_t \*work)                         |
|----------|---------------------------------------------------------------|
| 描述     | 运行一个work，使其在默认工作队列g_workqueue_default内调度执行 |
| 返回值   | 类型：int 返回成功或失败;                                     |
| 入参     | work：需要执行的工作描述结构体指针；                          |

#### 3.7.2.6、aos_work_cancel

>   定义描述：

| 函数原型 | int aos_work_cancel(aos_work_t \*work)   |
|----------|------------------------------------------|
| 描述     | 取消一个work，使其从所在的工作队列中删除 |
| 返回值   | 类型：int 返回成功或失败;                |
| 入参     | work：需要取消的工作描述结构体指针；     |

3.8 AOS Mem API
---------------

### 3.8.1 整体API对比

| Aos接口         | FreeRTOS              | 说明                                                                               |
|-----------------|-----------------------|------------------------------------------------------------------------------------|
| Rhino层内部调用 | vPortInitialiseBlocks | AliOS Things堆的配置见“2.2.6.3 内核使用堆的配置”章节； 内部使用k_mm_init完成初始化 |
| aos_zalloc      | pvPortMalloc          | 内存申请                                                                           |
| aos_malloc      |                       |                                                                                    |
| aos_realloc     |                       |                                                                                    |
| aos_free        | vPortFree             | 内存释放                                                                           |
| aos_alloc_trace | 无                    | 设置某块内存的owner                                                                |

### 3.8.2 具体接口详述

整体受宏RHINO_CONFIG_MM_TLF开关控制

#### 3.8.2.1、aos_zalloc

>   定义描述：

| 函数原型 | void \*aos_zalloc(unsigned int size)    |
|----------|-----------------------------------------|
| 描述     | 申请内存并清0                           |
| 返回值   | 类型：void \* 返回申请到的内存起始指针; |
| 入参     | size：申请内存大小，单位：byte字节      |

#### 3.8.2.2、aos_malloc

>   定义描述：

| 函数原型 | void \*aos_malloc(unsigned int size)    |
|----------|-----------------------------------------|
| 描述     | 申请内存，需要申请者清0                 |
| 返回值   | 类型：void \* 返回申请到的内存起始指针; |
| 入参     | size：申请内存大小，单位：byte字节      |

#### 3.8.2.3、aos_realloc

>   定义描述：

| 函数原型 | void \*aos_realloc(void \*mem, unsigned int size)                                                                                                                                                                                                                                                                          |
|----------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 描述     | 重置一块内存区域大小                                                                                                                                                                                                                                                                                                       |
| 返回值   | 类型：void \* 返回申请到的内存起始指针;                                                                                                                                                                                                                                                                                    |
| 入参     | Mem：需要重置的内存指针，如果是NULL，则同aos_malloc                                                                                                                                                                                                                                                                        |
|          | size：重置内存大小，单位：byte字节 如果mem不为空： 如果size \<原内存大小，将mem多余内存放入空闲区，返回mem； 如果size\>原内存大小，原内存区域尾部有空闲可用内存，则直接使用，此时返回值等于入参mem；如果当前内存块尾部区域不够，则重新申请size大小的内存，并将原始数据拷贝新区域，并释放原始内存块，此时返回值是块新地址。 |

#### 3.8.2.4、aos_alloc_trace

>   定义描述：

| 函数原型 | void aos_alloc_trace(void \*addr, size_t allocator) |
|----------|-----------------------------------------------------|
| 描述     | 设置某块内存的owner                                 |
| 返回值   | 无                                                  |
| 入参     | addr：需要设置的内存块                              |
|          | allocator：表示某owner值                            |

#### 3.8.2.5、aos_free

>   定义描述：

| 函数原型 | void aos_free(void \*mem) |
|----------|---------------------------|
| 描述     | 释放某块内存              |
| 返回值   | 无                        |
| 入参     | mem：需要释放的内存块     |

3.9 其他系统相关接口
--------------------

### 3.9.1 整体API对比

| Aos接口         | FreeRTOS            | 说明                   |
|-----------------|---------------------|------------------------|
| aos_reboot      | 无                  | 重启单板               |
| aos_get_hz      | configTICK_RATE_HZ  | 返回系统每秒tick频率   |
| aos_version_get | 无                  | 返回内核版本号         |
| aos_now         | 无                  | 返回内核启动至今的ns数 |
| aos_now_ms      | 无                  | 返回内核启动至今的ms数 |
| aos_init        | vTaskStartScheduler | 内核相关模块初始化     |
| aos_start       |                     | 内核启动进入任务调度   |

### 3.9.2 具体接口详述

#### 3.9.2.1 aos_reboot

>   定义描述：

| 函数原型 | void aos_reboot(void) |
|----------|-----------------------|
| 描述     | 重启单板              |

#### 3.9.2.2 aos_get_hz

>   定义描述：

| 函数原型 | int aos_get_hz(void) |
|----------|----------------------|
| 描述     | 返回系统每秒tick频率 |
| 返回值   | 类型：int            |

#### 3.9.2.3 aos_version_get

>   定义描述：

| 函数原型 | char \*aos_version_get(void)    |
|----------|---------------------------------|
| 描述     | 返回内核版本号                  |
| 返回值   | 类型：char \*;例如：AOS-R-1.3.0 |

#### 3.9.2.4 aos_now

>   定义描述：

| 函数原型 | long long aos_now(void) |
|----------|-------------------------|
| 描述     | 返回内核启动至今的ns数  |
| 返回值   | 类型：long long;        |

#### 3.9.2.5 aos_now_ms

>   定义描述：

| 函数原型 | long long aos_now_ms(void) |
|----------|----------------------------|
| 描述     | 返回内核启动至今的ms数     |
| 返回值   | 类型：long long;           |

#### 3.9.2.6 aos_init

>   定义描述：

| 函数原型 | void aos_init(void) |
|----------|---------------------|
| 描述     | 内核相关模块初始化  |
| 返回值   | 无                  |

#### 3.9.2.7 aos_start

>   定义描述：

| 函数原型 | void aos_start(void) |
|----------|----------------------|
| 描述     | 内核启动进入任务调度 |
| 返回值   | 无                   |

四、内核API对比参考
===================

4.1、Task API
-------------

### 4.1.1 整体API对比

| FreeRTOS                                                                                                           | Rhino                                        | 说明                                                                                                  |
|--------------------------------------------------------------------------------------------------------------------|----------------------------------------------|-------------------------------------------------------------------------------------------------------|
| xTaskCreate                                                                                                        | krhino_task_dyn_create                       | 动态创建任务                                                                                          |
| xTaskCreateStatic                                                                                                  | krhino_task_create                           | 静态创建任务                                                                                          |
| vTaskDelete                                                                                                        | krhino_task_del                              | 删除任务                                                                                              |
| vTaskDelay                                                                                                         | krhino_task_sleep                            | 任务睡眠多少ticks                                                                                     |
| vTaskDelayUntil                                                                                                    | krhino_task_sleep 组合实现                   | 任务睡眠到将来某一个tick。                                                                            |
| uxTaskPriorityGet                                                                                                  | 直接读任务结构体的优先级变量                 | 得到任务的优先级                                                                                      |
| vTaskPrioritySet                                                                                                   | krhino_task_pri_change                       | 设置任务的优先级                                                                                      |
| vTaskSuspend                                                                                                       | krhino_task_suspend                          | 停止某个任务                                                                                          |
| vTaskResume                                                                                                        | krhino_task_resume                           | 恢复某个任务                                                                                          |
| xTaskResumeFromISR                                                                                                 | krhino_task_resume                           | 从中断中恢复某个任务                                                                                  |
| xTaskAbortDelay                                                                                                    | krhino_task_wait_abort                       | 中止一个正在睡眠的任务                                                                                |
| vTaskSetThreadLocalStoragePointer                                                                                  | krhino_task_info_set                         | 设置任务的私有属性                                                                                    |
| pvTaskGetThreadLocalStoragePointer                                                                                 | krhino_task_info_get                         | 得到任务的私有属性                                                                                    |
| uxTaskGetSystemState                                                                                               | 直接读系统状态变量                           | 得到系统状态                                                                                          |
| vTaskGetInfo                                                                                                       | 直接读任务的结构体信息内容                   | 得到task结构体信息                                                                                    |
| xTaskGetApplicationTaskTag                                                                                         |                                              |                                                                                                       |
| xTaskGetCurrentTaskHandle                                                                                          | krhino_cur_task_get                          | 得到当前任务的hanlde                                                                                  |
| xTaskGetHandle                                                                                                     | 直接读对应任务的结构体地址                   | 得到指定任务的hanlde                                                                                  |
| xTaskGetIdleTaskHandle                                                                                             | 直接读空闲任务的结构体地址                   | 得到空闲任务的地址                                                                                    |
| uxTaskGetStackHighWaterMark                                                                                        | krhino_task_stack_free_get                   | 得到当前任务的栈使用                                                                                  |
| eTaskGetState                                                                                                      | 直接读任务的结构体获得任务状态               | 得到任务的状态值                                                                                      |
| pcTaskGetName                                                                                                      | 直接读任务结构体得到名字                     | 得到任务名字                                                                                          |
| xTaskGetTickCount                                                                                                  | krhino_sys_tick_get                          | 得到任务的当前tick值                                                                                  |
| xTaskGetTickCountFromISR                                                                                           | krhino_sys_tick_get                          | 中断中得到任务的当前tick值                                                                            |
| vTaskList                                                                                                          | 使用task头部的list                           | 使用task头部的list，debug中使用                                                                       |
| vTaskStartTrace                                                                                                    | 设计不同                                     | 开始trace功能                                                                                         |
| ulTaskEndTrace                                                                                                     | 设计不同                                     | 结束trace功能                                                                                         |
| xTaskCallApplicationTaskHook                                                                                       | 通过task hook函数对等实现                    | 调用任务相关的hook函数                                                                                |
| vTaskSetApplicationTaskTag                                                                                         | 通过task hook设置函数对等实现                | 设置任务相关的hook函数                                                                                |
| vTaskSetTimeOutState                                                                                               | krhino_task_sleep可实现，但是此api设计不合理 | 异步设置任务进入超时等待状态                                                                          |
| xTaskCheckForTimeOut                                                                                               | 直接读任务内部状态，此api设计不合理          | 得到任务的超时状态                                                                                    |
| xTaskGetSchedulerState                                                                                             | 直接读系统变量                               | 得到当前系统的运行状态                                                                                |
| uxTaskGetNumberOfTasks                                                                                             | 可以通过任务链表统计得出                     | 得到创建的任务数量                                                                                    |
| vTaskGetRunTimeStats                                                                                               | krhino_sys_time_get                          | 得到系统运行到现在的时间                                                                              |
| taskYIELD                                                                                                          | krhino_task_yield                            | Task做yield动作仅针对同等优先级的任务有效                                                             |
| taskENTER*\_*CRITICAL                                                                                              | RHINO_CRITICAL_ENTER                         | 进入临界区                                                                                            |
| taskEXIT*\_CRITICAL*                                                                                               | RHINO_CRITICAL_EXIT                          | 出临界区                                                                                              |
| [taskENTER_CRITICAL_FROM_ISR](http://www.freertos.org/taskENTER_CRITICAL_FROM_ISR_taskEXIT_CRITICAL_FROM_ISR.html) | RHINO_CRITICAL_ENTER                         | 中断中进入临界区                                                                                      |
| taskEXIT_CRITICAL_FROM_ISR                                                                                         | RHINO_CRITICAL_EXIT                          | 中断中出临界区                                                                                        |
| taskDISABLE_INTERRUPTS                                                                                             | RHINO_CRITICAL_ENTER                         | 关中断                                                                                                |
| taskENABLE_INTERRUPTS                                                                                              | RHINO_CRITICAL_EXIT                          | 开中断                                                                                                |
| vTaskStartScheduler                                                                                                | krhino_start                                 | 启动系统                                                                                              |
| vTaskEndScheduler                                                                                                  | 此api没有使用场景。                          | 结束正在运行的系统。此功能同硬件和驱动相关，Rhion设计将此功能放到HAL中。                              |
| vTaskStepTick                                                                                                      | tick_list_update                             | 调整内部tick                                                                                          |
| vTaskSuspendAll                                                                                                    | krhino_task_suspend                          | 系统关抢占                                                                                            |
| xTaskResumeAll                                                                                                     | krhino_task_resume                           | 系统从抢占中恢复                                                                                      |
| xTaskNotifyGive                                                                                                    | 可以使用信号量API组合实现                    | 利用信号量设计可以代替此功能。                                                                        |
| xTaskCreateRestricted                                                                                              | MPU设计不同                                  | 针对MPU使用。MPU相关，FreeRTOS独有设计API，其他RTOS没有。Rhino的MPU设计采用静态保护的方式，设计不同。 |
| vTaskAllocateMPURegions                                                                                            | MPU设计不同                                  |                                                                                                       |
| vPortSwitchToUserMode                                                                                              | MPU设计不同                                  | 切换到用户模式。Freertos相关                                                                          |
| xTaskNotifyGive                                                                                                    | krhino_sem_give达到相同目的                  | 通知任务运行                                                                                          |
| vTaskNotifyGiveFromISR                                                                                             | krhino_sem_give达到相同目的                  | 中断中通知任务运行                                                                                    |
| ulTaskNotifyTake                                                                                                   | krhino_sem_take达到相同目的                  | 中断中获取通知                                                                                        |
| xTaskNotify                                                                                                        | krhino_task_sem_give                         | 通知任务运行                                                                                          |
| xTaskNotifyAndQuery                                                                                                | krhino_task_sem_give组合达到                 | 通知任务运行并查询                                                                                    |
| xTaskNotifyAndQueryFromISR                                                                                         | krhino_task_sem_give组合达到                 | 中断中通知任务运行并查询                                                                              |
| xTaskNotifyFromISR                                                                                                 | krhino_task_sem_give达到目的                 | 中断中通知任务运行                                                                                    |
| xTaskNotifyWait                                                                                                    | krhino_task_sem_take                         | 中断中停止任务                                                                                        |
| xTaskNotifyStateClear                                                                                              | krhino_task_sem_take组合达到                 | 中断中通知任务并清空状态                                                                              |
| 没有                                                                                                               | krhino_task_time_slice_set                   | 设置当前任务的时间片                                                                                  |
| 没有                                                                                                               | krhino_sched_policy_set                      | 设置指定任务的调度方式                                                                                |
| 没有                                                                                                               | krhino_sched_policy_get                      | 得到指定任务的调度方式                                                                                |
| 没有                                                                                                               | krhino_global_space_get                      | 得到系统的RAM使用。                                                                                   |

### 4.1.2 具体接口详述

#### 4.1.2.1 xTaskCreate

FreeRTOS接口：

| BaseType_t xTaskCreate( TaskFunction_t pxTaskCode, const char \* const pcName, const configSTACK_DEPTH_TYPE usStackDepth, void \* const pvParameters, UBaseType_t uxPriority, TaskHandle_t \* const pxCreatedTask ) |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_task_dyn_create(ktask_t \*\*task, const name_t \*name, void \*arg, uint8_t pri, tick_t ticks, size_t stack, task_entry_t entry, uint8_t autorun) |
|----------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 描述     | 动态创建一个任务                                                                                                                                                |
| 返回值   | 类型：kstat_t 返回成功或失败;                                                                                                                                   |
| 入参     | Name = pcName                                                                                                                                                   |
|          | Arg = pvParameters                                                                                                                                              |
|          | Pri = uxPriority： FreeRTOS优先级范围从最低优先级0 到最高优先级(configMAX_PRIORITIES - 1)； krhino任务优先级从最高优先级0到最低优先级(RHINO_CONFIG_PRI_MAX - 1) |
|          | Ticks = 0                                                                                                                                                       |
|          | Stack = usStackDepth                                                                                                                                            |
|          | entry = pxTaskCode                                                                                                                                              |
|          | Autorun = 1                                                                                                                                                     |
| 出参     | Task = pxCreatedTask;本质一样，注意类型定义匹配                                                                                                                 |

#### 4.1.2.2 xTaskCreateStatic

FreeRTOS接口：

| TaskHandle_t xTaskCreateStatic( TaskFunction_t pxTaskCode, const char \* const pcName, const uint32_t ulStackDepth, void \* const pvParameters, UBaseType_t uxPriority, StackType_t \* const puxStackBuffer, StaticTask_t \* const pxTaskBuffer ) |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_task_create(ktask_t \*task, const name_t \*name, void \*arg, uint8_t prio, tick_t ticks, cpu_stack_t \*stack_buf, size_t stack_size, task_entry_t entry, uint8_t autorun) |
|----------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 描述     | 静态创建一个任务                                                                                                                                                                         |
| 返回值   | 类型：kstat_t 返回成功或失败;                                                                                                                                                            |
| 入参     | Task = pxTaskBuffer                                                                                                                                                                      |
|          | Name = pcName                                                                                                                                                                            |
|          | Arg = pvParameters                                                                                                                                                                       |
|          | Pri = uxPriority： FreeRTOS优先级范围从最低优先级0 到最高优先级(configMAX_PRIORITIES - 1)； krhino任务优先级从最高优先级0到最低优先级(RHINO_CONFIG_PRI_MAX - 1)                          |
|          | Ticks = 0                                                                                                                                                                                |
|          | stack_buf = puxStackBuffer                                                                                                                                                               |
|          | stack_size = ulStackDepth                                                                                                                                                                |
|          | entry = pxTaskCode                                                                                                                                                                       |
|          | Autorun = 1                                                                                                                                                                              |

#### 4.1.2.3 vTaskDelete

FreeRTOS接口：

| void vTaskDelete( TaskHandle_t xTaskToDelete ) |
|------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_task_del(ktask_t \*task) |
|----------|-----------------------------------------|
| 描述     | 删除一个任务                            |
| 返回值   | 类型：kstat_t 返回成功或失败;           |
| 入参     | Task = xTaskToDelete                    |

#### 4.1.2.4 vTaskDelay

FreeRTOS接口：

| void vTaskDelay( const TickType_t xTicksToDelay ) |
|---------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_task_sleep(tick_t ticks) |
|----------|-----------------------------------------|
| 入参     | Ticks = xTicksToDelay                   |

#### 4.1.2.5 vTaskDelayUntil

FreeRTOS接口：

| void vTaskDelayUntil( TickType_t \* const pxPreviousWakeTime, const TickType_t xTimeIncrement ) |
|-------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | 该FreeRTOS接口将所有任务阻塞某个时间，并且在时间到达后，将相关阻塞的任务，以及被阻塞执行的tick处理，重新计算进行补偿操作。 Krhino无此使用场景； 如果用户一定需要使用该接口，可以按照下面步骤修改： |
|----------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


-   rhino的关闭所有任务调度：krhino_sched_disable

-   获取当前的tick数g_tick_count

-   krhino_task_sleep可睡眠当前任务

-   krhino_task_resume可唤醒某个任务

-   krhino_sched_disable后，tick会继续触发，并且还是会不停更新任务状态，只是不发生调度切换，因此不需要额外执行阻塞后的任务补偿，在tick中断中自动处理。

#### 4.1.2.6 uxTaskPriorityGet

FreeRTOS接口：

| UBaseType_t uxTaskPriorityGet( TaskHandle_t xTask ) |
|-----------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | 直接读任务结构体的优先级变量 task-\>prio |
|----------|------------------------------------------|


#### 4.1.2.7 vTaskPrioritySet

FreeRTOS接口：

| void vTaskPrioritySet( TaskHandle_t xTask, UBaseType_t uxNewPriority ) |
|------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_task_pri_change(ktask_t \*task, uint8_t pri, uint8_t \*old_pri)                                                                                     |
|----------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 入参     | Task = xTask                                                                                                                                                       |
|          | Pri = uxNewPriority： FreeRTOS优先级范围从最低优先级0 到最高优先级(configMAX_PRIORITIES - 1)； krhino任务优先级从最高优先级0到最低优先级(RHINO_CONFIG_PRI_MAX - 1) |
| 出参     | old_pri：返回老优先级                                                                                                                                              |

#### 4.1.2.8 vTaskSuspend

FreeRTOS接口：

| void vTaskSuspend( TaskHandle_t xTaskToSuspend ) |
|--------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_task_suspend(ktask_t \*task) |
|----------|---------------------------------------------|
| 入参     | Task = xTaskToSuspend                       |

#### 4.1.2.9 vTaskResume

FreeRTOS接口：

| void vTaskResume( TaskHandle_t xTaskToResume ) |
|------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_task_resume(ktask_t \*task) |
|----------|--------------------------------------------|
| 入参     | Task = xTaskToResume                       |

#### 4.1.2.10 xTaskResumeFromISR

FreeRTOS接口：

| BaseType_t xTaskResumeFromISR( TaskHandle_t xTaskToResume ) |
|-------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_task_resume(ktask_t \*task) |
|----------|--------------------------------------------|
| 入参     | Task = xTaskToResume                       |

#### 4.1.2.11 xTaskAbortDelay

FreeRTOS接口：

| BaseType_t xTaskAbortDelay( TaskHandle_t xTask ) |
|--------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_task_wait_abort(ktask_t \*task) |
|----------|------------------------------------------------|
| 入参     | Task = xTaskToResume                           |

#### 4.1.2.12 vTaskSetThreadLocalStoragePointer

FreeRTOS接口：

| void vTaskSetThreadLocalStoragePointer( TaskHandle_t xTaskToSet, BaseType_t xIndex, void \*pvValue ) |
|------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_task_info_set(ktask_t \*task, size_t idx, void \*info) |
|----------|-----------------------------------------------------------------------|
| 入参     | Task = xTaskToSet                                                     |
|          | idx = xIndex ：\< RHINO_CONFIG_TASK_INFO_NUM                          |
|          | Info = pvValue                                                        |

#### 4.1.2.13 pvTaskGetThreadLocalStoragePointer

FreeRTOS接口：

| void \*pvTaskGetThreadLocalStoragePointer( TaskHandle_t xTaskToQuery, BaseType_t xIndex ) |
|-------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_task_info_get(ktask_t \*task, size_t idx, void \*\*info) |
|----------|-------------------------------------------------------------------------|
| 入参     | Task = xTaskToQuery                                                     |
|          | Idx = xIndex                                                            |
| 出参     | Info 表示返回内存地址，同pvTaskGetThreadLocalStoragePointer返回值       |

#### 4.1.2.14 uxTaskGetSystemState

FreeRTOS接口：

| UBaseType_t uxTaskGetSystemState( TaskStatus_t \* const pxTaskStatusArray, const UBaseType_t uxArraySize, uint32_t \* const pulTotalRunTime ) |
|-----------------------------------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | 该接口获取所有任务的状态，Krhino没有直接对应接口，代码流程中无此场景； 作为维测，krhino可以通过下面接口打印出所有任务的相关状态： dumpsys_task_func(NULL, 0, 1); |
|----------|------------------------------------------------------------------------------------------------------------------------------------------------------------------|


#### 4.1.2.15 vTaskGetInfo

FreeRTOS接口：

| void vTaskGetInfo( TaskHandle_t xTask, TaskStatus_t \*pxTaskStatus, BaseType_t xGetFreeStackSpace, eTaskState eState ) |
|------------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | 直接读任务的结构体信息内容 任务状态：Task-\>task_state 获取任务未使用空闲栈：krhino_task_stack_min_free |
|----------|---------------------------------------------------------------------------------------------------------|


#### 4.1.2.16 xTaskGetApplicationTaskTag

FreeRTOS接口：

| TaskHookFunction_t xTaskGetApplicationTaskTag( TaskHandle_t xTask ) |
|---------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | 无 |
|----------|----|


#### 4.1.2.17 xTaskGetCurrentTaskHandle

FreeRTOS接口：

| TaskHandle_t xTaskGetCurrentTaskHandle( void ) |
|------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | ktask_t \*krhino_cur_task_get(void) |
|----------|-------------------------------------|
| 出参     | 当前任务句柄                        |

#### 4.1.2.18 xTaskGetHandle

FreeRTOS接口：

| TaskHandle_t xTaskGetHandle( const char \*pcNameToQuery ) |
|-----------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | 功能上不需要，因为任务创建时的句柄地址由用户指定，或者将句柄返回给用户。 如果一定需要此功能，建议实现： 遍历g_kobj_list-\> task_head中的任务列表，返回匹配pcNameToQuery的任务句柄 |
|----------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


#### 4.1.2.19 xTaskGetIdleTaskHandle

FreeRTOS接口：

| TaskHandle_t xTaskGetIdleTaskHandle( void ) |
|---------------------------------------------|


Rhino接口替换说明：

| 函数原型 | 返回& g_idle_task[cpu_cur_get()] |
|----------|----------------------------------|


#### 4.1.2.20 uxTaskGetStackHighWaterMark

FreeRTOS接口：

| UBaseType_t uxTaskGetStackHighWaterMark( TaskHandle_t xTask ) |
|---------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_task_stack_min_free (ktask_t \*task, size_t \*free) |
|----------|--------------------------------------------------------------------|
| 入参     | Task = xTask                                                       |
| 出参     | \* free = uxTaskGetStackHighWaterMark返回值                        |

#### 4.1.2.21 eTaskGetState

FreeRTOS接口：

| eTaskState eTaskGetState( TaskHandle_t xTask ) |
|------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | 直接读任务的结构体获得任务状态 任务状态：Task-\>task_state |
|----------|------------------------------------------------------------|


#### 4.1.2.22 pcTaskGetName

FreeRTOS接口：

| char \*pcTaskGetName( TaskHandle_t xTaskToQuery ) |
|---------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | 直接读任务结构体得到名字 任务名字：Task-\> task_name |
|----------|------------------------------------------------------|


#### 4.1.2.23 xTaskGetTickCount

FreeRTOS接口：

| TickType_t xTaskGetTickCount( void ) |
|--------------------------------------|


Rhino接口替换说明：

| 函数原型 | sys_time_t krhino_sys_tick_get(void) |
|----------|--------------------------------------|


#### 4.1.2.24 xTaskGetTickCountFromISR

FreeRTOS接口：

| TickType_t xTaskGetTickCountFromISR( void ) |
|---------------------------------------------|


Rhino接口替换说明：

| 函数原型 | sys_time_t krhino_sys_tick_get(void) |
|----------|--------------------------------------|


#### 4.1.2.25 vTaskList

FreeRTOS接口：

| void vTaskList( char \* pcWriteBuffer ) |
|-----------------------------------------|


Rhino接口替换说明：

| 函数原型 | 无直接对应接口，rhino无使用场景 该接口实际格式化uxTaskGetSystemState获取的所有任务状态信息； 作为维测，krhino可以通过下面接口打印出所有任务的相关状态： dumpsys_task_func(NULL, 0, 1); |
|----------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


#### 4.1.2.26 xTaskCallApplicationTaskHook

FreeRTOS接口：

| BaseType_t xTaskCallApplicationTaskHook( TaskHandle_t xTask, void \*pvParameter ) |
|-----------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | 设计不同；可通过hook_impl.c内的task任务相关的钩子实现； 如idle任务每次运行的钩子krhino_idle_hook |
|----------|--------------------------------------------------------------------------------------------------|


#### 4.1.2.27 vTaskSetApplicationTaskTag

FreeRTOS接口：

| void vTaskSetApplicationTaskTag( TaskHandle_t xTask, TaskHookFunction_t pxHookFunction ) |
|------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | 设计不同，rhino设计不支持变换任务相关钩子，在编译时而不是运行时修改 |
|----------|---------------------------------------------------------------------|


#### 4.1.2.28 vTaskSetTimeOutState

FreeRTOS接口：

| void vTaskSetTimeOutState( TimeOut_t \* const pxTimeOut ) |
|-----------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | 属于获取内部超时和tick计数，内部使用，rhino无使用场景 |
|----------|-------------------------------------------------------|


#### 4.1.2.29 xTaskCheckForTimeOut

FreeRTOS接口：

| BaseType_t xTaskCheckForTimeOut( TimeOut_t \* const pxTimeOut, TickType_t \* const pxTicksToWait ) |
|----------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | 判断内部超时，属于内部实现，rhino无使用场景 |
|----------|---------------------------------------------|


#### 4.1.2.30 xTaskGetSchedulerState

FreeRTOS接口：

| BaseType_t xTaskGetSchedulerState( void ) |
|-------------------------------------------|


Rhino接口替换说明：

| 函数原型 | 直接获取g_sys_stat状态，取值为kstat_t |
|----------|---------------------------------------|


#### 4.1.2.31 uxTaskGetNumberOfTasks

FreeRTOS接口：

| UBaseType_t uxTaskGetNumberOfTasks( void ) |
|--------------------------------------------|


Rhino接口替换说明：

| 函数原型 | 获取当前所有的任务总数，rhino无使用场景； 如果一定要使用，可以通过g_kobj_list存放的任务遍历获取 |
|----------|-------------------------------------------------------------------------------------------------|


#### 4.1.2.32 vTaskGetRunTimeStats

FreeRTOS接口：

| void vTaskGetRunTimeStats( char \*pcWriteBuffer ) |
|---------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | 无直接对应接口，rhino无使用场景 该接口实际格式化uxTaskGetSystemState获取的所有任务状态信息； 作为维测，krhino可以通过下面接口打印出所有任务的相关状态： dumpsys_task_func(NULL, 0, 1); |
|----------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


#### 4.1.2.33 taskYIELD

FreeRTOS接口：

| \#define taskYIELD() portYIELD() |
|----------------------------------|


Rhino接口替换说明：

| 函数原型 | krhino_task_yield接口，该动作仅针对同等优先级的任务有效。 FreeRTOS的实现实际是使用类似void cpu_task_switch(void)来发生一次主动切换。 |
|----------|--------------------------------------------------------------------------------------------------------------------------------------|


#### 4.1.2.34 taskENTER*\_*CRITICAL

FreeRTOS接口：

| \#define taskENTER_CRITICAL() portENTER_CRITICAL() |
|----------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | RHINO_CRITICAL_ENTER 实际为关中断 |
|----------|-----------------------------------|


#### 4.1.2.35 taskEXIT*\_CRITICAL*

FreeRTOS接口：

| \#define taskEXIT_CRITICAL() portEXIT_CRITICAL() |
|--------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | RHINO_CRITICAL_EXIT 实际为开中断 |
|----------|----------------------------------|


#### 4.1.2.36 [taskENTER_CRITICAL_FROM_ISR](http://www.freertos.org/taskENTER_CRITICAL_FROM_ISR_taskEXIT_CRITICAL_FROM_ISR.html)

FreeRTOS接口：

| \#define taskENTER_CRITICAL_FROM_ISR() portSET_INTERRUPT_MASK_FROM_ISR() |
|--------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | RHINO_CRITICAL_ENTER 实际为关中断 |
|----------|-----------------------------------|


#### 4.1.2.37 taskEXIT_CRITICAL_FROM_ISR

FreeRTOS接口：

| \#define taskEXIT_CRITICAL_FROM_ISR( x ) portCLEAR_INTERRUPT_MASK_FROM_ISR( x ) |
|---------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | RHINO_CRITICAL_EXIT 实际为开中断 |
|----------|----------------------------------|


#### 4.1.2.38 taskDISABLE_INTERRUPTS

FreeRTOS接口：

| \#define taskDISABLE_INTERRUPTS() portDISABLE_INTERRUPTS() |
|------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | RHINO_CRITICAL_ENTER 实际为关中断 |
|----------|-----------------------------------|


#### 4.1.2.39 taskENABLE_INTERRUPTS

FreeRTOS接口：

| \#define taskENABLE_INTERRUPTS() portENABLE_INTERRUPTS() |
|----------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | RHINO_CRITICAL_EXIT 实际为开中断 |
|----------|----------------------------------|


#### 4.1.2.40 vTaskStartScheduler

FreeRTOS接口：

| void vTaskStartScheduler( void ) |
|----------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_start(void)        |
|----------|-----------------------------------|
| 注意     | krhino_start前需要调用krhino_init |

#### 4.1.2.41 vTaskEndScheduler

FreeRTOS接口：

| void vTaskEndScheduler( void ) |
|--------------------------------|


Rhino接口替换说明：

| 函数原型 | 没有使用场景 |
|----------|--------------|


#### 4.1.2.42 vTaskStepTick

FreeRTOS接口：

| void vTaskStepTick( const TickType_t xTicksToJump ) |
|-----------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | void tick_list_update(tick_i_t ticks) 统一在tick中断中调用krhino_tick_proc时，间接调用该接口 Tick中断来一次计数一次，并且处理超时任务，并进行任务时间片调度 |
|----------|-------------------------------------------------------------------------------------------------------------------------------------------------------------|


#### 4.1.2.43 vTaskSuspendAll

FreeRTOS接口：

| void vTaskSuspendAll( void ) |
|------------------------------|


Rhino接口替换说明：

| 函数原型 | Krhino可以通过krhino_sched_disable来阻塞所有任务调度； 通过krhino_task_suspend阻塞单个任务调度 |
|----------|------------------------------------------------------------------------------------------------|


#### 4.1.2.44 xTaskResumeAll

FreeRTOS接口：

| BaseType_t xTaskResumeAll( void ) |
|-----------------------------------|


Rhino接口替换说明：

| 函数原型 | Krhino可以通过krhino_sched_enable来使能调度，关调度期间，任务相关的状态变化都在tick中处理完，调度使能后会立即进行新的调度 |
|----------|---------------------------------------------------------------------------------------------------------------------------|


#### 4.1.2.45 xTaskCreateRestricted

FreeRTOS接口：

| BaseType_t xTaskCreateRestricted( const TaskParameters_t \* const pxTaskDefinition, TaskHandle_t \*pxCreatedTask ) |
|--------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | 无对应接口，krhino相关接口未绑定MPU |
|----------|-------------------------------------|


#### 4.1.2.46 vTaskAllocateMPURegions

FreeRTOS接口：

| void vTaskAllocateMPURegions( TaskHandle_t xTaskToModify, const MemoryRegion_t \* const xRegions ) |
|----------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | 无对应接口，krhino相关接口未绑定MPU |
|----------|-------------------------------------|


#### 4.1.2.47 vPortSwitchToUserMode

FreeRTOS接口：

| void vPortSwitchToUserMode( void ) |
|------------------------------------|


Rhino接口替换说明：

| 函数原型 | 非通用接口，FreeRTOS仅用来指明ARM M系列是MSP还是PSP，krhino无接口区分，M系列任务统一使用PSP |
|----------|---------------------------------------------------------------------------------------------|


#### 4.1.2.48 xTaskNotifyGive

FreeRTOS接口：

| \#define xTaskNotifyGive( xTaskToNotify ) xTaskGenericNotify( ( xTaskToNotify ), ( 0 ), eIncrement, NULL ) BaseType_t xTaskGenericNotify( TaskHandle_t xTaskToNotify, uint32_t ulValue, eNotifyAction eAction, uint32_t \*pulPreviousNotificationValue ) |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_sem_give(ksem_t \*sem) Notify功能整体通过k_sem.c替换，其实质都是等待一个value赋值即获取一个事件值。 注意ulTaskNotifyTake相应也要修改成： kstat_t krhino_sem_take(ksem_t \*sem, tick_t ticks) |
|----------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


#### 4.1.2.49 vTaskNotifyGiveFromISR

FreeRTOS接口：

| Void vTaskNotifyGiveFromISR(TaskHandle_t xTaskToNotify, BaseType_t \*pxHigherPriorityTaskWoken ) |
|--------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | 同上，直接使用kstat_t krhino_sem_give(ksem_t \*sem) 该接口只会修改任务相关的状态，其在中断内调用core_sched会直接return；在中断退出时，通过krhino_intrpt_exit接口cpu_intrpt_switch再发起调度。 |
|----------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


#### 4.1.2.50 ulTaskNotifyTake

FreeRTOS接口：

| uint32_t ulTaskNotifyTake( BaseType_t xClearCountOnExit, TickType_t xTicksToWait ) |
|------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_sem_take(ksem_t \*sem, tick_t ticks) xClearCountOnExit表示take后，计数清0还是减1，krhino不使用该参数； |
|----------|-----------------------------------------------------------------------------------------------------------------------|
| 入参     | Sem：自定义并使用krhino_sem_create创建一个sem                                                                         |
|          | Ticks = xTicksToWait                                                                                                  |

#### 4.1.2.51 xTaskNotify

FreeRTOS接口：

| \#define xTaskNotify( xTaskToNotify, ulValue, eAction ) xTaskGenericNotify( ( xTaskToNotify ), ( ulValue ), ( eAction ), NULL ) BaseType_t xTaskGenericNotify( TaskHandle_t xTaskToNotify, uint32_t ulValue, eNotifyAction eAction, uint32_t \*pulPreviousNotificationValue ) |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_task_sem_give(ktask_t \*task) 其实类似krhino_sem_give，只是该信号量与该任务结构体关联，需要通过krhino_task_sem_create初始化； 参数ulValue, eAction用来设定Notify对象值的变化，该参数krhino无使用场景。如果用户一定要使用类似该value值的设定，可以使用event API,见第六章节。 |
|----------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


#### 4.1.2.52 xTaskNotifyAndQuery

FreeRTOS接口：

| \#define xTaskNotifyAndQuery( xTaskToNotify, ulValue, eAction, pulPreviousNotifyValue ) xTaskGenericNotify( ( xTaskToNotify ), ( ulValue ), ( eAction ), ( pulPreviousNotifyValue ) ) BaseType_t xTaskGenericNotify( TaskHandle_t xTaskToNotify, uint32_t ulValue, eNotifyAction eAction, uint32_t \*pulPreviousNotificationValue ) |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_task_sem_give(ktask_t \*task) 同上面接口，参数ulValue, eAction，用来设定Notify对象值的变化，pulPreviousNotifyValue用来返回old value，该参数krhino无使用场景。如果用户一定要使用类似该value值的设定，可以使用event API,见第六章节。 |
|----------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


#### 4.1.2.53 xTaskNotifyAndQueryFromISR

FreeRTOS接口：

| \#define xTaskNotifyAndQueryFromISR(xTaskToNotify, ulValue, eAction, pulPreviousNotificationValue, pxHigherPriorityTaskWoken) xTaskGenericNotifyFromISR( (xTaskToNotify), (ulValue), (eAction), ( pulPreviousNotificationValue ), ( pxHigherPriorityTaskWoken ) ) BaseType_t xTaskGenericNotifyFromISR( TaskHandle_t xTaskToNotify, uint32_t ulValue, eNotifyAction eAction, uint32_t \*pulPreviousNotificationValue, BaseType_t \*pxHigherPriorityTaskWoken ) |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_task_sem_give(ktask_t \*task) 同上面接口，参数ulValue, eAction，用来设定Notify对象值的变化，pulPreviousNotifyValue用来返回old value，pxHigherPriorityTaskWoken用来返回是否发生任务切换，该参数krhino无使用场景。 |
|----------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


#### 4.1.2.54 xTaskNotifyFromISR

FreeRTOS接口：

| \#define xTaskNotifyFromISR( xTaskToNotify, ulValue, eAction, pxHigherPriorityTaskWoken ) xTaskGenericNotifyFromISR( ( xTaskToNotify ), ( ulValue ), ( eAction ), NULL, ( pxHigherPriorityTaskWoken ) ) |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_task_sem_give(ktask_t \*task) 同上面接口，参数ulValue, eAction，用来设定Notify对象值的变化， pxHigherPriorityTaskWoken用来返回是否发生任务切换，该参数krhino无使用场景。 |
|----------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


#### 4.1.2.55 xTaskNotifyWait

FreeRTOS接口：

| BaseType_t xTaskNotifyWait( uint32_t ulBitsToClearOnEntry, uint32_t ulBitsToClearOnExit, uint32_t \*pulNotificationValue, TickType_t xTicksToWait ) |
|-----------------------------------------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_task_sem_take(tick_t ticks) 参数ulBitsToClearOnEntry\\ ulBitsToClearOnExit表示入口和退出前对notify value值的操作；pulNotificationValue返回获取到的value值；该参数krhino无使用场景。如果用户一定要使用类似该value值的设定，可以使用event API,见第六章节。 |
|----------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


#### 4.1.2.56 xTaskNotifyStateClear

FreeRTOS接口：

| BaseType_t xTaskNotifyStateClear( TaskHandle_t xTask ) |
|--------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_task_sem_del(ktask_t \*task) |
|----------|---------------------------------------------|
| 入参     | Task = xTask                                |

4.2、Buf Queue API
------------------

### 4.2.1 整体API对比

Buf Queue 内部包含了一个FIFO缓冲区，每一次发送数据包到Buf
Queue都会把整包数据发送到FIFO内部，取数据包的时候再从内部FIFO缓冲区copy数据出来，优点是使用方便，缺点是发送和接收数据包，涉及到两次copy数据，效率是问题。

| FreeRTOS                                                                             | Rhino                                                           | 说明                                         |
|--------------------------------------------------------------------------------------|-----------------------------------------------------------------|----------------------------------------------|
| [xQueueCreate](http://www.freertos.org/a00116.html)                                  | krhino_buf_queue_dyn_create                                     | 动态创建queue                                |
| xQueueCreateStatic                                                                   | krhino_buf_queue_create                                         | 静态创建queue                                |
| vQueueDelete                                                                         | krhino_buf_queue_del                                            | 删除queue                                    |
| xQueueSend                                                                           | krhino_buf_queue_send                                           | 发送元素到queue                              |
| xQueueSendFromISR                                                                    | krhino_buf_queue_send                                           | 从中断发送元素到queue                        |
| xQueueSendToBack                                                                     | krhino_buf_queue_send                                           | 发送元素到queue尾部                          |
| xQueueSendToBackFromISR                                                              | krhino_buf_queue_send                                           | 从中断发送元素到queue尾部                    |
| xQueueSendToFront                                                                    | 此api设计不合理                                                 | 发送元素到queue头部                          |
| [xQueueSendToFrontFromISR](http://www.freertos.org/xQueueSendToFrontFromISR.html)    | 此api设计不合理                                                 | 从中断中发送元素到queue头部                  |
| [xQueueReceive](http://www.freertos.org/a00118.html)                                 | krhino_buf_queue_recv                                           | 从queue接收一个消息                          |
| [xQueueReceiveFromISR](http://www.freertos.org/a00120.html)                          | krhino_buf_queue_recv                                           | 从中断中queue接收一个消息                    |
| [uxQueueMessagesWaiting](http://www.freertos.org/a00018.html#ucQueueMessagesWaiting) | krhino_buf_queue_info_get                                       | 获得queue中已经有的消息的数目                |
| uxQueueSpacesAvailable                                                               | krhino_buf_queue_info_get                                       | 获得queue中剩余空间                          |
| xQueueReset                                                                          | krhino_buf_queue_flush                                          | 重置queue                                    |
| xQueueOverwrite                                                                      | krhino_buf_queue_send,此api设计有问题 queue内元素不应该被覆盖。 | 发送元素到queue尾部，queue满的话覆盖。       |
| xQueueOverwriteFromISR                                                               | krhino_buf_queue_send，此api设计有问题 queue内元素不应该被覆盖  | 中断中发送元素到queue尾部，queue满的话覆盖。 |
| xQueuePeek                                                                           | 业务不需要                                                      | 收取消息但是内容不从queue内取走。            |
| xQueuePeekFromISR                                                                    | 业务不需要                                                      | 中断中收取消息但是内容不从queue内取走        |
| [vQueueAddToRegistry](http://www.freertos.org/vQueueAddToRegistry.html)              | 可通过内核对象链表头打印出所有的Queue                           | 注册Queue，仅为调试使用                      |
| vQueueUnregisterQueue                                                                | 可通过内核对象链表头打印出所有的Queue                           | 不注册queue。 仅为调试使用                   |
| pcQueueGetName                                                                       | 直接读buf_queue结构体获得                                       | 获得queue名字                                |
| xQueueIsQueueFullFromISR                                                             | krhino_buf_queue_info_get                                       | 判断queue是否满了                            |
| xQueueIsQueueEmptyFromISR                                                            | krhino_buf_queue_info_get                                       | 判断queue是否空了                            |
| [xQueueCreateSet](http://www.freertos.org/xQueueCreateSet.html)                      | 业务不需要                                                      | 实现任务阻塞在多内核对象上。                 |
| xQueueRemoveFromSet                                                                  | 业务不需要                                                      | 实现任务阻塞在多内核对象上                   |
| xQueueSelectFromSet                                                                  | 业务不需要                                                      | 实现任务阻塞在多内核对象上                   |
| xQueueSelectFromSetFromISR                                                           | 业务不需要                                                      | 实现任务阻塞在多内核对象上                   |

### 4.2.2 具体接口详述

#### 4.2.2.1 [xQueueCreate](http://www.freertos.org/a00116.html)

FreeRTOS接口：

| \#define xQueueCreate( uxQueueLength, uxItemSize ) xQueueGenericCreate( ( uxQueueLength ), ( uxItemSize ), ( queueQUEUE_TYPE_BASE ) ) QueueHandle_t xQueueGenericCreate( const UBaseType_t uxQueueLength, const UBaseType_t uxItemSize, const uint8_t ucQueueType ) |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_buf_queue_dyn_create(kbuf_queue_t \*\*queue, const name_t \*name, size_t size, size_t max_msg) |
|----------|---------------------------------------------------------------------------------------------------------------|
| 返回值   | 成功或失败                                                                                                    |
| 入参     | Name：作为维测使用，可自定义名字，重复不报错                                                                  |
|          | Size = uxQueueLength \* uxItemSize：表示缓冲区的总长度                                                        |
|          | max_msg = uxItemSize：表示每一块的数据大小                                                                    |
| 出参     | Queue：存放获取的kbuf_queue_t句柄                                                                             |

#### 4.2.2.2 xQueueCreateStatic

FreeRTOS接口：

| \#define xQueueCreateStatic( uxQueueLength, uxItemSize, pucQueueStorage, pxQueueBuffer ) xQueueGenericCreateStatic( ( uxQueueLength ), ( uxItemSize ), ( pucQueueStorage ), ( pxQueueBuffer ), ( queueQUEUE_TYPE_BASE ) ) QueueHandle_t xQueueGenericCreateStatic( const UBaseType_t uxQueueLength, const UBaseType_t uxItemSize, uint8_t \*pucQueueStorage, StaticQueue_t \*pxStaticQueue, const uint8_t ucQueueType ) |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_buf_queue_create(kbuf_queue_t \*queue, const name_t \*name, void \*buf, size_t size, size_t max_msg) |
|----------|---------------------------------------------------------------------------------------------------------------------|
| 返回值   | 成功或失败                                                                                                          |
| 入参     | Queue = pxQueueBuffer：用户自定义一个kbuf_queue_t结构体                                                             |
|          | Name：作为维测使用，可自定义名字，重复不报错                                                                        |
|          | Buf = pucQueueStorage ： 缓冲区的起始地址                                                                           |
|          | Size = uxQueueLength \* uxItemSize：表示缓冲区的总长度                                                              |
|          | max_msg = uxItemSize：表示每一块的数据大小                                                                          |

#### 4.2.2.3 vQueueDelete

FreeRTOS接口：

| void vQueueDelete( QueueHandle_t xQueue ) |
|-------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_buf_queue_del(kbuf_queue_t \*queue) |
|----------|----------------------------------------------------|
| 返回值   | 成功或失败                                         |
| 入参     | Queue = xQueue：queue句柄                          |

#### 4.2.2.4 xQueueSend

FreeRTOS接口：

| \#define xQueueSend( xQueue, pvItemToQueue, xTicksToWait ) xQueueGenericSend( ( xQueue ), ( pvItemToQueue ), ( xTicksToWait ), queueSEND_TO_BACK ) BaseType_t xQueueGenericSend( QueueHandle_t xQueue, const void \* const pvItemToQueue, TickType_t xTicksToWait, const BaseType_t xCopyPosition ) |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_buf_queue_send(kbuf_queue_t \*queue, void \*msg, size_t size)                                                                        |
|----------|-----------------------------------------------------------------------------------------------------------------------------------------------------|
| 返回值   | 成功或失败                                                                                                                                          |
| 入参     | Queue = xQueue：queue句柄                                                                                                                           |
|          | Msg = pvItemToQueue                                                                                                                                 |
|          | Size ：必须小于创建时的max_msg。此设定是支持用户传入比max_msg小的任意长度内容，而不一定固定为max_msg。                                              |
| 其他     | xTicksToWait ：FreeRTOS此设定是在buf满的情况下，将调用send_buf的任务暂时挂起一段时间；AliOS Things不使用此设置，buf满即返回错误RHINO_BUF_QUEUE_FULL |

#### 4.2.2.5 xQueueSendFromISR

FreeRTOS接口：

| \#define xQueueSendFromISR( xQueue, pvItemToQueue, pxHigherPriorityTaskWoken ) xQueueGenericSendFromISR( ( xQueue ), ( pvItemToQueue ), ( pxHigherPriorityTaskWoken ), queueSEND_TO_BACK ) BaseType_t xQueueGenericSendFromISR( QueueHandle_t xQueue, const void \* const pvItemToQueue, BaseType_t \* const pxHigherPriorityTaskWoken, const BaseType_t xCopyPosition ) |
|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_buf_queue_send(kbuf_queue_t \*queue, void \*msg, size_t size)                                                     |
|----------|----------------------------------------------------------------------------------------------------------------------------------|
| 返回值   | 成功或失败                                                                                                                       |
| 入参     | Queue = xQueue：queue句柄                                                                                                        |
|          | Msg = pvItemToQueue                                                                                                              |
|          | Size ：必须小于创建时的max_msg。此设定是支持用户传入比max_msg小的内容，而不一定固定为max_msg                                     |
| 其他     | AliOS Things该接口不需要区分是不是在中断中执行； pxHigherPriorityTaskWoken表示FreeRTOS是否有高优先级任务唤醒，krhino不需要关注。 |

#### 4.2.2.6 xQueueSendToBack

FreeRTOS接口：

| \#define xQueueSendToBack( xQueue, pvItemToQueue, xTicksToWait ) xQueueGenericSend( ( xQueue ), ( pvItemToQueue ), ( xTicksToWait ), queueSEND_TO_BACK ) BaseType_t xQueueGenericSend( QueueHandle_t xQueue, const void \* const pvItemToQueue, TickType_t xTicksToWait, const BaseType_t xCopyPosition ) |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_buf_queue_send(kbuf_queue_t \*queue, void \*msg, size_t size)                                                                        |
|----------|-----------------------------------------------------------------------------------------------------------------------------------------------------|
| 返回值   | 成功或失败                                                                                                                                          |
| 入参     | Queue = xQueue：queue句柄                                                                                                                           |
|          | Msg = pvItemToQueue                                                                                                                                 |
|          | Size ：必须小于创建时的max_msg。此设定是支持用户传入比max_msg小的内容，而不一定固定为max_msg                                                        |
| 其他     | xTicksToWait ：FreeRTOS此设定是在buf满的情况下，将调用send_buf的任务暂时挂起一段时间；AliOS Things不使用此设置，buf满即返回错误RHINO_BUF_QUEUE_FULL |

#### 4.2.2.7 xQueueSendToBackFromISR

FreeRTOS接口：

| \#define xQueueSendToBackFromISR( xQueue, pvItemToQueue, pxHigherPriorityTaskWoken ) xQueueGenericSendFromISR( ( xQueue ), ( pvItemToQueue ), ( pxHigherPriorityTaskWoken ), queueSEND_TO_BACK ) BaseType_t xQueueGenericSendFromISR( QueueHandle_t xQueue, const void \* const pvItemToQueue, BaseType_t \* const pxHigherPriorityTaskWoken, const BaseType_t xCopyPosition ) |
|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_buf_queue_send(kbuf_queue_t \*queue, void \*msg, size_t size)                                                    |
|----------|---------------------------------------------------------------------------------------------------------------------------------|
| 返回值   | 成功或失败                                                                                                                      |
| 入参     | Queue = xQueue：queue句柄                                                                                                       |
|          | Msg = pvItemToQueue                                                                                                             |
|          | Size ：必须小于创建时的max_msg。此设定是支持用户传入比max_msg小的内容，而不一定固定为max_msg                                    |
| 其他     | Rhino该接口不需要区分是不是在中断中执行； pxHigherPriorityTaskWoken表示FreeRTOS是否有高优先级任务唤醒，AliOS Things不需要关注。 |

#### 4.2.2.8 xQueueSendToFront

FreeRTOS接口：

| \#define xQueueSendToFront( xQueue, pvItemToQueue, xTicksToWait ) xQueueGenericSend( ( xQueue ), ( pvItemToQueue ), ( xTicksToWait ), queueSEND_TO_FRONT ) BaseType_t xQueueGenericSend( QueueHandle_t xQueue, const void \* const pvItemToQueue, TickType_t xTicksToWait, const BaseType_t xCopyPosition ) |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | 此api设计不合理，AliOS Things不支持。 Rhino曾在老版本支持此配置，后来删除，认为在此buf_queue中不应存在后来的数据被先处理的场景。 |
|----------|----------------------------------------------------------------------------------------------------------------------------------|


#### 4.2.2.9 [xQueueSendToFrontFromISR](http://www.freertos.org/xQueueSendToFrontFromISR.html)

FreeRTOS接口：

| \#define xQueueSendToFrontFromISR( xQueue, pvItemToQueue, pxHigherPriorityTaskWoken ) xQueueGenericSendFromISR( ( xQueue ), ( pvItemToQueue ), ( pxHigherPriorityTaskWoken ), queueSEND_TO_FRONT ) BaseType_t xQueueGenericSendFromISR( QueueHandle_t xQueue, const void \* const pvItemToQueue, BaseType_t \* const pxHigherPriorityTaskWoken, const BaseType_t xCopyPosition ) |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | 此api设计不合理，AliOS Things不支持。 Rhino曾在老版本支持此配置，后来删除，认为在此buf_queue中不应存在后来的数据被先处理的场景。 |
|----------|----------------------------------------------------------------------------------------------------------------------------------|


#### 4.2.2.10 [xQueueReceive](http://www.freertos.org/a00118.html)

FreeRTOS接口：

| BaseType_t xQueueReceive( QueueHandle_t xQueue, void \* const pvBuffer, TickType_t xTicksToWait ) |
|---------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_buf_queue_recv(kbuf_queue_t \*queue, tick_t ticks, void \*msg, size_t \*size) |
|----------|----------------------------------------------------------------------------------------------|
| 返回值   | 成功或失败                                                                                   |
| 入参     | Queue = xQueue：注意数据类型匹配                                                             |
|          | Ticks = xTicksToWait                                                                         |
|          | Msg = pvBuffer                                                                               |
| 出参     | Size ：此设定是支持用户传入比max_msg小的任意长度内容，而不一定固定为max_msg。                |

#### 4.2.2.11 [xQueueReceiveFromISR](http://www.freertos.org/a00120.html)

FreeRTOS接口：

| BaseType_t xQueueReceiveFromISR( QueueHandle_t xQueue, void \* const pvBuffer, BaseType_t \* const pxHigherPriorityTaskWoken ) |
|--------------------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_buf_queue_recv(kbuf_queue_t \*queue, tick_t ticks, void \*msg, size_t \*size) |
|----------|----------------------------------------------------------------------------------------------|
| 返回值   | 成功或失败                                                                                   |
| 入参     | Queue = xQueue：注意数据类型匹配                                                             |
|          | Ticks = xTicksToWait                                                                         |
|          | Msg = pvBuffer                                                                               |
| 出参     | Size ：此设定是支持用户传入比max_msg小的任意长度内容，而不一定固定为max_msg。                |

#### 4.2.2.12 [uxQueueMessagesWaiting](http://www.freertos.org/a00018.html#ucQueueMessagesWaiting)

FreeRTOS接口：

| UBaseType_t uxQueueMessagesWaiting( const QueueHandle_t xQueue ) |
|------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_buf_queue_info_get(kbuf_queue_t \*queue, kbuf_queue_info_t \*info) |
|----------|-----------------------------------------------------------------------------------|
| 返回值   | 成功或失败                                                                        |
| 入参     | queue                                                                             |
| 出参     | Info ：返回包括当前cur_num等维测数据                                              |

#### 4.2.2.13 uxQueueSpacesAvailable

FreeRTOS接口：

| UBaseType_t uxQueueSpacesAvailable( const QueueHandle_t xQueue ) |
|------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_buf_queue_info_get(kbuf_queue_t \*queue, kbuf_queue_info_t \*info)                      |
|----------|--------------------------------------------------------------------------------------------------------|
| 返回值   | 成功或失败                                                                                             |
| 入参     | queue                                                                                                  |
| 出参     | Info ：返回包括当前free_buf_size等维测数据 注意此free_buf_size单位为byte；FreeRTOS返回的是多少空闲块。 |

#### 4.2.2.14 xQueueReset

FreeRTOS接口：

| \#define xQueueReset( xQueue ) xQueueGenericReset( xQueue, pdFALSE ) BaseType_t MPU_xQueueGenericReset( QueueHandle_t pxQueue, BaseType_t xNewQueue ) |
|-------------------------------------------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_buf_queue_flush(kbuf_queue_t \*queue) |
|----------|------------------------------------------------------|
| 入参     | Queue = xQueue                                       |

#### 4.2.2.15 xQueueOverwrite

FreeRTOS接口：

| \#define xQueueOverwrite( xQueue, pvItemToQueue ) xQueueGenericSend( ( xQueue ), ( pvItemToQueue ), 0, queueOVERWRITE ) BaseType_t xQueueGenericSend( QueueHandle_t xQueue, const void \* const pvItemToQueue, TickType_t xTicksToWait, const BaseType_t xCopyPosition ) |
|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | 此api设计有问题 queue内元素不应该被覆盖。 Rhino不支持内容覆盖 |
|----------|---------------------------------------------------------------|


#### 4.2.2.16 xQueueOverwriteFromISR

FreeRTOS接口：

| \#define xQueueOverwriteFromISR( xQueue, pvItemToQueue, pxHigherPriorityTaskWoken ) xQueueGenericSendFromISR( ( xQueue ), ( pvItemToQueue ), ( pxHigherPriorityTaskWoken ), queueOVERWRITE ) BaseType_t xQueueGenericSendFromISR( QueueHandle_t xQueue, const void \* const pvItemToQueue, BaseType_t \* const pxHigherPriorityTaskWoken, const BaseType_t xCopyPosition ) |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | 此api设计有问题 queue内元素不应该被覆盖。 Rhino不支持内容覆盖 |
|----------|---------------------------------------------------------------|


#### 4.2.2.17 xQueuePeek

FreeRTOS接口：

| BaseType_t xQueuePeek( QueueHandle_t xQueue, void \* const pvBuffer, TickType_t xTicksToWait ) |
|------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | 收取消息但是内容不从queue内取走。业务不需要。 |
|----------|-----------------------------------------------|


#### 4.2.2.18 xQueuePeekFromISR

FreeRTOS接口：

| BaseType_t xQueuePeekFromISR( QueueHandle_t xQueue, void \* const pvBuffer ) |
|------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | 收取消息但是内容不从queue内取走。业务不需要。 |
|----------|-----------------------------------------------|


#### 4.2.2.19 [vQueueAddToRegistry](http://www.freertos.org/vQueueAddToRegistry.html)

FreeRTOS接口：

| void vQueueAddToRegistry( QueueHandle_t xQueue, const char \*pcQueueName ) |
|----------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | 注册Queue，仅为调试使用。Krhino不需要此接口。 Rhino在创建queu时，如果打开RHINO_CONFIG_SYSTEM_STATS开关，则会自动加入到g_kobj_list.buf_queue_head维测队列里面。 |
|----------|----------------------------------------------------------------------------------------------------------------------------------------------------------------|


#### 4.2.2.20 vQueueUnregisterQueue

FreeRTOS接口：

| void vQueueUnregisterQueue( QueueHandle_t xQueue ) |
|----------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | 去注册Queue，仅为调试使用。Krhino不需要此接口。 Rhino在删除queu时，如果打开RHINO_CONFIG_SYSTEM_STATS开关，则会自动删除g_kobj_list.buf_queue_head维测队列里该数据。 |
|----------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------|


#### 4.2.2.21 pcQueueGetName

FreeRTOS接口：

| const char \*pcQueueGetName( QueueHandle_t xQueue ) |
|-----------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | 直接访问返回queue-\>blk_obj.name |
|----------|----------------------------------|


#### 4.2.2.22 xQueueIsQueueFullFromISR

FreeRTOS接口：

| BaseType_t xQueueIsQueueFullFromISR( const QueueHandle_t xQueue ) |
|-------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_buf_queue_info_get(kbuf_queue_t \*queue, kbuf_queue_info_t \*info) |
|----------|-----------------------------------------------------------------------------------|
| 入参     | Queue = xQueue                                                                    |
| 出参     | Info-\> free_buf_size表示剩余内存大小                                             |

#### 4.2.2.23 xQueueIsQueueEmptyFromISR

FreeRTOS接口：

| BaseType_t xQueueIsQueueEmptyFromISR( const QueueHandle_t xQueue ) |
|--------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_buf_queue_info_get(kbuf_queue_t \*queue, kbuf_queue_info_t \*info) |
|----------|-----------------------------------------------------------------------------------|
| 入参     | Queue = xQueue                                                                    |
| 出参     | Info-\> free_buf_size表示剩余内存大小                                             |

#### 4.2.2.24 [xQueueCreateSet](http://www.freertos.org/xQueueCreateSet.html)

FreeRTOS接口：

| QueueSetHandle_t xQueueCreateSet( const UBaseType_t uxEventQueueLength ) |
|--------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | 带Set结尾的queue表示一个集合，多个sem或者queue可以加入该集合，并向其发送数据；krhino无此使用场景，不支持。 |
|----------|------------------------------------------------------------------------------------------------------------|


#### 4.2.2.25 xQueueRemoveFromSet

FreeRTOS接口：

| BaseType_t xQueueRemoveFromSet( QueueSetMemberHandle_t xQueueOrSemaphore, QueueSetHandle_t xQueueSet ) |
|--------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | 带Set结尾的queue表示一个集合，多个sem或者queue可以加入该集合，并向其发送数据；krhino无此使用场景，不支持。 |
|----------|------------------------------------------------------------------------------------------------------------|


#### 4.2.2.26 xQueueSelectFromSet

FreeRTOS接口：

| QueueSetMemberHandle_t xQueueSelectFromSet( QueueSetHandle_t xQueueSet, TickType_t const xTicksToWait ) |
|---------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | 带Set结尾的queue表示一个集合，多个sem或者queue可以加入该集合，并向其发送数据；krhino无此使用场景，不支持。 |
|----------|------------------------------------------------------------------------------------------------------------|


#### 4.2.2.27 xQueueSelectFromSetFromISR

FreeRTOS接口：

| QueueSetMemberHandle_t xQueueSelectFromSetFromISR( QueueSetHandle_t xQueueSet ) |
|---------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | 带Set结尾的queue表示一个集合，多个sem或者queue可以加入该集合，并向其发送数据；krhino无此使用场景，不支持。 |
|----------|------------------------------------------------------------------------------------------------------------|


4.3、Queue API
--------------

### 4.3.1 整体API对比

Queue内部也有一个FIFO缓冲区,
每一次发送数据包到Queue只会把数据包的地址发送进去，也就是发送一个指针进去，取数据的时候也是只接收一个指针，效率会很快。Queue的设计解决了效率问题，但是使用上Queue稍微没有Buf
Queue方便。

| FreeRTOS                | Rhino                   | 说明                        |
|-------------------------|-------------------------|-----------------------------|
| 没有传递指针的Queue实现 | krhino_queue_dyn_create | 动态创建queue               |
|                         | krhino_queue_create     | 静态创建queue               |
|                         | krhino_queue_del        | 删除queue                   |
|                         | krhino_queue_dyn_del    | 动态删除queue               |
|                         | krhino_queue_back_send  | 发送元素到queue尾部         |
|                         | krhino_queue_all_send   | 把阻塞在queue上所有任务唤醒 |
|                         | krhino_queue_is_full    | Queue是否已满               |
|                         | krhino_queue_recv       | 从queue接收一个消息         |
|                         | krhino_queue_info_get   | 获得队列信息                |
|                         | krhino_queue_flush      | 重置queue                   |

### 4.3.2 具体接口详述

由于FreeRTOS无该功能，此模块不在此赘述。

4.4、Semaphore & Mutex API
--------------------------

### 4.4.1 整体API对比

| FreeRTOS                                                                                  | Rhino                   | 说明                                                                           |
|-------------------------------------------------------------------------------------------|-------------------------|--------------------------------------------------------------------------------|
| [xSemaphoreCreateBinary](http://www.freertos.org/xSemaphoreCreateBinary.html)             | 可用event替代。         | 创建动态两进制信号量                                                           |
| [xSemaphoreCreateBinaryStatic](http://www.freertos.org/xSemaphoreCreateBinaryStatic.html) | 可用event替代。         | 创建静态两进制信号量                                                           |
| xSemaphoreCreateCounting                                                                  | krhino_sem_dyn_create   | 动态创建信号量                                                                 |
| xSemaphoreCreateCountingStatic                                                            | krhino_sem_create       | 静态创建信号量                                                                 |
| xSemaphoreCreateMutex                                                                     | krhino_mutex_dyn_create | 动态创建mutex                                                                  |
| xSemaphoreCreateMutexStatic                                                               | krhino_mutex_create     | 静态创建mutex                                                                  |
| xSemCreateRecursiveMutex                                                                  | krhino_mutex_dyn_create | 动态创建可嵌套mutex                                                            |
| xSemCreateRecursiveMutexStatic                                                            | krhino_mutex_create     | 静态动态创建可嵌套mutex                                                        |
| vSemaphoreDelete                                                                          | krhino_sem_del          | 删除信号量                                                                     |
| xSemaphoreGetMutexHolder                                                                  | 直接读mutex结构体       | 获得mutex锁的占有任务                                                          |
| uxSemaphoreGetCount                                                                       | krhino_sem_count_get    | 获得内部信号量的count                                                          |
| xSemaphoreTake                                                                            | krhino_sem_take         | 信号量获得                                                                     |
| xSemaphoreTakeRecursive                                                                   | krhino_sem_take         |                                                                                |
| xSemaphoreTakeFromISR                                                                     | 此api设计不合理         | 中断中获得信号量。其它RTOS没有此设计。FreeRTOS的设计在中断中获得信号量值得商榷 |
| xSemaphoreGive                                                                            | krhino_sem_give         | 给还信号量                                                                     |
| xSemaphoreGiveRecursive                                                                   | krhino_mutex_unlock     | 可嵌套释放mutex锁                                                              |
| xSemaphoreGiveFromISR                                                                     | krhino_sem_give         | 中断中给还信号量                                                               |

### 4.4.2 具体接口详述

#### 4.4.2.1 [xSemaphoreCreateBinary](http://www.freertos.org/xSemaphoreCreateBinary.html)

FreeRTOS接口：

| \#define xSemaphoreCreateBinary() xQueueGenericCreate( ( UBaseType_t ) 1, semSEMAPHORE_QUEUE_ITEM_LENGTH, queueQUEUE_TYPE_BINARY_SEMAPHORE ) QueueHandle_t xQueueGenericCreate( const UBaseType_t uxQueueLength, const UBaseType_t uxItemSize, const uint8_t ucQueueType ) |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_event_dyn_create(kevent_t \*\*event, const name_t \*name, uint32_t flags)                                                                                                                                                                                                                                                                                                                                                                                                                      |
|----------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 返回值   | 成功或失败                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| 入参     | Name：用户指定一名字，维测使用                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
|          | flags = 0：初值是0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| 出参     | event：返回句柄                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| 说明     | 1、Krhino提供的k_sem模块计数初始可以设置任意值；k_mutex模块虽然也是只能0或者1，但是其内部实现了优先级反转功能；因此匹配FreeRTOS的二进制sem的接口，需要使用k_event来替代。 2、后续获取该event使用接口： kstat_t krhino_event_get(kevent_t \*event, uint32_t flags, uint8_t opt, uint32_t \*actl_flags, tick_t ticks)； 其中直接设置flags = 1，opt = RHINO_AND_CLEAR； 3、后续设置该event使用接口： kstat_t krhino_event_set(kevent_t \*event, uint32_t flags, uint8_t opt) 其中设置flags = 1，opt = RHINO_OR。 |

#### 4.4.2.2 [xSemaphoreCreateBinaryStatic](http://www.freertos.org/xSemaphoreCreateBinaryStatic.html)

FreeRTOS接口：

| \#define xSemaphoreCreateBinaryStatic( pxStaticSemaphore ) xQueueGenericCreateStatic( ( UBaseType_t ) 1, semSEMAPHORE_QUEUE_ITEM_LENGTH, NULL, pxStaticSemaphore, queueQUEUE_TYPE_BINARY_SEMAPHORE ) QueueHandle_t xQueueGenericCreateStatic( const UBaseType_t uxQueueLength, const UBaseType_t uxItemSize, uint8_t \*pucQueueStorage, StaticQueue_t \*pxStaticQueue, const uint8_t ucQueueType ) |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_event_create(kevent_t \*event, const name_t \*name, uint32_t flags)                                                                                                                                                                                                                                                                                                                                                                                                                            |
|----------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 返回值   | 成功或失败                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| 入参     | Event：用户自定义event结构体                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|          | Name：用户指定一名字，维测使用                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
|          | flags = 0：初值是0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| 说明     | 1、Krhino提供的k_sem模块计数初始可以设置任意值；k_mutex模块虽然也是只能0或者1，但是其内部实现了优先级反转功能；因此匹配FreeRTOS的二进制sem的接口，需要使用k_event来替代。 2、后续获取该event使用接口： kstat_t krhino_event_get(kevent_t \*event, uint32_t flags, uint8_t opt, uint32_t \*actl_flags, tick_t ticks)； 其中直接设置flags = 1，opt = RHINO_AND_CLEAR； 3、后续设置该event使用接口： kstat_t krhino_event_set(kevent_t \*event, uint32_t flags, uint8_t opt) 其中设置flags = 1，opt = RHINO_OR。 |

#### 4.4.2.3 xSemaphoreCreateCounting

FreeRTOS接口：

| \#define xSemaphoreCreateCounting( uxMaxCount, uxInitialCount ) xQueueCreateCountingSemaphore( ( uxMaxCount ), ( uxInitialCount ) ) QueueHandle_t xQueueCreateCountingSemaphore( const UBaseType_t uxMaxCount, const UBaseType_t uxInitialCount ) |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_sem_dyn_create(ksem_t \*\*sem, const name_t \*name, sem_count_t count) |
|----------|---------------------------------------------------------------------------------------|
| 返回值   | 成功或失败                                                                            |
| 入参     | Name：用户指定一名字，维测使用                                                        |
|          | Count = uxInitialCount                                                                |
| 出参     | Sem：存放返回的sem句柄                                                                |
| 说明：   | FreeRTOS该接口uxMaxCount参数不需要，krhino默认上限为-1                                |

#### 4.4.2.4 xSemaphoreCreateCountingStatic

FreeRTOS接口：

| \#define xSemaphoreCreateCountingStatic( uxMaxCount, uxInitialCount, pxSemaphoreBuffer ) xQueueCreateCountingSemaphoreStatic( ( uxMaxCount ), ( uxInitialCount ), ( pxSemaphoreBuffer ) ) QueueHandle_t xQueueCreateCountingSemaphoreStatic( const UBaseType_t uxMaxCount, const UBaseType_t uxInitialCount, StaticQueue_t \*pxStaticQueue ) |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_sem_create(ksem_t \*sem, const name_t \*name, sem_count_t count) |
|----------|---------------------------------------------------------------------------------|
| 返回值   | 成功或失败                                                                      |
| 入参     | Sem = pxSemaphoreBuffer：注意类型匹配，定义为ksem_t类型                         |
|          | Name：用户指定一名字，维测使用                                                  |
|          | Count = uxInitialCount                                                          |
| 说明：   | FreeRTOS该接口uxMaxCount参数不需要，krhino默认上限为-1                          |

#### 4.4.2.5 xSemaphoreCreateMutex

FreeRTOS接口：

| \#define xSemaphoreCreateMutex() xQueueCreateMutex( queueQUEUE_TYPE_MUTEX ) QueueHandle_t xQueueCreateMutex( const uint8_t ucQueueType ) |
|------------------------------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_mutex_dyn_create(kmutex_t \*\*mutex, const name_t \*name) |
|----------|--------------------------------------------------------------------------|
| 返回值   | 成功或失败                                                               |
| 入参     | Name：用户指定一名字，维测使用                                           |
| 出参     | Mutex：返回的句柄                                                        |

#### 4.4.2.6 xSemaphoreCreateMutexStatic

FreeRTOS接口：

| \#define xSemaphoreCreateMutexStatic( pxMutexBuffer ) xQueueCreateMutexStatic( queueQUEUE_TYPE_MUTEX, ( pxMutexBuffer ) ) QueueHandle_t xQueueCreateMutexStatic( const uint8_t ucQueueType, StaticQueue_t \*pxStaticQueue ) |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_mutex_create(kmutex_t \*mutex, const name_t \*name) |
|----------|--------------------------------------------------------------------|
| 返回值   | 成功或失败                                                         |
| 入参     | mutex = pxMutexBuffer：注意类型匹配，定义为ksem_t类型              |
|          | Name：用户指定一名字，维测使用                                     |

#### 4.4.2.7 xSemCreateRecursiveMutex

FreeRTOS接口：

| \#define xSemaphoreCreateRecursiveMutex() xQueueCreateMutex( queueQUEUE_TYPE_RECURSIVE_MUTEX ) QueueHandle_t xQueueCreateMutex( const uint8_t ucQueueType ) |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_mutex_dyn_create(kmutex_t \*\*mutex, const name_t \*name) |
|----------|--------------------------------------------------------------------------|
| 返回值   | 成功或失败                                                               |
| 入参     | Name：用户指定一名字，维测使用                                           |
| 出参     | Mutex：返回的句柄                                                        |

#### 4.4.2.8 xSemCreateRecursiveMutexStatic

FreeRTOS接口：

| \#define xSemaphoreCreateRecursiveMutexStatic( pxStaticSemaphore ) xQueueCreateMutexStatic( queueQUEUE_TYPE_RECURSIVE_MUTEX, pxStaticSemaphore ) QueueHandle_t xQueueCreateMutexStatic( const uint8_t ucQueueType, StaticQueue_t \*pxStaticQueue ) |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_mutex_create(kmutex_t \*mutex, const name_t \*name) |
|----------|--------------------------------------------------------------------|
| 返回值   | 成功或失败                                                         |
| 入参     | mutex = pxMutexBuffer：注意类型匹配，定义为ksem_t类型              |
|          | Name：用户指定一名字，维测使用                                     |

#### 4.4.2.9 vSemaphoreDelete

FreeRTOS接口：

| \#define vSemaphoreDelete( xSemaphore ) vQueueDelete( ( QueueHandle_t ) ( xSemaphore ) ) void vQueueDelete( QueueHandle_t xQueue ) |
|------------------------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | 此接口两个OS有两个区别： |
|----------|--------------------------|


1.  FreeRTOS在调用该删除接口时，需要人为确保没有任务被其阻塞，因为其内部只做了内存释放，没有对相关阻塞任务做处理；AliOS
    Things相关接口除了释放内存，还进行了阻塞任务的唤醒操作；

2.  由于此接口内有三种可能性：sem\\mutex\\event，因此AliOS
    Things分别对应不同的释放接口：

>   kstat_t krhino_sem_del(ksem_t \*sem)；

>   kstat_t krhino_mutex_del(kmutex_t \*mutex)；

>   kstat_t krhino_event_del(kevent_t \*event)

#### 4.4.2.10 xSemaphoreGetMutexHolder

FreeRTOS接口：

| \#define xSemaphoreGetMutexHolder( xSemaphore ) xQueueGetMutexHolder( ( xSemaphore ) ) |
|----------------------------------------------------------------------------------------|
| void\* xQueueGetMutexHolder( QueueHandle_t xSemaphore )                                |

Rhino接口替换说明：

| 函数原型 | 直接访问mutex结构体：mutex-\>mutex_task |
|----------|-----------------------------------------|


#### 4.4.2.11 uxSemaphoreGetCount

FreeRTOS接口：

| \#define uxSemaphoreGetCount( xSemaphore ) uxQueueMessagesWaiting( ( QueueHandle_t ) ( xSemaphore ) ) UBaseType_t uxQueueMessagesWaiting( const QueueHandle_t xQueue ) |
|------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_sem_count_get(ksem_t \*sem, sem_count_t \*count) |
|----------|-----------------------------------------------------------------|
| 返回值   | 成功或失败                                                      |
| 入参     | sem = xSemaphore                                                |
| 出参     | Count：返回当前sem值                                            |

#### 4.4.2.12 xSemaphoreTake

FreeRTOS接口：

| \#define xSemaphoreTake( xSemaphore, xBlockTime ) \\ xQueueSemaphoreTake( ( xSemaphore ), ( xBlockTime ) ) BaseType_t xQueueSemaphoreTake( QueueHandle_t xQueue, TickType_t xTicksToWait ) |
|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_sem_take(ksem_t \*sem, tick_t ticks) |
|----------|-----------------------------------------------------|
| 返回值   | 成功或失败                                          |
| 入参     | sem = xSemaphore                                    |
|          | Ticks = xBlockTime                                  |

#### 4.4.2.13 xSemaphoreTakeRecursive

FreeRTOS接口：

| \#define xSemaphoreTakeRecursive( xMutex, xBlockTime ) \\ xQueueTakeMutexRecursive( ( xMutex ), ( xBlockTime ) ) BaseType_t xQueueTakeMutexRecursive( QueueHandle_t xMutex, TickType_t xTicksToWait ) |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_sem_take(ksem_t \*sem, tick_t ticks) |
|----------|-----------------------------------------------------|
| 返回值   | 成功或失败                                          |
| 入参     | sem = xSemaphore                                    |
|          | Ticks = xBlockTime                                  |

#### 4.4.2.14 xSemaphoreTakeFromISR

FreeRTOS接口：

| \#define xSemaphoreTakeFromISR( xSemaphore, pxHigherPriorityTaskWoken ) \\ xQueueReceiveFromISR( ( QueueHandle_t ) ( xSemaphore ), NULL, ( pxHigherPriorityTaskWoken ) ) BaseType_t xQueueReceiveFromISR( QueueHandle_t xQueue, void \* const pvBuffer, BaseType_t \* const pxHigherPriorityTaskWoken ) |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | 此api设计不合理，中断中获得信号量。其它RTOS没有此设计。FreeRTOS的设计在中断中获得信号量值得商榷。 此接口在中断中帮助阻塞的任务take信号量，如果获取不到则报错，如果获取到，则帮助唤醒任务。 但是实际情况是，如果有信号量有值能够获取，那么在这个信号量值被设置的时候，对应的阻塞任务就已经被唤醒了； |
|----------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


#### 4.4.2.15 xSemaphoreGive

FreeRTOS接口：

| \#define xSemaphoreGive( xSemaphore ) \\ xQueueGenericSend( ( QueueHandle_t ) ( xSemaphore ), NULL, semGIVE_BLOCK_TIME, queueSEND_TO_BACK ) BaseType_t xQueueGenericSend( QueueHandle_t xQueue, const void \* const pvItemToQueue, TickType_t xTicksToWait, const BaseType_t xCopyPosition ) |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_sem_give(ksem_t \*sem) |
|----------|---------------------------------------|
| 返回值   | 成功或失败                            |
| 入参     | sem = xSemaphore：sem句柄             |

#### 4.4.2.16 xSemaphoreGiveRecursive

FreeRTOS接口：

| \#define xSemaphoreGiveRecursive( xMutex ) xQueueGiveMutexRecursive( ( xMutex ) ) BaseType_t xQueueGiveMutexRecursive( QueueHandle_t xMutex ) |
|-----------------------------------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_mutex_unlock(kmutex_t \*mutex) |
|----------|-----------------------------------------------|
| 返回值   | 成功或失败                                    |
| 入参     | mutex = xMutex：mutex句柄                     |

#### 4.4.2.17 xSemaphoreGiveFromISR

FreeRTOS接口：

| \#define xSemaphoreGiveFromISR( xSemaphore, pxHigherPriorityTaskWoken ) \\ xQueueGiveFromISR( ( QueueHandle_t ) ( xSemaphore ), ( pxHigherPriorityTaskWoken ) ) BaseType_t xQueueGiveFromISR( QueueHandle_t xQueue, BaseType_t \* const pxHigherPriorityTaskWoken ) |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_sem_give(ksem_t \*sem) |
|----------|---------------------------------------|
| 返回值   | 成功或失败                            |
| 入参     | sem = xSemaphore：sem句柄             |

4.5、Timer API
--------------

### 4.5.1 整体API对比

| FreeRTOS                                                                      | Rhino                              | 说明                                                   |
|-------------------------------------------------------------------------------|------------------------------------|--------------------------------------------------------|
| xTimerCreate                                                                  | krhino_timer_dyn_create            | 动态创建软件定时器                                     |
| xTimerCreateStatic                                                            | krhino_timer_create                | 静态创建软件定时器                                     |
| xTimerIsTimerActive                                                           | 直接读timer结构体                  | 探查timer是否是活的状态                                |
| xTimerStart                                                                   | krhino_timer_start                 | 软件定时器启动                                         |
| xTimerStop                                                                    | krhino_timer_stop                  | 软件定时器停止                                         |
| xTimerChangePeriod                                                            | krhino_timer_change                | 改变软件定时器的周期                                   |
| xTimerDelete                                                                  | krhino_timer_del                   | 删除软件定时器                                         |
| xTimerReset                                                                   | krhino_timer_stop krhino_timer_del | 重置软件定时器                                         |
| xTimerStartFromISR                                                            | krhino_timer_start                 | 软件定时器在中断中启动。FreeRTOS此设计值得商榷         |
| xTimerStopFromISR                                                             | krhino_timer_stop                  | 软件定时器在中断中停止 FreeRTOS此设计值得商榷          |
| xTimerChangePeriodFromISR                                                     | krhino_timer_change                | 软件定时器在中断中改变软件周期。FreeRTOS此设计值得商榷 |
| pcTimerGetName                                                                | 直接读timer结构体                  | 获得软件定时器名字                                     |
| xTimerResetFromISR                                                            | 设计不合理                         | 在中断中重置软件定时器 FreeRTOS此设计值得商榷          |
| pvTimerGetTimerID                                                             | 直接读timer结构体地址              | 获得软件定时器的id                                     |
| vTimerSetTimerID                                                              | timer结构体首地址就是唯一ID        | 设置软件定时器的id。                                   |
| xTimerGetPeriod                                                               | 直接读timer结构体内变量            | 获得软件定时器的周期                                   |
| xTimerGetExpiryTime                                                           | 直接读timer结构体内变量            | 获得软件定时器的超时时间                               |
| [xTimerPendFunctionCall](http://www.freertos.org/xTimerPendFunctionCall.html) | Rhino中的单次timer触发可替代此API  | 延迟一段时间给后台任务回调函数                         |
| xTimerPendFunctionCallFromISR                                                 | Rhino中的单次timer触发可替代此API  | 延迟一段时间给后台任务回调函数                         |

### 4.5.2 具体接口详述

#### 4.5.2.1 xTimerCreate

FreeRTOS接口：

| TimerHandle_t xTimerCreate( const char \* const pcTimerName, const TickType_t xTimerPeriodInTicks, const UBaseType_t uxAutoReload, void \* const pvTimerID, TimerCallbackFunction_t pxCallbackFunction ) |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_timer_dyn_create(ktimer_t \*\*timer, const name_t \*name, timer_cb_t cb, sys_time_t first, sys_time_t round, void \*arg, uint8_t auto_run)                                                     |
|----------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 返回值   | 成功或失败                                                                                                                                                                                                    |
| 入参     | Name = pcTimerName                                                                                                                                                                                            |
|          | Cb = pxCallbackFunction：注意类型匹配                                                                                                                                                                         |
|          | First = xTimerPeriodInTicks：固定周期                                                                                                                                                                         |
|          | Round = xTimerPeriodInTicks                                                                                                                                                                                   |
|          | Arg = pvTimerID：此参数稍微有差别： Krhino此参数作为定时器处理的第二个参数传入；FreeRTOS将其pvTimerID存放入time结构体内，其处理函数只有一个参数为timer句柄，如果需要参数，将其存放在pvTimerID内，取出后处理。 |
|          | auto_run = uxAutoReload                                                                                                                                                                                       |
| 出参     | Timer：返回句柄                                                                                                                                                                                               |

#### 4.5.2.2 xTimerCreateStatic

FreeRTOS接口：

| TimerHandle_t xTimerCreateStatic( const char \* const pcTimerName, const TickType_t xTimerPeriodInTicks, const UBaseType_t uxAutoReload, void \* const pvTimerID, TimerCallbackFunction_t pxCallbackFunction, StaticTimer_t \*pxTimerBuffer ) |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_timer_create(ktimer_t \*timer, const name_t \*name, timer_cb_t cb, sys_time_t first, sys_time_t round, void \*arg, uint8_t auto_run)                                                           |
|----------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 返回值   | 成功或失败                                                                                                                                                                                                    |
| 入参     | Timer = pxTimerBuffer：用户需要自定义ktimer_t结构体                                                                                                                                                           |
|          | Name = pcTimerName                                                                                                                                                                                            |
|          | Cb = pxCallbackFunction：注意类型匹配                                                                                                                                                                         |
|          | First = xTimerPeriodInTicks：固定周期                                                                                                                                                                         |
|          | Round = xTimerPeriodInTicks                                                                                                                                                                                   |
|          | Arg = pvTimerID：此参数稍微有差别： Krhino此参数作为定时器处理的第二个参数传入；FreeRTOS将其pvTimerID存放入time结构体内，其处理函数只有一个参数为timer句柄，如果需要参数，将其存放在pvTimerID内，取出后处理。 |
|          | auto_run = uxAutoReload                                                                                                                                                                                       |

#### 4.5.2.3 xTimerIsTimerActive

FreeRTOS接口：

| BaseType_t xTimerIsTimerActive( TimerHandle_t xTimer ) |
|--------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | 直接访问结构体timer-\>timer_state； 0表示非active;1表示active |
|----------|---------------------------------------------------------------|


#### 4.5.2.4 xTimerStart

FreeRTOS接口：

| \#define xTimerStart( xTimer, xTicksToWait ) \\ xTimerGenericCommand( (xTimer), tmrCOMMAND_START, ( xTaskGetTickCount() ), NULL, ( xTicksToWait ) ) |
|-----------------------------------------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_timer_start(ktimer_t \*timer)                                           |
|----------|----------------------------------------------------------------------------------------|
| 返回值   | 成功或失败                                                                             |
| 入参     | timer = xTimer krhino的定时器管理不带延时触发，如果发现处理命令buf满了，直接返回错误。 |

#### 4.5.2.5 xTimerStop

FreeRTOS接口：

| \#define xTimerStop( xTimer, xTicksToWait ) xTimerGenericCommand( ( xTimer ), tmrCOMMAND_STOP, 0U, NULL, ( xTicksToWait ) ) |
|-----------------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_timer_stop(ktimer_t \*timer)                                            |
|----------|----------------------------------------------------------------------------------------|
| 返回值   | 成功或失败                                                                             |
| 入参     | timer = xTimer krhino的定时器管理不带延时触发，如果发现处理命令buf满了，直接返回错误。 |

#### 4.5.2.6 xTimerChangePeriod

FreeRTOS接口：

| \#define xTimerChangePeriod( xTimer, xNewPeriod, xTicksToWait ) xTimerGenericCommand( ( xTimer ), tmrCOMMAND_CHANGE_PERIOD, ( xNewPeriod ), NULL, ( xTicksToWait ) ) |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_timer_change(ktimer_t \*timer, sys_time_t first, sys_time_t round) |
|----------|-----------------------------------------------------------------------------------|
| 返回值   | 成功或失败                                                                        |
| 入参     | timer = xTimer                                                                    |
|          | First = xNewPeriod                                                                |
|          | Round = xNewPeriod                                                                |
|          | krhino的定时器管理不带延时触发，如果发现处理命令buf满了，直接返回错误。           |

#### 4.5.2.7 xTimerDelete

FreeRTOS接口：

| \#define xTimerDelete( xTimer, xTicksToWait ) xTimerGenericCommand( ( xTimer ), tmrCOMMAND_DELETE, 0U, NULL, ( xTicksToWait ) ) |
|---------------------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_timer_del(ktimer_t \*timer)                              |
|----------|-------------------------------------------------------------------------|
| 返回值   | 成功或失败                                                              |
| 入参     | timer = xTimer                                                          |
| 说明     | krhino的定时器管理不带延时触发，如果发现处理命令buf满了，直接返回错误。 |

#### 4.5.2.8 xTimerReset

FreeRTOS接口：

| \#define xTimerReset( xTimer, xTicksToWait ) xTimerGenericCommand( ( xTimer ), tmrCOMMAND_RESET, ( xTaskGetTickCount() ), NULL, ( xTicksToWait ) ) |
|----------------------------------------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | Krhino不支持直接的重启定时器操作； 如果需要，可以使用stop + start组合操作 |
|----------|---------------------------------------------------------------------------|


#### 4.5.2.9 xTimerStartFromISR

FreeRTOS接口：

| \#define xTimerStartFromISR( xTimer, pxHigherPriorityTaskWoken ) \\ xTimerGenericCommand( ( xTimer ), tmrCOMMAND_START_FROM_ISR, \\ ( xTaskGetTickCountFromISR() ), ( pxHigherPriorityTaskWoken ), 0U ) |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_timer_start(ktimer_t \*timer)                                                                                                                    |
|----------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------|
| 返回值   | 成功或失败                                                                                                                                                      |
| 入参     | timer = xTimer                                                                                                                                                  |
| 说明     | krhino的定时器管理不带延时触发，如果发现处理命令buf满了，直接返回错误； 代码中此接口和xTimerStart处理一样；krhino的krhino_timer_start接口同样可以在中断中使用。 |

#### 4.5.2.10 xTimerStopFromISR

FreeRTOS接口：

| \#define xTimerStopFromISR( xTimer, pxHigherPriorityTaskWoken ) \\ xTimerGenericCommand( ( xTimer ), tmrCOMMAND_STOP_FROM_ISR, \\ 0, ( pxHigherPriorityTaskWoken ), 0U ) |
|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_timer_stop(ktimer_t \*timer) |
|----------|---------------------------------------------|
| 返回值   | 成功或失败                                  |
| 入参     | timer = xTimer                              |
| 说明     | pxHigherPriorityTaskWoken参数不关注         |

#### 4.5.2.11 xTimerChangePeriodFromISR

FreeRTOS接口：

| \#define xTimerChangePeriodFromISR( xTimer, xNewPeriod, pxHigherPriorityTaskWoken ) \\ xTimerGenericCommand( ( xTimer ), tmrCOMMAND_CHANGE_PERIOD_FROM_ISR, \\ ( xNewPeriod ), ( pxHigherPriorityTaskWoken ), 0U ) |
|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_timer_change(ktimer_t \*timer, sys_time_t first, sys_time_t round) |
|----------|-----------------------------------------------------------------------------------|
| 返回值   | 成功或失败                                                                        |
| 入参     | timer = xTimer                                                                    |
|          | First = xNewPeriod                                                                |
|          | Round = xNewPeriod                                                                |
|          | pxHigherPriorityTaskWoken参数不需要，用户不需要此判断。                           |

#### 4.5.2.12 pcTimerGetName

FreeRTOS接口：

| const char \* pcTimerGetName( TimerHandle_t xTimer ) |
|------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | 直接返回timer-\>name |
|----------|----------------------|


#### 4.5.2.13 xTimerResetFromISR

FreeRTOS接口：

| \#define xTimerResetFromISR( xTimer, pxHigherPriorityTaskWoken ) \\ xTimerGenericCommand( ( xTimer ), tmrCOMMAND_RESET_FROM_ISR, \\ ( xTaskGetTickCountFromISR() ), ( pxHigherPriorityTaskWoken ), 0U ) |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | Krhino不支持直接的重启定时器操作； 如果需要，可以使用stop + start组合操作 |
|----------|---------------------------------------------------------------------------|


#### 4.5.2.14 pvTimerGetTimerID

FreeRTOS接口：

| void \*pvTimerGetTimerID( const TimerHandle_t xTimer ) |
|--------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | Krhino不需要TimerID，所有操作都使用timer句柄 |
|----------|----------------------------------------------|


#### 4.5.2.15 vTimerSetTimerID

FreeRTOS接口：

| void vTimerSetTimerID( TimerHandle_t xTimer, void \*pvNewID ) |
|---------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | Krhino不需要TimerID，所有操作都使用timer句柄 |
|----------|----------------------------------------------|


#### 4.5.2.16 xTimerGetPeriod

FreeRTOS接口：

| TickType_t xTimerGetPeriod( TimerHandle_t xTimer ) |
|----------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | 直接访问timer-\>round_ticks |
|----------|-----------------------------|


#### 4.5.2.17 xTimerGetExpiryTime

FreeRTOS接口：

| TickType_t xTimerGetExpiryTime( TimerHandle_t xTimer ) |
|--------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | 直接访问timer-\>match：返回下一次触发的tick |
|----------|---------------------------------------------|


#### 4.5.2.18 [xTimerPendFunctionCall](http://www.freertos.org/xTimerPendFunctionCall.html)

FreeRTOS接口：

| BaseType_t xTimerPendFunctionCall( PendedFunction_t xFunctionToPend, void \*pvParameter1, uint32_t ulParameter2, TickType_t xTicksToWait ) |
|--------------------------------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_timer_dyn_create(ktimer_t \*\*timer, const name_t \*name, timer_cb_t cb, sys_time_t first, sys_time_t round, void \*arg, uint8_t auto_run) |
|----------|-----------------------------------------------------------------------------------------------------------------------------------------------------------|
| 返回值   | 成功或失败                                                                                                                                                |
| 入参     | Name ：自定义一个name                                                                                                                                     |
|          | Cb = xFunctionToPend：注意类型匹配                                                                                                                        |
|          | First = xTicksToWait                                                                                                                                      |
|          | Round = xTicksToWait                                                                                                                                      |
|          | Arg ：FreeRTOS该处有两个参数pvParameter1和pvParameter2，需要转换下。                                                                                      |
|          | auto_run = 1                                                                                                                                              |
| 出参     | Timer：返回句柄                                                                                                                                           |

#### 4.5.2.19 xTimerPendFunctionCallFromISR

FreeRTOS接口：

| BaseType_t xTimerPendFunctionCallFromISR( PendedFunction_t xFunctionToPend, void \*pvParameter1, uint32_t ulParameter2, BaseType_t \*pxHigherPriorityTaskWoken ) |
|------------------------------------------------------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | 此接口没有实际用途：直接将某处理函数加入到timer的处理buf内执行。由于该函数是在中断中执行，因此没有像xTimerPendFunctionCall有延时操作，因此无法通过创建单次定时器来替代。 |
|----------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


4.6、Event API
--------------

### 4.6.1 整体API对比

| FreeRTOS                    | Rhino                            | 说明                  |
|-----------------------------|----------------------------------|-----------------------|
| xEventGroupCreate           | krhino_event_dyn_create          | 动态创建even group    |
| xEventGroupCreateStatic     | krhino_event_create              | 静态创建even group    |
| vEventGroupDelete           | krhino_event_del                 | 删除event group       |
| xEventGroupWaitBits         | krhino_event_get                 | 等待event的位         |
| xEventGroupSetBits          | krhino_event_set                 | 设置event的位         |
| xEventGroupSetBitsFromISR   | krhino_event_set                 | 从中断中设置event的位 |
| xEventGroupClearBits        | krhino_event_set                 | 清掉event的位         |
| xEventGroupClearBitsFromISR | krhino_event_set                 | 中断中清掉event的位   |
| xEventGroupGetBits          | 直接读event结构体                | 得到event的位         |
| xEventGroupGetBitsFromISR   | 直接读event结构体                | 中断中得到event的位   |
| xEventGroupSync             | Rhion中可单用event组合达到此功能 | 多任务之间的同步      |

### 4.6.2 具体接口详述

#### 4.6.2.1 xEventGroupCreate

FreeRTOS接口：

| EventGroupHandle_t xEventGroupCreate( void ) |
|----------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_event_dyn_create(kevent_t \*\*event, const name_t \*name, uint32_t flags) |
|----------|------------------------------------------------------------------------------------------|
| 返回值   | 成功或失败                                                                               |
| 入参     | Name：用户自定义名字，维测使用                                                           |
|          | Flags = 0                                                                                |
| 出参     | Event：返回事件句柄                                                                      |

#### 4.6.2.2 xEventGroupCreateStatic

FreeRTOS接口：

| EventGroupHandle_t xEventGroupCreateStatic( StaticEventGroup_t \*pxEventGroupBuffer ) |
|---------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_event_create(kevent_t \*event, const name_t \*name, uint32_t flags) |
|----------|------------------------------------------------------------------------------------|
| 返回值   | 成功或失败                                                                         |
| 入参     | Event：用户自定义event结构体                                                       |
|          | Name：用户自定义名字，维测使用                                                     |
|          | Flags = 0                                                                          |

#### 4.6.2.3 vEventGroupDelete

FreeRTOS接口：

| void vEventGroupDelete( EventGroupHandle_t xEventGroup ) |
|----------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_event_del(kevent_t \*event) |
|----------|--------------------------------------------|
| 入参     | Event = xEventGroup：注意类型匹配          |

#### 4.6.2.4 xEventGroupWaitBits

FreeRTOS接口：

| EventBits_t xEventGroupWaitBits( EventGroupHandle_t xEventGroup, const EventBits_t uxBitsToWaitFor, const BaseType_t xClearOnExit, const BaseType_t xWaitForAllBits, TickType_t xTicksToWait ) |
|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_event_get(kevent_t \*event, uint32_t flags, uint8_t opt, uint32_t \*actl_flags, tick_t ticks)                    |
|----------|---------------------------------------------------------------------------------------------------------------------------------|
| 返回值   | 成功或失败                                                                                                                      |
| 入参     | Event = xEventGroup：注意类型匹配                                                                                               |
|          | Flags = uxBitsToWaitFor：注意FreeRTOS的该参数高8bit不能使用，rhino无限制                                                        |
|          | Opt = (xWaitForAllBits \<\< 1u) \| xClearOnExit                                                                                 |
|          | Ticks = xTicksToWait                                                                                                            |
| 出参     | actl_flags:对应xEventGroupWaitBits的返回值，此设定两个OS不太一样，不过此参数正常可以不需使用。 FreeRTOS此参数可能取值为不确定： |

1.  此返回值原则上是为了返回设定前的event
    value（去掉高8bit的操作位），但是可能会受到中断、高优先级的影响，因此值不确定；

2.  正常情况下，如果获取不到event，且没有超时设置，返回值为0；

3.  如果正常获取、超时获取、超时未获取，都会返回设定前的event
    value（去掉高8bit的操作位）。

#### 4.6.2.5 xEventGroupSetBits

FreeRTOS接口：

| EventBits_t xEventGroupSetBits( EventGroupHandle_t xEventGroup, const EventBits_t uxBitsToSet ) |
|-------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_event_set(kevent_t \*event, uint32_t flags, uint8_t opt) |
|----------|-------------------------------------------------------------------------|
| 返回值   | 成功或失败                                                              |
| 入参     | Event：事件句柄                                                         |
|          | Flags = EventBits_t：krhino没有高8bit不能使用的限制                     |
|          | Opt = RHINO_OR                                                          |

#### 4.6.2.6 xEventGroupSetBitsFromISR

FreeRTOS接口：

| BaseType_t xEventGroupSetBitsFromISR( EventGroupHandle_t xEventGroup, const EventBits_t uxBitsToSet, BaseType_t \*pxHigherPriorityTaskWoken ) |
|-----------------------------------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_event_set(kevent_t \*event, uint32_t flags, uint8_t opt) |
|----------|-------------------------------------------------------------------------|
| 返回值   | 成功或失败                                                              |
| 入参     | Event：事件句柄                                                         |
|          | Flags = uxBitsToSet：krhino没有高8bit不能使用的限制                     |
|          | Opt = RHINO_OR                                                          |

#### 4.6.2.7 xEventGroupClearBits

FreeRTOS接口：

| EventBits_t xEventGroupClearBits( EventGroupHandle_t xEventGroup, const EventBits_t uxBitsToClear ) |
|-----------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_event_set(kevent_t \*event, uint32_t flags, uint8_t opt) |
|----------|-------------------------------------------------------------------------|
| 返回值   | 成功或失败                                                              |
| 入参     | Event：事件句柄                                                         |
|          | Flags = \~( uxBitsToClear)：krhino没有高8bit不能使用的限制              |
|          | Opt = RHINO_AND                                                         |

#### 4.6.2.8 xEventGroupClearBitsFromISR

FreeRTOS接口：

| BaseType_t xEventGroupClearBitsFromISR( EventGroupHandle_t xEventGroup, const EventBits_t uxBitsToClear ) |
|-----------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | kstat_t krhino_event_set(kevent_t \*event, uint32_t flags, uint8_t opt) |
|----------|-------------------------------------------------------------------------|
| 返回值   | 成功或失败                                                              |
| 入参     | Event：事件句柄                                                         |
|          | Flags = \~( uxBitsToClear)：没有高8bit不能使用限制                      |
|          | Opt = RHINO_AND                                                         |

#### 4.6.2.9 xEventGroupGetBits

FreeRTOS接口：

| \#define xEventGroupGetBits( xEventGroup ) xEventGroupClearBits( xEventGroup, 0 ) EventBits_t xEventGroupClearBits( EventGroupHandle_t xEventGroup, const EventBits_t uxBitsToClear ) |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | 直接返回event-\>flags |
|----------|-----------------------|


#### 4.6.2.10 xEventGroupGetBitsFromISR

FreeRTOS接口：

| EventBits_t xEventGroupGetBitsFromISR( EventGroupHandle_t xEventGroup ) |
|-------------------------------------------------------------------------|


Rhino接口替换说明：

| 函数原型 | 直接返回event-\>flags |
|----------|-----------------------|


#### 4.6.2.11 xEventGroupSync

FreeRTOS接口：

| EventBits_t xEventGroupSync( EventGroupHandle_t xEventGroup, const EventBits_t uxBitsToSet, const EventBits_t uxBitsToWaitFor, TickType_t xTicksToWait ) |
|----------------------------------------------------------------------------------------------------------------------------------------------------------|


Rhino接口替换说明：

| 说明     | Rhion中可单用event组合达到此功能：                                                                           |
|----------|--------------------------------------------------------------------------------------------------------------|
| 函数1    | kstat_t krhino_event_set(kevent_t \*event, uint32_t flags, uint8_t opt)                                      |
| 入参     | Event = xEventGroup：注意类型匹配                                                                            |
|          | Flags = uxBitsToSet                                                                                          |
|          | Opt = RHINO_OR                                                                                               |
| 函数2    | kstat_t krhino_event_get(kevent_t \*event, uint32_t flags, uint8_t opt, uint32_t \*actl_flags, tick_t ticks) |
| 入参     | Event = xEventGroup：注意类型匹配                                                                            |
|          | Flags = uxBitsToWaitFor                                                                                      |
|          | Opt = RHINO_AND                                                                                              |
|          | Ticks = xTicksToWait                                                                                         |
| 出参     | actl_flags：参考xEventGroupWaitBits接口对krhino_event_get具体说明。                                          |
| 收尾处理 | 注意上面两个函数处理完后，需要清除标志：event-\> flags &= \~( uxBitsToWaitFor)                               |

4.7、 Mem API
-------------

### 4.7.1 整体API对比

| FreeRTOS              | Rhino                          | 说明               |
|-----------------------|--------------------------------|--------------------|
| vPortInitialiseBlocks | k_mm_init                      | 动态创建even group |
| pvPortMalloc          | krhino_mm_alloc                | 静态创建even group |
| vPortFree             | krhino_mm_free                 | 删除event group    |
| xPortGetFreeHeapSize  | 直接访问g_kmm_head-\>free_size | 等待event的位      |

### 4.7.2 具体接口详述

#### 4.7.2.1 vPortInitialiseBlocks

FreeRTOS接口：

| size_t xPortGetFreeHeapSize( void ) |
|-------------------------------------|


Rhino接口替换说明：

| 函数原型 | void k_mm_init(void)                                 |
|----------|------------------------------------------------------|
| 返回值   | 无                                                   |
| 说明     | 需要按照“2.2.6.3 内核使用堆的配置”章节，预设值堆空间 |

#### 4.7.2.2 pvPortMalloc

FreeRTOS接口：

| void \*pvPortMalloc( size_t xWantedSize ) |
|-------------------------------------------|


Rhino接口替换说明：

| 函数原型 | void \*krhino_mm_alloc(size_t size) |
|----------|-------------------------------------|
| 返回值   | 申请到的内存指针                    |
| 入参     | Size = xWantedSize                  |

#### 4.7.2.3 vPortFree

FreeRTOS接口：

| void vPortFree( void \*pv ) |
|-----------------------------|


Rhino接口替换说明：

| 函数原型 | void krhino_mm_free(void \*ptr) |
|----------|---------------------------------|
| 返回值   | 无                              |
| 入参     | Ptr = pv                        |

#### 4.7.2.4 xPortGetFreeHeapSize

FreeRTOS接口：

| size_t xPortGetFreeHeapSize( void ) |
|-------------------------------------|


Rhino接口替换说明：

| 函数原型 | 直接返回g_kmm_head-\>free_size |
|----------|--------------------------------|


4.8、Co-routines API
--------------------

目前业务上不需要co-routine的实现。

建议替换为task或者work实现。

4.9、smp多核 API
----------------

### 4.9.1 整体API对比

| FreeRTOS | Rhino                  | 说明                      |
|----------|------------------------|---------------------------|
| 无       | krhino_task_cpu_create | 在指定的cpu上创建任务     |
| 无       | krhino_task_cpu_bind   | 绑定任务到某一个具体cpu上 |
| 无       | krhino_task_cpu_unbind | 任务解除绑定到特定的cpu上 |
| 无       | krhino_spin_lock       | 自旋锁加锁                |
| 无       | rhino_spin_unlock      | 自旋锁解锁                |

### 4.9.2 具体接口详述

目前其他RTOS尚未支持该功能。

Rhino相关Smp说明，请参考：https://yq.aliyun.com/articles/589967

4.10、内核头文件包含
--------------------

Krhino的头文件包含统一使用：

| \#include “k_api.h” |
|---------------------|


五、编译方式说明
================

5.1、内核涉及文件部署
---------------------

（工具链\\example\\arch\\mcu\\链接脚本\\初始化）

| 模块                | 目录                    | 说明                                                               |
|---------------------|-------------------------|--------------------------------------------------------------------|
| 编译工具链          | build                   | 非IDE相关，使用AliOS Things编译框架aos make                        |
| Example（运行实例） | example                 | Krhino移植建议运行样例：**example\\rhinorun**                      |
| Arch（CPU架构相关） | platform\\arch          | 已经存在的arch文件直接使用； 不存在的架构需要按照章节2.1说明移植。 |
| Mcu相关             | platform\\mcu           | 硬件初始化、时钟、中断、打印等的基本功能。                         |
| 链接脚本            | platform\\mcu\\xxx      | 如果没有堆的修改（见2.6.3.1章节），可沿用原始链接脚本              |
| 初始化              | platform\\mcu\\xxx\\aos | 一般在aos下新建aos_main.c，作为main的初始化文件                    |
| 库函数              | utility\\libc           | Gcc: newlib_stub.c Armcc: armcc_libc.c Iarcc: iar_libc.c           |
| IDE相关工程         | projects                | 包含keil\\iar等                                                    |

5.2、Keil\\iar\\e2studio相关IDE
-------------------------------

IDE相关的编译工程都放在projects目录下，目前该目录下已经有一些示例工程，用户可以自建工程。对应的工程文件按照不同IDE的实际情况点击运行即可。

5.3、Gcc(linux\\vscode) 编译命令说明
------------------------------------

该部分在github上有详细步骤，此处不另做说明。

Linux下编译使用快速指导：<https://github.com/alibaba/AliOS-Things/wiki/Quick-Start>

Vscode下开发使用说明：<https://github.com/alibaba/AliOS-Things/wiki/AliOS-Things-Studio>

六、内核移植认证
================

AliOS
Things提供了基本的内核测试用例集，用于内核移植后的测试验证，所有移植的平台都需要运行该测试样例，确保内核功能的正确性。

内核测试集目录：test\\testcase\\certificate_test

在上面目录下提供了两个测试文件rhino_test.c和aos_test.c。其中rhino_test.c针对于纯内核的移植，aos_test.c针对于至少包含kernel层的移植，见章节2.8描述，其测试任务主要参考下面的《AliOS
Things Kernel 测试指南参考》。

目前主要的认证项都会带aos层，如果只关注rhino_test.c相关纯内核的验证，需要做以下修改：

-   修改rhino_test.c配置项，如：

| /\*以下字符定义可任取名字，不能为空\*/ \#define SYSINFO_ARCH " MIPS"                                                                                                                                                            |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| \#define SYSINFO_MCU " RDA" \#define SYSINFO_DEVICE_NAME " RDA8955" \#define SYSINFO_APP_VERSION "1.3.0" /\*kv和yloop不属于纯krhino模块，需要关闭\*/ \#define TEST_CONFIG_KV_ENABLED (0) \#define TEST_CONFIG_YLOOP_ENABLED (0) |

-   将rhino_test.c和cut.c\\ cut.h加入编译体系

可以将test\\testcase\\certificate_test目录下此三个直接拷贝到对应mcu下，新建一个test目录并加入到makefile；其他IDE直接添加编译文件。

-   在主任务中调用test_certificate执行测试用例认证直到用例通过即可。

上面属于纯krhino内核的测试方式，如果带aos接口层的测试请参考，

AliOS Things Kernel
测试指南：<https://github.com/alibaba/AliOS-Things/wiki/Manual-API>

七、移植问题反馈途径
====================

如果有移植遇到问题或者疑问，可以通过下面方式交流：

途径1：AliOS Things github主页：<https://github.com/alibaba/AliOS-Things>

途径2：钉钉群——AliOS Things 技术交流群
