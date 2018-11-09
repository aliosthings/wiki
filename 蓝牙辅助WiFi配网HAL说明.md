蓝牙辅助WiFi配网模块的HAL接口分为协议栈、OS、安全三个部分，这些接口的定义在`network/bluetooth/breeze/hal/include/`目录中：
* __breeze\_hal\_ble.h__
定义了蓝牙配网SDK对接到不同厂商蓝牙协议栈的接口，参考实现位于`network/bluetooth/breeze/hal/ble/breeze_hal_ble.c`文件；
* __breeze\_hal\_os.h__
定义了蓝牙配网SDK对接到不同OS系统的接口，基于AliOSThings的参考实现位于`network/bluetooth/breeze/hal/ble/breeze_hal_os.c`，用户如果使用AliOSThings时，该部分接口不需要对接；
* __breeze\_hal\_security.h__
定义了蓝牙配网SDK对接到不同安全算法实现的接口，基于mbedtls的参考实现位于`network/bluetooth/breeze/hal/ble/breeze_hal_security.c`文件，用户使用AliOSThings时，该部分接口不需要对接。

# 蓝牙协议栈HAL列表 

### <span data-type="color" style="color:#262626">ais_err_t ble_stack_init(ais_bt_init_t *ais_init)</span>
该接口完成对BLE协议栈的初始化。

<span data-type="color" style="color:#262626"><strong>参数说明</strong></span><span data-type="color" style="color:#262626">：输入参数</span><span data-type="color" style="color:#262626"><code>ais_init</code></span><span data-type="color" style="color:#262626">中指定了蓝牙service和characteristics，以及他们的权限属性等相关设置。</span>具体包括：
* uuid\_svc：service的uuid（type、value）信息；
* rc/wc/ic/nc/ wwnrc：蓝牙配网SDK使用到的属性信息，包括他们的uuid、property、permission等信息，以及on\_read/on\_write/on\_ccc\_change回调函数（HAL实现代码负责调用，对端读取属性值时调用`on_read`，对端写入属性值时调用`on_write`，ccc属性值变更时调用`on_ccc_change`）；
* on\_connected/on\_disconnected：回调函数，HAL代码负责调用（建立蓝牙连接时调用`on_connected`，断开蓝牙连接时调用`on_disconnected`）。

__注意__：
* 完成该函数调用后，设备默认可以开始蓝牙广播；
* 完成协议栈初始化后确保该函数能够正常返回；
* 该函数输入参数`ais_bt_init_t`中的uuid，分为16bits、32bits、128bits等几种type类型，HAL实现层需要根据uuid的类型，决定需要读取的uuid值，请参考以下代码：

<div data-type="alignment" data-value="center" style="text-align:center">
  <div data-type="p">
    <div id="2cbqix" data-type="image" data-display="block" data-align="left" data-src="https://cdn.nlark.com/lark/0/2018/png/56016/1537861860662-c03f2812-37c8-4bc6-8639-38eceff2d1a3.png" data-width="403">
      <img src="https://cdn.nlark.com/lark/0/2018/png/56016/1537861860662-c03f2812-37c8-4bc6-8639-38eceff2d1a3.png" width="403" />
    </div>
  </div>
</div>


<span data-type="color" style="color:#262626"><strong>返回值</strong></span><span data-type="color" style="color:#262626">：该函数成功时返回</span><span data-type="color" style="color:#262626"><code>AIS_ERR_SUCCESS</code></span><span data-type="color" style="color:#262626">，错误发生时返回对应的Breeze错误编码（错误编码定义在头文件中）。</span>

