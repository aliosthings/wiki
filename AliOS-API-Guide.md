------
## 1 RHINO API
### 1.1 aos_reboot()
> * void aos_reboot(void)	
> > - [x] System reboot

### 1.2 aos_get_hz()
> * int aos_get_hz(void)
> > - [x] get HZ

### 1.3 aos_version_get()
> * const char *aos_version_get(void)
> > - [x] Get kernel version
> > - [x] ************Returns:************
      the operation status, RHINO_SUCCESS is OK, others is error

### 1.4 aos_task_new()
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
## 2 
------
## 3
