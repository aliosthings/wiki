#### `public `[`hal_wifi_module_t`](#structhal__wifi__module__t)` * `[`hal_wifi_get_default_module`](#group__aos__hal__wifi_1ga566b8f91f7325b94b2672af6ee9e9792)`(void)` 

Get the default wifi instance. The system may have more than 1 wifi instance, this API returns the default one.

#### Parameters
* None

#### Returns
* `NULL` No instances registered.
* `!=NULL` Instance pointer.

#### `public void `[`hal_wifi_register_module`](#group__aos__hal__wifi_1gae63e89d8196178248779fac0acdbddf4)`(`[`hal_wifi_module_t`](#structhal__wifi__module__t)` * m)` 

Regster a wifi instance to the HAL framework.

#### Parameters
* `module` The wifi instance.

#### Returns
None

#### `public int `[`hal_wifi_init`](#group__aos__hal__wifi_1gad0f9198f876afee6ec2fa498c853fd2e)`(void)` 

Initialize wifi instances. Note: this is supposed to be called during system boot, not supposed to be called by user module directly.

#### Parameters
* None

#### Returns
* `==0` Success
* `!=0` Failure

#### `public void `[`hal_wifi_get_mac_addr`](#group__aos__hal__wifi_1ga6d6d2c8d07f5b80b9f0c23f3d05ace80)`(`[`hal_wifi_module_t`](#structhal__wifi__module__t)` * m,uint8_t * mac)` 

Get the MAC address of the specified wifi instance.

#### Parameters
* `m` The wifi instance, `NULL` if default.
* `mac` The place to hold the result.

#### Returns
* None

#### `public int `[`hal_wifi_start`](#group__aos__hal__wifi_1ga4fb4774e8247d115d457eed457acb9b6)`(`[`hal_wifi_module_t`](#structhal__wifi__module__t)` * m,`[`hal_wifi_init_type_t`](#structhal__wifi__init__type__t)` * init_para)` 

Start the wifi instance.

#### Parameters
* `m` The wifi instance, `NULL` if default.
* `init_para` The config used to start the wifi.

#### Returns
* `0` Success, otherwise failure.

#### `public int `[`hal_wifi_start_adv`](#group__aos__hal__wifi_1ga694965de667c13b1380fda9eedda1601)`(`[`hal_wifi_module_t`](#structhal__wifi__module__t)` * m,`[`hal_wifi_init_type_adv_t`](#structhal__wifi__init__type__adv__t)` * init_para_adv)` 

Start the wifi instance in anvanced way (more config specified).

#### Parameters
* `m` The wifi instance, `NULL` if default.
* `init_para_adv` The advanced config used to start the wifi.

#### Returns
* `0` Success, otherwise failure.

#### `public int `[`hal_wifi_get_ip_stat`](#group__aos__hal__wifi_1ga05cb0f3bdfcf73dcb862c894aef1c355)`(`[`hal_wifi_module_t`](#structhal__wifi__module__t)` * m,`[`hal_wifi_ip_stat_t`](#structhal__wifi__ip__stat__t)` * out_net_para,`[`hal_wifi_type_t`](#group__aos__hal__wifi_1ga9c6cd73d1b386384fea4dc5be8a25adc)` wifi_type)` 

Get the status of the specified wifi instance, e.g. the IP, mask, dhcp mode, etc.

#### Parameters
* `m` The wifi instance, `NULL` if default.
* `out_net_para` The place to hold the result.
* `wifi_type` SOFT_AP or STATION.

#### Returns
* `0` Success, otherwise failure.

#### `public int `[`hal_wifi_get_link_stat`](#group__aos__hal__wifi_1gad21b72cfba15bc51dc232ff1d7b8e3e3)`(`[`hal_wifi_module_t`](#structhal__wifi__module__t)` * m,`[`hal_wifi_link_stat_t`](#structhal__wifi__link__stat__t)` * out_stat)` 

Get the link status of the wifi instance ,e.g. ssid, bssid, channel, rssi, etc.

