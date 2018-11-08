# uData MODBUS sensor porting guide #

## MODBUS库API ##
AliOS Things提供MODBUS库，相关API可以查看kernel下面的mbmaster_api.h

    mb_status_t mb_rtc_init(mb_handler_t **handler,  uint8_t port, uint32_t baud_rate, mb_parity_t parity);   //初始化

    mb_status_t mb_read_holding_reginster(mb_handler_t* req_handler, uint8_t slave_addr, uint16_t start_addr, uint16_t quantity, uint8_t *respond_buf, uint8_t *respond_count);//读取modbus寄存器


## MODBUS传感器驱动介绍 ##
![](https://cdn.nlark.com/lark/0/2018/png/111215/1535434837701-fb78447d-04b7-456c-ad99-70032f6924d1.png)

AliOS Things提供一套传感器uData框架，将MODBUS传感器抽象驱动节点，通过vfs接口open，read操作。
MODBUS传感器驱动调用MODBUS库接口读取传感器数据。


MODBUS传感器驱动添加通过类似下面配置表修改
device\sensor\drv\sensor_drv_conf.h

    const modbus_sensor_t modbus_sensors[] = {
    { "KunLunHaiAn", "JHFS-W1", "wind speed", dev_windspeed_path, TAG_DEV_WINDSPD,
      SENSOR_OPEN, 0X30, 0x002A, 1, 0, 50 },
    { "KunLunHaiAn", "JHFX-W1", "wind direction", dev_winddirection_path, TAG_DEV_WINDDIR,
      SENSOR_OPEN, 0X31, 0x002A, 1, 0, 50 },
    { "KunLunHaiAn", "JHYL-W1", "current precipitation", dev_rainfall_path, TAG_DEV_RAIN,
      SENSOR_OPEN, 0X32, 0x0002, 1, 0, 50 },
    { "KunLunHaiAn", "JHYL-W1", "today precipitation", dev_todayrainfall_path, TAG_DEV_TODAYRAIN,
      SENSOR_OPEN, 0X32, 0x0001, 1, 0, 50 },
    };

    
数组结构体的注释如下：
 
    typedef struct
    {
    const char *   company;//厂商名
    const char *   model;	   //型号
    const char *   name;	   //名称
    const char *   path;	   //设备节点路径
    sensor_tag_e   tag;		   //传感器类型
    sensor_ability ability;	   //驱动是否支持,用户自己定义打开还是关闭
    unsigned char  slave;	   //从设备地址
    unsigned short addr;	   //寄存器地址
    unsigned short reg_cnt;/* 寄存器数量 */
    unsigned char  byte_reverse;  /* 是否数据反转 0: high bytes first, 1: low bytes first */
    unsigned short response_time; /* 读数据超时时间slave response time in ms */
    } modbus_sensor_t;

### MODBUS驱动初始化流程 ###
1. 总线初始化，调用mb_rtc_init，传入句柄handler，UART端口，波特率，奇偶校验等参数。


    mb_rtc_init(mb_handler_t **handler,  uint8_t port, uint32_t baud_rate, mb_parity_t parity);


2. 加载传感器配置参数，配置参数在上面介绍的modbus_sensor_t modbus_sensors这个表中指定，用户也可以自己定义。
3. 表中ability打开的传感器创建sensor_obj_t结构体节点，如下所示，可以通过vfs的open，read等接口打开传感器和读取传感器数据。
![](https://cdn.nlark.com/lark/0/2018/png/111215/1541687845580-37ca4a23-6675-4fe6-b735-916904865454.png)


## uData框架 ##
uData框架移植文档参考 [https://github.com/alibaba/AliOS-Things/wiki/AliOS-Things-uData-Framework-Porting-Guide](https://github.com/alibaba/AliOS-Things/wiki/AliOS-Things-uData-Framework-Porting-Guide)

uData框架介绍 [https://yq.aliyun.com/articles/368257](https://yq.aliyun.com/articles/368257)

uData框架介绍和移植文档可以参考上面链接。

### MODBUS异同点 ###

常规mems传感器轮询读取数据时可通过定时器读取，而使用MODBUS传感器时，读取超时时间可控，这里单独创建了一个task进行轮询读取注册成功的传感器驱动，轮询时间用户可根据自己需求修改。
![](https://cdn.nlark.com/lark/0/2018/png/111215/1541688679523-e66d3891-ebaa-4ab7-816b-63a23c69bfaa.png)


## 用户使用说明 ##

###  1、添加已经支持的传感器 ###
- 配置表中列出的目前已经支持的传感器型号，用户修改对应ability控制传感器驱动加载。
- 修改使能的传感器slave，传感器从机地址用户自己配置的，slave和配置一致。

###  2、添加新的传感器 ###
- 按照modbus_sensor_t结构体格式在配置表中添加传感器
- 传感器ability定义开启或关闭，slave和传感器配置的一致。
- 如果传感器类型全新的，在sensor.h文件如下代码格式中定义新path和tag，并添加到配置表中。


##  ##
    
    #define dev_acc_path "/dev/acc"
    #define dev_mag_path "/dev/mag"
    #define dev_gyro_path "/dev/gyro"
    #define dev_als_path "/dev/als"
    #define dev_ps_path "/dev/ps"
    #define dev_baro_path "/dev/baro"
    #define dev_temp_path "/dev/temp"
    #define dev_uv_path "/dev/uv"
    #define dev_humi_path "/dev/humi"
    #define dev_hall_path "/dev/hall"
    #define dev_hr_path "/dev/hr"
    #define dev_gps_path "/dev/gps"
    #define dev_noise_path "/dev/noise"
    #define dev_pm25_path "/dev/pm25" // pm2.5
    #define dev_co2_path "/dev/co2"
    #define dev_hcho_path "/dev/hcho"
    #define dev_tvoc_path "/dev/tvoc"
    #define dev_pm10_path "/dev/pm10" // pm10
    #define dev_pm1_path "/dev/pm1"   // pm1.0
    #define dev_ph_path "/dev/ph"
    #define dev_vwc_path "/dev/vwc"
    #define dev_ec_path "/dev/ec"   //electric conductivity
    #define dev_salinity_path   "/dev/salinity" //salinity
    #define dev_tds_path   "/dev/tds"   //Total dissolved solids
    #define dev_windspeed_path "/dev/windspeed"
    #define dev_winddirection_path "/dev/winddirection"
    #define dev_rainfall_path "/dev/rainfall"
    
    
    /* add the new sensor type into the last position  */
    typedef enum
    {
    TAG_DEV_ACC = 0, /* Accelerometer */
    TAG_DEV_MAG, /* Magnetometer */
    TAG_DEV_GYRO,/* Gyroscope */
    TAG_DEV_ALS, /* Ambient light sensor */
    TAG_DEV_PS,  /* Proximity */
    TAG_DEV_BARO,/* Barometer */
    TAG_DEV_TEMP,/* Temperature  */
    TAG_DEV_UV,  /* Ultraviolet */
    TAG_DEV_HUMI,/* Humidity */
    TAG_DEV_NOISE,   /* NoiseLoudness */
    TAG_DEV_PM25,/* PM2.5 */
    TAG_DEV_PM1P0,   /* PM1.0 */
    TAG_DEV_PM10,/* PM10 */
    TAG_DEV_CO2, /* CO2 Level */
    TAG_DEV_HCHO,/* HCHO Level */
    TAG_DEV_TVOC,/* TVOC Level */
    TAG_DEV_PH, /* PH value */
    TAG_DEV_VWC,/*volumetric water content*/
    TAG_DEV_EC,   /* EC value */
    TAG_DEV_SALINITY,  /* SALINITY value */
    TAG_DEV_TDS,/* Total dissolved solids */
    TAG_DEV_WINDSPD,/* Total dissolved solids */
    TAG_DEV_WINDDIR,/* Total dissolved solids */
    TAG_DEV_RAIN,/* Total dissolved solids */
    TAG_DEV_HALL,/* HALL */
    TAG_DEV_HR,  /* Heart Rate */
    TAG_DEV_RGB,/* RGB sensor */
    TAG_DEV_GS, /* Gesture sensor */
    TAG_DEV_IR, /* IR sensor */
    TAG_DEV_GPS,
    TAG_DEV_SENSOR_NUM_MAX,
    } sensor_tag_e;
    

###  3、注册传感器服务 ###

在uData.mk中打开相关服务的宏，如下所示，在static int udata_std_service_init(udata_type_e type)函数中会注册相关的服务。

    GLOBAL_DEFINES += AOS_UDATA_SERVICE_ALS
    GLOBAL_DEFINES += AOS_UDATA_SERVICE_PS
    GLOBAL_DEFINES += AOS_UDATA_SERVICE_BARO
    GLOBAL_DEFINES += AOS_UDATA_SERVICE_TEMP
    GLOBAL_DEFINES += AOS_UDATA_SERVICE_UV
    GLOBAL_DEFINES += AOS_UDATA_SERVICE_HUMI
    GLOBAL_DEFINES += AOS_UDATA_SERVICE_NOISE
    GLOBAL_DEFINES += AOS_UDATA_SERVICE_PM25
    GLOBAL_DEFINES += AOS_UDATA_SERVICE_CO2
    GLOBAL_DEFINES += AOS_UDATA_SERVICE_HCHO
    GLOBAL_DEFINES += AOS_UDATA_SERVICE_TVOC

###  4、订阅传感器数据 ###
用户在自己APP种订阅需要传感器数据，如下所示。

    ret = uData_subscribe(UDATA_SERVICE_TEMP);
    if (ret != 0) {
        LOG("%s %s %s %d\n", uDATA_STR, __func__, ERROR_LINE, __LINE__);
    }
    ret = uData_subscribe(UDATA_SERVICE_HUMI);
    if (ret != 0) {
        LOG("%s %s %s %d\n", uDATA_STR, __func__, ERROR_LINE, __LINE__);
    }


注册回调函数int uData_register_msg_handler(void *func);  在回调函数中会传入传感器数据。


###  5、编译 ###
编译时需要打开MODBUS宏，增加编译参数modbus_sensor_enable=1，已uDataapp为例

    aos make uDataapp@developerkit modbus_sensor_enable=1