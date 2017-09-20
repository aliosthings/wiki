## 1 aos_kv_set

```c
int aos_kv_set(const char *key, const void *value, int len, int sync)
```

- [x] **Description**

  Add another KV pair.

- [x] **Parameters**

  | IN/OUT |  NAME  |  DESC  |
  |--------|--------|--------|
  | [in] | key |   the key of the KV pair. |
  | [in] | value | the value of the KV pair. |
  | [in] | len |   the length of the value. |
  | [in] | sync |  save the KV pair to flash right now (should always be 1) |

- [x] **Returns**

  0 on success, negative error on failure

## 2 aos_kv_get

```c
int aos_kv_get(const char *key, void *buffer, int *buffer_len)
```

- [x] **Description**

  Get the KV value stored in buffer by its key.

- [x] **Parameters**

  | IN/OUT |  NAME  |  DESC  |
  |--------|--------|--------|
  | [in] |  key |        the key of the KV you want to get. |
  | [out] | buffer |     the memory to store KV value. |
  | [out] | buffer_len | the real length of value. |

- [x] **Returns**

  0 on success, negative error on failure

## 3 aos_kv_del

```c
int aos_kv_del(const char *key)
```

- [x] **Description**

  Delete the KV pair by its key.

- [x] **Parameters**

  | IN/OUT |  NAME  |  DESC  |
  |--------|--------|--------|
  | [in] | key | the key of the KV pair you want to delete. |

- [x] **Returns**

  0 on success, negative error on failure
