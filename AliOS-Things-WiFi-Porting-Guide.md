# 目录
  * [1 WiFi模块结构体](#1WiFi模块结构体)
  * [2 WiFi事件回调函数](#2WiFi事件回调函数)
  * [3 WiFi接口的实现](#3WiFi接口的实现)
  * [4 注册模块](#4注册模块)
  * [5 接口的使用](#5接口的使用)
---

AliOS WiFi HAL的定义请查看头文件定义：[wifi_hal.h](AliOS-Things/include/hal/wifi.h)。在AliOS移植的过程中，如果需要支持WiFi功能，则需要对WiFi HAL接口进行移植实现。

# 1WiFi模块结构体
AliOS中，WiFi相关的操作和接口封装在下面的结构体中，相关定义在文件[wifi_hal.h](AliOS-Things/include/hal/wifi.h)中。
  ```c
  struct hal_wifi_module_s {
      hal_module_base_t    base;
      const hal_wifi_event_cb_t *ev_cb;

      int  (*init)(hal_wifi_module_t *m);
      void (*get_mac_addr)(hal_wifi_module_t *m, uint8_t *mac);
      int  (*start)(hal_wifi_module_t *m, hal_wifi_init_type_t *init_para);
      int  (*start_adv)(hal_wifi_module_t *m, hal_wifi_init_type_adv_t *init_para_adv);
      int  (*get_ip_stat)(hal_wifi_module_t *m, hal_wifi_ip_stat_t *out_net_para, hal_wifi_type_t wifi_type);
      int  (*get_link_stat)(hal_wifi_module_t *m, hal_wifi_link_stat_t *out_stat);
      void (*start_scan)(hal_wifi_module_t *m);
      void (*start_scan_adv)(hal_wifi_module_t *m);
      int  (*power_off)(hal_wifi_module_t *m);
      int  (*power_on)(hal_wifi_module_t *m);
      int  (*suspend)(hal_wifi_module_t *m);
      int  (*suspend_station)(hal_wifi_module_t *m);
      int  (*suspend_soft_ap)(hal_wifi_module_t *m);
      int  (*set_channel)(hal_wifi_module_t *m, int ch);
      void (*start_monitor)(hal_wifi_module_t *m);
      void (*stop_monitor)(hal_wifi_module_t *m);
      void (*register_monitor_cb)(hal_wifi_module_t *m, monitor_data_cb_t fn);
      void (*register_wlan_mgnt_monitor_cb)(hal_wifi_module_t *m, monitor_data_cb_t fn);
      int (*wlan_send_80211_raw_frame)(hal_wifi_module_t *m, uint8_t *buf, int len);
  };
  ```

# 2WiFi事件回调函数
在WiFi启动和运行的过程中，需要通过调用回调函数来通知上层应用，以执行相应的动作。这些WiFi事件的回调函数，应该在WiFi底层（WiFi HAL）中合适的位置进行调用。
如WiFi底层拿到IP后，应执行ip_got回调，并将IP信息传递给上层；WiFi完成信道扫描后，应调用`scan_compeleted`或者`scan_adv_compeleted`回调，并将扫描结果传递给上层；在WiFi状态改变时，应调用`stat_chg`回调。
下面是AliOS中定义的WiFi事件回调函数和接口，相关定义在文件[wifi_hal.h](AliOS-Things/include/hal/wifi.h)中。
```c
typedef struct {
    void (*connect_fail)(hal_wifi_module_t *m, int err, void *arg);
    void (*ip_got)(hal_wifi_module_t *m, hal_wifi_ip_stat_t *pnet, void *arg);
    void (*stat_chg)(hal_wifi_module_t *m, hal_wifi_event_t stat, void *arg);
    void (*scan_compeleted)(hal_wifi_module_t *m, hal_wifi_scan_result_t *result,
                            void *arg);
    void (*scan_adv_compeleted)(hal_wifi_module_t *m,
                                hal_wifi_scan_result_adv_t *result, void *arg);
    void (*para_chg)(hal_wifi_module_t *m, hal_wifi_ap_info_adv_t *ap_info,
                     char *key, int key_len, void *arg);
    void (*fatal_err)(hal_wifi_module_t *m, void *arg);
} hal_wifi_event_cb_t;
```

在平台移植过程中，WiFi事件回调函数（结构体）可以通过`hal_wifi_install_event`函数进行注册。WiFi底层代码中，得到状态后，应该调用相应的事件的回调函数。例如，在获取到IP地址后，应通过以下代码来通知上层：
```c
sim_aos_wifi_vendor.ev_cb->ip_got(&sim_aos_wifi_vendor, pnet, NULL);
```
其中，`pnet`中包含了获取IP后的状态信息。

# 3WiFi接口的实现
具体的平台，用户需要分别实现WiFi模块结构体中对应的接口函数。关于WiFi HAL接口的说明，请参照：[WiFi HAL](https://github.com/alibaba/AliOS-Things/wiki/AliOS-Things-API-HAL-WiFi-Guide)。
如上一节所述，在WiFi HAL接口的实现中，需要在得到某些状态（如获得ip）后，执行相应的回调函数来通知上层。

# 4注册模块
在完成WiFi接口和事件回调的实现后，定义一个`hal_wifi_module_t`的结构体，将各个接口和回调的实现地址赋值给结构体中对应的域。如下：
  ```c
  hal_wifi_module_t sim_aos_wifi_vendor = {
      .base.name           = "alios_wifi_vender_name",
      .init                =  wifi_init,
      .get_mac_addr        =  wifi_get_mac_addr,
      .start               =  wifi_start,
      .start_adv           =  wifi_start_adv,
      .get_ip_stat         =  get_ip_stat,
      .get_link_stat       =  get_link_stat,
      .start_scan          =  start_scan,
      .start_scan_adv      =  start_scan_adv,
      .power_off           =  power_off,
      .power_on            =  power_on,
      .suspend             =  suspend,
      .suspend_station     =  suspend_station,
      .suspend_soft_ap     =  suspend_soft_ap,
      .set_channel         =  set_channel,
      .start_monitor       =  start_monitor,
      .stop_monitor        =  stop_monitor,
      .register_monitor_cb =  register_monitor_cb,
      .register_wlan_mgnt_monitor_cb = register_wlan_mgnt_monitor_cb,
      .wlan_send_80211_raw_frame = wlan_send_80211_raw_frame,
  };
  ```
AliOS中实现了如下的注册函数，可以对实现好的WiFi模块结构体进行注册。注册的动作一般是在硬件初始化的过程中进行。
  ```c
  void hal_wifi_register_module(hal_wifi_module_t *m);
  ```
完成注册的WiFi模块和接口才能被使用。

# 5接口的使用
需要使用WiFi功能和接口时，可以通过调用下面的函数来获取默认的WiFi模块结构体（第一个被注册的模块）。一般系统中只注册一个WiFi模块，在使用WiFi HAL接口时，一般由个参数是`hal_wifi_module_t *m`：若该参数不为空，则使用参数指定的WiFi模块；若为`NULL`，则使用默认的WiFi模块（使用如下接口）。
  ```c
  hal_wifi_module_t *hal_wifi_get_default_module(void);
  ```