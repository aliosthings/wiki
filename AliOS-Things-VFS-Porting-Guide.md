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

第二个参数fops为设备驱动结构体，在kernel/vfs/include/device/路径下对应的头文件中已经定义好，直接使用即可。 如adc对应的fops在kernel/vfs/include/device/vfs_uart.h中，引用该目录下的vfs_device.h即可。
# 2文件系统