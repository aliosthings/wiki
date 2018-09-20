[EN](AliOS-Things-uData-Sensor-Driver-Porting-Guide)| 中文

- uData框架介绍
- uData传感器驱动开发概要
- 驱动层的目录结构
- 驱动程序命名格式
- 驱动程序实现
- IO总线配置与接口
- 接口函数实现
- 设备初始化init函数实现
- 编译配置
- 传感器数据单位

### uData框架简介
uData框架设计之初的思想是基于传统sensorhub概念基础之上的，结合IoT的业务场景和AliOS Things物联网操作系统的特点设计而成的一个面对IoT的感知设备处理框架。uData主要分kernel和framework两层，kernel层主要是负责传感器驱动和相关的静态校准，包括轴向校准等；framework层主要是负责应用服务管理、动态校准管理和对外模块接口等。有关uData的具体设计将不再此文档中展开，下图可作为一个概要参考。本文档主要是介绍传感器驱动程序的开发。
![](https://i.imgur.com/rH0f5R7.png)

### uData传感器驱动开发概要
在本章节中，主要是介绍如何实现基于uData框架的传感器驱动开发。在uData设计之初，为了能更好的提供每个开发者极简开发，已将驱动相关的OS调用，比如中断注册接口，设备硬件配置接口和静态校准配置接口（目前暂时不支持)等都抽象到了sensor hal实现。每一个设备驱动程序，只需一个.c文件中，通过BUS总线如I2C，对设备进行读写和配置操作，就能实现全部的功能，同时也减少了开发者调试工作时间。

### 驱动层的目录结构

![](http://o7spigzvd.bkt.clouddn.com/udata_location.jpg)

#### 驱动程序命名格式
首先，为了代码的可读性，对文件命名和函数命名，都提供了一个很好的范例。
**文件命名格式：drv\_####\_####\_####.c** 

	参数1（设备类型）： 比如accel, gyro, mag, als, rgb, proximity, humi, temp, uv, baro等等。
	参数2（设备厂商）： 比如bosch等等
	参数3（设备型号）： 比如bma253,bme280等等。

如果你是在开发一个Bosch厂商的型号为bme280的湿度计计（humi）驱动，那可以文件命名为：drv\_humi\_bosch\_bme280.c
**函数命名格式：drv\_####\_####\_####\_####(...)**

	参数1（设备类型）： 比如humi等等。
	参数2（设备厂商）： 比如bosch等等
	参数3（设备型号）： 比如bme280等等。
	参数4（功能描述）： 比如setpowr，init等等。
例如，你是在为一个Bosch厂商的型号为bme280的湿度计（humi）驱动开发初始化函数，那可以文件命名为：drv\_humi_bosch\_bme280\_init（void）
####驱动程序实现
每一个传感器驱动程序都是以一个sensor\_obj_t对象来实现的，也就是说需要对这个对象的每个member进行实现。整个驱动程序主要分为三部分：IO总线配置，接口函数实现，初始化函数和编译配置。
<pre><code>
struct _sensor_obj_t {
	char*                    path;                     /* 设备节点路径 */
	sensor_tag_e             tag;                      /* 设备类型 */
	dev_io_port_e            io_port;                  /* 使用的IO总线类型 */
	work_mode_e              mode;                     /* 设备的工作模式 */
	dev_power_mode_e         power;                    /* 设备电源状态 */
	gpio_dev_t               gpio;                     /* 中断工作模式下的中断配置信息 */
	dev_sensor_full_info_t   info;                     /* 设备信息 */
	int (*open)(void);                                 /* 接口函数：打开设备，暂时只需power on即可 */
	int (*close)(void);                                /* 接口函数：关闭设备，暂时只需power off即可 */
	int (*read)(void *, size_t);                       /* 接口函数：读设备数据操作 */
	int (*write)(const void *buf, size_t len);         /* 接口函数：写设备操作，暂不使用 */
	int (*ioctl)(int cmd, unsigned long arg);          /* 接口函数：ioctl配置 */
	void(*irq_handle)(void);                           /* 接口函数：中断服务程序，在中断模式下才需要 */
}
</code></pre>

#### IO总线配置与接口
当前HAL层IO总线接口支持I2C/SPI两种，用户可根据实际硬件的实际连接来选择使用哪种总线与传感器进行交互。

##### 总线配置

每个传感器驱动还需要定义一个sensor\_io\_dev\_t的全局变量####\_ctx；用户通过赋值该变量来配置总线（I2C或SPI），之后即可通过该配置信息与传感器进行交互。
<pre><code>
typedef struct  _sensor_io_dev_t{
    dev_io_port_e           io_port;
    union{
        i2c_dev_t           dev_i2c;
        spi_dev_t           dev_spi;
    };
}sensor_io_dev_t;

sensor_io_dev_t bme280_ctx;
</code></pre>

对于只支持一种总线类型的传感器，可以在变量####\_ctx定义时直接初始化，不需要在函数中赋值。

对于支持I2C和SPI两种总线的传感器，可以为I2C和SPI分别定义配置信息的变量，并通过函数对bme280\_ctx进行赋值。
如果传感器支持I2C总线，定义一个的i2c\_dev\_t的全局变量，并配置其中的设备I2C地址，参考如下：
<pre><code>i2c_dev_t  ####_ctx_i2c = {
    .port = 3,                  /*传感器使用的I2C的port口为3*/
    .config.dev_addr = 0x5D<<1, /* 从设备I2C地址，8bit */
};</code></pre>

