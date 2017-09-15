## CLOUD API
## 1.1 aos_cloud_register_callback()
> * int aos_cloud_register_callback(int cb_type, aos_cloud_cb_t cb)
> > - [x] Register cloud event callback
> > - [x] ************Parameters:************

    [in]  cb_type        event type interested
    [in]  aos_cloud_cb_t cloud event callback

> > - [x] ************Returns:************
      the operation status, 0 is OK, others is error

## 1.2 aos_cloud_report()
> * int aos_cloud_report(const char *method,
                     const char *json_buffer,
                     void (*done_cb)(void *),
                     void *arg);
> > - [x] Report event to cloud
> > - [x] ************Parameters:************

    [in]  method        remote method name
    [in]  json_buffer   method's payload
    [in]  done_cb       report done callback
    [in]  arg           private data passed to done_cb

> > - [x] ************Returns:************
      the operation status, 0 is OK, others is error

## 1.3 aos_cloud_trigger()
> * void aos_cloud_trigger(int cb_type, const char *json_buffer)
> > - [x] Report event to cloud
> > - [x] ************Parameters:************

    [in]  cb_type       event type
    [in]  json_buffer   payload

## 1.4 aos_cloud_register_backend()
> * aos_cloud_register_backend(int (*report)(const char *method, const char *json_buffer))
> > - [x] Report event to cloud
> > - [x] ************Parameters:************

    [in]  report       called when user do aos_cloud_report