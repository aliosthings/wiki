## 2.5 fota移植
### 2.5.1 移植概要
  fota跟具体芯片相关的接口建议放置在platform/mcu/xxxx/port/下面，文件名fota_port.c.其中，xxxx为当前正在移植的平台名。
  fota_port.c需要实现结构体hal_ota_module_t中的几个函数：

    int (*init)(hal_ota_module_t *m, void *something);
    int (*ota_write)(hal_ota_module_t *m, volatile uint32_t *off_set,
                     uint8_t *in_buf , uint32_t in_buf_len);
    int (*ota_read)(hal_ota_module_t *m,  volatile uint32_t *off_set,
                    uint8_t *out_buf , uint32_t out_buf_len);
    int (*ota_set_boot)(hal_ota_module_t *m, void *something);

 ### 2.5.2 接口实现
  1. 实现int (*init)(hal_ota_module_t *m, void *something)，此接口主要进行flash硬件及相关变量的初始化。
  参数说明：

    m  接口模块指针，函数中暂无需使用。
    something  当前被用作断点续传的断点地址，使用： _off_set = *(uint32_t*)something。

  初始化时，判断_off_set是否为0.

    若为0，则需擦除fota下载flash分区,准备进行一次全新的下载。为了安全起见，
    建议对flash操作进行crc16校验，故同时初始化crc16.   
    若不为0，则认为上次下载中断，接下来将进行断点续传。无需擦除fota下载flash分区。
    如使用了crc16校验，则需从flash指定区域读取上次断点时备份的crc16校验。 

  2. 实现 int (*ota_write)(hal_ota_module_t *m, volatile uint32_t *off_set, uint8_t *in_buf , uint32_t in_buf_len)，
  此接口用于fota下载时实现固件逐块保存。
  参数说明：

    m  接口模块指针，函数中暂无需使用。
    off_set  写偏移地址，当前上层直接置0，无需使用。
    in_buf  本次需要写入的数据。
    in_buf_len  本次写入数据长度。

  由于off_set调用时永远置0，所以写偏移地址需要函数自身实现，即每次写入之后将全局偏移量加上本次写入长度。此函数需要调用flash写操作函数对数据进行写入。

  3. 实现int (*ota_read)(hal_ota_module_t *m,  volatile uint32_t *off_set,uint8_t *out_buf , uint32_t out_buf_len);
  当前fota没有用到此接口，可以不实现。
  参数说明：

    m  接口模块指针，函数中暂无需使用。
    off_set  读偏移地址，无需使用。
    out_buf  读出缓存。
    in_buf_len  本次读出的数据长度。
 
  此函数封装flash读操作函数即可。

  4.实现int (*ota_set_boot)(hal_ota_module_t *m, void *something);本接口用于下载完成后对系统进行升级或者下载中断后保存现场。
  参数说明：

    m  接口模块指针，函数中暂无需使用。
    something  传入的参数，真实传入类型为：ota_finish_param_t *。

ota_finish_param_t定义如下：

    typedef struct  {
        OTA_ENUM_UPDATE_TYPE update_type;
        OTA_ENUM_RESULT_TYPE result_type ;
    } ota_finish_param_t;

  获取此变量：ota_finish_param_t *param = (ota_finish_param_t *)something;其中两个子变量含义：

    update_type：升级类型，枚举类型，必须为 OTA_KERNEL,OTA_APP,OTA_ALL之一，分别代表升级内核，升级APP及全部升级。
    result_type：结果类型，枚举类型，必须为 OTA_FINISH或OTA_BREAKPOINT。分别代表升级完成和升级中断。

  当result_type == OTA_BREAKPOINT时，应保存当前crc校验值到flash，以备断电后可以断点续传。
  当result_type == OTA_FINISH，说明下载完成，接下来应该根据update_type将下载到fota下载分区的固件复制到相应区域替换原固件。