# ADC
------
## 1 hal_adc_init

```c
int32_t hal_adc_init(adc_dev_t *adc)
```

- [x] **Description**

  Initialises an ADC interface, Prepares an ADC hardware interface for sampling

- [x] **Parameters**

  | IN/OUT |  NAME  |  DESC  |
  |--------|--------|--------|
  | [in] | adc | the interface which should be initialised |

- [x] **Returns**

  0 : on success, EIO : if an error occurred with any step

## 2 hal_adc_value_get

```c
int32_t hal_adc_value_get(adc_dev_t *adc, void *output, uint32_t timeout)
```

- [x] **Description**

  Takes a single sample from an ADC interface

- [x] **Parameters**

  | IN/OUT |  NAME  |  DESC  |
  |--------|--------|--------|
  | [in] |  adc |     the interface which should be sampled   |
  | [out] | output |  pointer to a variable which will receive the sample   |
  | [in] |  timeout | ms timeout |

- [x] **Returns**

  0 : on success, EIO : if an error occurred with any step

## 3 hal_adc_finalize

```c
int32_t hal_adc_finalize(adc_dev_t *adc)
```

- [x] **Description**

  De-initialises an ADC interface, Turns off an ADC hardware interface

- [x] **Parameters**

  | IN/OUT |  NAME  |  DESC  |
  |--------|--------|--------|
  | [in] | adc | the interface which should be de-initialised |

- [x] **Returns**

  0 : on success, EIO : if an error occurred with any step

------
# FLASH
------
## 1 *hal_flash_get_info

```c
hal_logic_partition_t *hal_flash_get_info(hal_partition_t in_partition)
```

- [x] **Description**

  Get the infomation of the specified flash area

- [x] **Parameters**

  | IN/OUT |  NAME  |  DESC  |
  |--------|--------|--------|
  | [in] | in_partition | The target flash logical partition which should be erased |

- [x] **Returns**

     HAL_logi_partition struct

## 2 hal_flash_erase

```c
int32_t hal_flash_erase(hal_partition_t in_partition, uint32_t off_set, uint32_t size)
```

- [x] **Description**

  Erase an area on a Flash logical partition

- [x] **Parameters**

  | IN/OUT |  NAME  |  DESC  |
  |--------|--------|--------|
  | [in] | in_partition | The target flash logical partition which should be erased   |
  | [in] | off_set |      Start address of the erased flash area   |
  | [in] | size |         Size of the erased flash are |

- [x] **Returns**

  0 : On success, EIO : If an error occurred with any step

## 3 hal_flash_write

```c
int32_t hal_flash_write(hal_partition_t in_partition, uint32_t *off_set,
                               const void *in_buf, uint32_t in_buf_len)
```

- [x] **Description**

  Write data to an area on a flash logical partition without erase

- [x] **Parameters**

  | IN/OUT |  NAME  |  DESC  |
  |--------|--------|--------|
  | [in] | in_partition |   The target flash logical partition which should be read which should be written   |
  | [in] | off_set |        Point to the start address that the data is written to, and        point to the last unwritten address after this function is        returned, so you can call this function serval times without        update this start address.   |
  | [in] | inBuffer |       point to the data buffer that will be written to flash   |
  | [in] | inBufferLength | The length of the buffe |

- [x] **Returns**

  0 : On success, EIO : If an error occurred with any step

## 4 hal_flash_erase_write

```c
int32_t hal_flash_erase_write(hal_partition_t in_partition, uint32_t *off_set,
                                        const void *in_buf, uint32_t in_buf_len)
```

- [x] **Description**

  Write data to an area on a flash logical partition with erase first

- [x] **Parameters**

  | IN/OUT |  NAME  |  DESC  |
  |--------|--------|--------|
  | [in] | in_partition |   The target flash logical partition which should be read which should be written   |
  | [in] | off_set |        Point to the start address that the data is written to, and        point to the last unwritten address after this function is        returned, so you can call this function serval times without        update this start address.   |
  | [in] | inBuffer |       point to the data buffer that will be written to flash   |
  | [in] | inBufferLength | The length of the buffe |