#### Parameters
* `m` The wifi instance, `NULL` if default.
* `out_stat` The returned link status result.

#### Returns
* `0` Success, otherwise failure.

#### `public void `[`hal_wifi_start_scan`](#group__aos__hal__wifi_1ga45482258f138aa8dc654a62903cb9cce)`(`[`hal_wifi_module_t`](#structhal__wifi__module__t)` * m)` 

#### `public void `[`hal_wifi_start_scan_adv`](#group__aos__hal__wifi_1ga1ee2b973dd8c784d8c7bb0b62b317cf9)`(`[`hal_wifi_module_t`](#structhal__wifi__module__t)` * m)` 

#### `public int `[`hal_wifi_power_off`](#group__aos__hal__wifi_1ga356cb12cb844304ba82baf4fe7b2e39c)`(`[`hal_wifi_module_t`](#structhal__wifi__module__t)` * m)` 

#### `public int `[`hal_wifi_power_on`](#group__aos__hal__wifi_1gacb7504fd7489f48484ad465ff8b35889)`(`[`hal_wifi_module_t`](#structhal__wifi__module__t)` * m)` 

#### `public int `[`hal_wifi_suspend`](#group__aos__hal__wifi_1ga747082505fd08e36af0b25e819e28731)`(`[`hal_wifi_module_t`](#structhal__wifi__module__t)` * m)` 

#### `public int `[`hal_wifi_suspend_station`](#group__aos__hal__wifi_1ga1e83e196a0be456be4b37f4cee524818)`(`[`hal_wifi_module_t`](#structhal__wifi__module__t)` * m)` 

#### `public int `[`hal_wifi_suspend_soft_ap`](#group__aos__hal__wifi_1ga6a47820504b46b4a96baacce00cbd5b4)`(`[`hal_wifi_module_t`](#structhal__wifi__module__t)` * m)` 

#### `public int `[`hal_wifi_set_channel`](#group__aos__hal__wifi_1gaf3de80f45f31dd80dbbf0f1dacca0ec7)`(`[`hal_wifi_module_t`](#structhal__wifi__module__t)` * m,int ch)` 

#### `public void `[`hal_wifi_start_wifi_monitor`](#group__aos__hal__wifi_1gaa26d3158ef4961dfd5c8359aad7970da)`(`[`hal_wifi_module_t`](#structhal__wifi__module__t)` * m)` 

#### `public void `[`hal_wifi_stop_wifi_monitor`](#group__aos__hal__wifi_1ga3ad81dbe6f917782f84e404effb49381)`(`[`hal_wifi_module_t`](#structhal__wifi__module__t)` * m)` 

#### `public void `[`hal_wifi_register_monitor_cb`](#group__aos__hal__wifi_1gab8d8dadf29c391633e02d369ff645ec3)`(`[`hal_wifi_module_t`](#structhal__wifi__module__t)` * m,`[`monitor_data_cb_t`](#group__aos__hal__wifi_1ga42c3d0c8c75e00b79323b460b4ae589c)` fn)` 

#### `public void `[`hal_wifi_start_debug_mode`](#group__aos__hal__wifi_1ga3357287dece311d15428f91e848931ed)`(`[`hal_wifi_module_t`](#structhal__wifi__module__t)` * m)` 

#### `public void `[`hal_wifi_stop_debug_mode`](#group__aos__hal__wifi_1ga7f942f8856082a8deee80b9913d81edb)`(`[`hal_wifi_module_t`](#structhal__wifi__module__t)` * m)` 

#### `public void `[`hal_wifi_install_event`](#group__aos__hal__wifi_1gabb2676da0387cf522a0a9c4abc9a4210)`(`[`hal_wifi_module_t`](#structhal__wifi__module__t)` * m,const `[`hal_wifi_event_cb_t`](#structhal__wifi__event__cb__t)` * cb)` 

Set the event callback function array for the wifi.
Please don't do time consuming work in these callbacks.

#### Parameters
* `m` The wifi instance, `NULL` for default.
* `cb` The event callback function info.

#### Returns
None