如果传感器支持SPI总线，同样定义一个的spi\_dev\_t的全局变量，并配置其中的设备SPI地址，参考如下：
<pre><code>spi_dev_t ####_ctx_spi = {
    .port = 2,                  /*传感器使用的SPI的port口为2*/
};</code></pre>

参考函数drv\_humi\_bosch\_bme280\_io\_init初始化相应总线类型的结构体。

<pre><code>static int drv_humi_bosch_bme280_io_init(int io_port)
{
    memset(&bme280_ctx, 0, sizeof(bme280_ctx));
    if (io_port == I2C_PORT) {
        bme280_ctx.io_port  = I2C_PORT;
        memcpy(&bme280_ctx.dev_i2c,&bme280_ctx_i2c,sizeof(bme280_ctx.dev_i2c));
        return 0;
    } else if (io_port == SPI_PORT) {
        bme280_ctx.io_port  = SPI_PORT;
        memcpy(&bme280_ctx.dev_spi,&bme280_ctx_spi,sizeof(bme280_ctx.dev_spi));
        return 0;
    }
    return -1;
}</code></pre>

##### 总线接口
当前senor hal层的总线接口支持I2C和SPI两种方式访问传感器，具体接口说明如下：
<pre><code>
/***************************************************
传感器数据读取接口
参数：
dev: 传感器驱动数据类型描述， 类型: sensor_io_dev_t
reg: 寄存器保存的地址空间， 类型: uint8_t*
data: 读取数据的地址空间， 类型: uint8_t*
size: 读取数据的长度， 类型: uint16_t
timeout: 数据读取最大阻塞时间， 类型: uint32_t

返回值 0: 成功； 非0: 失败
注意事项: 无
***************************************************/
int32_t sensor_io_read(sensor_io_dev_t* dev, uint8_t* reg, uint8_t* data, uint16_t size,uint32_t timeout);


/***************************************************
传感器数据写入接口
参数：
dev: 传感器驱动数据类型描述， 类型: sensor_io_dev_t
reg: 寄存器保存的地址空间， 类型: uint8_t*
data: 写入数据的地址空间， 类型: uint8_t*
size: 读取数据的长度， 类型: uint16_t
timeout: 数据读取最大阻塞时间， 类型: uint32_t

返回值 0: 成功； 非0: 失败
注意事项: 通过SPI总线读取时，地址和数据需按照传感器的格式要求，写入data中；reg赋值为NULL;
***************************************************/
int32_t sensor_io_write(sensor_io_dev_t* dev, uint8_t* reg, uint8_t *data, uint16_t size, uint32_t timeout);
</code></pre>

