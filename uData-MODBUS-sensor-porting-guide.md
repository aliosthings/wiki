# uData MODBUS sensor porting guide #

## MODBUS传感器驱动框架介绍 ##
![](https://cdn.nlark.com/lark/0/2018/png/111215/1535434837701-fb78447d-04b7-456c-ad99-70032f6924d1.png)

AliOS Things提供一套传感器uData框架，将MODBUS传感器抽象驱动节点，通过vfs接口open，read操作。
AliOS Things还提供MODBUS协议库，MODBUS传感器驱动调用MODBUS库接口读取传感器数据。


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
    
