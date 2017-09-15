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

    [in]  name       task name, any string
    [in]  fn         task function
    [in]  arg        any pointer, will give to your task-function as argument
    [in]  stacksize  stacksize in bytes

> > - [x] ************Returns:************
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

## 1.8 aos_task_key_create()
> * int aos_task_key_create(aos_task_key_t *key)
> > - [x] create a task key
> > - [x] ************Parameters:************

    [in]  key  pointer of key object

> > - [x] ************Returns:************
      the check status, 0 is OK, -1 indicates invalid

## 1.9 aos_task_key_delete()
> * void aos_task_key_delete(aos_task_key_t key)
> > - [x] delete a task key
> > - [x] ************Parameters:************

    [in]  key  key object

## 1.10 aos_task_setspecific()
> * int aos_task_setspecific(aos_task_key_t key, void *vp)
> > - [x] associate a task-specific value with a key
> > - [x] ************Parameters:************

    [in]  key  key object
    [in]  vp   pointer of a task-specific value

> > - [x] ************Returns:************
      the check status, 0 is OK, -1 indicates invalid

## 1.11 aos_task_getspecific()
> * void *aos_task_getspecific(aos_task_key_t key)
> > - [x] get the value currently bound to the specified key
> > - [x] ************Parameters:************

    [in]  key  pointer of key object

> > - [x] ************Returns:************
      the check status, 0 is OK, -1 indicates invalid

## 1.12 aos_mutex_new()
> * int aos_mutex_new(aos_mutex_t *mutex)
> > - [x] alloc a mutex
> > - [x] ************Parameters:************

    [in]  mutex  pointer of mutex object,mutex object must be alloced, hdl pointer in aos_mutex_t will refer a kernel obj internally

> > - [x] ************Returns:************
      0 is OK

## 1.13 aos_mutex_free()
> * void aos_mutex_free(aos_mutex_t *mutex)
> > - [x] free a mutex
> > - [x] ************Parameters:************

    [in]  mutex  mutex object, mem refered by hdl pointer in aos_mutex_t will be freed internally 

## 1.14 aos_mutex_lock()
> * int aos_mutex_lock(aos_mutex_t *mutex, unsigned int timeout)
> > - [x] lock a mutex
> > - [x] ************Parameters:************

    [in]  mutex  mutex object, it contains kernel obj pointer which aos_mutex_new alloced  

> > - [x] ************Returns:************
      0 is OK

## 1.15 aos_mutex_unlock()
> * int aos_mutex_unlock(aos_mutex_t *mutex)
> > - [x] unlock a mutex
> > - [x] ************Parameters:************

    [in]  mutex  mutex object, it contains kernel obj pointer which oc_mutex_new alloced  
> > - [x] ************Returns:************
    0 is OK

## 1.16 aos_mutex_is_valid()
> * int aos_mutex_is_valid(aos_mutex_t *mutex)
> > - [x] This function will check if mutex is valid
> > - [x] ************Parameters:************

    [in]  mutex  pointer to the mutex

> > - [x] ************Returns:************
      the check status, RHINO_TRUE is OK, RHINO_FALSE indicates invalid

## 1.17 aos_sem_new()
> * int aos_sem_new(aos_sem_t *sem, int count)
> > - [x] alloc a semaphore
> > - [x] ************Parameters:************

    [out]  sem   pointer of semaphore object,semaphore object must be alloced, hdl pointer in aos_sem_t will refer a kernel obj internally
    [in]  count  initial semaphore counter 

> > - [x] ************Returns:************

## 1.18 aos_sem_free()
> * void aos_sem_free(aos_sem_t *sem)
> > - [x] destroy a semaphore
> > - [x] ************Parameters:************

    [in]  sem  pointer of semaphore object,mem refered by hdl pointer in aos_sem_t will be freed internally