#### 传感器接口函数实现
所有的外设驱动都是以vfs形式来读写操作的，所以每一个驱动按需实现必要的接口函数： 
<pre><code>int (*open)(void); 
int (*close)(void);
int (*read)(void *, size_t);
int (*write)(const void *buf, size_t len);
int (*ioctl)(int cmd, unsigned long arg);
void(*irq_handle)(void);</code></pre>
#### 设备初始化init函数实现
主要是实现对sensor\_obj\_t的初始化设置并把设备驱动注册到sensor hal层统一调度管理；另外需要在初始化函数中实现对设备的默认参数配置，身份确定（validata id）并让设备进入低功耗模式。具体请参考如下实例：
<pre><code>
int drv_humi_bosch_bme280_init(void){
    int          ret = 0;
    sensor_obj_t sensor;
    memset(&sensor, 0, sizeof(sensor));
    /* fill the sensor obj parameters here */
    sensor.io_port    = SPI_PORT;
    sensor.tag        = TAG_DEV_HUMI;
    sensor.path       = dev_humi_path;
    sensor.open       = drv_humi_bosch_bme280_open;
    sensor.close      = drv_humi_bosch_bme280_close;
    sensor.read       = drv_humi_bosch_bme280_read;
    sensor.write      = NULL;
    sensor.ioctl      = drv_humi_bosch_bme280_ioctl;
    sensor.irq_handle = drv_humi_bosch_bme280_irq_handle;

    /* 把设备驱动信息注册到sensor hal，并创建一个创建分配一个设备节点给此设备 */
    ret = sensor_create_obj(&sensor);
    if (unlikely(ret)) {
        return -1;
    }
    /* 总线回调函数注册，非必需，用户可按照自己的方式调用总线接口*/
    ret = drv_humi_bosch_bme280_io_init(sensor.io_port);
    if (unlikely(ret)) {
        return -1;
    }
    /* 验证设备ID，并非一定需要此功能 */
    ret = drv_humi_bosch_bme280_validate_id(BME280_CHIP_ID);
    if (unlikely(ret)) {
        return -1;
    }
    /* 传感器进入初始化状态 */
    ret = drv_humi_bosch_bme280_soft_reset();
    if (unlikely(ret)) {
        return -1;
    }

    /* 设定默认配置参数，实时通过ioctl可以调节配置 */
    ret = drv_humi_bosch_bme280_set_default_config();
    if (unlikely(ret)) {
        return -1;
    }
    /* 获取静态校准参数 */
    ret = drv_humi_bosch_bme280_get_cali_parm();
    if (unlikely(ret)) {
        return -1;
    }

    /* update the phy sensor info to sensor hal */
    LOG("%s %s successfully \n", SENSOR_STR, __func__);
    return 0;
}
</code></pre>
如果传感器需要配置成中断模式触发，在初始化时需要配置以下带有注释说明的参数（以BMA253为例）；
<pre><code>
int drv_acc_bosch_bma253_init(void)
{
    int          ret = 0;
    sensor_obj_t sensor;

    memset(&sensor, 0, sizeof(sensor));
    /* fill the sensor obj parameters here */
    sensor.io_port     = I2C_PORT;
    sensor.tag         = TAG_DEV_ACC;
    sensor.path        = dev_acc_path;
    sensor.open        = drv_acc_bosch_bma253_open;
    sensor.close       = drv_acc_bosch_bma253_close;
    sensor.read        = drv_acc_bosch_bma253_read;
    sensor.write       = NULL;
    sensor.ioctl       = drv_acc_bosch_bma253_ioctl;
    sensor.irq_handle  = drv_acc_bosch_bma253_irq_handle; /* 实现中断回调函数 */
    sensor.mode        = DEV_INT;                         /* 传感器运行模式 */  
    sensor.gpio.port   = BMA253_IRQ_PIN;                  /* 传感器中断使用的pin脚 */
    sensor.gpio.config = IRQ_MODE;                        /* pin脚配置成中断模式 */
    sensor.gpio.priv   = &bma253_irq_mode_rising;         /* 中断为上升沿触发 */

    ...

}

</code></pre>