- [x] **Returns**

  0 : On success, EIO : If an error occurred with any step

## 5 hal_flash_read

```c
int32_t hal_flash_read(hal_partition_t in_partition, uint32_t *off_set,
                       void *out_buf, uint32_t in_buf_len)
```

- [x] **Description**

  Read data from an area on a Flash to data buffer in RAM

- [x] **Parameters**

  | IN/OUT |  NAME  |  DESC  |
  |--------|--------|--------|
  | [in] | in_partition |   The target flash logical partition which should be read   |
  | [in] | off_set |        Point to the start address that the data is read, and        point to the last unread address after this function is        returned, so you can call this function serval times without        update this start address.   |
  | [in] | outBuffer |      Point to the data buffer that stores the data read from flash   |
  | [in] | inBufferLength | The length of the buffe |

- [x] **Returns**

  0 : On success, EIO : If an error occurred with any step

## 6 hal_flash_enable_secure

```c
int32_t hal_flash_enable_secure(hal_partition_t partition, uint32_t off_set, uint32_t size)
```

- [x] **Description**

  Set security options on a logical partition

- [x] **Parameters**

  | IN/OUT |  NAME  |  DESC  |
  |--------|--------|--------|
  | [in] | partition | The target flash logical partition   |
  | [in] | offset |    Point to the start address that the data is read, and   point to the last unread address after this function is   returned, so you can call this function serval times without   update this start address.   |
  | [in] | size |      Size of enabled flash are |

- [x] **Returns**

  0 : On success, EIO : If an error occurred with any step

## 7 hal_flash_dis_secure

```c
int32_t hal_flash_dis_secure(hal_partition_t partition, uint32_t off_set, uint32_t size)
```

- [x] **Description**

  Disable security options on a logical partition

- [x] **Parameters**

  | IN/OUT |  NAME  |  DESC  |
  |--------|--------|--------|
  | [in] | partition | The target flash logical partition   |
  | [in] | offset |    Point to the start address that the data is read, and   point to the last unread address after this function is   returned, so you can call this function serval times without   update this start address.   |
  | [in] | size |      Size of disabled flash are |

- [x] **Returns**

  0 : On success, EIO : If an error occurred with any step

------
GPIO
------
## 1 hal_gpio_init

```c
int32_t hal_gpio_init(gpio_dev_t *gpio)
```

- [x] **Description**

  Initialises a GPIO pin

- [x] **Parameters**

  | IN/OUT |  NAME  |  DESC  |
  |--------|--------|--------|
  | [in] | gpiothe gpio pin which should be initialised |  |
  | [in] | configuration | A structure containing the required gpio configuration |

- [x] **Returns**

  0 : on success, EIO : if an error occurred with any step

## 2 hal_gpio_output_high

```c
int32_t hal_gpio_output_high(gpio_dev_t *gpio)
```

- [x] **Description**

  Sets an output GPIO pin high

- [x] **Parameters**

  | IN/OUT |  NAME  |  DESC  |
  |--------|--------|--------|
  | [in] | gpio | the gpio pin which should be set high |

- [x] **Returns**

  0 : on success, EIO : if an error occurred with any step

## 3 hal_gpio_output_low

```c
int32_t hal_gpio_output_low(gpio_dev_t *gpio)
```

- [x] **Description**

  Sets an output GPIO pin low

- [x] **Parameters**

  | IN/OUT |  NAME  |  DESC  |
  |--------|--------|--------|
  | [in] | gpio | the gpio pin which should be set low |

- [x] **Returns**

  0 : on success, EIO : if an error occurred with any step

## 4 hal_gpio_output_toggle

```c
int32_t hal_gpio_output_toggle(gpio_dev_t *gpio)
```

- [x] **Description**

  Trigger an output GPIO pin's output. Using this function on a
  gpio pin which is set to input mode is undefined.

- [x] **Parameters**

  | IN/OUT |  NAME  |  DESC  |
  |--------|--------|--------|
  | [in] | gpio | the gpio pin which should be set low |

- [x] **Returns**

  0 : on success, EIO : if an error occurred with any step

## 5 hal_gpio_input_get