## 1.19 aos_sem_wait()
> * int aos_sem_wait(aos_sem_t *sem, unsigned int timeout)
> > - [x] acquire a semaphore
> > - [x] ************Parameters:************

    [in]  sem      semaphore object,,it contains kernel obj pointer which aos_sem_new alloced
    [in]  timeout  waiting until timeout in milliseconds 

> > - [x] ************Returns:************


## 1.20 aos_sem_signal()
> * void aos_sem_signal(aos_sem_t *sem)
> > - [x] release a semaphore
> > - [x] ************Parameters:************

    [in]  sem  semaphore object,,it contains kernel obj pointer which aos_sem_new alloced

## 1.21 aos_sem_is_valid()
> * int aos_sem_is_valid(aos_sem_t *sem)
> > - [x] This function will check if semaphore is valid
> > - [x] ************Parameters:************

    [in]  sem  pointer to the semaphore 

> > - [x] ************Returns:************
      the check status, RHINO_TRUE is OK, RHINO_FALSE indicates invalid

## 1.22 aos_sem_signal_all()
> * void aos_sem_signal_all(aos_sem_t *sem)
> > - [x] release all semaphore
> > - [x] ************Parameters:************

    [in]  sem  semaphore object, it contains kernel obj pointer which aos_sem_new alloced  

## 1.23 aos_queue_new()
> * int aos_queue_new(aos_queue_t *queue, void *buf, unsigned int size, int max_msg)
> > - [x] This function will create a queue
> > - [x] ************Parameters:************

    [in]	queue	pointer to the queue(the space is provided by user)
    [in]	buf	buf of the queue(provided by user)
    [in]	size	the bytes of the buf
    [in]	max_msg	the max size of the msg 

> > - [x] ************Returns:************
    the operation status, 0 is OK, others is error

## 1.24 aos_queue_free()
> * void aos_queue_free(aos_queue_t *queue)
> > - [x] This function will delete a queue
> > - [x] ************Parameters:************

    [in]	queue	pointer to the queue

## 1.25 aos_queue_send()
> * int aos_queue_send(aos_queue_t *queue, void *msg, unsigned int size)
> > - [x] This function will send a msg to the front of a queue
> > - [x] ************Parameters:************

    [in]	queue	pointer to the queue
[in]	msg	msg to send
[in]	size	size of the msg

> > - [x] ************Returns:************
    the operation status, 0 is OK, others is error

## 1.26 aos_queue_recv()
> * int aos_queue_recv(aos_queue_t *queue, unsigned int ms, void *msg, unsigned int *size)
> > - [x] This function will receive msg from a queue
> > - [x] ************Parameters:************

[in]	queue	pointer to the queue
[in]	ms	ms to wait before receive
[out]	msg	buf to save msg
[out]	size	size of the msg
  
> > - [x] ************Returns:************
    the operation status, 0 is OK, others is error

## 1.27 aos_queue_is_valid()
> * int aos_queue_is_valid(aos_queue_t *queue)
> > - [x] This function will check if queue is valid
> > - [x] ************Parameters:************

[in]	queue	pointer to the queue  

> > - [x] ************Returns:************
    the check status, RHINO_TRUE is OK, RHINO_FALSE indicates invalid

## 1.28 aos_queue_buf_ptr()
> * void *aos_queue_buf_ptr(aos_queue_t *queue)
> > - [x] This function will return buf ptr if queue is inited
> > - [x] ************Parameters:************

[in]	queue	pointer to the queue

> > - [x] ************Returns:************
    the check status, NULL is error

## 1.29 aos_sched_disable()
> * int aos_sched_disable(void)
> > - [x] This function will disable kernel sched
 
> > - [x] ************Returns:************
    the operation status, 0 is OK, others is error

## 1.30 aos_sched_enable()
> * int aos_sched_enable(void)
> > - [x] This function will enable kernel sched

> > - [x] ************Returns:************
    the operation status, 0 is OK, others is error

