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

# 2文件系统