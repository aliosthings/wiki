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