## 1.31 aos_timer_new()
> * int aos_timer_new(aos_timer_t *timer, void(*fn)(void *, void *), void *arg, int ms, int repeat)
> > - [x] This function will create a timer
> > - [x] ************Parameters:************

[in]	timer	pointer to the timer
[in]	fn	callbak of the timer
[in]	arg	the argument of the callback
[in]	ms	ms of the normal timer triger
[in]	repeat	repeat or not when the timer is created
 
> > - [x] ************Returns:************
    the operation status, 0 is OK, others is error

## 1.32 aos_timer_free()
> * void aos_timer_free(aos_timer_t *timer)
> > - [x] This function will delete a timer
> > - [x] ************Parameters:************

[in]	timer	pointer to a timer

## 1.33 aos_timer_start()
> * int aos_timer_start(aos_timer_t *timer)
> > - [x] This function will start a timer
> > - [x] ************Parameters:************

[in]	timer	pointer to the timer

> > - [x] ************Returns:************
    the operation status, 0 is OK, others is error

## 1.34 aos_timer_stop()
> * int aos_timer_stop(aos_timer_t *timer)
> > - [x] This function will stop a timer
> > - [x] ************Parameters:************

[in]	timer	pointer to the timer

> > - [x] ************Returns:************
    the operation status, 0 is OK, others is error

## 1.35 aos_timer_change()
> * int aos_timer_change(aos_timer_t *timer, int ms)
> > - [x] This function will change attributes of a timer
> > - [x] ************Parameters:************

[in]	timer	pointer to the timer
[in]	ms	ms of the timer triger
 
> > - [x] ************Returns:************
    the operation status, 0 is OK, others is error

## 1.36 aos_workqueue_create()
> * int aos_workqueue_create(aos_workqueue_t *workqueue, int pri, int stack_size)
> > - [x] This function will creat a workqueue
> > - [x] ************Parameters:************

[in]	workqueue	the workqueue to be created
[in]	pri	the priority of the worker
[in]	stack_size	the size of the worker-stack
 
> > - [x] ************Returns:************
    the operation status, 0 is OK, others is error

## 1.37 aos_workqueue_del()
> * void aos_workqueue_del(aos_workqueue_t *workqueue)
> > - [x] This function will delete a workqueue
> > - [x] ************Parameters:************

[in]	workqueue	the workqueue to be deleted  

## 1.38 aos_work_init()
> * int aos_work_init(aos_work_t *work, void(*fn)(void *), void *arg, int dly)
> > - [x] This function will initialize a work
> > - [x] ************Parameters:************

[in]	work	the work to be initialized
[in]	fn	the call back function to run
[in]	arg	the paraments of the function
[in]	dly	ms to delay before run
  
> > - [x] ************Returns:************
    the operation status, 0 is OK, others is error

## 1.39 aos_work_destroy()
> * void aos_work_destroy(aos_work_t *work)
> > - [x] This function will destroy a work
> > - [x] ************Parameters:************

[in]	work	the work to be destroied

## 1.40 aos_work_run()
> * int aos_work_run(aos_workqueue_t *workqueue, aos_work_t *work)
> > - [x] This function will run a work on a workqueue
> > - [x] ************Parameters:************

[in]	workqueue	the workqueue to run work
[in]	work	the work to run
 
> > - [x] ************Returns:************
    the operation status, 0 is OK, others is error

## 1.41 aos_work_sched()
> * int aos_work_sched(aos_work_t *work)
> > - [x] This function will run a work on the default workqueue
> > - [x] ************Parameters:************

[in]	work	the work to run
  
> > - [x] ************Returns:************
    the operation status, 0 is OK, others is error

## 1.42 aos_work_cancel()
> * int aos_work_cancel(aos_work_t *work)
> > - [x] This function will cancel a work on the default workqueue
> > - [x] ************Parameters:************

[in]	work	the work to cancel
 
> > - [x] ************Returns:************
    the operation status, 0 is OK, others is error

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