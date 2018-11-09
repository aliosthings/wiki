蓝牙辅助WiFi配网模块的HAL接口分为协议栈、OS、安全三个部分，这些接口的定义在network/bluetooth/breeze/hal/include/目录中：
* breeze_hal_ble.h

定义了蓝牙配网SDK对接到不同厂商蓝牙协议栈的接口，参考实现位于network/bluetooth/breeze/hal/ble/breeze_hal_ble.c文件；

* breeze_hal_os.h

定义了蓝牙配网SDK对接到不同OS系统的接口，基于AliOSThings的参考实现位于network/bluetooth/breeze/hal/ble/breeze_hal_os.c，用户如果使用AliOSThings时，该部分接口不需要对接；

* breeze_hal_security.h

定义了蓝牙配网SDK对接到不同安全算法实现的接口，基于mbedtls的参考实现位于network/bluetooth/breeze/hal/ble/breeze_hal_security.c文件，用户使用AliOSThings时，该部分接口不需要对接。

# 蓝牙协议栈HAL列表 

**ais_err_t ble_stack_init(ais_bt_init_t *ais_init)**
该接口完成对BLE协议栈的初始化。

**参数说明**：输入参数ais_init中指定了蓝牙service和characteristics，以及他们的权限属性等相关设置。具体包括：
* uuid_svc：service的uuid（type、value）信息；
* rc/wc/ic/nc/ wwnrc：蓝牙配网SDK使用到的属性信息，包括他们的uuid、property、permission等信息，以及* * on_read/on_write/on_ccc_change回调函数（HAL实现代码负责调用，对端读取属性值时调用on_read，对端写入属性值时调用on_write，ccc属性值变更时调用on_ccc_change）；
* on_connected/on_disconnected：回调函数，HAL代码负责调用（建立蓝牙连接时调用on_connected，断开蓝牙连接时调用on_disconnected）。

**注意：**
* 完成该函数调用后，设备默认可以开始蓝牙广播；
* 完成协议栈初始化后确保该函数能够正常返回；
* 该函数输入参数ais_bt_init_t中的uuid，分为16bits、32bits、128bits等几种type类型，HAL实现层需要根据uuid的类型，决定需要读取的uuid值，请参考以下代码：

**返回值：**该函数成功时返回AIS_ERR_SUCCESS，错误发生时返回对应的Breeze错误编码（错误编码定义在头文件中）。

**参考对接：**请参考这里。

**ais_err_t ble_stack_deinit()**
该接口负责协议栈停止和资源销毁等工作。

**参数说明：**该函数无输入参数。

**返回值：**该函数成功退出是返回AIS_ERR_SUCCESS，错误发生时返回Breeze错误编码。

**参考对接：**请参考这里。

**void ble_disconnect(uint8_t reason)**
该接口断开已有的蓝牙连接。该函数断开当前的蓝牙连接，与ble_stack_deinit的区别是，后续还可以进行连接。

**参数说明：**reason为蓝牙协议规定的断开原因，如Remote User Terminated Connect（0x13）、Connection Accept Timeout Exceeded（0x10）等。详情请参考蓝牙协议栈文档。

**返回值：**无。

**参考对接：**请参考这里。

**ais_err_t ble_advertising_start(ais_adv_init_t*adv)**
该接口开启蓝牙广播。

**参数说明：**输入参数adv指定了所需的广播信息，包括flag、设备名、厂商数据段内容。

**返回值：**该函数成功退出是返回AIS_ERR_SUCCESS，错误发生时返回Breeze错误编码。

**参考对接：**请参考这里。

**注意：**
* 蓝牙连接断开后，HAL层或底层需要维护蓝牙广播的重新发出，必要时由HAL层或者底层保存传入的广播参数。
* 参数中未指定的广播参数（如广播最大/最小间隔时长），均建议采用特定协议栈推荐的默认参数；

**ais_err_t ble_advertising_stop()**
该接口停止蓝牙广播。该函数会被Breeze SDK调用。

**参数说明：**无。

**返回值：**该函数成功退出是返回AIS_ERR_SUCCESS，错误发生时返回Breeze错误编码。

**参考对接：**请参考这里。

**ais_err_t ble_send_notification(uint8_t *p_data, uint16_t length)**
该接口通过notify方式发送数据。

**参数说明：**p_data为发送数据的buffer地址（调用者传入/维护），length为数据长度。

**返回值：**该函数成功退出是返回AIS_ERR_SUCCESS，错误发生时返回Breeze错误编码。

**参考对接：**请参考这里。

**注意：**该函数调用完成后，调用者认为发送完毕，数据beffer可能马上会被销毁或改写，HAL层必要时对数据进行缓存。

**ais_err_t ble_send_indication(uint8_t *p_data, uint16_t length, void (*txdone)(uint8_t res))**
该接口通过indicate方式发送数据。