#### 编译配置
##### 1.在sensor.mk文件中添加所要编译的驱动代码并定义其相关的宏定义。比如，需要为BOSCH BME280湿度计添加编译配置：

    $(NAME)\_SOURCES += \  

        drv_sensor_sample.c \
        sensor_hal.c \
        sensor_drv_api.c \
        sensor_hw_config.c \
        sensor_static_cali.c \
        drv_humi_bosch_bme280.c   /* 请在最末处添加新的驱动代码 */
    
    GLOBAL_INCLUDES += .  
    
    GLOBAL_DEFINES      += AOS_SENSOR  
    
    GLOBAL_DEFINES      += AOS_SENSOR_HUMI_BOSCH_BME280 /* 请为新的驱动程序定义一个宏，在编译配置时将会使用到 */
##### 2.把所需要编译驱动的init函数添加到sensor\_hal.c的sensor\_init（）函数中，可参考如下：
<pre><code>
int sensor_init(void){
    int ret   = 0;
    int index = 0; 
    g_sensor_cnt = 0 ;

    /* 请参考此格式添加init函数，初始化成功代表驱动已注册到sensor hal里了 */
    #ifdef AOS_SENSOR_HUMI_BOSCH_BME280    
        drv_humi_bosch_bme280_init();
    #endif /* AOS_SENSOR_HUMI_BOSCH_BME280 */

    ret = sensor_hal_register();
    if(ret != 0){
        return -1;
    }
    return 0;
}
</code></pre>

#### 传感器数据单位

主要是介绍uData相关的传感器数据的单位规范说明，从而避免所有开发者所提供的驱动代码上的传感器数据单位不一致，导致数据上云，算法等无法正常运算。考虑到不是所有的平台都支持浮点运算，也考虑到大数据的浮点运算对端侧系统带来的性能负担，约定基于uData的传感器数据运算均以整型数据计算。本数据单位标准规范当前仅限于物理传感器驱动数据和应用算法之间的范畴，呈现给最终用户的单位格式可以由最终产品所规定的单位格式而定。

| 传感器名称 |      简称       |  单位   | 传感器类别  |                                说明 |
| ----- | :-----------: | :---: | :----: | --------------------------------: |
| 加速度计  |      acc      |  mg   | 运动类传感器 | 1 g = 1000 mg, 1 g = 9.8 m/s2（米每秒） |
| 陀螺仪   |     gyro      | udps  | 运动类传感器 |   1 dps = 1000 000 udps, dps(度每秒) |
| 磁力计   |      mag      |  mG   | 位置类传感器 |                1 G = 1000 mG(毫高斯) |
| 接近光   |   proximity   |  cm   | 位置类传感器 |                 表示物体到传感器的距离，单位：厘米 |
| 光感计   |      als      |  lux  | 环境类传感器 |                             亮度流明值 |
| 气压计   | baro/pressure |  Pa   | 环境类传感器 |                100 Pa = 1 hPa（百帕） |
| 温度计   |     temp      | °c/10 | 环境类传感器 |                            0.1摄氏度 |
| 湿度计   |     humi      |   ‰   | 环境类传感器 |                   相对湿度%RH，一般只用‰表示 |
| 心率计   |      hr       |  bpm  | 健康类传感器 |                          bpm：次数每秒 |

##### 注：后期会迭代增加新的传感器数据单位。

#### AliOS Things支持的传感器列表

当前AliOS Things在uData框架下已支持多款传感器，现将几款典型的传感器列举如下。随着生态的拓展，更多类型、更多厂家的传感器会持续集成进来。

| 传感器型号   | 传感器类型      | 厂家     |
| :------ | :--------- | :----- |
| BMA253  | 加速度传感器     | BOSCH  |
| BMP280  | 压力传感器      | BOSCH  |
| BMG160  | 陀螺仪传感器     | BOSCH  |
| BME280  | 湿度传感器      | BOSCH  |
| LPS22HB | 压力传感器      | ST     |
| LSM6DSL | 加速度、陀螺仪传感器 | ST     |
| LTR553  | 环境光、光接近传感器 | LITEON |
| DA217   | 加速度传感器     | 明皜科技   |

至此，uData软件框架的驱动程序开发教程已介绍完毕。