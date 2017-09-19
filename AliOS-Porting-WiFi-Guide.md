AliOS WiFi HAL的定义请查看头文件定义：[WiFi HAL接口定义](https://github.com/alibaba/AliOS/wiki/AliOS-API-HAL-WIFI-Guide)。在AliOS移植的移植过程中，如果需要支持WiFi功能，则需要对WiFi HAL接口进行移植实现。

# 1 WiFi模块结构体
AliOS中，WiFi相关的操作和接口封装在下面的结构体中：
```c
struct hal_wifi_module_s {
    hal_module_base_t    base;
    const hal_wifi_event_cb_t *ev_cb;

    int  (*init)(hal_wifi_module_t *m);
    void (*get_mac_addr)(hal_wifi_module_t *m, uint8_t *mac);
    int  (*start)(hal_wifi_module_t *m, hal_wifi_init_type_t *init_para);
    int  (*start_adv)(hal_wifi_module_t *m,
                      hal_wifi_init_type_adv_t *init_para_adv);
    int  (*get_ip_stat)(hal_wifi_module_t *m, hal_wifi_ip_stat_t *out_net_para,
                        hal_wifi_type_t wifi_type);
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
    void (*start_debug_mode)(hal_wifi_module_t *m);
    void (*stop_debug_mode)(hal_wifi_module_t *m);
};
```

# 2 接口的实现
具体的平台，用户需要分别实现上述结构体中对应的接口函数。

# 注册WiFi模块
在完成具体接口的实现后，定义一个`hal_wifi_module_t`的结构体，将各个接口的实现函数地址赋值给结构体中对应的域。如下：
```c
hal_wifi_module_t sim_aos_wifi_beken = {
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
    .start_debug_mode = start_debug_mode,
    .stop_debug_mode = stop_debug_mode
};
```
AliOS中实现了如下的注册函数，可以对实现好的WiFi模块结构体进行注册。注册的动作一般是在硬件初始化的过程中进行。
```c
void hal_wifi_register_module(hal_wifi_module_t *m);
```
完成注册的WiFi模块和接口才能被使用。

# 3 接口调用
需要使用WiFi功能和接口时，可以通过调用下面的函数来获取相应的WiFi模块结构体。
```c
hal_wifi_module_t *hal_wifi_get_default_module(void);
```