<span data-type="color" style="color:#262626"><strong>参考对接</strong></span><span data-type="color" style="color:#262626">：请参考</span>[这里](https://github.com/alibaba/AliOS-Things/blob/rel_2.0.0/network/bluetooth/breeze/hal/ble/breeze_hal_ble.c)<span data-type="color" style="color:#262626">。</span>
### <span data-type="color" style="color:#262626">ais_err_t ble_stack_deinit()</span>
<span data-type="color" style="color:#262626">该接口负责协议栈停止和资源销毁等工作。</span>

<span data-type="color" style="color:#262626"><strong>参数说明</strong></span><span data-type="color" style="color:#262626">：该函数无输入参数。</span>

<span data-type="color" style="color:#262626"><strong>返回值</strong></span><span data-type="color" style="color:#262626">：该函数成功退出是返回</span><span data-type="color" style="color:#262626"><code>AIS_ERR_SUCCESS</code></span><span data-type="color" style="color:#262626">，错误发生时返回Breeze错误编码。</span>

<span data-type="color" style="color:#262626"><strong>参考对接</strong></span><span data-type="color" style="color:#262626">：请参考</span>[这里](https://github.com/alibaba/AliOS-Things/blob/rel_2.0.0/network/bluetooth/breeze/hal/ble/breeze_hal_ble.c)<span data-type="color" style="color:#262626">。</span>

### <span data-type="color" style="color:#262626">void ble_disconnect(uint8_t reason)</span>
<span data-type="color" style="color:#262626">该接口断开已有的蓝牙连接。该函数断开当前的蓝牙连接，与</span><span data-type="color" style="color:#262626"><code>ble_stack_deinit</code></span><span data-type="color" style="color:#262626">的区别是，后续还可以进行连接。</span>

<span data-type="color" style="color:#262626"><strong>参数说明</strong></span><span data-type="color" style="color:#262626">：</span><span data-type="color" style="color:#262626"><code>reason</code></span><span data-type="color" style="color:#262626">为蓝牙协议规定的断开原因，如Remote User Terminated Connect（0x13）、Connection Accept Timeout Exceeded（0x10）等。详情请参考蓝牙协议栈文档。</span>

<span data-type="color" style="color:#262626"><strong>返回值</strong></span><span data-type="color" style="color:#262626">：无。</span>

<span data-type="color" style="color:#262626"><strong>参考对接</strong></span><span data-type="color" style="color:#262626">：请参考</span>[这里](https://github.com/alibaba/AliOS-Things/blob/rel_2.0.0/network/bluetooth/breeze/hal/ble/breeze_hal_ble.c)<span data-type="color" style="color:#262626">。</span>

### <span data-type="color" style="color:#262626">ais_err_t ble_advertising_start(ais_adv_init_t*adv)</span>
<span data-type="color" style="color:#262626">该接口开启蓝牙广播。</span>

<span data-type="color" style="color:#262626"><strong>参数说明</strong></span><span data-type="color" style="color:#262626">：输入参数</span><span data-type="color" style="color:#262626"><code>adv</code></span><span data-type="color" style="color:#262626">指定了所需的广播信息，包括flag、设备名、厂商数据段内容。</span>

<span data-type="color" style="color:#262626"><strong>返回值</strong></span><span data-type="color" style="color:#262626">：该函数成功退出是返回</span><span data-type="color" style="color:#262626"><code>AIS_ERR_SUCCESS</code></span><span data-type="color" style="color:#262626">，错误发生时返回Breeze错误编码。</span>

<span data-type="color" style="color:#262626"><strong>参考对接</strong></span><span data-type="color" style="color:#262626">：请参考</span>[这里](https://github.com/alibaba/AliOS-Things/blob/rel_2.0.0/network/bluetooth/breeze/hal/ble/breeze_hal_ble.c)<span data-type="color" style="color:#262626">。</span>

<span data-type="color" style="color:#262626"><strong>注意</strong></span><span data-type="color" style="color:#262626">：</span>
* <span data-type="color" style="color:#262626">蓝牙连接断开后，HAL层或底层需要维护蓝牙广播的重新发出，必要时由HAL层或者底层保存传入的广播参数。</span>
* <span data-type="color" style="color:#262626">参数中未指定的广播参数（如广播最大/最小间隔时长），均建议采用特定协议栈推荐的默认参数；</span>

### <span data-type="color" style="color:#262626">ais_err_t ble_advertising_stop()</span>
<span data-type="color" style="color:#262626">该接口停止蓝牙广播。该函数会被Breeze SDK调用。</span>

<span data-type="color" style="color:#262626"><strong>参数说明</strong></span><span data-type="color" style="color:#262626">：无。</span>

<span data-type="color" style="color:#262626"><strong>返回值</strong></span><span data-type="color" style="color:#262626">：该函数成功退出是返回</span><span data-type="color" style="color:#262626"><code>AIS_ERR_SUCCESS</code></span><span data-type="color" style="color:#262626">，错误发生时返回Breeze错误编码。</span>

<span data-type="color" style="color:#262626"><strong>参考对接</strong></span><span data-type="color" style="color:#262626">：请参考</span>[这里](https://github.com/alibaba/AliOS-Things/blob/rel_2.0.0/network/bluetooth/breeze/hal/ble/breeze_hal_ble.c)<span data-type="color" style="color:#262626">。</span>

### <span data-type="color" style="color:#262626">ais_err_t ble_send_notification(uint8_t *p_data, uint16_t length)</span>
<span data-type="color" style="color:#262626">该接口通过notify方式发送数据。</span>

<span data-type="color" style="color:#262626"><strong>参数说明</strong></span><span data-type="color" style="color:#262626">：</span><span data-type="color" style="color:#262626"><code>p_data</code></span><span data-type="color" style="color:#262626">为发送数据的buffer地址（调用者传入/维护），</span><span data-type="color" style="color:#262626"><code>length</code></span><span data-type="color" style="color:#262626">为数据长度。</span>

<span data-type="color" style="color:#262626"><strong>返回值</strong></span><span data-type="color" style="color:#262626">：该函数成功退出是返回</span><span data-type="color" style="color:#262626"><code>AIS_ERR_SUCCESS</code></span><span data-type="color" style="color:#262626">，错误发生时返回Breeze错误编码。</span>

<span data-type="color" style="color:#262626"><strong>参考对接</strong></span><span data-type="color" style="color:#262626">：请参考</span>[这里](https://github.com/alibaba/AliOS-Things/blob/rel_2.0.0/network/bluetooth/breeze/hal/ble/breeze_hal_ble.c)<span data-type="color" style="color:#262626">。</span>

<span data-type="color" style="color:#262626"><strong>注意</strong></span><span data-type="color" style="color:#262626">：该函数调用完成后，调用者认为发送完毕，数据beffer可能马上会被销毁或改写，HAL层必要时对数据进行缓存。</span>

### <span data-type="color" style="color:rgb(25, 31, 37)"><span data-type="background" style="background-color:rgb(255, 255, 255)">ais_err_t ble_send_indication(uint8_t *p_data, uint16_t length, void (*txdone)(uint8_t res))</span></span>
<span data-type="color" style="color:#262626">该接口通过indicate方式发送数据。</span>

<span data-type="color" style="color:#262626"><strong>参数说明</strong></span><span data-type="color" style="color:#262626">：</span><span data-type="color" style="color:#262626"><code>p_data</code></span><span data-type="color" style="color:#262626">为发送数据的buffer地址（调用者传入/维护），</span><span data-type="color" style="color:#262626"><code>length</code></span><span data-type="color" style="color:#262626">为数据长度，</span><span data-type="color" style="color:#262626"><code>txdone</code></span><span data-type="color" style="color:#262626">为回调处理函数，由HAL实现代码在发送indication数据完毕后调用。</span>

<span data-type="color" style="color:#262626"><strong>返回值</strong></span><span data-type="color" style="color:#262626">：该函数成功退出是返回</span><span data-type="color" style="color:#262626"><code>AIS_ERR_SUCCESS</code></span><span data-type="color" style="color:#262626">，错误发生时返回Breeze错误编码。</span>

<span data-type="color" style="color:#262626"><strong>参考对接</strong></span><span data-type="color" style="color:#262626">：请参考</span>[这里](https://github.com/alibaba/AliOS-Things/blob/rel_2.0.0/network/bluetooth/breeze/hal/ble/breeze_hal_ble.c)<span data-type="color" style="color:#262626">。</span>

<span data-type="color" style="color:#262626"><strong>注意</strong></span><span data-type="color" style="color:#262626">：该函数调用完成后，调用者认为发送完毕，数据beffer可能马上会被销毁或改写，HAL层必要时对数据进行缓存。</span>

### <span data-type="color" style="color:#262626">ais_err_t ble_get_mac(uint8_t *mac)</span>
该接口用于获取蓝牙设备的MAC地址。

<span data-type="color" style="color:#262626"><strong>参数说明</strong></span><span data-type="color" style="color:#262626">：</span><span data-type="color" style="color:#262626"><code>mac</code></span><span data-type="color" style="color:#262626">用于存储获取到的蓝牙MAC地址，6字节二进制格式：0xAA，0xBB，0xCC，0xDD，0xEE，0xFF（对应MAC地址“AA:BB:CC:DD:EE:FF”）。</span>

<span data-type="color" style="color:#262626"><strong>返回值</strong></span><span data-type="color" style="color:#262626">：该函数成功退出是返回</span><span data-type="color" style="color:#262626"><code>AIS_ERR_SUCCESS</code></span><span data-type="color" style="color:#262626">，错误发生时返回Breeze错误编码。</span>
<span data-type="color" style="color:#262626">参考对接：请参考</span>[这里](https://github.com/alibaba/AliOS-Things/blob/rel_2.0.0/network/bluetooth/breeze/hal/ble/breeze_hal_ble.c)<span data-type="color" style="color:#262626">。</span>

__注意__：`mac`参数为6字节内存，由调用者负责分配和销毁，HAL实现层只负责mac字段的填充。

# OS HAL列表

OS HAL接口提供以下功能：
* 定时器支持；
* 系统重启接口；
* 系统时间戳获取和睡眠接口；
* Key-Value键值读取接口。

### int os\_timer\_new(os\_timer\_t\*timer, os\_timer\_cb\_t cb, void \*arg, int ms)
该接口用于创建定时器。

__参数说明__：`timer`为定时器指针，`cb`为定时器超时回调处理函数，`arg`为回调函数参数，`ms`为超时时间。

__返回值__：成功时时返回0，否则返回非0值。
### int os\_timer\_start(os\_timer\_t\*timer)
该接口用于启动定时器。

__参数说明__：`timer`为定时器指针。

__返回值__：成功时返回0，否则返回非0值。
### int os\_timer\_stop(os\_timer\_t\*timer)
该接口停止定时器计时。

__参数说明__：`timer`为定时器指针。

__返回值__：成功时返回0，否则返回非0值。
### void os\_timer\_free(os\_timer\_t\*timer)
该接口注销定时器。

__参数说明__：`timer`为定时器指针。

__返回值__：无。
### void os\_msleep(int ms)
该接口触发系统/进程进行睡眠。

__参数说明__：`ms`为睡眠时长，单位为毫秒。

__返回值__：无。
### long long os\_now\_ms()
该接口用于获取系统当前时间戳（从系统启动开始计数），单位为毫秒。

__参数说明__：无。

__返回值__：系统时间戳。
### void os\_reboot()
该接口使系统重启。

__参数说明__：无。

__返回值__：无。
### int os\_kv\_set(const char \*key,const void \*value, int len, int sync)
该接口用于设置永久存储Key-Value键值。

__参数说明__：`key`为键名（字符串）；`value`为键值（任意值）；`len`为键值长度；`sync`为预留参数，暂时传入1。

__返回值__：成功时返回0，否则返回非0值。
### int os\_kv\_get(const char \*key,void \*buffer, int \*buffer\_len)
该接口用于读取永久存储Key-Value键值。

__参数说明__：`key`为键名（字符串）；`buffer`为键值（任意值）；`len`为键值长度。

__返回值__：成功时返回0，否则返回非0值。
### int os\_kv\_del(const char \*key)
该接口用于删除永久存储Key-Value键值。

__参数说明__：`key`为键名（字符串）。

__返回值__：成功时返回0，否则返回非0值。
### <span data-type="color" style="color:rgb(25, 31, 37)"><span data-type="background" style="background-color:rgb(255, 255, 255)">int os_rand(void)</span></span>
该接口用于产生一个整型的随机值。

__参数说明__：无。

__返回值__：随机值。

# 安全相关的HAL 

### void \*ais\_aes128\_init(constuint8\_t \*key, const uint8\_t \*iv)
该接口对AES128加解密算法流程进行初始化。

__参数说明__：`key`为AES128 CBC算法要求的key输入，`iv`为AES128 CBC算法要求输入的iv值。

__返回值__：`void`指针，指向初始化后的context，后续加解密流程中使用该返回值。
### int ais\_aes128\_destroy(void\*aes)
该接口销毁AES128加解密算法流程，释放相关资源。

__参数说明__：`aes`为`ais_aes128_init`接口初始化之后返回的context。

__返回值__：如果成功销毁返回0，否则返回-1。
### int ais\_aes128\_cbc\_encrypt(void\*aes, const void \*src, size\_t block\_num, void \*dst)
调用该接口进行AES128 CBC加密计算。

__参数说明__：`aes`为`ais_aes128_init`接口初始化之后返回的context，`src`指针指向需要加密的数据，`block_num`为需要加密的数据块数（16字节为一块，不足16字节按一块计算），`dst`为加密后数据的存储地址。

__返回值__：成功时返回0，否则返回-1。
### int ais\_aes128\_cbc\_decrypt(void\*aes, const void \*src, size\_t block\_num, void \*dst)
调用该接口进行AES128 CBC解密计算。

__参数说明__：`aes`为`ais_aes128_init`接口初始化之后返回的context，`src`指针指向需要加密的数据，`block_num`为需要加密的数据块数（16字节为一块，不足16字节按一块计算），`dst`为解密后数据的存储地址。

__返回值__：成功时返回0，否则返回-1。

