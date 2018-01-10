# 目录
  * [1 硬件抽象层移植](#1硬件抽象层移植)
  * [2 flash抽象层对接](#2flash抽象层对接)
---

## 1硬件抽象层移植
硬件抽象层HAL抽象层普遍存在于各个操作系统之中，最主要的目的是为了屏蔽不同芯片平台的差异，从而使上面的应用软件不会随芯片而改变。目前AliOS Things定义了全面的HAL抽象层，只要对接相应的HAL接口就能控制芯片的控制器，从而达到控制硬件外设的目的。

### AliOS Things定义的HAL层硬件如下:

| 1 |  adc |
| ------ | ------ |
| 2 | flash |
| 3 | gpio |
| 4 | i2c |
| 5 | pwm |
| 6 | rng |
| 7 | rtc |
| 8 | sd |
| 9 | spi |
| 10 | timer |
| 11 | uart |
| 12 | wdg |

目前HAL抽象层的定义已经能兼容多家芯片公司的标准，比如STM32，Beken，全志，NXP等芯片厂商，用户可参照已有平台的HAL封装实现。

下面举一个uart实际封装的例子来说明是如何移植的：

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

下面以STM32L4系列为例介绍hal层具体porting步骤：

由于STM32L4的驱动函数和hal层定义的接口并非完全一致，我们需要在STM32L4驱动上封装一层，以对接hal层。

以uart为例，对接uart1和uart2，我们需要新建两个文件hal_uart_stm32l4.c和hal_uart_stm32l4.h，将封装层代码放到这两个文件中。

在hal_uart_stm32l4.c中，首先定义相应的STM32L4的uart句柄：
```C
/* handle for uart */
UART_HandleTypeDef uart1_handle;
UART_HandleTypeDef uart2_handle;
```
由于hal层对于组件属性的宏定义和驱动层并非完全一致，如hal层要配置uart的数据位为8位应该配置uart_config_t的hal_uart_data_width_t成员为DATA_WIDTH_8BIT（值为3），但是对应到STM32L4的初始化，要配置uart的数据位为8，则应该配置UART_InitTypeDef的WordLength为UART_WORDLENGTH_8B（值为0），因而必须对这些进行装换，定义如下函数进行转换：
```C
/* function used to transform hal para to stm32l4 para */
static int32_t uart_dataWidth_transform(hal_uart_data_width_t data_width_hal, 
               uint32_t *data_width_stm32l4);
static int32_t uart_parity_transform(hal_uart_parity_t parity_hal, 
               uint32_t *parity_stm32l4);
static int32_t uart_stop_bits_transform(hal_uart_stop_bits_t stop_bits_hal, 
               uint32_t *stop_bits_stm32l4);
static int32_t uart_flow_control_transform(hal_uart_flow_control_t flow_control_hal, 
               uint32_t *flow_control_stm32l4);
static int32_t uart_mode_transform(hal_uart_mode_t mode_hal, uint32_t *mode_stm32l4);

int32_t uart_dataWidth_transform(hal_uart_data_width_t data_width_hal,
        uint32_t *data_width_stm32l4)
{
    uint32_t data_width = 0;
    int32_t	ret = 0;

    if(data_width_hal == DATA_WIDTH_7BIT)
    {
        data_width = UART_WORDLENGTH_7B;
    }
    else if(data_width_hal == DATA_WIDTH_8BIT)
    {
        data_width = UART_WORDLENGTH_8B;
    }
    else if(data_width_hal == DATA_WIDTH_9BIT)
    {
        data_width = UART_WORDLENGTH_9B;
    }
    else
    {
        ret = -1;
    }

    if(ret == 0)
    {
        *data_width_stm32l4 = data_width;
    }

    return ret;
}

int32_t uart_parity_transform(hal_uart_parity_t parity_hal,
        uint32_t *parity_stm32l4)
{
    uint32_t parity = 0;
    int32_t	ret = 0;

    if(parity_hal == NO_PARITY)
    {
        parity = UART_PARITY_NONE;
    }
    else if(parity_hal == ODD_PARITY)
    {
        parity = UART_PARITY_EVEN;
    }
    else if(parity_hal == EVEN_PARITY)
    {
        parity = UART_PARITY_ODD;
    }
    else
    {
        ret = -1;
    }

    if(ret == 0)
    {
        *parity_stm32l4 = parity;
    }

    return ret;
}

int32_t uart_stop_bits_transform(hal_uart_stop_bits_t stop_bits_hal,
        uint32_t *stop_bits_stm32l4)
{
    uint32_t stop_bits = 0;
    int32_t	ret = 0;

    if(stop_bits_hal == STOP_BITS_1)
    {
        stop_bits = UART_STOPBITS_1;
    }
    else if(stop_bits_hal == STOP_BITS_2)
    {
        stop_bits = UART_STOPBITS_2;
    }
    else
    {
        ret = -1;
    }

    if(ret == 0)
    {
        *stop_bits_stm32l4 = stop_bits;
    }

    return ret;
}

int32_t uart_flow_control_transform(hal_uart_flow_control_t flow_control_hal,
        uint32_t *flow_control_stm32l4)
{
    uint32_t flow_control = 0;
    int32_t	ret = 0;

    if(flow_control_hal == FLOW_CONTROL_DISABLED)
    {
        flow_control = UART_HWCONTROL_NONE;
    }
    else if(flow_control_hal == FLOW_CONTROL_CTS)
    {
        flow_control = UART_HWCONTROL_CTS;
    }
    else if(flow_control_hal == FLOW_CONTROL_RTS)
    {
        flow_control = UART_HWCONTROL_RTS;
    }
    else if(flow_control_hal == FLOW_CONTROL_RTS)
    {
    	flow_control = UART_HWCONTROL_RTS_CTS;
    }
    else
    {
    	ret = -1;
    }

    if(ret == 0)
    {
    	*flow_control_stm32l4 = flow_control;
    }

    return ret;
}

int32_t uart_mode_transform(hal_uart_mode_t mode_hal, uint32_t *mode_stm32l4)
{
    uint32_t mode = 0;
    int32_t	ret = 0;

    if(mode_hal == MODE_TX)
    {
        mode = UART_MODE_TX;
    }
    else if(mode_hal == MODE_RX)
    {
        mode = UART_MODE_RX;
    }
    else if(mode_hal == MODE_TX_RX)
    {
        mode = UART_MODE_TX_RX;
    } 
    else
    {
        ret = -1;
    }

    if(ret == 0)
    {
        *mode_stm32l4 = mode;
    }

    return ret;
}

```



### 2.2 KV组件移植（与flash hal层相关）
 * 开发者需要实现相关flash hal层接口；
 * 开发者需通过在Makefile中声明组件依赖关系：$(NAME)_COMPONENTS += modules.fs.kv；
 * 开发者需通过CONFIG_AOS_KV_PTN宏定义指定KV组件所使用的flash分区号；
 * 若开发者所使用的flash介质的最小擦除单位大于4096 bytes，需调整KV组件内的逻辑块大小（默认为4096 bytes）；
 * 开发者需通过CONFIG_AOS_KV_BUFFER_SIZE宏定义指定KV组件所使用的flash分区大小（不能小于2个kv组件的逻辑块大小，默认值为8192 bytes）；
 * kv键值长度限制：
    * 最大键(key)长度小于255 bytes;
    * 最大值(value)长度可通过ITEM_MAX_VAL_LEN宏定义进行设置，预设值为512 bytes。