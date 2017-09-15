请在各子wiki填写，谢谢！可参考kv vfs
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
> > - [x] Add another KV pair
> > - [x] ************Parameters:************

    [in]  key    the key of the KV pair

    [in]  value  the value of the KV pair

    [in]  len    the length of the value

    [in]  sync   save the KV pair to flash right now (should always be 1)
> > - [x] ************Returns:************
       0 on success, negative error on failure

## 6.2 aos_kv_get()
> * int aos_kv_get(const char *key, void *buffer, int *buffer_len)
> > - [x] Get the KV value stored in buffer by its key
> > - [x] ************Parameters:************

    [in]   key         the key of the KV pair you want to get

    [out]  buffer      the memory to store KV value

    [out]  buffer_len  the real length of value
> > - [x] ************Returns:************
       0 on success, negative error on failure

## 6.3 aos_kv_del()
> * int aos_kv_del(const char *key)
> > - [x] Delete the KV pair by its key
> > - [x] ************Parameters:************

    [in]  key  the key of the KV pair you want to delete
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
## 11.1 aos_open()
> * int aos_open(const char *path, int flags)
> > - [x] Open the file or device by its path
> > - [x] ************Parameters:************

    [in]  path   the path of the file or device you want to open

    [in]  flags  the mode of open operation
> > - [x] ************Returns:************
       the new file descriptor, negative error on failure

## 11.2 aos_close()
> * int aos_close(int fd)
> > - [x] Close the file or device by its fd
> > - [x] ************Parameters:************

    [in]  fd  the handle of the file or device
> > - [x] ************Returns:************
       0 on success, negative error on failure

## 11.3 aos_read()
> * ssize_t aos_read(int fd, void *buf, size_t nbytes)
> > - [x] Read the contents of a file or device into a buffer
> > - [x] ************Parameters:************

    [in]   fd      the handle of the file or device

    [in]   nbytes  the number of bytes to read

    [out]  buf     the buffer to read into
> > - [x] ************Returns:************
       The number of bytes read, 0 at the end of file, negative error on failure

## 11.3 aos_write()
> * ssize_t aos_write(int fd, const void *buf, size_t nbytes)
> > - [x] Write the contents of a buffer to file or device
> > - [x] ************Parameters:************

    [in]  fd      the handle of the file or device

    [in]  nbytes  the number of bytes to write

    [in]  buf     the buffer to write from
> > - [x] ************Returns:************
       The number of bytes written, negative error on failure

## 11.4 aos_ioctl()
> * int aos_ioctl(int fd, int cmd, unsigned long arg)
> > - [x] This is a wildcard API for sending controller specific commands
> > - [x] ************Parameters:************

    [in]  fd   the handle of the file or device

    [in]  cmd  a controller specific command

    [in]  arg  argument to the command, interpreted according to the command
> > - [x] ************Returns:************
       Any return from the command

## 11.5 aos_poll()
> * int aos_poll(struct pollfd *fds, int nfds, int timeout)
> > - [x] A mechanism to multiplex input/output over a set of file handles(file descriptors)  
          For every file handle provided, poll() examines it for any events registered for that particular file handles
> > - [x] ************Parameters:************

    [in]  fds      a point to the array of PollFh struct carrying a file handle and bitmask of events

    [in]  nfds     number of file handles

    [in]  timeout  timer value to timeout or -1 for loop forever
> > - [x] ************Returns:************
       Number of file handles selected (for which revents is non-zero). 0 if timed out with nothing selected. -1 for error.

## 11.6 aos_fcntl()
> * int aos_fcntl(int fd, int cmd, int val)
> > - [x] Performs one of the operations described below on the open file descriptor, The operation is determined by cmd
> > - [x] ************Parameters:************

    [in]  fd   the handle of the file or device

    [in]  cmd  the operation of the file or device

    [in]  val  it depends on whether cmd need params
> > - [x] ************Returns:************
       0 on success, negative error on failure

## 11.7 aos_lseek()
> * off_t aos_lseek(int fd, off_t offset, int whence)
> > - [x] Move the file position to a given offset from a given location
> > - [x] ************Parameters:************

    [in]  fd      file handle

    [in]  offset  the offset from whence to move to

    [in]  whence  the start of where to seek
> > - [x] ************Returns:************
       The new offset of the file

## 11.8 aos_sync()
> * int aos_sync(int fd)
> > - [x] Flush any buffers associated with the file
> > - [x] ************Parameters:************

    [in]  fd  file handle
> > - [x] ************Returns:************
       0 on success, negative error code on failure

## 11.9 aos_stat()
> * int aos_stat(const char *path, struct stat *st)
> > - [x] Store information about the file in a stat structure
> > - [x] ************Parameters:************

    [in]  path  the name of the file to find information about

    [in]  st    the stat buffer to write to
> > - [x] ************Returns:************
       0 on success, negative error code on failure

## 11.10 aos_unlink()
> * int aos_unlink(const char *path)
> > - [x] Remove a file from the filesystem
> > - [x] ************Parameters:************

    [in]  path  the name of the file to remove
> > - [x] ************Returns:************
       0 on success, negative error code on failure

## 11.11 aos_rename()
> * int aos_rename(const char *oldpath, const char *newpath)
> > - [x] Rename a file in filesystem
> > - [x] ************Parameters:************

    [in]  oldpath  the name of the file to rename

    [in]  newpath  the name to rename it to
> > - [x] ************Returns:************
       0 on success, negative error code on failure

## 11.12 aos_opendir()
> * aos_dir_t *aos_opendir(const char *path)
> > - [x] Open a directory on the filesystem
> > - [x] ************Parameters:************

    [in]  path  name of the directory to open
> > - [x] ************Returns:************
       A point of directory stream on success, NULL on failure

## 11.13 aos_closedir()
> * int aos_closedir(aos_dir_t *dir)
> > - [x] Close a directory
> > - [x] ************Parameters:************

    [in]  dir  directory handle
> > - [x] ************Returns:************
       0 on success, negative error code on failure

## 11.14 aos_readdir()
> * aos_dirent_t *aos_readdir(aos_dir_t *dir)
> > - [x] Read the next directory enter
> > - [x] ************Parameters:************

    [in]  dir  directory handle
> > - [x] ************Returns:************
       a pointer to a dirent structure

## 11.15 aos_mkdir()
> * int aos_mkdir(const char *path)
> > - [x] Create the directory, if they do not already exist
> > - [x] ************Parameters:************

    [in]  path  the name of the directory
> > - [x] ************Returns:************
       0 on success, negative error code on failure
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
