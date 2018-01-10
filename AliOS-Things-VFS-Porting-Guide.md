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
2）这里包含了所有支持的设备的头文件，如果包含所要使用的设备则继续，否则反馈给我们。如果所要使用的设备支持，则打开include/hal/soc/路径，找到对应的hal头文件（如uart设备则打开uart.h），并实现该头文件中所声明的所有函数。对接方法见hal porting guide

# 2文件系统