VFS用于为各类文件（包括设备和文件系统的文件）提供了一个统一的用户操作接口。

# 目录
  * [1 设备驱动](#1设备驱动)
  * [2 文件系统](#2文件系统)
------
# 1设备驱动
## 1.1 设备驱动对接hal层
1）打开kernel/vfs/include/device/vfs_device.h。
```C
/*
 * Copyright (C) 2015-2017 Alibaba Group Holding Limited
 */

#ifndef AOS_VFS_DEVICE_H
#define AOS_VFS_DEVICE_H

#ifdef __cplusplus
extern "C" {
#endif

#include "vfs_adc.h"
#include "vfs_gpio.h"
#include "vfs_i2c.h"
#include "vfs_pwm.h"
#include "vfs_rtc.h"
#include "vfs_spi.h"
#include "vfs_uart.h"
#include "vfs_wdg.h"

#ifdef __cplusplus
}
#endif

#endif /* AOS_VFS_DEVICE_H */
```
2）这里包含了所有支持的设备的头文件，如果包含所要使用的设备则继续，否则反馈给我们。如果所要使用的设备支持，则打开include/hal/soc/路径，找到对应的hal头文件（如uart设备则打开uart.h），并实现该头文件中所声明的所有函数。对接方法见AliOS Things HAL Porting Guide.

## 1.2 注册驱动设备
1）在kernel/vfs/include/vfs_register.h中找到注册函数
```C
int aos_register_driver(const char *path, file_ops_t *fops, void *arg)
```
第一个参数path为设备路径，如uart设备可以定义为const char* uart_path = "/dev/uart"，设备路径必须以"/"开始，总长度不能超过4096.

第二个参数fops为设备驱动结构体，在kernel/vfs/include/device/路径下对应的头文件中已经定义好，直接使用即可。 如uart对应的fops在kernel/vfs/include/device/vfs_uart.h中为uart_ops，引用该目录下的vfs_device.h即可引用该结构体。
第三个参数arg为指向设备配置信息的指针，adc的设备配置信息结构体定义在hal层include/hal/soc/uart.h中，为uart_dev_t。定义uart配置信息结构体，如定义uart_dev_t    uart_dev_test，并根据具体设备进行初始化，并调用aos_register_driver函数注册。
```C
ret = aos_register_driver（uart_path, &uart_ops, &uart_dev_test)
```
如果返回值为0则注册成功。
如果系统中有多个同类型设备，则需要对每一个设备进行注册，如存在两个uart，分别为uart1和uart2。
```C
const char* uart1_path = "/dev/uart1";
const char* uart2_path = "/dev/uart2"

i2c_dev_t uart1_dev_test =
{
    .port = PORT_UART1,
    .config.baud_rate = 115200,
    .config.data_width = DATA_WIDTH_8BIT,
    .config.parity = ODD_PARITY,
    .config.hal_uart_stop_bits_t = STOP_BITS_1,
    .config.hal_uart_flow_control_t = FLOW_CONTROL_CTS
};

i2c_dev_t uart2_dev_test =
{
    .port = PORT_UART2,
    .config.baud_rate = 460800,
    .config.data_width = DATA_WIDTH_8BIT,
    .config.parity = EVEN_PARITY,
    .config.hal_uart_stop_bits_t = STOP_BITS_1,
    .config.hal_uart_flow_control_t = FLOW_CONTROL_CTS
};

ret1 = aos_register_driver（uart1_path, &uart_ops, &uart1_dev_test);
ret2 = aos_register_driver（uart2_path, &uart_ops, &uart2_dev_test);
```
设备ops保持一致均为uart_ops，其他两个参数根据具体进行配置。注意设备配置信息中的port参数与HAL对阶层保持一致，便于驱动进行解析。
## 1.3 设备打开
```C
int fd_uart;
fd_uart = aos_open(uart_path,0);
```
第二个参数目前未使用，可直接设置为0，如果返回值大于AOS_CONFIG_VFS_FD_OFFSET则打开成功.



# 2文件系统