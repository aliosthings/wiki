本文主要指导如何将已经运行FreeRTOS的系统切换到Alios Things上。此文档包括了详细的OS目录结构对比、CPU移植必要点，以及OS接口替换指导。适用于指导在通用CPU体系上，FreeRTOS系统向Alios Things的整体迁移。
参考版本：  
FreeRTOS：FreeRTOSv10.0.1  
AliOS Things：AOS-R-1.3.0  

## 目录  

- [1 主要特性对比](#1主要特性对比)
	- [1.1 内核功能](#1内核功能)
	- [1.2 实时性](#1实时性)
	- [1.3 代码体积以及占用的RAM大小](#1代码体积以及占用的RAM大小)

- [2 通用CPU移植修改点](#1通用CPU移植修改点)
	- [2.1 已经支持的CPU移植](#1已经支持的CPU移植)
	- [2.2 尚不支持的CPU移植](#1尚不支持的CPU移植)
		- [2.2.1 CPU porting](#1CPU%20porting)
		- [2.2.2 系统tick](#1系统tick)
		- [2.2.3 C库](#1C库)
		- [2.2.4 基本输入输出](#1基本输入输出)
		- [2.2.5 运行示例example](#1运行示例example)
		- [2.2.6 内核可配置项](#1内核可配置项)
		- [2.2.7 系统初始化](#1系统初始化)
		- [2.2.8 上层应用调用aos接口说明](#1上层应用调用aos接口说明)  

- [3 OS API对比参考](#1OS%20API对比参考)  
	- [3.1 Task API](#1Task%20API)
	- [3.2 Buf Queue API](#1Buf%20Queue%20API)
	- [3.3 Queue API](#1Queue%20API)
	- [3.4 Semaphore & Mutex API](#1Semaphore%20&%20Mutex%20API)
	- [3.5 Timer API](#1Timer%20API)
	- [3.6 Event API](#1Event%20API)
	- [3.7 Co-routines API](#1Co-routines%20API)
	- [3.8 smp多核 API](#38-smp多核-api)
	- [3.9 内核头文件包含](#1内核头文件包含)

- [4 编译方式说明](#1编译方式说明)
	- [4.1 内核涉及文件部署](#1内核涉及文件部署I)
	- [4.2 Keil\iar\e2studio相关IDE](#1Keil\iar\e2studio相关IDE)
	- [4.3 Gcc(linux\vscode) 编译命令说明](#1Gcc(linux\vscode)%20编译命令说明)

- [5 内核移植认证](#1内核移植认证)  
- [6 移植问题反馈途径](#1移植问题反馈途径)


## 1 主要特性对比
以下三个方面和FreeRTOS对比:  
	* 内核功能  
	* 实时性  
    * 代码体积以及占用的RAM大小  
基本功能点，接口层面的见第后续章节.

### 1.1 内核功能  

![](https://i.imgur.com/twokPaq.png)

### 1.2 实时性
![](https://i.imgur.com/dmHKRhY.png)
注：Basing on CK802T , 20M HZ, 256KB RAM  
	* Interrupt Delay、Max disable sched和Task Preemption是最重要的几个实时性指标，Interrupt Delay相比FreeRTOS性能提高一倍, Task Preemption比FreeRROS优2us。rhino 所有系统API都不会关调度，保证优先级高的任务能够随时抢占  
	*Task Yield 比FreeRTOS慢2us  
	*信号量通知的性能比FreeRTOS慢3.5us  
	*Mutex 通知的功能比起FreeRTOS稍差  
以上数据对比来自中天微公司的实测。  
从实时操作系统的指标来看，Interrupt delay是最重要的实时性指标，是实时操作系统的硬实时的标准，各家 rtos主推的实时性指标也是这一个。如果Interrupt delay时间大的话，在一些高实时性的领域，比如工业，医疗，航空等领域，就会不符合要求。其次的一个实时性指标是Max disable sched，这是决定一个实时操作系统的软实时性的指标，从上表中可以看出rhino这块的时间为0，整个系统不关抢占，而freertos的设计比如分配内存等采用了关内核抢占的形式，所以这个时间是比较大的。从这两个实时性指标来看，rhino均占优势。  

### 1.3 代码体积以及占用的RAM大小  
最小配置情况下（只运行一个idle task）
![](https://i.imgur.com/8VlrbLI.png)

注:  
	*Rhino 的Footprint比FreeRTOS整体占优  
TCB多出的4个字节是因为Rhino为了解决优先级反转嵌套而引入，FreeRTOS没有完善解决此问题。完整的系统级的优先级反转解决能力是rhino相比其它rtos的一大竞争力所在。  


## 2 通用CPU移植修改点  
对于AliOS Things已经支持的CPU，相关的`arch\cpu`文件可以直接使用，只需要加入编译体系即可；对于尚未支持的CPU，只需要对照相关移植点修改即可。  
AliOS Things支持硬件列表  
![](https://i.imgur.com/0IoSWoa.png)
![](https://i.imgur.com/wvfoa5S.png)

上述支持列表以实际版本中支持的为准。  
具体可以按照下面目录结构查找实际版本支持的单板情况：  

![](https://i.imgur.com/FKmRMbu.png)


### 2.1 已经支持的CPU移植  
对于此类型CPU，AliOS Things工程内，已经支持了OS在该平台上运行所需的CPU arch代码，因此不需要额外的CPU架构相关的移植工作，可以跳过2.1 CPU porting章节，进行mcu相关的适配。  

### 2.2 尚不支持的CPU移植  
对于新增一个CPU类型（包括arch、mcu相关），我们需要关注几个重要移植点。完成这些移植点后，AliOS Things就能适配上一个新的CPU。  
主要移植点：  

#### 2.2.1 CPU porting

如果需要新增CPU架构支持，在`platform\arch`目录下增加相应目录。相应的文件参考已有命名和部署。  
主要涉及的适配接口包括：  
![](https://i.imgur.com/GdLDDeL.png)

#### 2.2.2 系统tick  
Tick相关的需要有两处修改：  
##### 2.2.2.1 tick中断挂接
在tick中断处理接口内部需要调用`krhino_tick_proc`，并且在处理前后需要加入`krhino_intrpt_enter`和`krhino_intrpt_exit`  
样例：  
```  
    krhino_intrpt_enter();    
    krhino_tick_proc();    
    krhino_intrpt_exit();    
```
对应FreeRTOS中`xPortSysTickHandler`或`FreeRTOS_Tick_Handler`处理。  

##### 2.2.2.2 tick频率配置  
需要将tick中断的频率配置给相应的寄存器。AliOS Things 在`k_config.h`中有相关`RHINO_CONFIG_TICKS_PER_SECOND`的设定。对应替换`configTICK_RATE_HZ`的设置即可。
![](https://i.imgur.com/oGBOiMA.png)

#### 2.2.3 C库  

OS内已经实现了分别针对armcc、gcc、iar三种编译体系的C库函数对接。  

![](https://i.imgur.com/yfa49Ow.png)

对于keil\iar等IDE平台，只需要将对应的文件加入编译体系，对于gcc，只需要将对应的组件libc加入makefile体系即可。  
比如`platform\mcu\stm32l475\stm32l475.mk`中设定了`$(NAME)_COMPONENTS += libc`    

#### 2.2.4 基本输入输出  

OS运行后，需要有基本的打印输出功能，即`printf`能工作；对于需要能在串口执行命令的需求下，还需要有获取串口字符串功能。一般通过重构下述接口实现:  
![](https://i.imgur.com/JD7wM9g.png)

#### 2.2.5 运行示例example  

在目录example下提供了各种OS上app运行实例，对于基本的内核移植，可以参考`example\rhinorun`将该实例运行起来，即表示内核基本的任务、tick中断能够正常运行。  

#### 2.2.6 内核可配置项  

`K_config.h`文件中包含了所有内核裁剪配置，包括模块裁剪、内存裁剪。可以根据不同的模块需求，以及内存大小来进行修改裁剪。  

##### 2.2.6.1 内核模块裁剪  
![](https://i.imgur.com/7iqqPBn.png)

##### 2.2.6.2 内核内存裁剪  
对于内存裁剪，不同的CPU由于需要保存的栈上下文有区别，所以在不同的平台上会有区别。基本考虑点是任务的上下文大小，任务内部的处理需要的大致栈大小。参考缩减任务栈配置：  

```  
RHINO_CONFIG_TIMER_TASK_STACK_SIZE  128
RHINO_CONFIG_K_DYN_TASK_STACK      128
RHINO_CONFIG_IDLE_TASK_STACK_SIZE    100
RHINO_CONFIG_CPU_USAGE_TASK_STACK  100
```
需要运行上层协议栈时，  
打开`RHINO_CONFIG_WORKQUEUE`项配置栈大小： 
``` 
#define RHINO_CONFIG_WORKQUEUE_STACK_SIZE     512  
 
```

上述栈大小是系统运行的建议大小，尚不是系统极限能运行的大小。如果在一个系统中，对于内存使用需要使用到极致，可以按照两个步骤来估算极限值：  
A、	直接估算法：  
（1）、计算实际任务上下文。根据不同的CPU，如`ARM\MIPS\XTENSA`需要保存的寄存器不一样，不同的配置项，比如开不开浮点数等计算需要保存的现场栈大小；  
（2）、估算任务处理接口内部开栈大小  
B、实际运行检测调整  
下述图中“StackSize”表示任务栈总大小，“MinFreesize”表示该任务运行到目前为止未使用的栈，单位都是cpu_stack_t（4字节）；  
如果系统未支持cli命令，可以使用`krhino_task_stack_min_free`接口来获取某任务的“MinFreesize”。 

 ![](https://i.imgur.com/QA27cO4.png)

##### 2.2.6.3 内核使用堆的配置
如果要使用内存申请功能，则需要打开`RHINO_CONFIG_MM_TLF`宏，来使能k_mm模块，并且配置对应的堆空间。
堆空间定义有三种方式：链接脚本定义、汇编定义、数组定义。推荐方式：链接脚本定义。
其基本原则是要预留一个内存空间作为堆使用，并将其交给`g_mm_region`管理。  

###### 2.2.6.3.1 链接脚本定义（建议方式）  
（参考文件：`platform\mcu\nrf52xxx\ nrf52_common.ld`）  

![](https://i.imgur.com/sSLdfZI.png)

堆的起点heap_start定义为栈的结尾，堆的结尾heap_end定义为RAM的结尾，这样剩余RAM的空间都交给OS管理。
对应的krhino的堆空间初始化为：  

注意：这段内存分配给堆使用，并不是表示内存都耗尽了，而是将其交给OS管理，用户通过malloc出来的内存都是从其中申请。  

###### 2.2.6.3.2 汇编定义  

（参考文件：`platform\mcu\stm32l4xx\src\STM32L496G-Discovery\startup_stm32l496xx_keil.s`）  
![](https://i.imgur.com/aEcgaPB.png)

此方式并没有将剩余RAM的空间都直接交给OS管理，需要用户自己来调整大小。  
对应的krhino的堆空间初始化为：  

```  
k_mm_region_t g_mm_region[] = {{(uint8_t *) &__heap_base, (size_t) &Heap_Size}}; 
```

###### 2.2.6.3.3 数组定义 
（参考文件：`platform\mcu\nrf52xxx\aos\ soc_impl.c`）
直接定义一个数组：  
```  
#define HEAP_BUFFER_SIZE 1024*20
uint8_t g_heap_buf[HEAP_BUFFER_SIZE];
 
```
此方式也没有将剩余RAM的空间都直接交给OS管理，需要用户自己来调整大小。  
对应的krhino的堆空间初始化为：  
```  
k_mm_region_t g_mm_region[] = {{g_heap_buf, HEAP_BUFFER_SIZE}};
 
```

#### 2.2.7 系统初始化  

##### 2.2.7.1 硬件初始化
![](https://i.imgur.com/LOJLh7P.png)

##### 2.2.7.2 内核初始化 
![](https://i.imgur.com/0kEa8hg.png)


初始化的流程都大同小异，其中CPU本身的启动加载按照不同板子的实际情况处理，此处仅说明OS部分的初始化。
主要包括：内核模块初始化`krhino_start`;创建主任务`krhino_task_create`;内核启动`krhino_start`。  

![](https://i.imgur.com/76b3xOQ.png)

主任务会在`krhino_start`开始调度后进入，如果不创建主任务，则系统会默认进入OS自身创建的其他任务运行，比如idle任务。主任务入口一般初始化内核运行需要的相关硬件寄存器，比如tick时钟，串口等等。一些硬件初始化也可以放在`krhino_init`之前，但是需要注意在内核初始化前，禁止启动和内核相关的操作，主要包括激活带内核处理的中断，比如`tick\uart`，依赖内核的库函数：  
（1）、`krhino_start`前不能有OS相关的中断处理。原因是如果在内核运行前触发了某个中断，并且该中断使用了`krhino_intrpt_exit`处理，则会进入任务切换，而此时内核尚未开始调度；  
（2）、`printf`、`malloc`相关的接口，在内核初始化后才能使用。原因是此类库函数被内核重定向，会调用内核接口`aos_malloc`，依赖内核的初始化。  

#### 2.2.8 上层应用调用aos接口说明  
 
AliOS Things的内核模块本身使用带`krhino_`的接口，此接口一般是内核本身或者纯内核的软件系统使用；对于应用来说，统一提供aos_的内核应用接口，原则上上层应用，包括协议栈不再独立调用`krhino`开头的接口。Aos_rhino.c内抽象出了上层所有需要使用的内核功能，并且尽可能将参数精简，以达到用户使用方便的目的。  
另外，通过aos层，还可以封装其他如freertos、posix的接口，可参考aos_freertos.c和aos_posix.c文件。Aos层的OS接口作为一个抽象层，原则上可以封装所有类似其他OS的功能接口。  
关于aos层的接口说明，请参考：https://living.aliyun.com/doc#ok40t4.html  



## 3 OS API对比参考
同为嵌入式OS系统，AliOS Things和FreeRTOS系统在接口使用上虽然存在着一些差别，但是由于其定位类似，所以大部分功能接口都能找到对应的处理，或者通过简单的功能组合来实现。以下列出主要FreeRTOS和AliOS Things rhino接口替换参数细节。  

### 3.1 Task API  

#### 3.1.1 整体API对比  

![](https://i.imgur.com/8pOcj28.png)
![](https://i.imgur.com/o5wVdJg.png)
![](https://i.imgur.com/7jMOPhd.png)
![](https://i.imgur.com/1QHs8cu.png)
![](https://i.imgur.com/955J7VE.png)
![](https://i.imgur.com/u3maR24.png)
![](https://i.imgur.com/O8bFk8M.png)


#### 3.1.2 具体接口详述  


##### 3.1.2.1 xTaskCreate  

FreeRTOS接口：  

``` 
BaseType_t xTaskCreate(	TaskFunction_t pxTaskCode,
							const char * const pcName,									                    const configSTACK_DEPTH_TYPE usStackDepth,
							void * const pvParameters,
							UBaseType_t uxPriority,
							TaskHandle_t * const pxCreatedTask )
 
```

Rhino接口替换说明：  
![](https://i.imgur.com/T38IuiK.png)
![](https://i.imgur.com/Vsu5Gst.png)


##### 3.1.2.2 xTaskCreateStatic  

FreeRTOS接口：
```  
TaskHandle_t xTaskCreateStatic(	TaskFunction_t pxTaskCode,
									const char * const pcName,											            const uint32_t ulStackDepth,
									void * const pvParameters,
									UBaseType_t uxPriority,
									StackType_t * const puxStackBuffer,
									StaticTask_t * const pxTaskBuffer )
 
```
Rhino接口替换说明：  

![](https://i.imgur.com/YCN2eKx.png)

##### 3.1.2.3 vTaskDelete    
FreeRTOS接口：  
```  
void vTaskDelete( TaskHandle_t xTaskToDelete )
 
```
Rhino接口替换说明：  

![](https://i.imgur.com/aoSzdFn.png)


##### 3.1.2.4 vTaskDelay
FreeRTOS接口：  
```  
void vTaskDelay( const TickType_t xTicksToDelay )
 
```
Rhino接口替换说明：  

![](https://i.imgur.com/L2cqUiX.png)  

##### 3.1.2.5 vTaskDelayUntil
FreeRTOS接口：  
```  
void vTaskDelayUntil( TickType_t * const pxPreviousWakeTime, const TickType_t xTimeIncrement )
 
```
Rhino接口替换说明：

![](https://i.imgur.com/xqh6qjl.png)


##### 3.1.2.6 uxTaskPriorityGet  

FreeRTOS接口：  
```  
UBaseType_t uxTaskPriorityGet( TaskHandle_t xTask )
 
```
Rhino接口替换说明：  
![](https://i.imgur.com/doxYoD5.png)  


##### 3.1.2.7 vTaskPrioritySet  
 
FreeRTOS接口：  
```  
void vTaskPrioritySet( TaskHandle_t xTask, UBaseType_t uxNewPriority )
 
```
Rhino接口替换说明：  
![](https://i.imgur.com/jLFbo0V.png)

##### 3.1.2.8 vTaskSuspend
FreeRTOS接口：  
```  
void vTaskSuspend( TaskHandle_t xTaskToSuspend )
 
```
Rhino接口替换说明：  

![](https://i.imgur.com/vq1aEpJ.png)


##### 3.1.2.9 vTaskResume

FreeRTOS接口：  
```  
void vTaskResume( TaskHandle_t xTaskToResume )
 
```
Rhino接口替换说明：  

![](https://i.imgur.com/ARZbNdS.png)  

  
##### 3.1.2.10 xTaskResumeFromISR  
FreeRTOS接口：  
```  
BaseType_t xTaskResumeFromISR( TaskHandle_t xTaskToResume )
 
```
Rhino接口替换说明：  

![](https://i.imgur.com/4hseqtu.png)


##### 3.1.2.11 xTaskAbortDelay 
FreeRTOS接口：  
```  
BaseType_t xTaskAbortDelay( TaskHandle_t xTask )
 
```
Rhino接口替换说明：  
![](https://i.imgur.com/l5iq4C2.png)

##### 3.1.2.12 vTaskSetThreadLocalStoragePointer
FreeRTOS接口：  
```  
void vTaskSetThreadLocalStoragePointer( TaskHandle_t xTaskToSet, BaseType_t xIndex, void *pvValue )
 
```
Rhino接口替换说明：  

![](https://i.imgur.com/Ej5JABf.png)

##### 3.1.2.13 pvTaskGetThreadLocalStoragePointer
FreeRTOS接口：  
```  
void *pvTaskGetThreadLocalStoragePointer( TaskHandle_t xTaskToQuery, BaseType_t xIndex )
 
```
Rhino接口替换说明：  
![](https://i.imgur.com/sIgUoFj.png)


##### 3.1.2.14 uxTaskGetSystemState

FreeRTOS接口：  

```  
UBaseType_t uxTaskGetSystemState( TaskStatus_t * const pxTaskStatusArray, const UBaseType_t uxArraySize, uint32_t * const pulTotalRunTime )
 
```
Rhino接口替换说明：  
![](https://i.imgur.com/gr84fne.png)


##### 3.1.2.15 vTaskGetInfo

FreeRTOS接口：  
```  
void vTaskGetInfo( TaskHandle_t xTask, TaskStatus_t *pxTaskStatus, BaseType_t xGetFreeStackSpace, eTaskState eState )
 
```
Rhino接口替换说明：  

![](https://i.imgur.com/mxkbXIB.png)

##### 3.1.2.16 xTaskGetApplicationTaskTag
FreeRTOS接口：  
```  
TaskHookFunction_t xTaskGetApplicationTaskTag( TaskHandle_t xTask )
 
```
Rhino接口替换说明：  

![](https://i.imgur.com/c4MdAAN.png)  


##### 3.1.2.17 xTaskGetCurrentTaskHandle

FreeRTOS接口：  
```  
TaskHandle_t xTaskGetCurrentTaskHandle( void )
 
```
Rhino接口替换说明：  

![](https://i.imgur.com/9neOh3F.png)


##### 3.1.2.18 xTaskGetHandle
FreeRTOS接口：  
```  
TaskHandle_t xTaskGetHandle( const char *pcNameToQuery )
 
```
Rhino接口替换说明：  

![](https://i.imgur.com/C2gTjta.png)


##### 3.1.2.19 xTaskGetIdleTaskHandle

FreeRTOS接口：  
```  
TaskHandle_t xTaskGetIdleTaskHandle( void )
 
```
Rhino接口替换说明：  
![](https://i.imgur.com/FcRybVd.png)


##### 3.1.2.20 uxTaskGetStackHighWaterMark

FreeRTOS接口：  
```  
UBaseType_t uxTaskGetStackHighWaterMark( TaskHandle_t xTask )
 
```
Rhino接口替换说明：  

![](https://i.imgur.com/FFbBXPe.png)

##### 3.1.2.21 eTaskGetState
FreeRTOS接口：  
```  
eTaskState eTaskGetState( TaskHandle_t xTask )
 
```
Rhino接口替换说明：  

![](https://i.imgur.com/eqYU0KL.png)


##### 3.1.2.22 pcTaskGetName
FreeRTOS接口：  

```  
char *pcTaskGetName( TaskHandle_t xTaskToQuery )
 
```
Rhino接口替换说明：  
![](https://i.imgur.com/N1zGG6P.png)

##### 3.1.2.23 xTaskGetTickCount
FreeRTOS接口：  
```  
TickType_t xTaskGetTickCount( void )
 
```
Rhino接口替换说明：  
![](https://i.imgur.com/EXrogOb.png)

##### 3.1.2.24 xTaskGetTickCountFromISR

FreeRTOS接口：  
```  
TickType_t xTaskGetTickCountFromISR( void )
 
```
Rhino接口替换说明：  

![](https://i.imgur.com/C0N1iKG.png)



##### 3.1.2.25 vTaskList

FreeRTOS接口：  
```  
void vTaskList( char * pcWriteBuffer )
 
```
Rhino接口替换说明：  

![](https://i.imgur.com/KLvUsAj.png)


##### 3.1.2.26 xTaskCallApplicationTaskHook

FreeRTOS接口：  
```  
BaseType_t xTaskCallApplicationTaskHook( TaskHandle_t xTask, void *pvParameter )
 
```
Rhino接口替换说明：  
![](https://i.imgur.com/AX1OVm0.png)


##### 3.1.2.27 vTaskSetApplicationTaskTag

FreeRTOS接口：  
```  
void vTaskSetApplicationTaskTag( TaskHandle_t xTask, TaskHookFunction_t pxHookFunction )
 
```
Rhino接口替换说明：  

![](https://i.imgur.com/UQwGDVN.png)


##### 3.1.2.28 vTaskSetTimeOutState

FreeRTOS接口：  
```  
void vTaskSetTimeOutState( TimeOut_t * const pxTimeOut )
 
```
Rhino接口替换说明：  
![](https://i.imgur.com/QMOBKwU.png)


##### 3.1.2.29 xTaskCheckForTimeOut

FreeRTOS接口：  
```  
BaseType_t xTaskCheckForTimeOut( TimeOut_t * const pxTimeOut, TickType_t * const pxTicksToWait )
 
```
Rhino接口替换说明：  
![](https://i.imgur.com/j4pE90q.png)



##### 3.1.2.30 xTaskGetSchedulerState

FreeRTOS接口：  
```  
BaseType_t xTaskGetSchedulerState( void )
 
```
Rhino接口替换说明：  
![](https://i.imgur.com/65Yzf26.png)

##### 3.1.2.31 uxTaskGetNumberOfTasks

FreeRTOS接口：  
```  
UBaseType_t uxTaskGetNumberOfTasks( void )
 
```
Rhino接口替换说明：  

![](https://i.imgur.com/eiYFKDw.png)


##### 3.1.2.32 vTaskGetRunTimeStats

FreeRTOS接口：  
```  
void vTaskGetRunTimeStats( char *pcWriteBuffer )
 
```
Rhino接口替换说明：  
![](https://i.imgur.com/Tph6Bh8.png)

##### 3.1.2.33 taskYIELD

FreeRTOS接口：  
```  
#define taskYIELD()					portYIELD()
 
```
Rhino接口替换说明：  
![](https://i.imgur.com/Tt0lUYD.png)


##### 3.1.2.34 taskENTER_CRITICAL

FreeRTOS接口：  
```  
#define taskENTER_CRITICAL()		portENTER_CRITICAL()
 
```
Rhino接口替换说明：  

![](https://i.imgur.com/Qg1jKWq.png)



##### 3.1.2.35 taskEXIT_CRITICAL

FreeRTOS接口：  
```  
#define taskEXIT_CRITICAL()          portEXIT_CRITICAL()
 
```
Rhino接口替换说明：  

![](https://i.imgur.com/CzdTpZy.png)

##### 3.1.2.36 taskENTER_CRITICAL_FROM_ISR

FreeRTOS接口：  
```  
#define taskENTER_CRITICAL_FROM_ISR() portSET_INTERRUPT_MASK_FROM_ISR()
 
```
Rhino接口替换说明：  
![](https://i.imgur.com/uqb83ew.png)

##### 3.1.2.37 taskEXIT_CRITICAL_FROM_ISR

FreeRTOS接口：  
```  
#define taskEXIT_CRITICAL_FROM_ISR( x ) portCLEAR_INTERRUPT_MASK_FROM_ISR( x )
 
```
Rhino接口替换说明：  
![](https://i.imgur.com/3xHPvQ8.png)


##### 3.1.2.38 taskDISABLE_INTERRUPTS

FreeRTOS接口：  
```  
#define taskDISABLE_INTERRUPTS()	portDISABLE_INTERRUPTS()
 
```
Rhino接口替换说明：  
![](https://i.imgur.com/RK29J3n.png)


##### 3.1.2.39 taskENABLE_INTERRUPTS

FreeRTOS接口：  
```  
#define taskENABLE_INTERRUPTS()		portENABLE_INTERRUPTS()
 
```
Rhino接口替换说明：  
![](https://i.imgur.com/fYdt6cp.png)


##### 3.1.2.40 vTaskStartScheduler

FreeRTOS接口：  
```  
void vTaskStartScheduler( void )
 
```
Rhino接口替换说明：  
![](https://i.imgur.com/6akfMvg.png)

##### 3.1.2.41 vTaskEndScheduler

FreeRTOS接口：  
```  
void vTaskEndScheduler( void )
 
```
Rhino接口替换说明：  
![](https://i.imgur.com/JpxrQkq.png)


##### 3.1.2.42 vTaskStepTick

FreeRTOS接口：  
```  
void vTaskStepTick( const TickType_t xTicksToJump )
 
```
Rhino接口替换说明：  
![](https://i.imgur.com/OanRt5L.png)


##### 3.1.2.43 vTaskSuspendAll

FreeRTOS接口：  
```  
void vTaskSuspendAll( void )
 
```
Rhino接口替换说明：  
![](https://i.imgur.com/AwWbwY4.png)

##### 3.1.2.44 xTaskResumeAll

FreeRTOS接口：  
```  
BaseType_t xTaskResumeAll( void )
 
```
Rhino接口替换说明：  
![](https://i.imgur.com/U3EYLhr.png)


##### 3.1.2.45 xTaskCreateRestricted

FreeRTOS接口：  
```  
BaseType_t xTaskCreateRestricted( const TaskParameters_t * const pxTaskDefinition, TaskHandle_t *pxCreatedTask )
 
```
Rhino接口替换说明：  
![](https://i.imgur.com/soA2nHJ.png)


##### 3.1.2.46 vTaskAllocateMPURegions

FreeRTOS接口：  
```  
void vTaskAllocateMPURegions( TaskHandle_t xTaskToModify, const MemoryRegion_t * const xRegions )
 
```
Rhino接口替换说明：  
![](https://i.imgur.com/9ClJ7f9.png)


##### 3.1.2.47 vPortSwitchToUserMode

FreeRTOS接口：  
```  
void vPortSwitchToUserMode( void )
 
```
Rhino接口替换说明：  

![](https://i.imgur.com/jnb4QxX.png)


##### 3.1.2.48 xTaskNotifyGive

FreeRTOS接口：  
```  
#define xTaskNotifyGive( xTaskToNotify ) xTaskGenericNotify( ( xTaskToNotify ), ( 0 ), eIncrement, NULL )
BaseType_t xTaskGenericNotify( TaskHandle_t xTaskToNotify, uint32_t ulValue, eNotifyAction eAction, uint32_t *pulPreviousNotificationValue )
 
```
Rhino接口替换说明：  
![](https://i.imgur.com/RAxdWu0.png)


##### 3.1.2.49 vTaskNotifyGiveFromISR

FreeRTOS接口：  
```  
Void vTaskNotifyGiveFromISR(TaskHandle_t xTaskToNotify, BaseType_t *pxHigherPriorityTaskWoken )
 
```
Rhino接口替换说明：  
![](https://i.imgur.com/lEA3KT0.png)



##### 3.1.2.50 ulTaskNotifyTake

FreeRTOS接口：  
```  
uint32_t ulTaskNotifyTake( BaseType_t xClearCountOnExit, TickType_t xTicksToWait )
```
Rhino接口替换说明：  
![](https://i.imgur.com/5aLXRuC.png)


##### 3.1.2.51 xTaskNotify

FreeRTOS接口：  
```  
#define xTaskNotify( xTaskToNotify, ulValue, eAction ) xTaskGenericNotify( ( xTaskToNotify ), ( ulValue ), ( eAction ), NULL )
BaseType_t xTaskGenericNotify( TaskHandle_t xTaskToNotify, uint32_t ulValue, eNotifyAction eAction, uint32_t *pulPreviousNotificationValue )

```
Rhino接口替换说明：  
![](https://i.imgur.com/uOP7rX0.png)

##### 3.1.2.52 xTaskNotifyAndQuery

FreeRTOS接口：  
```  
#define xTaskNotifyAndQuery( xTaskToNotify, ulValue, eAction, pulPreviousNotifyValue ) xTaskGenericNotify( ( xTaskToNotify ), ( ulValue ), ( eAction ), ( pulPreviousNotifyValue ) )

BaseType_t xTaskGenericNotify( TaskHandle_t xTaskToNotify, uint32_t ulValue, eNotifyAction eAction, uint32_t *pulPreviousNotificationValue )

```
Rhino接口替换说明：  
![](https://i.imgur.com/Dwf2NsZ.png)


##### 3.1.2.53 xTaskNotifyAndQueryFromISR

FreeRTOS接口：  
```  
#define xTaskNotifyAndQueryFromISR(xTaskToNotify, ulValue, eAction, pulPreviousNotificationValue, pxHigherPriorityTaskWoken)
xTaskGenericNotifyFromISR( (xTaskToNotify), (ulValue), (eAction), ( pulPreviousNotificationValue ), ( pxHigherPriorityTaskWoken ) )

BaseType_t xTaskGenericNotifyFromISR( TaskHandle_t xTaskToNotify, uint32_t ulValue, eNotifyAction eAction, uint32_t *pulPreviousNotificationValue, BaseType_t *pxHigherPriorityTaskWoken )

```
Rhino接口替换说明：  
![](https://i.imgur.com/qlWhxHL.png)


##### 3.1.2.54 xTaskNotifyFromISR

FreeRTOS接口：  
```  
#define xTaskNotifyFromISR( xTaskToNotify, ulValue, eAction, pxHigherPriorityTaskWoken ) xTaskGenericNotifyFromISR( ( xTaskToNotify ), ( ulValue ), ( eAction ), NULL, ( pxHigherPriorityTaskWoken ) )

```
Rhino接口替换说明：  
![](https://i.imgur.com/BwHuWVB.png)


##### 3.1.2.55 xTaskNotifyWait

FreeRTOS接口：  
```  
BaseType_t xTaskNotifyWait( uint32_t ulBitsToClearOnEntry, uint32_t ulBitsToClearOnExit, uint32_t *pulNotificationValue, TickType_t xTicksToWait )

```
Rhino接口替换说明：  
![](https://i.imgur.com/qEwNI5v.png)

##### 3.1.2.56 xTaskNotifyStateClear

FreeRTOS接口：  
```  
BaseType_t xTaskNotifyStateClear( TaskHandle_t xTask )
```
Rhino接口替换说明：  
![](https://i.imgur.com/unoSUpH.png)



### 3.2 Buf Queue API  

#### 3.2.1 整体API对比 
Buf Queue 内部包含了一个FIFO缓冲区，每一次发送数据包到Buf Queue都会把整包数据发送到FIFO内部，取数据包的时候再从内部FIFO缓冲区copy数据出来，优点是使用方便，缺点是发送和接收数据包，涉及到两次copy数据，效率是问题。  

![](https://i.imgur.com/GPvmUpY.png)
![](https://i.imgur.com/VMEVypo.png)
![](https://i.imgur.com/RBSkfGb.png)

#### 3.2.2 具体接口详述 

##### 3.2.2.1 xQueueCreate

FreeRTOS接口：  
```  
#define xQueueCreate( uxQueueLength, uxItemSize ) xQueueGenericCreate( ( uxQueueLength ), ( uxItemSize ), ( queueQUEUE_TYPE_BASE ) )

QueueHandle_t xQueueGenericCreate( const UBaseType_t uxQueueLength, const UBaseType_t uxItemSize, const uint8_t ucQueueType )

```
Rhino接口替换说明：  
![](https://i.imgur.com/iITWs9a.png)


##### 3.2.2.2 xQueueCreateStatic

FreeRTOS接口：  
```  
#define xQueueCreateStatic( uxQueueLength, uxItemSize, pucQueueStorage, pxQueueBuffer ) xQueueGenericCreateStatic( ( uxQueueLength ), ( uxItemSize ), ( pucQueueStorage ), ( pxQueueBuffer ), ( queueQUEUE_TYPE_BASE ) )

QueueHandle_t xQueueGenericCreateStatic( const UBaseType_t uxQueueLength, const UBaseType_t uxItemSize, uint8_t *pucQueueStorage, StaticQueue_t *pxStaticQueue, const uint8_t ucQueueType )

```
Rhino接口替换说明：  
![](https://i.imgur.com/rlKp4Wk.png)

##### 3.2.2.3 vQueueDelete

FreeRTOS接口：  
```  
void vQueueDelete( QueueHandle_t xQueue )
```
Rhino接口替换说明：  
![](https://i.imgur.com/mM1nP4S.png)

##### 3.2.2.4 xQueueSend

FreeRTOS接口：  
```  
#define xQueueSend( xQueue, pvItemToQueue, xTicksToWait ) xQueueGenericSend( ( xQueue ), ( pvItemToQueue ), ( xTicksToWait ), queueSEND_TO_BACK )

BaseType_t xQueueGenericSend( QueueHandle_t xQueue, const void * const pvItemToQueue, TickType_t xTicksToWait, const BaseType_t xCopyPosition )

```
Rhino接口替换说明：  
![](https://i.imgur.com/1Pu9A4A.png)

##### 3.2.2.5 xQueueSendFromISR

FreeRTOS接口：  
```  
#define xQueueSendFromISR( xQueue, pvItemToQueue, pxHigherPriorityTaskWoken ) xQueueGenericSendFromISR( ( xQueue ), ( pvItemToQueue ), ( pxHigherPriorityTaskWoken ), queueSEND_TO_BACK )

BaseType_t xQueueGenericSendFromISR( QueueHandle_t xQueue, const void * const pvItemToQueue, BaseType_t * const pxHigherPriorityTaskWoken, const BaseType_t xCopyPosition )

```
Rhino接口替换说明：  

![](https://i.imgur.com/n2DJirX.png)



##### 3.2.2.6 xQueueSendToBack

FreeRTOS接口：  
```  
#define xQueueSendToBack( xQueue, pvItemToQueue, xTicksToWait ) xQueueGenericSend( ( xQueue ), ( pvItemToQueue ), ( xTicksToWait ), queueSEND_TO_BACK )

BaseType_t xQueueGenericSend( QueueHandle_t xQueue, const void * const pvItemToQueue, TickType_t xTicksToWait, const BaseType_t xCopyPosition )

```
Rhino接口替换说明：  
![](https://i.imgur.com/Bmscnur.png)


##### 3.2.2.7 xQueueSendToBackFromISR

FreeRTOS接口：  
```  
#define xQueueSendToBackFromISR( xQueue, pvItemToQueue, pxHigherPriorityTaskWoken ) xQueueGenericSendFromISR( ( xQueue ), ( pvItemToQueue ), ( pxHigherPriorityTaskWoken ), queueSEND_TO_BACK )

BaseType_t xQueueGenericSendFromISR( QueueHandle_t xQueue, const void * const pvItemToQueue, BaseType_t * const pxHigherPriorityTaskWoken, const BaseType_t xCopyPosition )

```
Rhino接口替换说明：  
![](https://i.imgur.com/hbrjHDS.png)


##### 3.2.2.8 xQueueSendToFront

FreeRTOS接口：  
```  
#define xQueueSendToFront( xQueue, pvItemToQueue, xTicksToWait ) xQueueGenericSend( ( xQueue ), ( pvItemToQueue ), ( xTicksToWait ), queueSEND_TO_FRONT )

BaseType_t xQueueGenericSend( QueueHandle_t xQueue, const void * const pvItemToQueue, TickType_t xTicksToWait, const BaseType_t xCopyPosition )

```
Rhino接口替换说明：  
![](https://i.imgur.com/bqga28L.png)

##### 3.2.2.9 xQueueSendToFrontFromISR

FreeRTOS接口：  
```  
#define xQueueSendToFrontFromISR( xQueue, pvItemToQueue, pxHigherPriorityTaskWoken ) xQueueGenericSendFromISR( ( xQueue ), ( pvItemToQueue ), ( pxHigherPriorityTaskWoken ), queueSEND_TO_FRONT )

BaseType_t xQueueGenericSendFromISR( QueueHandle_t xQueue, const void * const pvItemToQueue, BaseType_t * const pxHigherPriorityTaskWoken, const BaseType_t xCopyPosition )

```
Rhino接口替换说明：  
![](https://i.imgur.com/CJsfB1w.png)

##### 3.2.2.10 xQueueReceive

FreeRTOS接口：  
```  
BaseType_t xQueueReceive( QueueHandle_t xQueue, void * const pvBuffer, TickType_t xTicksToWait )
```
Rhino接口替换说明：  

![](https://i.imgur.com/j4mfGES.png)

##### 3.2.2.11 xQueueReceiveFromISR

FreeRTOS接口：  
``` 
BaseType_t xQueueReceiveFromISR( QueueHandle_t xQueue, void * const pvBuffer, BaseType_t * const pxHigherPriorityTaskWoken )
```
Rhino接口替换说明：  
![](https://i.imgur.com/mtywR14.png)

##### 3.2.2.12 uxQueueMessagesWaiting

FreeRTOS接口：  
```  
UBaseType_t uxQueueMessagesWaiting( const QueueHandle_t xQueue )
```
Rhino接口替换说明：  
![](https://i.imgur.com/W52sP1B.png)


##### 3.2.2.13 uxQueueSpacesAvailable

FreeRTOS接口：  
```  
UBaseType_t uxQueueMessagesWaiting( const QueueHandle_t xQueue )
```
Rhino接口替换说明：  
![](https://i.imgur.com/I7UvthD.png)



##### 3.2.2.14 xQueueReset

FreeRTOS接口：  
```  
#define xQueueReset( xQueue ) xQueueGenericReset( xQueue, pdFALSE )
BaseType_t MPU_xQueueGenericReset( QueueHandle_t pxQueue, BaseType_t xNewQueue )

```
Rhino接口替换说明：  
![](https://i.imgur.com/G7bg9K5.png)



##### 3.2.2.15 xQueueOverwrite

FreeRTOS接口：  
```  
#define xQueueOverwrite( xQueue, pvItemToQueue ) xQueueGenericSend( ( xQueue ), ( pvItemToQueue ), 0, queueOVERWRITE )

BaseType_t xQueueGenericSend( QueueHandle_t xQueue, const void * const pvItemToQueue, TickType_t xTicksToWait, const BaseType_t xCopyPosition )

```
Rhino接口替换说明：  
![](https://i.imgur.com/E5Tn66i.png)

##### 3.2.2.16 xQueueOverwriteFromISR

FreeRTOS接口：  
```  
#define xQueueOverwriteFromISR( xQueue, pvItemToQueue, pxHigherPriorityTaskWoken ) xQueueGenericSendFromISR( ( xQueue ), ( pvItemToQueue ), ( pxHigherPriorityTaskWoken ), queueOVERWRITE )

BaseType_t xQueueGenericSendFromISR( QueueHandle_t xQueue, const void * const pvItemToQueue, BaseType_t * const pxHigherPriorityTaskWoken, const BaseType_t xCopyPosition )

```
Rhino接口替换说明：  

![](https://i.imgur.com/sWLHPSL.png)


##### 3.2.2.17 xQueuePeek

FreeRTOS接口：  
```  
BaseType_t xQueuePeek( QueueHandle_t xQueue, void * const pvBuffer, TickType_t xTicksToWait )
```
Rhino接口替换说明：  
![](https://i.imgur.com/mRjaaoE.png)

##### 3.2.2.18 xQueuePeekFromISR

FreeRTOS接口：  
```  
BaseType_t xQueuePeekFromISR( QueueHandle_t xQueue,  void * const pvBuffer )
```
Rhino接口替换说明：  
![](https://i.imgur.com/ejBGObN.png)


##### 3.2.2.19 vQueueAddToRegistry

FreeRTOS接口：  
``` 
void vQueueAddToRegistry( QueueHandle_t xQueue, const char *pcQueueName )
```
Rhino接口替换说明：  
![](https://i.imgur.com/Fa2qAGy.png)


##### 3.2.2.20 vQueueUnregisterQueue

FreeRTOS接口：  
```  
void vQueueUnregisterQueue( QueueHandle_t xQueue )
```
Rhino接口替换说明：  
![](https://i.imgur.com/D5oEPN6.png)



##### 3.2.2.21 pcQueueGetName

FreeRTOS接口：  
```  
const char *pcQueueGetName( QueueHandle_t xQueue )
```
Rhino接口替换说明：  

![](https://i.imgur.com/ro9UDFK.png)



##### 3.2.2.22 xQueueIsQueueFullFromISR

FreeRTOS接口：  
```  
BaseType_t xQueueIsQueueFullFromISR( const QueueHandle_t xQueue )
```
Rhino接口替换说明：  

![](https://i.imgur.com/FY7ZE0W.png)


##### 3.2.2.23 xQueueIsQueueEmptyFromISR

FreeRTOS接口：  
```  
BaseType_t xQueueIsQueueEmptyFromISR( const QueueHandle_t xQueue )
```
Rhino接口替换说明：  

![](https://i.imgur.com/hr0Ap0c.png)


##### 3.2.2.24 xQueueCreateSet

FreeRTOS接口：  
```  
QueueSetHandle_t xQueueCreateSet( const UBaseType_t uxEventQueueLength )
```
Rhino接口替换说明：  
![](https://i.imgur.com/bwwr6u9.png)


##### 3.2.2.25 xQueueRemoveFromSet

FreeRTOS接口：  
```  
BaseType_t xQueueRemoveFromSet( QueueSetMemberHandle_t xQueueOrSemaphore, QueueSetHandle_t xQueueSet )
```
Rhino接口替换说明：  
![](https://i.imgur.com/POPzbzq.png)



##### 3.2.2.26 xQueueSelectFromSet

FreeRTOS接口：  
``` 
QueueSetMemberHandle_t xQueueSelectFromSet( QueueSetHandle_t xQueueSet, TickType_t const xTicksToWait )
```
Rhino接口替换说明：  
![](https://i.imgur.com/M6yDdc3.png)

##### 3.2.2.27 xQueueSelectFromSetFromISR

FreeRTOS接口：  
``` 
QueueSetMemberHandle_t xQueueSelectFromSetFromISR( QueueSetHandle_t xQueueSet )
```
Rhino接口替换说明：  
![](https://i.imgur.com/YnKcoE5.png)



### 3.3 Queue API

#### 3.3.1 整体API对比
Queue内部也有一个FIFO缓冲区, 每一次发送数据包到Queue只会把数据包的地址发送进去，也就是发送一个指针进去，取数据的时候也是只接收一个指针，效率会很快。Queue的设计解决了效率问题，但是使用上Queue稍微没有Buf Queue方便。  
![](https://i.imgur.com/CMuFAU8.png)

#### 3.3.2 具体接口详述

由于FreeRTOS无该功能，此模块不在此赘述。  
  

### 3.4 Semaphore & Mutex API  

#### 3.4.1 整体API对比

![](https://i.imgur.com/Xc9tF9b.png)
![](https://i.imgur.com/GFnxgc8.png)

#### 3.4.2 具体接口详述  

##### 3.4.2.1 xSemaphoreCreateBinary

FreeRTOS接口：  
```  
#define xSemaphoreCreateBinary() xQueueGenericCreate( ( UBaseType_t ) 1, semSEMAPHORE_QUEUE_ITEM_LENGTH, queueQUEUE_TYPE_BINARY_SEMAPHORE )

QueueHandle_t xQueueGenericCreate( const UBaseType_t uxQueueLength, const UBaseType_t uxItemSize, const uint8_t ucQueueType )

```
Rhino接口替换说明：  

![](https://i.imgur.com/pROdyM1.png)



##### 3.4.2.2 xSemaphoreCreateBinaryStatic

FreeRTOS接口：  
``` 
#define xSemaphoreCreateBinaryStatic( pxStaticSemaphore ) xQueueGenericCreateStatic( ( UBaseType_t ) 1, semSEMAPHORE_QUEUE_ITEM_LENGTH, NULL, pxStaticSemaphore, queueQUEUE_TYPE_BINARY_SEMAPHORE )

QueueHandle_t xQueueGenericCreateStatic( const UBaseType_t uxQueueLength, const UBaseType_t uxItemSize, uint8_t *pucQueueStorage, StaticQueue_t *pxStaticQueue, const uint8_t ucQueueType )

```
Rhino接口替换说明：  
![](https://i.imgur.com/ejzFecc.png)


##### 3.4.2.3 xSemaphoreCreateCounting

FreeRTOS接口：  
``` 
#define xSemaphoreCreateCounting( uxMaxCount, uxInitialCount ) xQueueCreateCountingSemaphore( ( uxMaxCount ), ( uxInitialCount ) )

QueueHandle_t xQueueCreateCountingSemaphore( const UBaseType_t uxMaxCount, const UBaseType_t uxInitialCount )

```
Rhino接口替换说明：  
![](https://i.imgur.com/H77tGez.png)


##### 3.4.2.4 xSemaphoreCreateCountingStatic

FreeRTOS接口：  
```  
#define xSemaphoreCreateCountingStatic( uxMaxCount, uxInitialCount, pxSemaphoreBuffer ) xQueueCreateCountingSemaphoreStatic( ( uxMaxCount ), ( uxInitialCount ), ( pxSemaphoreBuffer ) )

QueueHandle_t xQueueCreateCountingSemaphoreStatic( const UBaseType_t uxMaxCount, const UBaseType_t uxInitialCount, StaticQueue_t *pxStaticQueue )

```
Rhino接口替换说明：  
![](https://i.imgur.com/gEUg8GS.png)

##### 3.4.2.5 xSemaphoreCreateMutex

FreeRTOS接口：  
``` 
#define xSemaphoreCreateMutex() xQueueCreateMutex( queueQUEUE_TYPE_MUTEX )

QueueHandle_t xQueueCreateMutex( const uint8_t ucQueueType )

```
Rhino接口替换说明：  
![](https://i.imgur.com/x5Qjaw4.png)


##### 3.4.2.6 xSemaphoreCreateMutexStatic

FreeRTOS接口：  
```  
#define xSemaphoreCreateMutexStatic( pxMutexBuffer ) xQueueCreateMutexStatic( queueQUEUE_TYPE_MUTEX, ( pxMutexBuffer ) )

QueueHandle_t xQueueCreateMutexStatic( const uint8_t ucQueueType, StaticQueue_t *pxStaticQueue )

```
Rhino接口替换说明：  
![](https://i.imgur.com/tKTl1fS.png)


##### 3.4.2.7 xSemCreateRecursiveMutex

FreeRTOS接口：  
``` 
#define xSemaphoreCreateRecursiveMutex() xQueueCreateMutex( queueQUEUE_TYPE_RECURSIVE_MUTEX )

QueueHandle_t xQueueCreateMutex( const uint8_t ucQueueType )

```
Rhino接口替换说明：  
![](https://i.imgur.com/fLR1n3G.png)



##### 3.4.2.8 xSemCreateRecursiveMutexStatic

FreeRTOS接口：  
```  
#define xSemaphoreCreateRecursiveMutexStatic( pxStaticSemaphore ) xQueueCreateMutexStatic( queueQUEUE_TYPE_RECURSIVE_MUTEX, pxStaticSemaphore )

QueueHandle_t xQueueCreateMutexStatic( const uint8_t ucQueueType, StaticQueue_t *pxStaticQueue )

```
Rhino接口替换说明：  

![](https://i.imgur.com/XCmUWtM.png)

##### 3.4.2.9 vSemaphoreDelete

FreeRTOS接口：  
```  
#define vSemaphoreDelete( xSemaphore ) vQueueDelete( ( QueueHandle_t ) ( xSemaphore ) )

void vQueueDelete( QueueHandle_t xQueue )

```
Rhino接口替换说明：  
![](https://i.imgur.com/XmWnJSb.png)



##### 3.4.2.10 xSemaphoreGetMutexHolder

FreeRTOS接口：  
```  
#define xSemaphoreGetMutexHolder( xSemaphore ) xQueueGetMutexHolder( ( xSemaphore ) )
void* xQueueGetMutexHolder( QueueHandle_t xSemaphore )

```
Rhino接口替换说明：  
![](https://i.imgur.com/Mp8UW8O.png)


##### 3.4.2.11 uxSemaphoreGetCount

FreeRTOS接口：  
``` 
#define uxSemaphoreGetCount( xSemaphore ) uxQueueMessagesWaiting( ( QueueHandle_t ) ( xSemaphore ) )

UBaseType_t uxQueueMessagesWaiting( const QueueHandle_t xQueue )

```
Rhino接口替换说明：  
![](https://i.imgur.com/fHdaHY5.png)


##### 3.4.2.12 xSemaphoreTake

FreeRTOS接口：  
```  
#define xSemaphoreTake( xSemaphore, xBlockTime )   \
xQueueSemaphoreTake( ( xSemaphore ), ( xBlockTime ) )

BaseType_t xQueueSemaphoreTake( QueueHandle_t xQueue, TickType_t xTicksToWait )

```
Rhino接口替换说明：  
![](https://i.imgur.com/veIy7hz.png)



##### 3.4.2.13 xSemaphoreTakeRecursive

FreeRTOS接口：    
``` 
#define xSemaphoreTakeRecursive( xMutex, xBlockTime )  \
xQueueTakeMutexRecursive( ( xMutex ), ( xBlockTime ) )

BaseType_t xQueueTakeMutexRecursive( QueueHandle_t xMutex, TickType_t xTicksToWait )

```
Rhino接口替换说明：  
![](https://i.imgur.com/FYipMlK.png)



##### 3.4.2.14 xSemaphoreTakeFromISR

FreeRTOS接口：  
``` 
#define xSemaphoreTakeFromISR( xSemaphore, pxHigherPriorityTaskWoken )    \
xQueueReceiveFromISR( ( QueueHandle_t ) ( xSemaphore ), NULL, ( pxHigherPriorityTaskWoken ) )

BaseType_t xQueueReceiveFromISR( QueueHandle_t xQueue, void * const pvBuffer, BaseType_t * const pxHigherPriorityTaskWoken )

```
Rhino接口替换说明：  
![](https://i.imgur.com/DThCBi9.png)

##### 3.4.2.15 xSemaphoreGive

FreeRTOS接口：  
```  
#define xSemaphoreGive( xSemaphore )   \
xQueueGenericSend( ( QueueHandle_t ) ( xSemaphore ), NULL, semGIVE_BLOCK_TIME, queueSEND_TO_BACK )

BaseType_t xQueueGenericSend( QueueHandle_t xQueue, const void * const pvItemToQueue, TickType_t xTicksToWait, const BaseType_t xCopyPosition )

```
Rhino接口替换说明：  
![](https://i.imgur.com/8esEHEP.png)


##### 3.4.2.16 xSemaphoreGiveRecursive

FreeRTOS接口：  
``` 
#define xSemaphoreGiveRecursive( xMutex )      xQueueGiveMutexRecursive( ( xMutex ) )

BaseType_t xQueueGiveMutexRecursive( QueueHandle_t xMutex )

```  
Rhino接口替换说明：  
![](https://i.imgur.com/p6mHQZD.png)

##### 3.4.2.17 xSemaphoreGiveFromISR

FreeRTOS接口：  
```  
#define xSemaphoreGiveFromISR( xSemaphore, pxHigherPriorityTaskWoken )   \
xQueueGiveFromISR( ( QueueHandle_t ) ( xSemaphore ), ( pxHigherPriorityTaskWoken ) )

BaseType_t xQueueGiveFromISR( QueueHandle_t xQueue, BaseType_t * const pxHigherPriorityTaskWoken )

```
Rhino接口替换说明：  

![](https://i.imgur.com/nI4H2rS.png)




### 3.5 Timer API
#### 3.5.1 整体API对比  
![](https://i.imgur.com/jBY6xM1.png)
![](https://i.imgur.com/EqEF5dl.png)
![](https://i.imgur.com/MCoj3G5.png)


#### 3.5.2 具体接口详述  

##### 3.5.2.1 xTimerCreate

FreeRTOS接口：  
```  
TimerHandle_t xTimerCreate(	const char * const pcTimerName,											          const TickType_t xTimerPeriodInTicks,
								const UBaseType_t uxAutoReload,
								void * const pvTimerID,
								TimerCallbackFunction_t pxCallbackFunction )
```
Rhino接口替换说明：  

![](https://i.imgur.com/k2XKh8o.png)


##### 3.5.2.2 xTimerCreateStatic

FreeRTOS接口：  
```  
TimerHandle_t xTimerCreateStatic(	const char * const pcTimerName,	
										const TickType_t xTimerPeriodInTicks,
										const UBaseType_t uxAutoReload,
										void * const pvTimerID,
										TimerCallbackFunction_t pxCallbackFunction,
										StaticTimer_t *pxTimerBuffer )
```
Rhino接口替换说明：  

![](https://i.imgur.com/D5TTE1W.png)


##### 3.5.2.3 xTimerIsTimerActive

FreeRTOS接口：  
```  
BaseType_t xTimerIsTimerActive( TimerHandle_t xTimer )
```
Rhino接口替换说明：  

![](https://i.imgur.com/CRAyAcG.png)


##### 3.5.2.4 xTimerStart

FreeRTOS接口：  
```  
#define xTimerStart( xTimer, xTicksToWait )      \
xTimerGenericCommand( (xTimer), tmrCOMMAND_START, ( xTaskGetTickCount() ), NULL, ( xTicksToWait ) )

```
Rhino接口替换说明：  

![](https://i.imgur.com/ELlFWuI.png)


##### 3.5.2.5 xTimerStop

FreeRTOS接口：  
```  
#define xTimerStop( xTimer, xTicksToWait ) xTimerGenericCommand( ( xTimer ), tmrCOMMAND_STOP, 0U, NULL, ( xTicksToWait ) )
```
Rhino接口替换说明：  
![](https://i.imgur.com/dEdjWxD.png)


##### 3.5.2.6 xTimerChangePeriod

FreeRTOS接口：  
```  
#define xTimerChangePeriod( xTimer, xNewPeriod, xTicksToWait ) xTimerGenericCommand( ( xTimer ), tmrCOMMAND_CHANGE_PERIOD, ( xNewPeriod ), NULL, ( xTicksToWait ) )
```
Rhino接口替换说明：  
![](https://i.imgur.com/frlnRgw.png)


##### 3.5.2.7 xTimerDelete

FreeRTOS接口：  
```  
#define xTimerDelete( xTimer, xTicksToWait ) xTimerGenericCommand( ( xTimer ), tmrCOMMAND_DELETE, 0U, NULL, ( xTicksToWait ) )
```
Rhino接口替换说明：  
![](https://i.imgur.com/t2UjSAQ.png)




##### 3.5.2.8 xTimerReset

FreeRTOS接口：  
```  
#define xTimerReset( xTimer, xTicksToWait ) xTimerGenericCommand( ( xTimer ), tmrCOMMAND_RESET, ( xTaskGetTickCount() ), NULL, ( xTicksToWait ) )
```
Rhino接口替换说明：  
![](https://i.imgur.com/GG114Vn.png)



##### 3.5.2.9 xTimerStartFromISR

FreeRTOS接口：  
```  
#define xTimerStartFromISR( xTimer, pxHigherPriorityTaskWoken )               \
xTimerGenericCommand( ( xTimer ), tmrCOMMAND_START_FROM_ISR,          \
( xTaskGetTickCountFromISR() ), ( pxHigherPriorityTaskWoken ), 0U )

```
Rhino接口替换说明：  
![](https://i.imgur.com/hZLwJ4B.png)


##### 3.5.2.10 xTimerStopFromISR

FreeRTOS接口：  
```  
#define xTimerStopFromISR( xTimer, pxHigherPriorityTaskWoken )                \
xTimerGenericCommand( ( xTimer ), tmrCOMMAND_STOP_FROM_ISR,            \
0, ( pxHigherPriorityTaskWoken ), 0U )

```
Rhino接口替换说明：  
![](https://i.imgur.com/ETQzITv.png)


##### 3.5.2.11 xTimerChangePeriodFromISR

FreeRTOS接口：  
```  
#define xTimerChangePeriodFromISR( xTimer, xNewPeriod, pxHigherPriorityTaskWoken )    \
xTimerGenericCommand( ( xTimer ), tmrCOMMAND_CHANGE_PERIOD_FROM_ISR,        \
( xNewPeriod ), ( pxHigherPriorityTaskWoken ), 0U )

```
Rhino接口替换说明：  
![](https://i.imgur.com/tUmNtv2.png)




##### 3.5.2.12 pcTimerGetName

FreeRTOS接口：  
```  
const char * pcTimerGetName( TimerHandle_t xTimer )

```
Rhino接口替换说明：  
![](https://i.imgur.com/ccVOWz9.png)




##### 3.5.2.13 xTimerResetFromISR

FreeRTOS接口：  
```  
#define xTimerResetFromISR( xTimer, pxHigherPriorityTaskWoken )                    \
xTimerGenericCommand( ( xTimer ), tmrCOMMAND_RESET_FROM_ISR,                \
( xTaskGetTickCountFromISR() ), ( pxHigherPriorityTaskWoken ), 0U )

```
Rhino接口替换说明：  
![](https://i.imgur.com/SPgHdiZ.png)



##### 3.5.2.14 pvTimerGetTimerID

FreeRTOS接口：  
```  
void *pvTimerGetTimerID( const TimerHandle_t xTimer )
```
Rhino接口替换说明：  
![](https://i.imgur.com/6KY3c3k.png)

##### 3.5.2.15 vTimerSetTimerID

FreeRTOS接口：  
```  
void vTimerSetTimerID( TimerHandle_t xTimer, void *pvNewID )
```
Rhino接口替换说明：  
![](https://i.imgur.com/tbPKck9.png)


##### 3.5.2.16 xTimerGetPeriod

FreeRTOS接口：  
```  
TickType_t xTimerGetPeriod( TimerHandle_t xTimer )
```
Rhino接口替换说明：  
![](https://i.imgur.com/rYA5MFd.png)



##### 3.5.2.17 xTimerGetExpiryTime

FreeRTOS接口：  
```  
TickType_t xTimerGetExpiryTime( TimerHandle_t xTimer )
```
Rhino接口替换说明：  
![](https://i.imgur.com/zHjFmIP.png)

##### 3.5.2.18 xTimerPendFunctionCall

FreeRTOS接口：  
```  
BaseType_t xTimerPendFunctionCall( PendedFunction_t xFunctionToPend, void *pvParameter1, uint32_t ulParameter2, TickType_t xTicksToWait )
```
Rhino接口替换说明：  

![](https://i.imgur.com/FGUbyvQ.png)


##### 3.5.2.19 xTimerPendFunctionCallFromISR

FreeRTOS接口：  
```  
BaseType_t xTimerPendFunctionCallFromISR( PendedFunction_t xFunctionToPend, void *pvParameter1, uint32_t ulParameter2, BaseType_t *pxHigherPriorityTaskWoken )
```
Rhino接口替换说明：  
![](https://i.imgur.com/gBQGluf.png)


### 3.6 Event API

#### 3.6.1 整体API对比

![](https://i.imgur.com/mtc6T7K.png)

#### 3.6.2 具体接口详述

##### 3.6.2.1 xEventGroupCreate

FreeRTOS接口：  
```  
EventGroupHandle_t xEventGroupCreate( void )
```
Rhino接口替换说明：  
![](https://i.imgur.com/PpXcyBG.png)


##### 3.6.2.2 xEventGroupCreateStatic

FreeRTOS接口：  
```  
EventGroupHandle_t xEventGroupCreateStatic( StaticEventGroup_t *pxEventGroupBuffer )
```
Rhino接口替换说明：  
![](https://i.imgur.com/I5tO36p.png)



##### 3.6.2.3 vEventGroupDelete

FreeRTOS接口：  
```  
void vEventGroupDelete( EventGroupHandle_t xEventGroup )
```
Rhino接口替换说明：  

![](https://i.imgur.com/2Ynq756.png)



##### 3.6.2.4 xEventGroupWaitBits

FreeRTOS接口：  
```  
EventBits_t xEventGroupWaitBits( EventGroupHandle_t xEventGroup, const EventBits_t uxBitsToWaitFor, const BaseType_t xClearOnExit, const BaseType_t xWaitForAllBits, TickType_t xTicksToWait )
```
Rhino接口替换说明：  
![](https://i.imgur.com/WAaAZXl.png)


##### 3.6.2.5 xEventGroupSetBits

FreeRTOS接口：  
```  
EventBits_t xEventGroupSetBits( EventGroupHandle_t xEventGroup, const EventBits_t uxBitsToSet )
```
Rhino接口替换说明：  
![](https://i.imgur.com/6lXloZb.png)




##### 3.6.2.6 xEventGroupSetBitsFromISR

FreeRTOS接口：  
```  
BaseType_t xEventGroupSetBitsFromISR( EventGroupHandle_t xEventGroup, const EventBits_t uxBitsToSet, BaseType_t *pxHigherPriorityTaskWoken )
```
Rhino接口替换说明：  
![](https://i.imgur.com/IPC6LUw.png)




##### 3.6.2.7 xEventGroupClearBits

FreeRTOS接口：  
```  
EventBits_t xEventGroupClearBits( EventGroupHandle_t xEventGroup, const EventBits_t uxBitsToClear )
```
Rhino接口替换说明：  
![](https://i.imgur.com/7QwsaOM.png)


##### 3.6.2.8 xEventGroupClearBitsFromISR

FreeRTOS接口：  
```  
BaseType_t xEventGroupClearBitsFromISR( EventGroupHandle_t xEventGroup, const EventBits_t uxBitsToClear )
```
Rhino接口替换说明：  
![](https://i.imgur.com/9mV0CQv.png)


##### 3.6.2.9 xEventGroupGetBits

FreeRTOS接口：  
```  
#define xEventGroupGetBits( xEventGroup ) xEventGroupClearBits( xEventGroup, 0 )

EventBits_t xEventGroupClearBits( EventGroupHandle_t xEventGroup, const EventBits_t uxBitsToClear )

```
Rhino接口替换说明：  
![](https://i.imgur.com/YqPeFhf.png)


##### 3.6.2.10 xEventGroupGetBitsFromISR

FreeRTOS接口：  
```  
EventBits_t xEventGroupGetBitsFromISR( EventGroupHandle_t xEventGroup )

```
Rhino接口替换说明：  
![](https://i.imgur.com/gLzlhl9.png)



##### 3.6.2.11 xEventGroupSync

FreeRTOS接口：  
```  
EventBits_t xEventGroupSync( EventGroupHandle_t xEventGroup, const EventBits_t uxBitsToSet, const EventBits_t uxBitsToWaitFor, TickType_t xTicksToWait )

```
Rhino接口替换说明：  
![](https://i.imgur.com/Ychbcbn.png)



### 3.7 Co-routines API  
目前业务上不需要co-routine的实现。  
建议替换为task或者work实现。  


### 3.8 smp多核 API 

#### 3.8.1  整体API对比
![](https://i.imgur.com/KizLpv8.png)


#### 3.8.2 具体接口详述  
目前其他RTOS尚未支持该功能。  
Rhino相关Smp说明，请参考：https://yq.aliyun.com/articles/589967  


### 3.9 内核头文件包含
Krhino的头文件包含统一使用：  
```  
#include “k_api.h”
```


## 4 编译方式说明  

### 4.1 内核涉及文件部署  
（工具链\example\arch\mcu\链接脚本\初始化）  
![](https://i.imgur.com/eA3RNQL.png)
![](https://i.imgur.com/ritxVij.png)

### 4.2 Keil\iar\e2studio相关IDE  
IDE相关的编译工程都放在projects目录下，目前该目录下已经有一些示例工程，用户可以自建工程。对应的工程文件按照不同IDE的实际情况点击运行即可。  

### 4.3 Gcc(linux\vscode) 编译命令说明  

该部分在github上有详细步骤，此处不另做说明。  
Linux下编译使用快速指导： [Quick-Start](Quick-Start)    
Vscode下开发使用说明：[AliOS-Things-Studio](AliOS-Things-Studio)   

## 5 内核移植认证  

AliOS Things提供了基本的内核测试用例集，用于内核移植后的测试验证，所有移植的平台都需要运行该测试样例，确保内核功能的正确性。  
内核测试集目录：`test\testcase\certificate_test`  
在上面目录下提供了两个测试文件rhino_test.c和aos_test.c。其中rhino_test.c针对于纯内核的移植，aos_test.c针对于至少包含kernel层的移植，见章节2.8描述，其测试任务主要参考下面的《AliOS Things Kernel 测试指南参考》。  
目前主要的认证项都会带aos层，如果只关注rhino_test.c相关纯内核的验证，需要做以下修改：  
	*修改rhino_test.c配置项，如：
```  
/*以下字符定义可任取名字，不能为空*/
#define SYSINFO_ARCH        " MIPS"                    
#define SYSINFO_MCU         " RDA"
#define SYSINFO_DEVICE_NAME " RDA8955"
#define SYSINFO_APP_VERSION "1.3.0"

/*kv和yloop不属于纯krhino模块，需要关闭*/
#define TEST_CONFIG_KV_ENABLED                  (0)
#define TEST_CONFIG_YLOOP_ENABLED               (0)

```
	*将rhino_test.c和cut.c\ cut.h加入编译体系
可以将`test\testcase\certificate_test`目录下此三个直接拷贝到对应mcu下，新建一个test目录并加入到makefile；其他IDE直接添加编译文件。
	*在主任务中调用`test_certificate`执行测试用例认证直到用例通过即可。

上面属于纯krhino内核的测试方式，如果带aos接口层的测试请参考，  
AliOS Things Kernel 测试指南：[AliOS Things Kernel 测试指南](Manual-API#AliOS%20Things%20Kernel%20测试指南)  



## 6 移植问题反馈途径  
如果有移植遇到问题或者疑问，可以通过下面方式交流：  
途径1：AliOS Things github主页：https://github.com/alibaba/AliOS-Things  
途径2：钉钉群——AliOS Things 技术交流群  

