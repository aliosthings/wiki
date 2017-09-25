# 目录
  * [1 硬件抽象层移植](#1硬件抽象层移植)
  * [2 kv组件移植开发注意事项](#2kv组件移植开发注意事项)
---

## 1硬件抽象层移植
硬件抽象层HAL抽象层普遍存在于各个操作系统之中，最主要的目的是为了屏蔽底下不同的芯片平台的差异，从而使上面的应用软件不会因为不同的芯片而改变。目前ALiOS定义了全面的hal抽象层，芯片公司或者用户只要对接相应的hal接口既能满足控制芯片的控制器，从而达到控制硬件外设的目的。

### 目前ALiOS定义的hal层硬件主要有以下:

| 1 |  adc |
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

目前hal抽象层的定义已经能兼容多家芯片公司的标准，比如STM32，Beken，全志，NXP等等芯片厂商，所以此块定义的API非常标准，用户参照已有平台的hal封装既能实现。

下面举一个uart实际封装的例子来说明是如何移植的。

int32_t hal_uart_init(uart_dev_t *uart)

{

  xxx_uart_init(uart)；

}

xxx_uart_init的意思是指不同芯片厂商的 uart初始化。

int32_t hal_uart_send(uart_dev_t *uart, void *data, uint32_t size, uint32_t timeout)

{

  xxx_uart_send(uart, data, size, timeout);

}

xxx_uart_send的意思是指不同芯片厂商的uart发送函数。

其余的hal层api的封装以此类推。

## 2kv组件移植开发注意事项
* 开发者需要实现相关Flash HAL层接口；
* 开发者需通过在Makefile中声明组件依赖关系：$(NAME)_COMPONENTS += modules.fs.kv；
* 开发者需通过CONFIG_AOS_KV_PTN宏定义指定kv组件所使用的flash分区号；
* 若开发者所使用的flash介质的最小擦除单位大于4096 bytes，需调整kv组件内的逻辑块大小（默认为4096 bytes）；
* 开发者需通过CONFIG_AOS_KV_BUFFER_SIZE宏定义指定kv组件所使用的flash分区大小（不能小于2个kv组件的逻辑块大小，默认值为8192 bytes）；
* kv键值长度限制：
    * 最大键(key)长度小于255 bytes;
    * 最大值(value)长度可通过ITEM_MAX_VAL_LEN宏定义进行设置，预设值为512 bytes;
