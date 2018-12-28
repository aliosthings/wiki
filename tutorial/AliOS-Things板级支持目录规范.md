EN| [中文](AliOS-Things板级支持目录规范) 

本文主要介绍AliOS
Things新增单板支持，相关board\\platform目录、文件的部署规范，以及相关接口定义和使用的标准。相关代码合入AliOS
Things工程，都需要遵循此文档规范。
代码提交和回流过程中，都会按照本规范进行代码检查，不符合的代码不予入库，请务必遵循。
AliOS Things参考版本：AOS-R-2.0.0

参考示例规范单板：

board: aaboard_demo ;

mcu:   aamcu_demo;

arch:  Cortex-M4

1、目录结构规范
===============

下述为新增一个单板支持，必须关注的几个目录项：

| 目录名         | 介绍                                                             |
|----------------|------------------------------------------------------------------|
| app\\example   | 通用用户运行实例，如helloworld实例，可直接使用，无特殊情况不修改 |
| test\\develop  | 用户自定义特殊运行实例，满足某一特定场景时添加                   |
| board          | 用户需要适配、可配置board级代码，系统启动相关代码                |
| platform\\arch | 该CPU架构内核调度适配接口，可直接使用                            |
| platform\\mcu  | 该MCU通用SDK以及对应的hal适配层                                  |

1.1、example新增规范
--------------------

原则上不建议新增example，除非目前的example不能满足功能需求。app\\example下为通用运行实例，test\\develop为某些特定场景的实例；如果需要增加实例，无特殊情况，都优先往test\\develop中添加。

### 1.1.1、目录功能

针对上层用户需要运行的具体实例出发，抽象出具体代表某个功能的实例工程，如基本的定时输出功能：helloworld,
上云通道实例功能：mqttapp。app\\example目录下，为已经抽象的通用运行实例，原则上用户不需要修改，直接使用现行实例。

### 1.1.2、命名规范

运行实例取名简洁、直观，需要和具体运行的功能对应。

### 1.1.3、目录结构规范

文件部署规范如下，以helloworld示例，
```
helloworld
|-- helloworld.c       # helloworld source code, including app entry ”application_start”
|-- Config.in          # menuconfig config file
|-- aos.mk             # aos build system file(for make)
|-- k_app_config.h     # aos app config file, has higher priority than k_config.h
|-- ucube.py           # aos build system file(for scons)
|-- README.md
```

### 1.1.4、函数命名规范

**运行实例入口统一使用**application_start函数。用户在该接口内添加具体实现。

### 1.1.5、mk编写规范（aos.mk）
```
NAME := helloworld                        #example名，和目录统一
$(NAME)_MBINS_TYPE := app                 #在多bin情况下，归属kernel还是app
$(NAME)_VERSION := 1.0.0                  #menuconfig组件版本号
$(NAME)_SUMMARY := Hello World            #描述                  
$(NAME)_SOURCES      +=                   #example.c文件
$(NAME)_COMPONENTS   +=                   #依赖其他组件名
GLOBAL_INCLUDES      +=                   #全局头文件
GLOBAL_DEFINES       +=                   #全局宏定义
```
1.2、board新增规范
------------------

### 1.2.1、目录功能

board下统一放置板级相关启动、配置、初始化代码，以及板级外设驱动。

### 1.2.2、命名规范

board取名需要使用标准通用名，能方便检索获取到相关单板信息。

### 1.2.3、目录结构规范

board目录下文件结构部署和命名需要遵循下面布局规则，以aaboard_demo单板为例
```
Dir\File                          Description                                        Necessary for kernel run
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
注：gcc、keil、iar任意支持一种即可，无需全部支持，即startup_xx.s和链接文件只需实现一套即可
```
### 1.2.4、函数命名规范

