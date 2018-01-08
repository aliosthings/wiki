
### uData诞生背景
&emsp;&emsp;uData框架设计之初的思想是基于传统sensorhub概念基础之上的，结合IoT的业务场景和AliOS Things物联网操作系统的特点设计而成的一个面对IoT的感知设备处理框架。uData的主要目的是为了解决IoT端侧设备传感器开发的周期长、应用算法缺少和无云端一体化等痛点问题。
### uData概要介绍
uData设计之初是遵循分层解耦的模块化设计原则，其目的是为了让uData根据客户的不同业务和需求组件化做移植适配。下图是当前架构模块图，主要分kernel和framework两层，kernel层主要是负责传感器驱动，硬件端口配置和相关的静态校准，包括轴向校准等；framework层主要是负责应用服务管理、动态校准管理和对外模块接口等。
![](https://i.imgur.com/iSaUEYR.png)

- **uData关键模块说明**
uData，目前主要有三大模块支撑整个架构。其他模块均可以按照业务需求进行组件化配置或者增加新功能。

| 模块名 | 所在模块路径 | 具体描述|
| ---- | ---- | ---- |
| 应用服务管理模块 | framwork\service mgr | 1.管理基于传感器的应用算法数据服务，如注册等<br>2.支撑整个uData框架的事件调度机制<br>3.管理对外组件的业务需求，如订阅等 | 
| 抽象数据管理模块 | framwork\abs data model |  1.对物理传感器的抽象化管理<br>2.和实际物理传感器分离，并做1：1映射<br>3.以vfs方式和kernel层sensor进行通信|
| 传感器抽象层模块 | device\sensor\hal |  1.提供物理传感器驱动的驱动接口，如注册，创建驱动对象等<br>2.提供静态校准的配置接口，如轴向等<br>3.提供硬件配置接口，比如I2C,SPI配置相关配置 | 

- **uData数据表**
当前uData的框架中分别有三张数据表，应用服务表、抽象数据表，物理传感器表。

| 数据表 | 所在模块 | 对应数据业务 |  具体描述 |
| ---- | ---- | ---- |---- |
| 应用服务表 | framwork\service mgr | 管理基于传感器的应用算法数据表 |  g_service_db[] |
| 抽象数据表 | framwork\abs data model |  管理对物理传感器抽象的数据表|g_abs_data_db[] | 
| 物理传感器表 | device\sensor\hal |  管理系统可用的物理传感器数据表 |g_sensor_obj[] | 

- **uData数据类型**
uData主要分两种类型的数据，一种是uData的应用算法数据类型，开发者和外部模块也只和这类型的数据进行通信和交互；另外一种是物理传感器数据类别，存在于kernel的sensor驱动层，并和uData framework层进行通信和交互，暂不对外。一般情况下，每一个应用算法服务数据会订阅一个物理传感器数据，也可能一个应用算法数据基于多个物理传感器数据。

```
/* uData应用算法数据类型 */
typedef enum 
{
 UDATA_SERVICE_ACC = 0,     /* Accelerometer */ 
 UDATA_SERVICE_MAG,         /* Magnetometer */
 UDATA_SERVICE_GYRO,        /* Gyroscope */
 UDATA_SERVICE_ALS,         /* Ambient light sensor */
 UDATA_SERVICE_PS,          /* Proximity */
 UDATA_SERVICE_BARO,        /* Barometer */
 UDATA_SERVICE_TEMP,        /* Temperature  */
 UDATA_SERVICE_UV,          /* Ultraviolet */
 UDATA_SERVICE_HUMI,        /* Humidity */
 UDATA_SERVICE_HALL,        /* HALL sensor */
 UDATA_SERVICE_HR,          /* Heart Rate sensor */
 UDATA_SERVICE_PEDOMETER,   
 UDATA_SERVICE_PDR,     
 UDATA_SERVICE_VDR,
 
 UDATA_MAX_CNT, 
}udata_type_e; 
```

```
/* uData物理传感器数据类型 */
typedef enum{
    TAG_DEV_ACC = 0，   /* Accelerometer */
    TAG_DEV_MAG,        /* Magnetometer */
    TAG_DEV_GYRO，      /* Gyroscope */
    TAG_DEV_ALS,        /* Ambient light sensor */
    TAG_DEV_PS,         /* Proximity */
    TAG_DEV_BARO,       /* Barometer */
    TAG_DEV_TEMP,       /* Temperature  */
    TAG_DEV_UV,         /* Ultraviolet */
    TAG_DEV_HUMI,       /* Humidity */
    TAG_DEV_HALL,       /* HALL */
    TAG_DEV_HR,         /* Heart Rate */
    TAG_DEV_SENSOR_NUM_MAX,	
} sensor_tag_e;
```

- **物理传感器介绍**
当前uData所支持的都是基于MEMS传感器（微机电系统，Microelectro Mechanical System）来设计实现的，下表是对现有的传感器做一个简单的介绍，可以增加对整个文档的理解和uData的认识。

| 传感器列表 | 传感器类型 | 功能简介 |  
| ---- | ---- | ---- |
| 光感器 | 环境类传感器 | 感知周围的光亮强度 |  
| 温度计 | 环境类传感器 | 感知周围的环境温度 | 
| 湿度计 | 环境类传感器 | 感知周围的环境湿度 |  
| 气压计 | 环境类传感器 | 感知所在区域的气压值 |  
| 紫外线 | 环境类传感器 | 感知所在区域的紫外线强度 | 
| PM2.5 | 环境类传感器 | 感知所在区域的PM2.5值 |  
| gap | 环境类传感器 | 感知所在区域的有害气体值 |  
| 加速度计 | 运动类传感器 |  测算对象当时的加速度值| 
| 陀螺仪 | 运动类传感器 |  测算对象当时的角速度值|
| 磁力计 | 位置类传感器 |  测算对象周围的磁场强度 | 
| 接近光 | 位置类传感器 |  感知物体接近的距离 |
| 心率计 | 健康类传感器 |  测算对象当时的心率值 |
| 血压计 | 健康类传感器 |  测算对象当时的血压值 | 

### uData开机流程
在本章节中，主要是介绍uData的开机流程，主要是从系统开机，到内核初始化，sensor初始化，framework初始化再到uData的framework初始化。也可以从下图中可以清楚的了解到整个初始化过程。

![](https://i.imgur.com/damo1Wb.png)


###uData模块间通信模式
当前的uData模块间通信是基于AliOS Things的yloop异步处理机制的。当前uData所支持的异步事件按如下所示，也可以在include\aos\yloop.h中查阅相关信息：
```
/** uData event */
#define EV_UDATA                           0x0004
#define CODE_UDATA_DEV_READ                1
#define CODE_UDATA_DEV_IOCTL               2
#define CODE_UDATA_DEV_OPEN                3
#define CODE_UDATA_DEV_CLOSE               4
#define CODE_UDATA_DEV_ENABLE              5
#define CODE_UDATA_DEV_DISABLE             6
#define CODE_UDATA_SERVICE_SUBSRIBE        7  /* 目前用于外部组件的订阅，如数据上云业务 */
#define CODE_UDATA_SERVICE_UNSUBSRIBE      8  /* 目前用于外部组件的退阅，如数据上云业务 */
#define CODE_UDATA_SERVICE_PROCESS         9
#define CODE_UDATA_SERVICE_IOCTL           10
#define CODE_UDATA_REPORT_PUBLISH          11 /* 当uData数据准备好之后，会广播事件通知相关的外部模块 */
```
在uData框架的framework层有一个任务调度器（uData_service_dispatcher）和一个定时器（g_abs_data_timer）来实现整个uData的通讯机制。
- **数据读取方式**
1. 查询方式（POLLING） ：基于定时器发起的方式。
2. 中断方式（PUSH/INT）：基于传感器中断发起的方式。

考虑到IoT业务多数是基于环境类传感器的，对传感器数据采样周期不是很快，暂时uData只支持查询的方式来读取数据，后期会支持基于传感器硬件中断的方式和更高频率的高精度定时器查询方式。
![](https://i.imgur.com/IiJswBk.png)

刚才介绍了uData内部模块间通信和数据读取方式，下图描述了对我们整个uData框架的整体实现和通讯机制。
![](https://i.imgur.com/Fz67Tde.png)

#### uData各功能组件状态和开发计划 

| 组件名称 | 功能描述 | 当前状态 | AliOS Things版本 |未来版本功能 |
| ---- | ---- | ---- |---- |---- |
| uData Interface | 1.提供对外的订阅、退阅API | 已支持 |  v1.2 |1.支持Remote ioctl功能<br>2.支持query inof功能 |
| Service Mgr | 1.提供Service调度机制<br>2.提供Service算法注册机制<br>3.提供数据封装功能 |  已支持 |v1.2  |1.支持应用算法本地控制设备功能 |
| abs data model | 1.提供abs timer定时器机制<br>2.提供动态算法注册机制<br>3.提供抽象数据对象管理 | 已支持 | v1.2  |1.高精度定时器自适应适配功能 |
| sensor hal | 提供sensor open,close, ioctl,read软件接口<br>2.提供sensor驱动注册功能<br>3.提供sensor I2C配置接口 | 已支持 |  v1.2  |1.sensor静态校准软件接口，包含静态参数校准和轴向校准<br>2.硬件接口配置接口，含I2C，SPI，中断配置 |
| sensor drv | 提供了加速度、湿度计、气压计的驱动程序 | 已支持 |  v1.2  |1.增加温度计，陀螺仪，Tof sensor的驱动程序。<br>2.支持传感器状态检测功能BIST<br>3.支持传感器的中断工作模式<br>4.支持更多厂家的传感器设备 |
### uData框架小结
本文主要是从uData的软件设计实现方面来介绍。关于[uData移植](https://github.com/alibaba/AliOS-Things/wiki/AliOS-Things-uData-Framework-Porting-Guide)，[sensor驱动开发](https://github.com/alibaba/AliOS-Things/wiki/AliOS-Things-uData-Sensor-Driver-Porting-Guide)等请参考其他相关的文档。