**参数说明：**p_data为发送数据的buffer地址（调用者传入/维护），length为数据长度，txdone为回调处理函数，由HAL实现代码在发送indication数据完毕后调用。

**返回值：**该函数成功退出是返回AIS_ERR_SUCCESS，错误发生时返回Breeze错误编码。

**参考对接：**请参考这里。

**注意：**该函数调用完成后，调用者认为发送完毕，数据beffer可能马上会被销毁或改写，HAL层必要时对数据进行缓存。

**ais_err_t ble_get_mac(uint8_t *mac)**
该接口用于获取蓝牙设备的MAC地址。

**参数说明：**mac用于存储获取到的蓝牙MAC地址，6字节二进制格式：0xAA，0xBB，0xCC，0xDD，0xEE，0xFF（对应MAC地址“AA:BB:CC:DD:EE:FF”）。

**返回值：**该函数成功退出是返回AIS_ERR_SUCCESS，错误发生时返回Breeze错误编码。
**参考对接：**请参考这里。

# OS HAL列表

## OS HAL接口提供以下功能：
* 定时器支持；
* 系统重启接口；
* 系统时间戳获取和睡眠接口；
* Key-Value键值读取接口。

**int os_timer_new(os_timer_t*timer, os_timer_cb_t cb, void *arg, int ms)**
该接口用于创建定时器。

**参数说明：**timer为定时器指针，cb为定时器超时回调处理函数，arg为回调函数参数，ms为超时时间。

**返回值：**成功时时返回0，否则返回非0值。


**int os_timer_start(os_timer_t*timer)**
该接口用于启动定时器。

**参数说明：**timer为定时器指针。

**返回值：**成功时返回0，否则返回非0值。

**int os_timer_stop(os_timer_t*timer)**
该接口停止定时器计时。

**参数说明：**timer为定时器指针。

**返回值：**成功时返回0，否则返回非0值。

**void os_timer_free(os_timer_t*timer)**
该接口注销定时器。

**参数说明：**timer为定时器指针。

**返回值：**无。


**void os_msleep(int ms)**
该接口触发系统/进程进行睡眠。

**参数说明：**ms为睡眠时长，单位为毫秒。

**返回值：**无。

**long long os_now_ms()**
该接口用于获取系统当前时间戳（从系统启动开始计数），单位为毫秒。

**参数说明：**无。

**返回值：**系统时间戳。

**void os_reboot()**
该接口使系统重启。

**参数说明：**无。

**返回值：**无。

**int os_kv_set(const char *key,const void *value, int len, int sync)**
该接口用于设置永久存储Key-Value键值。

**参数说明：**key为键名（字符串）；value为键值（任意值）；len为键值长度；sync为预留参数，暂时传入1。

**返回值：**成功时返回0，否则返回非0值。

**int os_kv_get(const char *key,void *buffer, int *buffer_len)**
该接口用于读取永久存储Key-Value键值。

**参数说明：**key为键名（字符串）；buffer为键值（任意值）；len为键值长度。

**返回值：**成功时返回0，否则返回非0值。

**int os_kv_del(const char *key)**
该接口用于删除永久存储Key-Value键值。

**参数说明：**key为键名（字符串）。

**返回值：**成功时返回0，否则返回非0值。

**int os_rand(void)**
该接口用于产生一个整型的随机值。

**参数说明：**无。

**返回值：**随机值。

**void *ais_aes128_init(constuint8_t *key, const uint8_t *iv)**
该接口对AES128加解密算法流程进行初始化。

**参数说明：**key为AES128 CBC算法要求的key输入，iv为AES128 CBC算法要求输入的iv值。

**返回值：**void指针，指向初始化后的context，后续加解密流程中使用该返回值。

**int ais_aes128_destroy(void*aes)**
该接口销毁AES128加解密算法流程，释放相关资源。

**参数说明：**aes为ais_aes128_init接口初始化之后返回的context。

**返回值：**如果成功销毁返回0，否则返回-1。

**int ais_aes128_cbc_encrypt(void*aes, const void *src, size_t block_num, void *dst)**
调用该接口进行AES128 CBC加密计算。

**参数说明：**aes为ais_aes128_init接口初始化之后返回的context，src指针指向需要加密的数据，block_num为需要加密的数据块数（16字节为一块，不足16字节按一块计算），dst为加密后数据的存储地址。

**返回值：**成功时返回0，否则返回-1。


**int ais_aes128_cbc_decrypt(void*aes, const void *src, size_t block_num, void *dst)**
调用该接口进行AES128 CBC解密计算。

**参数说明：**aes为ais_aes128_init接口初始化之后返回的context，src指针指向需要加密的数据，block_num为需要加密的数据块数（16字节为一块，不足16字节按一块计算），dst为解密后数据的存储地址。

**返回值：**成功时返回0，否则返回-1。



注意：mac参数为6字节内存，由调用者负责分配和销毁，HAL实现层只负责mac字段的填充。