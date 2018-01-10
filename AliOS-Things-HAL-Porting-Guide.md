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
由于hal层对于组件属性的宏定义和驱动层并非完全一致，如hal层要配置uart的数据位为8位，应该配置uart_config_t的hal_uart_data_width_t成员为DATA_WIDTH_8BIT（值为3），但是对应到STM32L4的初始化，要配置uart的数据位为8，则应该配置UART_InitTypeDef的WordLength为UART_WORDLENGTH_8B（值为0），因而必须对这些进行装换，定义如下函数进行转换：
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
然后逐一实现hal层的函数

初始化

```C
int32_t hal_uart_init(uart_dev_t *uart)
{
    int32_t ret = -1;

    if (uart == NULL) {
        return -1;
     }

    switch (uart->port) {
        case PORT_UART1:
      	    uart->priv = &uart1_handle;				
            ret = uart1_init(uart);
            break;
        case PORT_UART2:
      	    uart->priv = &uart2_handle;				
            ret = uart2_init(uart);
            break;
        /* if ohter uart exist add init code here */

        default:
            break;
    }

    return ret;
}

int32_t uart1_init(uart_dev_t *uart)
{
    int32_t ret = 0;

    uart1_handle.Instance                    = UART1;
    uart1_handle.Init.BaudRate               = uart->config.baud_rate;

    ret = uart_dataWidth_transform(uart->config.data_width, 
          &uart1_handle.Init.WordLength);
    ret |= uart_parity_transform(uart->config.parity, 
           &uart1_handle.Init.Parity);
    ret |= uart_stop_bits_transform(uart->config.stop_bits, 
           &uart1_handle.Init.StopBits);
    ret |= uart_flow_control_transform(uart->config.flow_control, 
           &uart1_handle.Init.HwFlowCtl);
    ret |= uart_mode_transform(uart->config.mode, 
           &uart1_handle.Init.Mode);

    if (ret != 0) {
        return -1;
    }

    uart1_handle.Init.HwFlowCtl              = UART1_HW_FLOW_CTL;
    uart1_handle.Init.OverSampling           = UART1_OVER_SAMPLING;
    uart1_handle.Init.OneBitSampling         = UART1_ONE_BIT_SAMPLING;
    uart1_handle.AdvancedInit.AdvFeatureInit = UART1_ADV_FEATURE_INIT;
    uart1_handle.buffer_queue = &g_buf_queue_uart1;

    /* init uart */
    uart1_MspInit();
    HAL_UART_Init(&uart1_handle);

    ret = krhino_buf_queue_create(&g_buf_queue_uart1, "buf_queue_uart",
          g_buf_uart1, MAX_BUF_UART_BYTES, 1);
		
    return ret;
}

void uart1_MspInit(void)
{
    GPIO_InitTypeDef gpio_init_structure;

    /* Enable GPIO clock */
    UART1_TX_GPIO_CLK_ENABLE();
    UART1_RX_GPIO_CLK_ENABLE();

    /* Enable USART clock */
    UART1_CLK_ENABLE();
 
    /* Configure USART Tx as alternate function */
    gpio_init_structure.Pin       = UART1_TX_PIN;
    gpio_init_structure.Mode      = UART1_TX_MODE;
    gpio_init_structure.Speed     = UART1_TX_SPEED;
    gpio_init_structure.Pull      = UART1_TX_PULL;
    gpio_init_structure.Alternate = UART1_TX_ALTERNATE;
    HAL_GPIO_Init(UART1_TX_GPIO_PORT, &gpio_init_structure);

    /* Configure USART Rx as alternate function */
    gpio_init_structure.Pin       = UART1_RX_PIN;
    gpio_init_structure.Mode      = UART1_RX_MODE;
    gpio_init_structure.Alternate = UART1_RX_ALTERNATE;
    HAL_GPIO_Init(UART1_RX_GPIO_PORT, &gpio_init_structure);

    HAL_NVIC_SetPriority(UART1_IRQn, 0, 1);
    HAL_NVIC_EnableIRQ(UART1_IRQn);
}

int32_t uart2_init(uart_dev_t *uart)
{
    int32_t ret = 0;

    uart2_handle.Instance                    = UART2;
    uart2_handle.Init.BaudRate               = uart->config.baud_rate;

    ret = uart_dataWidth_transform(uart->config.data_width, 
          &uart2_handle.Init.WordLength);
    ret |= uart_parity_transform(uart->config.parity, 
           &uart2_handle.Init.Parity);
    ret |= uart_stop_bits_transform(uart->config.stop_bits, 
           &uart2_handle.Init.StopBits);
    ret |= uart_flow_control_transform(uart->config.flow_control, 
           &uart2_handle.Init.HwFlowCtl);
    ret |= uart_mode_transform(uart->config.mode, 
           &uart2_handle.Init.Mode);

    if (ret != 0) {
        return -1;
    }

    uart2_handle.Init.HwFlowCtl              = UART2_HW_FLOW_CTL;
    uart2_handle.Init.OverSampling           = UART2_OVER_SAMPLING;
    uart2_handle.Init.OneBitSampling         = UART2_ONE_BIT_SAMPLING;
    uart2_handle.AdvancedInit.AdvFeatureInit = UART2_ADV_FEATURE_INIT;
    uart2_handle.buffer_queue = &g_buf_queue_uart2;

    /* init uart */
    uart2_MspInit();
    HAL_UART_Init(&uart2_handle);

    ret = krhino_buf_queue_create(&g_buf_queue_uart2, "buf_queue_uart",
          g_buf_uart2, MAX_BUF_UART_BYTES, 1);
		
    return ret;
}

void uart2_MspInit(void)
{
    GPIO_InitTypeDef gpio_init_structure;

    /* Enable GPIO clock */
    UART2_TX_GPIO_CLK_ENABLE();
    UART2_RX_GPIO_CLK_ENABLE();

    /* Enable USART clock */
    UART2_CLK_ENABLE();
 
    /* Configure USART Tx as alternate function */
    gpio_init_structure.Pin       = UART2_TX_PIN;
    gpio_init_structure.Mode      = UART2_TX_MODE;
    gpio_init_structure.Speed     = UART2_TX_SPEED;
    gpio_init_structure.Pull      = UART2_TX_PULL;
    gpio_init_structure.Alternate = UART2_TX_ALTERNATE;
    HAL_GPIO_Init(UART2_TX_GPIO_PORT, &gpio_init_structure);

    /* Configure USART Rx as alternate function */
    gpio_init_structure.Pin       = UART2_RX_PIN;
    gpio_init_structure.Mode      = UART2_RX_MODE;
    gpio_init_structure.Alternate = UART2_RX_ALTERNATE;
    HAL_GPIO_Init(UART2_RX_GPIO_PORT, &gpio_init_structure);

    HAL_NVIC_SetPriority(UART2_IRQn, 0,1);
    HAL_NVIC_EnableIRQ(UART2_IRQn);
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