## CLOUD API
## 1.1 aos_cloud_register_callback()
> * int aos_cloud_register_callback(int cb_type, aos_cloud_cb_t cb)
> > - [x] Register cloud event callback
> > - [x] ************Parameters:************

    [in]  cb_type        event type interested
    [in]  aos_cloud_cb_t cloud event callback

> > - [x] ************Returns:************
      the operation status, 0 is OK, others is error

## 1.2 aos_get_hz()
> * int aos_get_hz(void)
> > - [x] get HZ

## 1.3 aos_version_get()
> * const char *aos_version_get(void)
> > - [x] Get kernel version
> > - [x] ************Returns:************
      the operation status, RHINO_SUCCESS is OK, others is error

## 1.4 aos_task_new()
```c
int aos_task_new(const char *name, void(*)(void *)fn, void *arg, int stack_size)
```
* Create a task

- [x] ************Parameters:************

-    [in]  name       task name, any string
-    [in]  fn         task function
    [in]  arg        any pointer, will give to your task-function as argument
    [in]  stacksize  stacksize in bytes

- [x] ************Returns:************
      the operation status, RHINO_SUCCESS is OK, others is error

## 1.5 aos_task_new_ext()
> * int aos_task_new_ext(aos_task_t *task, const char *name, void (*fn)(void *), void *arg, int stack_size, int prio)
> > - [x] Create a task
> > - [x] ************Parameters:************

    [in]  task        handle
    [in]  name        task name, any string
    [in]  fn          task function
    [in]  arg         any pointer, will give to your task-function as argument
    [in]  stack_buf   if stack_buf==NULL, provided by kernel
    [in]  stack_size  stacksize in bytes
    [in]  prio        priority value, smaller the stronger

> > - [x] ************Returns:************
      the operation status, RHINO_SUCCESS is OK, others is error

## 1.6 aos_task_exit()
> * void aos_task_exit(int code)
> > - [x] exit a task
> > - [x] ************Parameters:************

    [in]  code  the id which aos_task_new returned

## 1.7 aos_task_name()
> * const char *aos_task_name(void)
> > - [x] get task name
> > - [x] ************Returns:************
      task name
