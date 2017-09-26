# 目录
  * [1 硬件抽象层移植](#1硬件抽象层移植)
  * [2 flash抽象层对接](#2flash抽象层对接)
---

## 1硬件抽象层移植
硬件抽象层HAL抽象层普遍存在于各个操作系统之中，最主要的目的是为了屏蔽底下不同的芯片平台的差异，从而使上面的应用软件不会因为不同的芯片而改变。目前AliOS Things定义了全面的HAL抽象层，芯片公司或者用户只要对接相应的HAL接口既能满足控制芯片的控制器，从而达到控制硬件外设的目的。

### AliOS Things定义的HAL层硬件如下:

| 1 |  adc |
| ------ | ------ |
| 2 | flash |
| 3 | gpio |
|4 | i2c|
|5 | pwm|
|6 | rng||
|7 | rtc|
|8 | sd|
|9  |spi|
|10 |timer|
|11 |uart|
|12| wdg|

目前HAL抽象层的定义已经能兼容多家芯片公司的标准，比如STM32，Beken，全志，NXP等等芯片厂商，所以此块定义的API非常标准，用户参照已有平台的HAL封装既能实现。

下面举一个uart实际封装的例子来说明是如何移植的。

  ```C
    int32_t hal_uart_init(uart_dev_t *uart)
    {

        xxx_uart_init(uart)；

    }
  ```

    xxx_uart_init的意思是指不同芯片厂商的 uart初始化。

 ```C
    int32_t hal_uart_send(uart_dev_t *uart, void *data, uint32_t size, uint32_t timeout)
    {

        xxx_uart_send(uart, data, size, timeout);

    }
  ```

    xxx_uart_send的意思是指不同芯片厂商的uart发送函数。

  其余的HAL层API的封装以此类推。

## 2flash抽象层对接
### 2.1 flash 抽象层对接
flash抽象层移植代码示例，[参考实现](https://github.com/alibaba/AliOS-Things/blob/master/platform/mcu/stm32l4xx/hal/flash_port.c)。  
主要涉及到以下函数的相关修改：
```C
  hal_logic_partition_t *hal_flash_get_info(hal_partition_t in_partition)

  int32_t hal_flash_erase(hal_partition_t in_partition, uint32_t off_set, uint32_t size)

  int32_t hal_flash_write(hal_partition_t in_partition, uint32_t *off_set,
                          const void *in_buf, uint32_t in_buf_len)

  int32_t hal_flash_erase_write(hal_partition_t in_partition, uint32_t *off_set,
                                const void *in_buf, uint32_t in_buf_len)

  int32_t hal_flash_read(hal_partition_t in_partition, uint32_t *off_set, void *out_buf,
                         uint32_t in_buf_len)

  int32_t hal_flash_enable_secure(hal_partition_t partition, uint32_t off_set,
                                  uint32_t size)  

  int32_t hal_flash_dis_secure(hal_partition_t partition, uint32_t off_set, uint32_t size)
```

### KV组件移植（与flash hal层相关）
 * 开发者需要实现相关flash hal层接口；
 * 开发者需通过在Makefile中声明组件依赖关系：$(NAME)_COMPONENTS += modules.fs.kv；
 * 开发者需通过CONFIG_AOS_KV_PTN宏定义指定KV组件所使用的flash分区号；
 * 若开发者所使用的flash介质的最小擦除单位大于4096 bytes，需调整KV组件内的逻辑块大小（默认为4096 bytes）；
 * 开发者需通过CONFIG_AOS_KV_BUFFER_SIZE宏定义指定KV组件所使用的flash分区大小（不能小于2个kv组件的逻辑块大小，默认值为8192 bytes）；
 * kv键值长度限制：
    * 最大键(key)长度小于255 bytes;
    * 最大值(value)长度可通过ITEM_MAX_VAL_LEN宏定义进行设置，预设值为512 bytes;
