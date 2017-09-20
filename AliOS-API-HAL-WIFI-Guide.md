## 1 struct {
    char ap_num;       /* The number of access points found in scanning. */
    struct {
        char ssid[32]; /* The SSID of an access point. */
        char ap_power; /* Signal strength, min:0, max:100. */
    } *ap_list;
} hal_wifi_scan_result_t;

typedef struct {
    char ap_num;          /* The number of access points found in scanning. */
    struct {
        char ssid[32];    /* The SSID of an access point. */
        char ap_power;    /* Signal strength, min:0, max:100 */
        char bssid[6];    /* The BSSID of an access point. */
        char channel;     /* The RF frequency, 1-13 */
        uint8_t security; /* Security type, @ref wlan_sec_type_t */
    } *ap_list;
} hal_wifi_scan_result_adv_t;

typedef enum {
    NOTIFY_STATION_UP = 1,
    NOTIFY_STATION_DOWN,

    NOTIFY_AP_UP,
    NOTIFY_AP_DOWN,
} hal_wifi_event_t;


typedef struct {
    char    ssid[32]; /* SSID of the wlan that needs to be connected. Example: "SSID String". */
    char    bssid[6]; /* BSSID of the wlan needs to be connected. Example: {0xC8 0x93 0x46 0x11 0x22 0x33}. */
    uint8_t channel;  /* Wlan's RF frequency, channel 0-13. 1-13 means a fixed channelthat can speed up a connection procedure,
						 0 is not a fixed input means all channels are possible*/
    uint8_t security;
} hal_wifi_ap_info_adv_t;

typedef struct {
    char wifi_mode;              /* DHCP mode: @ref wlanInterfaceTypedef. */
    char wifi_ssid[32];          /* SSID of the wlan needs to be connected. */
    char wifi_key[64];           /* Security key of the wlan needs to be connected, ignored in an open system. */
    char local_ip_addr[16];      /* Static IP configuration, Local IP address. */
    char net_mask[16];           /* Static IP configuration, Netmask. */
    char gateway_ip_addr[16];    /* Static IP configuration, Router IP address. */
    char dns_server_ip_addr[16]; /* Static IP configuration, DNS server IP address. */
    char dhcp_mode;              /* DHCP mode, @ref DHCP_Disable, @ref DHCP_Client and @ref DHCP_Server. */
    char reserved[32];
    int  wifi_retry_interval;    /* Retry interval if an error is occured when connecting an access point,
                                    time unit is millisecond. */
#ifdef STM32L475xx
    WIFI_Ecn_t access_sec;
#endif
} hal_wifi_init_type_t;


typedef struct {
    hal_wifi_ap_info_adv_t ap_info;
    char key[64];                /* Security key or PMK of the wlan. */
    int  key_len;                /* The length of the key. */
    char local_ip_addr[16];      /* Static IP configuration, Local IP address. */
    char net_mask[16];           /* Static IP configuration, Netmask. */
    char gateway_ip_addr[16];    /* Static IP configuration, Router IP address. */
    char dns_server_ip_addr[16]; /* Static IP configuration, DNS server IP address. */
    char dhcp_mode;              /* DHCP mode, @ref DHCP_Disable, @ref DHCP_Client and @ref DHCP_Server. */
    char reserved[32];
    int  wifi_retry_interval;    /* Retry interval if an error is occured when connecting an access point, time unit is millisecond. */
} hal_wifi_init_type_adv_t;


typedef struct {
    uint8_t dhcp;     /* DHCP mode: @ref DHCP_Disable, @ref DHCP_Client, @ref DHCP_Server. */
    char    ip[16];   /* Local IP address on the target wlan interface: @ref wlanInterfaceTypedef. */
    char    gate[16]; /* Router IP address on the target wlan interface: @ref wlanInterfaceTypedef. */
    char    mask[16]; /* Netmask on the target wlan interface: @ref wlanInterfaceTypedef. */
    char    dns[16];  /* DNS server IP address. */
    char    mac[16];  /* MAC address, example: "C89346112233". */
    char    broadcastip[16];
} hal_wifi_ip_stat_t;

