# 1. 概述
## 1.1 移植目标
(1)  系统能启动一个任务采用krhino_task_sleep来做定时的打印输出，比如每秒钟打印日志。  
(2)  跑通Rhino kernel的所有测试用例。

## 1.2 移植内容
(1) 硬件体系架构相关移植(目录platform/arch/*)  
(2) 时钟中断移植（在时钟中断中需要调用yunos_tick_proc）  
(3 )内存/栈溢出保护等特性移植(可选)

## 1.3 工具链
系统默认使用gcc编译，目前针对arm架构，  
系统自带工具链是gcc version 5.4.1 20160919 (release) [ARM/embedded-5-branch revision 240496],  
工具链的地址是在 aos/build/compiler/arm-none-eabi-5_4-2016q2-20160622/

## 1.4 相关目录
移植相关的代码主要存放在**arch**和**mcu**两个目录中：
* arch  
该目录主要存放硬件体系架构所需要的移植接口实现文件，  
如任务切换、启动、开关中断等（即arch/include/port.h中所定义的接口）。  
  
示例(armv5)：  
头文件：arch\arm\armv5\port*.h  
源代码：arch\arm\armv5\port下面的c文件和汇编文件。  
注：arch下的目录结构按CPU架构区分，请参照已有目录。
* mcu  
该目录主要存放厂商提供的代码或二进制文件，如系统启动、驱动、编译/链接脚本等。mcu下的目录结构按“厂商/芯片系列”进行区分。

# 2. 系统移植
## 2.1 环境配置
### 2.1.1 代码存放
硬件体系结构相关的代码存放在arch目录，如armv5  
启动、外设及驱动相关的代码存放在mcu目录，如stm32

### 2.1.2 编译配置
* IDE  
基于集成开发环境开发时需要在targets相关目录下建立编译相关的工程并把Rhino的代码添加到工程中。
* 非IDE  
此处非IDE是指直接使用Makefile构建编译系统，在这种情况下需要修改Rhino根目录下的Makefile文件，将默认的模拟linux文件替换为芯片相关文件。  
AOS采用aos-cube工具包来管理编译系统，编译命令示例：  
`aos make example_name@platform_name`  
aos-cube安装配置 (ubuntu)：  
`$ sudo apt-get install -y gcc-multilib`  
`$ sudo apt-get install -y libssl-dev libssl-dev:i386`  
`$ sudo apt-get install -y libncurses5-dev libncurses5-dev:i386`  
`$ sudo apt-get install -y libreadline-dev libreadline-dev:i386`    
`$ sudo apt-get install -y python-pip`  
`$ sudo pip install aos-cube`

## 2.2 系统启动
### 2.2.1 系统初始化
系统初始化主要是指bss、data段的初始化以及系统时钟频率等必须在系统启动之前进行的初始化操作，如中断向量表、MCU运行频率等，该部分在移植开始前均已实现。需要务必保证 bss段的清0的动作，在系统起来之前。对于cormex-m4或者cortex-m7的具备FPU的系列需要确认是否编译打开了硬浮点数的支持，如果打开了务必保证启动前硬件上对FPU做初始化。

### 2.2.2 时钟中断
* 节拍率（HZ）  
节拍率是Rhino运行的原动力，其通过系统定时器设置，通常为100，即每秒有100次系统定时中断（cortex-m中使用SysTick定时器），其宏定义为：**_YUNOS_CONFIG_TICKS_PER_SECOND_**。
* 中断处理  
为了驱动Rhino的运行，需要在中断处理函数中调用yunos_tick_proc这个函数。示例代码如下:  
```
void tick_interrupt(void) {
    yunos_intrpt_enter();
    yunos_tick_proc();
    yunos_intrpt_exit();
}
```
### 2.2.3 内核启动
内核启动的简易示例代码如下：  
```
int main(int argc, char **argv) {
    heap_init();
    driver_init();
    yunos_init(); /* app task create */
    yunos_start();
}
``` 
注意：  
**_(1) main函数中首先需要初始化堆这块，具体的注意事项请参考下面的soc_impl.c的移植。_**  
**_(2) driver_init()里面不会产生中断，不然整个系统在yunos_start()起来之前会挂掉。_**

### 2.2.4 C库移植
目前系统使用newlib仓库，newlib的移植由于具有通用性，已经统一到系统utility/libc下

## 2.3 接口移植
### 2.3.1 cpu体系架构移植
核心系统的移植主要是指实现arch port.h中所定义的接口，相关接口描述如下：
* size_t cpu_intrpt_save(void)
该接口主要完成相关寄存器的保存。

* void cpu_intrpt_restore(size_t cpsr)
该接口主要完成相关寄存器的恢复。

* void cpu_intrpt_switch(void)  
该接口主要完成中断切换时寄存器的维护。

* void cpu_task_switch(void)  
该接口主要完成任务切换。

* void cpu_first_task_start(void)  
该接口主要完成启动系统第一个任务。

* void *cpu_task_stack_init(cpu_stack_t *base,size_t size, void *arg,task_entry_t entry)  
该接口主要完成任务堆栈的初始化，其中size以**字长**为单位。

* int32_t cpu_bitmap_clz(uint32_t val)  
该接口主要是通过类似Arm中的clz指令实现位图的快速查找，在**YUNOS_CONFIG_BITMAP_HW**宏打开（置1）时实现该接口，在未打开时默认使用Rhino中的软件算法查找。

* YUNOS_INLINE uint8_t cpu_cur_get(void)  
该接口在port.h中默认的单核实现如下：
```
YUNOS_INLINE uint8_t cpu_cur_get(void) {
    return 0;
}
```
注意：  
**_上述所有的移植接口都应该在port.h里面存在，可以参考现有平台的port.h的实现。_**

### 2.3.2 内核特性移植
内核特性移植主要是通过修改k_config.h来配置kernel的模块使能。  
最简单的方法是copy一个现有工程的k_config.h来快速达到移植的目的。  
除此之外还需要实现k_soc.h里面定义的一些必要的接口，比如内存分配这块。  
最简单的方法是copy一个现有工程的soc_impl.c来快速达到移植的目的。  
**_soc_impl.c里面必须要实现的是内存分配这块的配置g_mm_region，具体的如何设置请参考相应的工程文件。_  **

### 2.3.3 调试模块移植
* 串口驱动移植  
串口主要用于打印日志。打印主要是使用printf,使用newlib的前提下需要对接_write_r这个函数。  

* C库移植  
系统使用newlib C库。newlib对接的所有函数接口在newlib_stub.c里面。  
值得一提是两个接口一个是对接printf的接口，还有一个是对接malloc的接口_malloc_r，  
移植的时候参考系统现有提供的newlib_stub.c实现。对于c库的初始化需要在汇编启动文件中调用_start来完成。  

## 2.4 移植模板
Rhino内核的移植模版主要是参照现有的工程的移植。目前移植的有armv5 以及cortex-m系列等cpu架构。 

## 2.5 驱动移植
驱动是指完成上层业务逻辑所需要的驱动，如wifi、ble等外设驱动，该部分与内核没有直接关系，可参考YOS的HAL接口设计。所有hal接口存放在include/hal下面。

# 3. 验收测试
目前Rhino已经提供了完善的kernel级别的测试用例用于测试所提供API的功能。Kernel的测试代码在kernel/rhino/test下面，测试的入口函数是test_case_task_start。