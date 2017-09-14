------
# 1 KERNEL API
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

    [in]  name  task name, any string

    [in]  fn    task function

    [in]  arg   any pointer, will give to your task-function as argument

    [in]  stacksize  stacksize in bytes
> > - [x] ************Returns:************
      the operation status, RHINO_SUCCESS is OK, others is error

## 1.5 aos_task_new_ext()
> * int aos_task_new_ext(aos_task_t *task, const char *name, void (*fn)(void *), void *arg, int stack_size, int prio)
> > - [x] Create a task
> > - [x] ************Parameters:************

    [in]  task	      handle
    [in]  name	      task name, any string
    [in]  fn	      task function
    [in]  arg	      any pointer, will give to your task-function as argument
    [in]  stack_buf   stack-buf: if stack_buf==NULL, provided by kernel
    [in]  stack_size  stacksize in bytes
    [in]  prio	      priority value, smaller the stronger
> > - [x] ************Returns:************
      the operation status, RHINO_SUCCESS is OK, others is error

## 1.6 aos_task_exit()
> * void aos_task_exit(int code)
> > - [x] exit a task
> > - [x] ************Parameters:************

    [in]  code  the id which aos_task_new returned

## 1.7 aos_task_name()
> * 
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************


## 1.8 aos_task_key_create
> * 
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.9 aos_task_key_delete
> * 
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.10 aos_task_setspecific
> * 
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.11 aos_task_getspecific
> * 
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.12 aos_mutex_new
> * 
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.13 aos_mutex_free
> * 
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.14 aos_mutex_lock
> * 
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.15 aos_mutex_unlock
> * 
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.16 aos_mutex_is_valid
> * 
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.17 aos_sem_new
> * 
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.18 aos_sem_free
> * 
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.19 aos_sem_wait
> * 
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************


## 1.20 aos_sem_signal
> * 
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************


## 1.21 aos_sem_is_valid
> * 
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.22 aos_sem_signal_all
> * 
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.23 aos_queue_new
> * 
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.24 aos_queue_free
> * 
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.25 aos_queue_send
> * 
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.26 aos_queue_recv
> * 
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.27 aos_queue_is_valid
> * 
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.28 aos_queue_buf_ptr
> * 
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.29 aos_sched_disable
> * 
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.30 aos_sched_enable
> * 
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.31 aos_timer_new
> * 
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.32 aos_timer_free
> * 
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************


## 1.33 aos_timer_start
> * 
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************


## 1.34 aos_timer_stop
> * 
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.35 aos_timer_change
> * 
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.36 aos_workqueue_create
> * 
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.37 aos_workqueue_del
> * 
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.38 aos_work_init
> * 
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.39 aos_work_destroy
> * 
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.40 aos_work_run
> * 
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.41 aos_work_sched
> * 
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.42 aos_work_cancel
> * 
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.43 aos_realloc
> * 
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.44 aos_malloc
> * 
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.45 aos_zalloc
> * 
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.46 aos_alloc_trace
> * 
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.47 aos_free
> * 
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.48 aos_now
> * 
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.49 aos_free_ms
> * 
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.50 aos_msleep
> * 
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************