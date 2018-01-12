# API INDEX

  * [1 hal_timer_init](#1-hal_timer_init)
  * [2 hal_timer_start](#2-hal_timer_start)
  * [3 hal_timer_stop](#3-hal_timer_stop)
  * [4 hal_timer_finalize](#4-hal_timer_finalize)

------

## 1-hal_timer_init

```c
void hal_timer_init(timer_dev_t *tim)
```

- [x] **Description**

  init a hardware timer

- [x] **Parameters**

  | IN/OUT |  NAME  |  DESC  |
  |--------|--------|--------|
  | [in] | tim |        timer struct   |

- [x] **Returns**

  None.


## 2-hal_timer_start

```c
int32_t hal_timer_start(hal_timer_t *tmr)
```

- [x] **Description**

  init a hardware timer

- [x] **Parameters**

  None.

- [x] **Returns**

  0 == success, EIO == failure

## 3-hal_timer_stop

```c
void hal_timer_stop(hal_timer_t *tmr)
```

- [x] **Description**

  stop a hardware timer

- [x] **Parameters**

  | IN/OUT |  NAME  |  DESC  |
  |--------|--------|--------|
  | [in] | tmr | timer struct   |
  | [in] | cb |  callback to be triggered after useconds   |
  | [in] | arg | passed to cb |

- [x] **Returns**

  None.
