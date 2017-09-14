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

    [in]  stack_buf   if stack_buf==NULL, provided by kernel

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
> * const char *aos_task_name(void)
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************


## 1.8 aos_task_key_create()
> * int aos_task_key_create(aos_task_key_t *key)
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.9 aos_task_key_delete()
> * void aos_task_key_delete(aos_task_key_t key)
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.10 aos_task_setspecific()
> * int aos_task_setspecific(aos_task_key_t key, void *vp)
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.11 aos_task_getspecific()
> * void *aos_task_getspecific(aos_task_key_t key)
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.12 aos_mutex_new()
> * int aos_mutex_new(aos_mutex_t *mutex)
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.13 aos_mutex_free()
> * void aos_mutex_free(aos_mutex_t *mutex)
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.14 aos_mutex_lock()
> * int aos_mutex_lock(aos_mutex_t *mutex, unsigned int timeout)
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.15 aos_mutex_unlock()
> * int aos_mutex_unlock(aos_mutex_t *mutex)
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.16 aos_mutex_is_valid()
> * int aos_mutex_is_valid(aos_mutex_t *mutex)
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.17 aos_sem_new()
> * int aos_sem_new(aos_sem_t *sem, int count)
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.18 aos_sem_free()
> * void aos_sem_free(aos_sem_t *sem)
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.19 aos_sem_wait()
> * int aos_sem_wait(aos_sem_t *sem, unsigned int timeout)
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************


## 1.20 aos_sem_signal()
> * void aos_sem_signal(aos_sem_t *sem)
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************


## 1.21 aos_sem_is_valid()
> * int aos_sem_is_valid(aos_sem_t *sem)
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.22 aos_sem_signal_all()
> * void aos_sem_signal_all(aos_sem_t *sem)
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.23 aos_queue_new()
> * int aos_queue_new(aos_queue_t *queue, void *buf, unsigned int size, int max_msg)
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.24 aos_queue_free()
> * void aos_queue_free(aos_queue_t *queue)
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.25 aos_queue_send()
> * int aos_queue_send(aos_queue_t *queue, void *msg, unsigned int size)
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.26 aos_queue_recv()
> * int aos_queue_recv(aos_queue_t *queue, unsigned int ms, void *msg, unsigned int *size)
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.27 aos_queue_is_valid()
> * int aos_queue_is_valid(aos_queue_t *queue)
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.28 aos_queue_buf_ptr()
> * void *aos_queue_buf_ptr(aos_queue_t *queue)
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.29 aos_sched_disable()
> * int aos_sched_disable(void)
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.30 aos_sched_enable()
> * int aos_sched_enable(void)
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.31 aos_timer_new()
> * int aos_timer_new(aos_timer_t *timer, void(*fn)(void *, void *), void *arg, int ms, int repeat)
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.32 aos_timer_free()
> * void aos_timer_free(aos_timer_t *timer)
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************


## 1.33 aos_timer_start()
> * int aos_timer_start(aos_timer_t *timer)
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************


## 1.34 aos_timer_stop()
> * int aos_timer_stop(aos_timer_t *timer)
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.35 aos_timer_change()
> * int aos_timer_change(aos_timer_t *timer, int ms)
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.36 aos_workqueue_create()
> * int aos_workqueue_create(aos_workqueue_t *workqueue, int pri, int stack_size)
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.37 aos_workqueue_del()
> * void aos_workqueue_del(aos_workqueue_t *workqueue)
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.38 aos_work_init()
> * int aos_work_init(aos_work_t *work, void(*fn)(void *), void *arg, int dly)
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.39 aos_work_destroy()
> * void aos_work_destroy(aos_work_t *work)
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.40 aos_work_run()
> * int aos_work_run(aos_workqueue_t *workqueue, aos_work_t *work)
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.41 aos_work_sched()
> * int aos_work_sched(aos_work_t *work)
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.42 aos_work_cancel()
> * int aos_work_cancel(aos_work_t *work)
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.43 aos_realloc()
> * void *aos_realloc(void *mem, unsigned int size)
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.44 aos_malloc()
> * void *aos_malloc(unsigned int size)
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.45 aos_zalloc()
> * void *aos_zalloc(unsigned int size)
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.46 aos_alloc_trace()
> * void aos_alloc_trace(void *addr, size_t allocator)
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.47 aos_free()
> * void aos_free(void *mem)
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.48 aos_now()
> * long long aos_now(void)
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.49 aos_free_ms()
> * long long aos_now_ms(void)
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************

## 1.50 aos_msleep()
> * void aos_msleep(int ms)
> > - [x]
> > - [x] ************Parameters:************

    [in] 

    [in] 

    [in]  

    [in]  
> > - [x] ************Returns:************