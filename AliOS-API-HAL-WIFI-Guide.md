#### `hal_wifi_module_t *hal_wifi_get_default_module(void)` 

Get the default wifi instance. The system may have more than 1 wifi instance, this API returns the default one.

#### Parameters
* None

#### Returns
* `NULL`   - No instances registered.
* `!=NULL` - Instance pointer.

#### `void hal_wifi_register_module(hal_wifi_module_t *m)` 

Regster a wifi instance to the HAL framework.

#### Parameters
* `module` - The wifi instance.

#### Returns
None

#### `int  hal_wifi_init(void)` 

Initialize wifi instances. Note: this is supposed to be called during system boot, not supposed to be called by user module directly.

#### Parameters
* None

#### Returns
* `==0` - Success
* `!=0` - Failure

#### `void hal_wifi_get_mac_addr(hal_wifi_module_t *m, uint8_t *mac)` 

Get the MAC address of the specified wifi instance.

#### Parameters
* `m`   - The wifi instance, `NULL` if default.
* `mac` - The place to hold the result.

#### Returns
* None

#### `int  hal_wifi_start(hal_wifi_module_t *m, hal_wifi_init_type_t *init_para)`

Start the wifi instance.

#### Parameters
* `m`         - The wifi instance, `NULL` if default.
* `init_para` - The config used to start the wifi.

#### Returns
* `0` - Success, otherwise failure.

#### `int  hal_wifi_start_adv(hal_wifi_module_t *m, hal_wifi_init_type_adv_t *init_para_adv)`

Start the wifi instance in anvanced way (more config specified).

#### Parameters
* `m`             - The wifi instance, `NULL` if default.
* `init_para_adv` - The advanced config used to start the wifi.

#### Returns
* `0` - Success, otherwise failure.

#### `int  hal_wifi_get_ip_stat(hal_wifi_module_t *m, hal_wifi_ip_stat_t *out_net_para, hal_wifi_type_t wifi_type)` 

Get the status of the specified wifi instance, e.g. the IP, mask, dhcp mode, etc.

#### Parameters
* `m`            - The wifi instance, `NULL` if default.
* `out_net_para` - The place to hold the result.
* `wifi_type`    - SOFT_AP or STATION.

#### Returns
* `0` - Success, otherwise failure.

#### `int  hal_wifi_get_link_stat(hal_wifi_module_t *m, hal_wifi_link_stat_t *out_stat)` 

Get the link status of the wifi instance ,e.g. ssid, bssid, channel, rssi, etc.

#### Parameters
* `m`        - The wifi instance, `NULL` if default.
* `out_stat` - The returned link status result.

#### Returns
* `0` - Success, otherwise failure.

#### `void hal_wifi_start_scan(hal_wifi_module_t *m)` 

Start the scanning of the specified wifi instance.

#### Parameters
* `m` - The wifi instance, `NULL` if default.

#### Returns
* None

#### `void hal_wifi_start_scan_adv(hal_wifi_module_t *m)` 

Start the scanning of the specified wifi instance in advanced way.

#### Parameters
* `m` - The wifi instance, `NULL` if default.

#### Returns
* None

#### `int  hal_wifi_power_off(hal_wifi_module_t *m)` 

Power off the wifi instance.

#### Parameters
* `m` - The wifi instance, `NULL` if default.

#### Returns
* `0` - Success, otherwise failure.

#### `int  hal_wifi_power_on(hal_wifi_module_t *m)` 

Power on the wifi instance.

#### Parameters
* `m` - The wifi instance, `NULL` if default.

#### Returns
* `0` - Success, otherwise failure.

#### `int  hal_wifi_suspend(hal_wifi_module_t *m)` 

Suspend the wifi instance.

#### Parameters
* `m` - The wifi instance, `NULL` if default.

#### Returns
* `0` - Success, otherwise failure.

#### `int  hal_wifi_suspend_station(hal_wifi_module_t *m)` 

Suspend the wifi instance in station mode.

#### Parameters
* `m` - The wifi instance, `NULL` if default.

#### Returns
* `0` - Success, otherwise failure.

#### `int  hal_wifi_suspend_soft_ap(hal_wifi_module_t *m)` 

Suspend the wifi instance in soft_ap mode.

#### Parameters
* `m` - The wifi instance, `NULL` if default.

#### Returns
* `0` - Success, otherwise failure.

#### `int  hal_wifi_set_channel(hal_wifi_module_t *m, int ch)` 

Set the channel of the wifi instance.

#### Parameters
* `m`  - The wifi instance, `NULL` if default.
* `ch` - The channel to set.

#### Returns
* `0` - Success, otherwise failure.

#### `void hal_wifi_start_wifi_monitor(hal_wifi_module_t *m)` 

Start the monitor mode of the wifi instance.

#### Parameters
* `m` - The wifi instance, `NULL` if default.

#### Returns
* None.

#### `void hal_wifi_stop_wifi_monitor(hal_wifi_module_t *m)` 

Stop the monitor mode of the wifi instance.

#### Parameters
* `m` - The wifi instance, `NULL` if default.

#### Returns
* None.

#### `void hal_wifi_register_monitor_cb(hal_wifi_module_t *m, monitor_data_cb_t fn)` 

Register the montior callback on the wifi instance.

#### Parameters
* `m`  - The wifi instance, `NULL` if default.
* `fn` - The callback function.

#### Returns
* None.

#### `void hal_wifi_start_debug_mode(hal_wifi_module_t *m)` 

Start debug mode of the wifi instance.

#### Parameters
* `m` - The wifi instance, `NULL` if default.

#### Returns
* None.

#### `void hal_wifi_stop_debug_mode(hal_wifi_module_t *m)` 

Stop debug mode of the wifi instance.

#### Parameters
* `m` - The wifi instance, `NULL` if default.

#### Returns
* None.

#### `void hal_wifi_install_event(hal_wifi_module_t *m, const hal_wifi_event_cb_t *cb)` 

Set the event callback function array for the wifi.
Please don't do time consuming work in these callbacks.

#### Parameters
* `m` - The wifi instance, `NULL` for default.
* `cb` - The event callback function info.

#### Returns
None