| **文件**         | **函数名**                                                                                                                                           |
|------------------|------------------------------------------------------------------------------------------------------------------------------------------------------|
| k_config.c       | 实现样例单板aaboard_demo该文件内所有对接接口                                                                                                         |
| partition_conf.c | 统一分区初始化接口：flash_partition_init                                                                                                             |
| board.c          | 统一单板初始化接口：board_init                                                                                                                       |
| startup.c        | 无特殊情况统一C程序主入口为main； 内部调用单板初始化board_init; 内部调用krhino接口初始化内核； 内部创建主任务入口sys_init。 （具体见初始化流程规范） |

### 1.2.5、mk编写规范（aos.mk）
```
NAME := board_aaboard_demo               #board_+单板名                   
$(NAME)_MBINS_TYPE := kernel             #在多bin情况下，归属kernel还是app
$(NAME)_VERSION    :=                    #组件版本号
$(NAME)_SUMMARY    :=                    #描述
MODULE             := 1062               #固定
HOST_ARCH          := Cortex-M4          #CPU arch
HOST_MCU_FAMILY    := aamcu_demo         #归属MCU系列，需要对应platform\mcu
SUPPORT_MBINS      := no                 #是否支持app\kernel的bin分离
HOST_MCU_NAME      := aamcu1_demo        # MCU子系列类型
ENABLE_VFP         := 1                  #是否支持浮点数
$(NAME)_SOURCES       +=                 #board组件包含.c文件
$(NAME)_COMPONENTS    +=                 #依赖其他组件名
GLOBAL_INCLUDES       +=                 #头文件
GLOBAL_CFLAGS         +=                 #c文件编译选项 
GLOBAL_ASMFLAGS       +=                 #汇编编译选项 
GLOBAL_LDFLAGS        +=                 #链接选项
GLOBAL_DEFINES        +=                 #用户自定义宏   
注意：
（1）、其中HOST_MCU_FAMILY的定义需要对应platform\mcu下具体某mcu目录名。HOST_MCU_NAME表示具体的mcu子系列。
（2）、用户可以通过GLOBAL_DEFINES定义宏，如GLOBAL_DEFINES += CONFIG_AOS_CLI_BOARD或者GLOBAL_DEFINES += CONFIG_AOS_KV_BLK_BITS=14。当然也可以直接在编译选项 GLOBAL_CFLAGS使用-D定义。

```
1.3、platform新增规范
---------------------

platform目录分为arch和mcu两个子目录，arch存放CPU架构相关的调度代码，mcu存放通用的BSP驱动代码和hal对接层。

### 1.3.1、arch子目录新增规范

目前arch下已经适配了主要的CPU架构，原则上只需要直接使用。如果需要新增，需要关注下述章节。

#### 1.3.1.1、目录功能

arch目录下主要是基本的CPU架构相关的porting，主要包括开关中断实现、任务切换、中断上下文切换等功能。

#### 1.3.1.2、命名规范

必须使用业界通用CPU架构名，从名字可以清晰了解是哪种CPU、哪种processs系列。

#### 1.3.1.3、目录结构规范

新增CPU架构规范，以ARM体系为例。

三级和四级目录按照具体情况可选。对于三级目录，如果此架构只会使用gcc，则不需要分此目录；如果二级目录可以区分不同的处理器系列或架构类型，则按照具体情况不需要添加。

| 一级目录 CPU arch | 二级目录 Process arch | 三级目录(具体情况可选) Compiler Type | 四级目录(具体情况可选) Process series |
|-------------------|-----------------------|--------------------------------------|---------------------------------------|
| ARM               | armv5                 | armcc\\gcc\\iccarm                   |                                       |
|                   | armv6m                | armcc\\gcc\\iccarm                   | m0                                    |
|                   | armv7m                | armcc\\gcc\\iccarm                   | m3                                    |
|                   |                       |                                      | m4                                    |
|                   |                       |                                      | m7                                    |
|                   | armv7a                | armcc\\gcc\\iccarm                   | a5                                    |
|                   |                       |                                      | a7                                    |
|                   |                       |                                      | a9                                    |

