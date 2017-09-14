------
# 1 RHINO API
## 1.1 aos_reboot()
> * void aos_reboot(void)	
> > - [x] System reboot

## 1.2 aos_get_hz()
> * int aos_get_hz(void)
> > - [x] get HZ

## 1.3 aos_version_get()
> * const char *aos_version_get(void)
> > - [x] Get kernel version
> > - [x] ************Returns:************
      the operation status, RHINO_SUCCESS is OK, others is error

## 1.4 aos_task_new()
> * int aos_task_new(const char *name, void(*)(void *)fn, void *arg, int stack_size)
> > - [x] Create a task
> > - [x] ************Parameters:************

    [in]  name       task name, any string

    [in]  fn         task function

    [in]  arg        any pointer, will give to your task-function as argument

    [in]  stacksize  stacksize in bytes
> > - [x] ************Returns:************
      the operation status, RHINO_SUCCESS is OK, others is error
------
# 2 ALINK API

------
# 3 CLI API

------
# 4 CLOUD API

------
# 5 DEBUG API

------
# 6 KV API
## 6.1 aos_kv_set()
> * int aos_kv_set(const char *key, const void *value, int len, int sync)
> > - [x] Add another KV pair.
> > - [x] ************Parameters:************

    [in]  key        the key of the KV pair

    [in]  value      the value of the KV pair

    [in]  len        the length of the value

    [in]  sync       save the KV pair to flash right now (should always be 1)
> > - [x] ************Returns:************
       0 on success, negative error on failure

## 6.2 aos_kv_get()
> * int aos_kv_get(const char *key, void *buffer, int *buffer_len)
> > - [x] Get the KV value stored in buffer by its key
> > - [x] ************Parameters:************

    [in]   key           the key of the KV pair you want to get

    [out]  buffer        the memory to store KV value

    [out]  buffer_len    the real length of value
> > - [x] ************Returns:************
       0 on success, negative error on failure

## 6.3 aos_kv_del()
> * int aos_kv_del(const char *key)
> > - [x] Delete the KV pair by its key
> > - [x] ************Parameters:************

    [in]   key    the key of the KV pair you want to delete
> > - [x] ************Returns:************
       0 on success, negative error on failure
------
# 7 LIST API

------
# 8 LOG API

------
# 9 MBEDTLS-SSL API

------
# 10 VERSION API

------
# 11 VFS API

------
# 12 YLOOP API

------
# 13 HAL API
## 13.1 HAL-OTA API

## 13.2 HAL-SENSOR API

## 13.3 HAL-TRACE API

## 13.4 HAL-WIFI API

## 13.5 HAL-SOC API
### 13.5.1 HAL-ADC API

### 13.5.2 HAL-FLASH API

### 13.5.3 HAL-GPIO API

### 13.5.4 HAL-I2C API

### 13.5.5 HAL-PWM API

### 13.5.6 HAL-RNG API

### 13.5.7 HAL-RTC API

### 13.5.8 HAL-SD API

### 13.5.9 HAL-SPI API

### 13.5.10 HAL-TIMER API

### 13.5.11 HAL-UART API

### 13.5.12 HAL-WDG API
