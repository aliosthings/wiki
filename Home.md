## Template1: aos_task_new()
```c
int aos_task_new(const char *name, void(*)(void *)fn, void *arg, int stack_size)
```
- [x] **Description**
  Create a new task

- [x] **Parameters**

  | IN/OUT| NAME| DESC |
  |-------|-----|------|
  | [in] | name      | task name, any string |
  | [in] | fn        | task function |
  | [in] | arg       | any pointer, will give to your task-function as argument |
  | [in] | stacksize | stacksize in bytes |

- [x] **Returns**

  | ERRNO | DESC |
  |-------|------|
  | 0 | Success |
  | -1 | Error |

- [x] **Example**
```c
    int ret = aos_task_new(...);
```

## Template2: aos_task_new()
```c
int aos_task_new(const char *name, void(*)(void *)fn, void *arg, int stack_size)
```
- [x] **Description**

  Create a new task

- [x] **Parameters**

  [in] **name**:      task name, any string

  [in] **fn**:        task function

  [in] **arg**:       any pointer, will give to your task-function as argument

  [in] **stacksize**: stacksize in bytes

- [x] **Returns**

   0: Success

  -1: Error

- [x] **Example**
```c
    int ret = aos_task_new(...);
```