```c
int8_t hal_gpio_input_get(gpio_dev_t *gpio, uint32_t *value)
```

- [x] **Description**

  Get the state of an input GPIO pin. Using this function on a
  gpio pin which is set to output mode will return an undefined value.

- [x] **Parameters**

  | IN/OUT |  NAME  |  DESC  |
  |--------|--------|--------|
  | [in] | gpio |  the gpio pin which should be read   |
  | [in] | value | gpio value |

- [x] **Returns**

  0 : on success, EIO : if an error occurred with any step

## 6 hal_gpio_enable_irq

```c
int32_t hal_gpio_enable_irq(gpio_dev_t *gpio, gpio_irq_trigger_t trigger,
                            gpio_irq_handler_t handler, void *arg)
```

- [x] **Description**

  Enables an interrupt trigger for an input GPIO pin.
  Using this function on a gpio pin which is set to
  output mode is undefined.

- [x] **Parameters**

  | IN/OUT |  NAME  |  DESC  |
  |--------|--------|--------|
  | [in] | gpio |    the gpio pin which will provide the interrupt trigger   |
  | [in] | trigger | the type of trigger (rising/falling edge)   |
  | [in] | handler | a function pointer to the interrupt handler   |
  | [in] | arg |     an argument that will be passed to the interrupt handle |

- [x] **Returns**

  0 : on success, EIO : if an error occurred with any step

## 7 hal_gpio_disable_irq

```c
int32_t hal_gpio_disable_irq(gpio_dev_t *gpio)
```

- [x] **Description**

  Disables an interrupt trigger for an input GPIO pin.
  Using this function on a gpio pin which has not been set up
  using @ref hal_gpio_input_irq_enable is undefined.

- [x] **Parameters**

  | IN/OUT |  NAME  |  DESC  |
  |--------|--------|--------|
  | [in] | gpio | the gpio pin which provided the interrupt trigge |

- [x] **Returns**

  0 : on success, EIO : if an error occurred with any step

## 8 hal_gpio_clear_irq

```c
int32_t hal_gpio_clear_irq(gpio_dev_t *gpio)
```

- [x] **Description**

  Disables an interrupt trigger for an input GPIO pin.
  Using this function on a gpio pin which has not been set up
  using @ref hal_gpio_input_irq_enable is undefined.

- [x] **Parameters**

  | IN/OUT |  NAME  |  DESC  |
  |--------|--------|--------|
  | [in] | gpio | the gpio pin which provided the interrupt trigge |

- [x] **Returns**

  0 : on success, EIO : if an error occurred with any step

## 9 hal_gpio_finalize

```c
int32_t hal_gpio_finalize(gpio_dev_t *gpio)
```

- [x] **Description**

  Set a GPIO pin in default state.

- [x] **Parameters**

  | IN/OUT |  NAME  |  DESC  |
  |--------|--------|--------|
  | [in] | gpio | the gpio pin which should be deinitialised |

- [x] **Returns**

  0 : on success, EIO : if an error occurred with any step
------
I2C
------
## 1 hal_i2c_init

```c
int32_t hal_i2c_init(i2c_dev_t *i2c)
```

- [x] **Description**

  Initialises an I2C interface
  Prepares an I2C hardware interface for communication as a master or slave

- [x] **Parameters**

  | IN/OUT |  NAME  |  DESC  |
  |--------|--------|--------|
  | [in] | i2c | the device for which the i2c port should be initialised |

- [x] **Returns**

  0 : on success, EIO : if an error occurred during initialisation

## 2 hal_i2c_master_send

```c
int32_t hal_i2c_master_send(i2c_dev_t *i2c, uint16_t dev_addr, uint8_t *data, uint16_t size, uint32_t timeout)
```

- [x] **Description**

  I2c master send

- [x] **Parameters**

  | IN/OUT |  NAME  |  DESC  |
  |--------|--------|--------|
  | [in] | i2c |      the i2c device   |
  | [in] | dev_addr | device address   |
  | [in] | data |     i2c send data   |
  | [in] | size |     i2c send data size   |
  | [in] | timeout |  timeout in ms |

- [x] **Returns**

  0 : on success, EIO : if an error occurred during initialisation