#### 1.3.1.4、函数命名规范

CPU arch统一对接下述接口

| CPU Porting接口      | 说明                                                                                                       |
|----------------------|------------------------------------------------------------------------------------------------------------|
| cpu_intrpt_save      | 关中断                                                                                                     |
| cpu_intrpt_restore   | 开中断                                                                                                     |
| cpu_intrpt_switch    | 中断退出切换（在中断处理函数尾部使用，需要确保被打断的上下文正确保存，中断退出后，回到当前最高优先级任务） |
| cpu_task_switch      | 任务切换（需要保存老任务上下文、获取最高优先级任务、恢复新任务上下文）                                     |
| cpu_first_task_start | 进入第一个任务调度                                                                                         |
| cpu_task_stack_init  | 任务栈初始化                                                                                               |
| cpu_cur_get          | 获取当前核号                                                                                               |

#### 1.3.1.5、mk编写规范（aos.mk）

没有例外情况，统一在二级Process arch目录添加对应的编译mk文件。

arch mk添加规范如下（以armv7m为例）：

```
NAME := armv7m                            #Process arch名  
$(NAME)_MBINS_TYPE := kernel              #多bin情况下，归属kernel还是app
$(NAME)_VERSION    := 0.0.1.0             #menuconfig版本号
$(NAME)_SUMMARY    := arch for armv7m     #描述              
$(NAME)_SOURCES       +=                  #组件包含.c文件
GLOBAL_INCLUDES       +=                  #包含头文件   
ifeq ($(COMPILER),armcc)                  #区分编译器
ifeq ($(HOST_ARCH),Cortex-M4)             #区分Process series
```
### 1.3.2、mcu子目录新增规范

#### 1.3.2.1、目录功能

Mcu目录存放其原始SDK驱动文件，以及hal驱动对接层。

其中的SDK文件原则上直接使用厂商的驱动包，除了License或bug修复等，原则上不做修改。板级相关的配置代码统一放入board目录。

#### 1.3.2.2、命名规范

Mcu命令需要使用业界通用名，能直观方便检索到相关信息为准。

#### 1.3.2.3、目录结构规范
```
Dir\File                          Description                           Necessary for kernel run
|-- drivers                 # board peripheral driver                                Y
|-- hal                     # hal API layer, hal uart is necessary                   Y
|-- aos.mk                  # mcu makefile                                           Y
|-- Config.in               # menuconfig component config                            Y
|-- ucube.py                # aos build system file(for scons)                       N
|-- README.md                                                                        Y
```
#### 1.3.2.4、函数命名规范

统一按照样例aamcu_demo\\hal下列出的各模块hal API实现。

#### 1.3.2.5、mk编写规范（aos.mk）

mcu的mk文件，其描述了当前mcu组件需要的编译文件和编译选项。