typedef enum {
    SOFT_AP,  /* Act as an access point, and other station can connect, 4 stations Max */
    STATION   /* Act as a station which can connect to an access point */
} hal_wifi_type_t;

enum {
    DHCP_DISABLE = 0,
    DHCP_CLIENT,
    DHCP_SERVER,
};

typedef struct {
    int     is_connected;  /* The link to wlan is established or not, 0: disconnected, 1: connected. */
    int     wifi_strength; /* Signal strength of the current connected AP */
    uint8_t ssid[32];      /* SSID of the current connected wlan */
    uint8_t bssid[6];      /* BSSID of the current connected wlan */
    int     channel;       /* Channel of the current connected wlan */
} hal_wifi_link_stat_t;

typedef struct hal_wifi_link_info_s {
    int8_t rssi; /* rssi value of received packet */
} hal_wifi_link_info_t;

/**
 * The event call back function called at specific events occurred.
 *
 * @note For HAL implementors, these callbacks must be
 *       called under normal task context, not from interrupt.
 */
typedef struct {
    void 

```c
typedef struct {
    char ap_num
```

- [x] **Description**

   Scan result using normal scan.
 /
typedef struct {
    char ap_num;       /* The number of access points found in scanning. /
    struct {
        char ssid[32]; /* The SSID of an access point. /
        char ap_power; /* Signal strength, min:0, max:100. /
    } ap_list;
} hal_wifi_scan_result_t;

typedef struct {
    char ap_num;          /* The number of access points found in scanning. /
    struct {
        char ssid[32];    /* The SSID of an access point. /
        char ap_power;    /* Signal strength, min:0, max:100 /
        char bssid[6];    /* The BSSID of an access point. /
        char channel;     /* The RF frequency, 1-13 /
        uint8_t security; /* Security type, @ref wlan_sec_type_t /
    } ap_list;
} hal_wifi_scan_result_adv_t;

typedef enum {
    NOTIFY_STATION_UP = 1,
    NOTIFY_STATION_DOWN,

    NOTIFY_AP_UP,
    NOTIFY_AP_DOWN,
} hal_wifi_event_t;


typedef struct {
    char    ssid[32]; /* SSID of the wlan that needs to be connected. Example: "SSID String". /
    char    bssid[6]; /* BSSID of the wlan needs to be connected. Example: {0xC8 0x93 0x46 0x11 0x22 0x33}. /
    uint8_t channel;  /* Wlan's RF frequency, channel 0-13. 1-13 means a fixed channelthat can speed up a connection procedure,
						 0 is not a fixed input means all channels are possible*/
    uint8_t security;
} hal_wifi_ap_info_adv_t;

typedef struct {
    char wifi_mode;              /* DHCP mode: @ref wlanInterfaceTypedef. /
    char wifi_ssid[32];          /* SSID of the wlan needs to be connected. /
    char wifi_key[64];           /* Security key of the wlan needs to be connected, ignored in an open system. /
    char local_ip_addr[16];      /* Static IP configuration, Local IP address. /
    char net_mask[16];           /* Static IP configuration, Netmask. /
    char gateway_ip_addr[16];    /* Static IP configuration, Router IP address. /
    char dns_server_ip_addr[16]; /* Static IP configuration, DNS server IP address. /
    char dhcp_mode;              /* DHCP mode, @ref DHCP_Disable, @ref DHCP_Client and @ref DHCP_Server. /
    char reserved[32];
    int  wifi_retry_interval;    /* Retry interval if an error is occured when connecting an access point,
                                    time unit is millisecond. /
#ifdef STM32L475xx
    WIFI_Ecn_t access_sec;
#endif
} hal_wifi_init_type_t;


typedef struct {
    hal_wifi_ap_info_adv_t ap_info;
    char key[64];                /* Security key or PMK of the wlan. /
    int  key_len;                /* The length of the key. /
    char local_ip_addr[16];      /* Static IP configuration, Local IP address. /
    char net_mask[16];           /* Static IP configuration, Netmask. /
    char gateway_ip_addr[16];    /* Static IP configuration, Router IP address. /
    char dns_server_ip_addr[16]; /* Static IP configuration, DNS server IP address. /
    char dhcp_mode;              /* DHCP mode, @ref DHCP_Disable, @ref DHCP_Client and @ref DHCP_Server. /
    char reserved[32];
    int  wifi_retry_interval;    /* Retry interval if an error is occured when connecting an access point, time unit is millisecond. /
} hal_wifi_init_type_adv_t;


typedef struct {
    uint8_t dhcp;     /* DHCP mode: @ref DHCP_Disable, @ref DHCP_Client, @ref DHCP_Server. /
    char    ip[16];   /* Local IP address on the target wlan interface: @ref wlanInterfaceTypedef. /
    char    gate[16]; /* Router IP address on the target wlan interface: @ref wlanInterfaceTypedef. /
    char    mask[16]; /* Netmask on the target wlan interface: @ref wlanInterfaceTypedef. /
    char    dns[16];  /* DNS server IP address. /
    char    mac[16];  /* MAC address, example: "C89346112233". /
    char    broadcastip[16];
} hal_wifi_ip_stat_t;

typedef enum {
    SOFT_AP,  /* Act as an access point, and other station can connect, 4 stations Max /
    STATION   /* Act as a station which can connect to an access point /
} hal_wifi_type_t;

enum {
    DHCP_DISABLE = 0,
    DHCP_CLIENT,
    DHCP_SERVER,
};

typedef struct {
    int     is_connected;  /* The link to wlan is established or not, 0: disconnected, 1: connected. /
    int     wifi_strength; /* Signal strength of the current connected AP /
    uint8_t ssid[32];      /* SSID of the current connected wlan /
    uint8_t bssid[6];      /* BSSID of the current connected wlan /
    int     channel;       /* Channel of the current connected wlan /
} hal_wifi_link_stat_t;

typedef struct hal_wifi_link_info_s {
    int8_t rssi; /* rssi value of received packet /
} hal_wifi_link_info_t;

/**
  The event call back function called at specific events occurred.

- [x] **Parameters**

  None.

- [x] **Returns**

  None.


## 2 *hal_wifi_get_default_module

```c
hal_wifi_module_t *hal_wifi_get_default_module(void)
```

- [x] **Description**

  Get the default wifi instance.
  The system may have more than one wifi instance,
  this API returns the default one.

- [x] **Parameters**

  None.

- [x] **Returns**

  Instance pointer, or NULL if no instance registered.

## 3 hal_wifi_register_module

```c
void hal_wifi_register_module(hal_wifi_module_t *m)
```

- [x] **Description**

  Regster a wifi instance to the HAL framework.

- [x] **Parameters**

  | IN/OUT |  NAME  |  DESC  |
  |--------|--------|--------|
  | [in] | m | the wifi instance. |

- [x] **Returns**

  None.


## 4 hal_wifi_init

```c
int hal_wifi_init(void)
```

- [x] **Description**

  Initialize wifi instances.

- [x] **Parameters**

  None.

- [x] **Returns**

  0 on success, otherwise failure.
 *
 * @note  This is supposed to be called during system boot,
 *        not supposed to be called by user module directly.

## 5 hal_wifi_get_mac_addr

```c
void hal_wifi_get_mac_addr(hal_wifi_module_t *m, uint8_t *mac)
```

- [x] **Description**

  Get the MAC address of the specified wifi instance.

- [x] **Parameters**

  | IN/OUT |  NAME  |  DESC  |
  |--------|--------|--------|
  | [in] |  m |   the wifi instance, NULL if default.   |
  | [out] | mac | the place to hold the result. |

- [x] **Returns**

  None.


## 6 hal_wifi_start

```c
int hal_wifi_start(hal_wifi_module_t *m, hal_wifi_init_type_t *init_para)
```

- [x] **Description**

  Start the wifi instance.

- [x] **Parameters**

  | IN/OUT |  NAME  |  DESC  |
  |--------|--------|--------|
  | [in] | m |         the wifi instance, NULL if default.   |
  | [in] | init_para | the config used to start the wifi. |

- [x] **Returns**

      0 on success, otherwise failure.

## 7 hal_wifi_start_adv

```c
int hal_wifi_start_adv(hal_wifi_module_t *m, hal_wifi_init_type_adv_t *init_para_adv)
```

- [x] **Description**

  Start the wifi instance in anvanced way (more config specified).

- [x] **Parameters**

  | IN/OUT |  NAME  |  DESC  |
  |--------|--------|--------|
  | [in] | m |  the wifi instance, NULL if default.   |
  | [in] | init_para_adv | the advanced config used to start the wifi. |

- [x] **Returns**

      0 on success, otherwise failure.

## 8 hal_wifi_get_ip_stat

```c
int hal_wifi_get_ip_stat(hal_wifi_module_t *m,
                          hal_wifi_ip_stat_t *out_net_para, hal_wifi_type_t wifi_type)
```

- [x] **Description**

  Get the status of the specified wifi instance, e.g. the IP, mask, dhcp mode, etc.

- [x] **Parameters**

  | IN/OUT |  NAME  |  DESC  |
  |--------|--------|--------|
  | [in] |  m | the wifi instance, NULL if default.   |
  | [out] | out_net_para | the place to hold the results.   |
  | [in] |  wifi_type |    SOFT_AP or STATION. |

- [x] **Returns**

      0 on success, otherwise failure.

## 9 hal_wifi_get_link_stat

```c
int hal_wifi_get_link_stat(hal_wifi_module_t *m, hal_wifi_link_stat_t *out_stat)
```

- [x] **Description**

  Get the link status of the wifi instance ,e.g. ssid, bssid, channel, rssi, etc.

- [x] **Parameters**

  | IN/OUT |  NAME  |  DESC  |
  |--------|--------|--------|
  | [in] |  m |        the wifi instance, NULL if default.   |
  | [out] | out_stat | the place to hold the results. |

- [x] **Returns**

      0 on success, otherwise failure.

## 10 hal_wifi_start_scan

```c
void hal_wifi_start_scan(hal_wifi_module_t *m)
```

- [x] **Description**

  Start the scanning of the specified wifi instance.

- [x] **Parameters**

  | IN/OUT |  NAME  |  DESC  |
  |--------|--------|--------|
  | [in] | m | the wifi instance, NULL if default. |

- [x] **Returns**

  None.


## 11 hal_wifi_start_scan_adv

```c
void hal_wifi_start_scan_adv(hal_wifi_module_t *m)
```

- [x] **Description**

  Start the scanning of the specified wifi instance in advanced way.

- [x] **Parameters**

  | IN/OUT |  NAME  |  DESC  |
  |--------|--------|--------|
  | [in] | m | the wifi instance, NULL if default. |

- [x] **Returns**

  None.


## 12 hal_wifi_power_off

```c
int hal_wifi_power_off(hal_wifi_module_t *m)
```

- [x] **Description**

  Power off the wifi instance.

- [x] **Parameters**

  | IN/OUT |  NAME  |  DESC  |
  |--------|--------|--------|
  | [in] | m | the wifi instance, NULL if default. |

- [x] **Returns**

     0 on success, otherwise failure.

## 13 hal_wifi_power_on

```c
int hal_wifi_power_on(hal_wifi_module_t *m)
```

- [x] **Description**

  Power on the wifi instance.

- [x] **Parameters**

  | IN/OUT |  NAME  |  DESC  |
  |--------|--------|--------|
  | [in] | m | the wifi instance, NULL if default. |

- [x] **Returns**

     0 on success, otherwise failure.

## 14 hal_wifi_suspend

```c
int hal_wifi_suspend(hal_wifi_module_t *m)
```

- [x] **Description**

  Suspend the wifi instance.

- [x] **Parameters**

  | IN/OUT |  NAME  |  DESC  |
  |--------|--------|--------|
  | [in] | m | the wifi instance, NULL if default. |

- [x] **Returns**

     0 on success, otherwise failure.

## 15 hal_wifi_suspend_station

```c
int hal_wifi_suspend_station(hal_wifi_module_t *m)
```

- [x] **Description**

  Suspend the wifi instance in station mode.

- [x] **Parameters**

  | IN/OUT |  NAME  |  DESC  |
  |--------|--------|--------|
  | [in] | m | the wifi instance, NULL if default. |

- [x] **Returns**

     0 on success, otherwise failure.

## 16 hal_wifi_suspend_soft_ap

```c
int hal_wifi_suspend_soft_ap(hal_wifi_module_t *m)
```

- [x] **Description**

  Suspend the wifi instance in soft_ap mode.

- [x] **Parameters**

  | IN/OUT |  NAME  |  DESC  |
  |--------|--------|--------|
  | [in] | m | the wifi instance, NULL if default. |

- [x] **Returns**

     0 on success, otherwise failure.

## 17 hal_wifi_set_channel

```c
int hal_wifi_set_channel(hal_wifi_module_t *m, int ch)
```

- [x] **Description**

  Set the channel of the wifi instance.

- [x] **Parameters**

  | IN/OUT |  NAME  |  DESC  |
  |--------|--------|--------|
  | [in] | m | the wifi instance, NULL if default. |

- [x] **Returns**

     0 on success, otherwise failure.

## 18 hal_wifi_start_wifi_monitor

```c
void hal_wifi_start_wifi_monitor(hal_wifi_module_t *m)
```

- [x] **Description**

  Start the monitor mode of the wifi instance.

- [x] **Parameters**

  | IN/OUT |  NAME  |  DESC  |
  |--------|--------|--------|
  | [in] | m | the wifi instance, NULL if default. |

- [x] **Returns**

  None.


## 19 hal_wifi_stop_wifi_monitor

```c
void hal_wifi_stop_wifi_monitor(hal_wifi_module_t *m)
```

- [x] **Description**

  Stop the monitor mode of the wifi instance.

- [x] **Parameters**

  | IN/OUT |  NAME  |  DESC  |
  |--------|--------|--------|
  | [in] | m | The wifi instance, NULL if default. |

- [x] **Returns**

  None.


## 20 hal_wifi_register_monitor_cb

```c
void hal_wifi_register_monitor_cb(hal_wifi_module_t *m, monitor_data_cb_t fn)
```

- [x] **Description**

  Register the montior callback on the wifi instance.

- [x] **Parameters**

  | IN/OUT |  NAME  |  DESC  |
  |--------|--------|--------|
  | [in] | m |  the wifi instance, NULL if default.   |
  | [in] | fn | the callback function. |

- [x] **Returns**

  None.


## 21 hal_wifi_start_debug_mode

```c
void hal_wifi_start_debug_mode(hal_wifi_module_t *m)
```

- [x] **Description**

  Start debug mode of the wifi instance.

- [x] **Parameters**

  | IN/OUT |  NAME  |  DESC  |
  |--------|--------|--------|
  | [in] | m | the wifi instance, NULL if default. |

- [x] **Returns**

  None.


## 22 hal_wifi_stop_debug_mode

```c
void hal_wifi_stop_debug_mode(hal_wifi_module_t *m)
```

- [x] **Description**

  Stop debug mode of the wifi instance.

- [x] **Parameters**

  | IN/OUT |  NAME  |  DESC  |
  |--------|--------|--------|
  | [in] | m | the wifi instance, NULL if default. |

- [x] **Returns**

  None.


## 23 hal_wifi_install_event

```c
void hal_wifi_install_event(hal_wifi_module_t *m, const hal_wifi_event_cb_t *cb)
```

- [x] **Description**

  Set the event callback function array for the wifi.
  Please don't do time consuming work in these callbacks.

- [x] **Parameters**

  | IN/OUT |  NAME  |  DESC  |
  |--------|--------|--------|
  | [in] | m |  the wifi instance, NULL for default.   |
  | [in] | cb | the event callback function info.   @note Please don't do time consuming work in these callbacks. |

- [x] **Returns**

  None.