## 3 hal_i2c_master_recv

```c
int32_t hal_i2c_master_recv(i2c_dev_t *i2c, uint16_t dev_addr, uint8_t *data, uint16_t size, uint32_t timeout)
```

- [x] **Description**

  I2c master recv

- [x] **Parameters**

  | IN/OUT |  NAME  |  DESC  |
  |--------|--------|--------|
  | [in] |  i2c |      the i2c device   |
  | [in] |  dev_addr | device address   |
  | [out] | data |     i2c receive data   |
  | [in] |  size |     i2c receive data size   |
  | [in] |  timeout |  timeout in ms |

- [x] **Returns**

  0 : on success, EIO : if an error occurred during initialisation

## 4 hal_i2C_slave_send

```c
int32_t hal_i2C_slave_send(i2c_dev_t *i2c, uint8_t *data, uint16_t size, uint32_t timeout)
```

- [x] **Description**

  I2c slave send

- [x] **Parameters**

  | IN/OUT |  NAME  |  DESC  |
  |--------|--------|--------|
  | [in] | i2c |     the i2c device   |
  | [in] | data |    i2c slave send data   |
  | [in] | size |    i2c slave send data size   |
  | [in] | timeout | timeout in ms |

- [x] **Returns**

  0 : on success, EIO : if an error occurred during initialisation

## 5 hal_i2c_slave_recv

```c
int32_t hal_i2c_slave_recv(i2c_dev_t *i2c, uint8_t *data, uint16_t size, uint32_t timeout)
```

- [x] **Description**

  I2c slave receive

- [x] **Parameters**

  | IN/OUT |  NAME  |  DESC  |
  |--------|--------|--------|
  | [in] |  i2c |     tthe i2c device   |
  | [out] | data |    i2c slave receive data   |
  | [in] |  size |    i2c slave receive data size   |
  | [in] |  timeout | timeout in ms |

- [x] **Returns**

  0 : on success, EIO : if an error occurred during initialisation

## 6 hal_i2c_mem_write

```c
int32_t hal_i2c_mem_write(i2c_dev_t *i2c, uint16_t dev_addr, uint16_t mem_addr, uint16_t mem_addr_size, uint8_t *data,
                          uint16_t size, uint32_t timeout)
```

- [x] **Description**

  I2c mem write

- [x] **Parameters**

  | IN/OUT |  NAME  |  DESC  |
  |--------|--------|--------|
  | [in] | i2c the i2c device |  |
  | [in] | dev_addr |      device address   |
  | [in] | mem_addr |      mem address   |
  | [in] | mem_addr_size | mem address   |
  | [in] | datai2c master send data |  |
  | [in] | sizei2c master send data size |  |
  | [in] | timeout |       timeout in ms |

- [x] **Returns**

  0 : on success, EIO : if an error occurred during initialisation

## 7 hal_i2c_mem_read

```c
int32_t hal_i2c_mem_read(i2c_dev_t *i2c, uint16_t dev_addr, uint16_t mem_addr, uint16_t mem_addr_size, uint8_t *data,
                         uint16_t size, uint32_t timeout)
```

- [x] **Description**

  I2c master mem read

- [x] **Parameters**

  | IN/OUT |  NAME  |  DESC  |
  |--------|--------|--------|
  | [in] |  i2c the i2c device |  |
  | [in] |  dev_addr |      device address   |
  | [in] |  mem_addr |      mem address   |
  | [in] |  mem_addr_size | mem address   |
  | [out] | datai2c master send data |  |
  | [in] |  sizei2c master send data size |  |
  | [in] |  timeout |       timeout in ms |

- [x] **Returns**

  0 : on success, EIO : if an error occurred during initialisation

## 8 hal_i2c_finalize

```c
int32_t hal_i2c_finalize(i2c_dev_t *i2c)
```

- [x] **Description**

  Deinitialises an I2C device

- [x] **Parameters**

  | IN/OUT |  NAME  |  DESC  |
  |--------|--------|--------|
  | [in] | i2c | the i2c device |

- [x] **Returns**

  0 : on success, EIO : if an error occurred during deinitialisation
------