如果该系列MCU能实现一个通用mk文件则使用一个即可；如果该MCU体系下存在多种MCU子系列，那么需要添加子mcu的mk文件，在其中放置不同的属性定义。aos.mk作为主mk，主要放置公共的属性配置，并使用HOST_MCU_NAME来分别引用对应的子mcu。

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
NAME := mcu_aamcu_demo                  #主MCU名，需要和目录名一致  
$(NAME)_MBINS_TYPE   := kernel          #多bin情况下，归属kernel还是app
$(NAME)_VERSION      := 0.0.1           #menuconfig组件版本号
$(NAME)_SUMMARY      := driver & sdk    #描述               
$(NAME)_SOURCES      +=                 #MCU组件包含.c文件
$(NAME)_COMPONENTS   +=                 #依赖其他组件名
GLOBAL_INCLUDES      +=                 #头文件
GLOBAL_CFLAGS        +=                 #c文件编译选项 
GLOBAL_ASMFLAGS      +=                 #汇编编译选项 
GLOBAL_LDFLAGS       +=                 #链接选项
GLOBAL_DEFINES       +=                 #用户自定义宏 
```

2、接口定义使用规范
===================

2.1、内核接口使用规范
---------------------

**规范**：对于纯内核系统，或者内核本身、bsp相关代码使用krhino接口；对于上层连接协议栈、app统一使用aos接口。

2.2、HAL定义规范
----------------

**规范**：hal相关接口的命名和声明统一参照目录aamcu_demo\\hal下提供的样例demo实现。

3、初始化流程规范
=================

系统从复位启动到main函数入口的流程一般使用该单板通用的汇编程序来实现，进入main函数后需要遵循下面规范。下面规范一方面为了使用接口统一，另一方面避免发生一些已知的流程问题。

**main函数位置规范：**

按照1.2
章节board目录结构描述，统一放在startup.c中实现，用户example的入口统一为application_start.

**单板驱动初始化规范：**

初始化接口统一为board_init;
**由于此接口调用时，内核尚未初始化，此初始化阶段不能激活中断处理，否则会触发中断调度**。

**内核初始化调用：**

统一使用krhino接口，如krhino_init和krhino_start。

**主任务创建规范：**

内核初始化本身只会创建内部任务，如idle\\timer任务；初始化流程中需要创建主任务，供用户app运行。统一通过krhino接口如krhino_task_dyn_create来创建主任务；主任务的入口统一为**sys_init**。

**接口使用限制说明：**

krhino_init前不调用malloc、printf函数。原因是此类库函数被内核重定向，会调用内核接口aos_malloc，依赖内核的初始化。

**系统初始化流程规范如下：**  
![](https://i.imgur.com/oxUBiNT.png)  

主任务会在krhino_start开始调度后进入，如果不创建主任务，则系统会默认进入OS自身创建的其他任务运行，比如idle任务。

**主任务入口sys_init实现：**

在sys_init中，可以添加相关中断激活程序的驱动，比如开始tick计数并触发可能的tick中断，具体实现参考对应单板；

如果需要初始化相关中间件和协议栈模块，使用aos_components_init接口；

最后，在非多bin的情况下，统一调用application_start进入上层app入口；多bin情况下，由aos_components_init内部分发处理。

**参考代码**（board\\aaboard_demo\\startup\\ startup.c）**：**

（1）、系统初始化示例：

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

（2）、主任务初始化示例：

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
（3）、用户app入口示例（参考app\\example\\helloworld\\helloworld.c）：

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

4、内核认证
===========

AliOS
Things提供了基本的内核测试用例集，用于内核移植后的测试验证，所有移植的平台都需要运行该测试样例，确保内核功能的正确性。

内核测试集目录：test\\testcase\\certificate_test

在上面目录下提供了两个测试文件rhino_test.c和aos_test.c。其中rhino_test.c针对于纯内核的移植，aos_test.c针对于至少包含AOS
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
-   将rhino_test.c和cut.c\\ cut.h加入编译体系

可以将test\\testcase\\certificate_test目录下此三个直接拷贝到对应mcu下，新建一个test目录并加入到makefile；其他IDE直接添加编译文件。

-   在主任务中调用test_certificate执行测试用例认证直到用例通过即可。

上面属于纯krhino内核的测试方式，如果带aos接口层的测试请参考，

AliOS Things Kernel
测试指南：<https://github.com/alibaba/AliOS-Things/wiki/Manual-API>

5、代码合入整体原则
===================

5.1、公共代码修改
-----------------

公共代码原则上避免修改，以影响其他单板。通用文件修改后，需要确认不影响其他工程的编译和运行。如果影响公共代码，需要清晰说明：是修复bug、增加新特性、或是改进功能，并介绍如何完成的。

公共代码范围：目前除新增board目录、新增mcu目录，新增test\\develop目录，其他目录或者文件都视为公共文件，包括app\\example目录。修改后，都可能影响其他单板。

5.2、License准则
----------------

-   原创为主尊重版权，请作者标明自己的 copyright
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
