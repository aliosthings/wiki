------
# 1 KV API
## 1.1 aos_kv_set()
> * int aos_kv_set(const char *key, const void *value, int len, int sync)
> > - [x] Add another KV pair
> > - [x] ************Parameters:************

    [in]  key    the key of the KV pair

    [in]  value  the value of the KV pair

    [in]  len    the length of the value

    [in]  sync   save the KV pair to flash right now (should always be 1)
> > - [x] ************Returns:************
       0 on success, negative error on failure

## 1.2 aos_kv_get()
> * int aos_kv_get(const char *key, void *buffer, int *buffer_len)
> > - [x] Get the KV value stored in buffer by its key
> > - [x] ************Parameters:************

    [in]   key         the key of the KV pair you want to get

    [out]  buffer      the memory to store KV value

    [out]  buffer_len  the real length of value
> > - [x] ************Returns:************
       0 on success, negative error on failure

## 1.3 aos_kv_del()
> * int aos_kv_del(const char *key)
> > - [x] Delete the KV pair by its key
> > - [x] ************Parameters:************

    [in]  key  the key of the KV pair you want to delete
> > - [x] ************Returns:************
       0 on success, negative error on failure
------