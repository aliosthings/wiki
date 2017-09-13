# Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
`define `[`ALINK_WAIT_FOREVER`](#group__wifi__entry_1ga24e84b646981469702aabfb6da1e9b5f)            | 
`define `[`MAX_COMMANDS`](#cli_8h_1a4b2b20c68bee625b7dc737c4d05699fd)            | 
`define `[`INBUF_SIZE`](#cli_8h_1a6378f14810330164b7fb66f3334b2a27)            | 
`define `[`OUTBUF_SIZE`](#cli_8h_1a3df829d6427c2cd4fbd387268040cc65)            | 
`define `[`CLI_ARGS`](#cli_8h_1a32dbd9172ae6648a0197494b96925799)            | 
`define `[`cmd_printf`](#cli_8h_1a195767ec31ec406a0c1ee072bbf5929a)            | 
`define `[`SHORT_FILE`](#debug_8h_1ae262b34c650329f4896e6c3adeaf99d0)            | 
`define `[`debug_print_assert`](#debug_8h_1aa497f2a6a03dd57dc3ee43f9af17d053)            | 
`define `[`unlikely`](#debug_8h_1a84a1f426a227f1448ec65947ac42919e)            | 
`define `[`check`](#debug_8h_1ac7484fb87785e637ebc2895cb5d5a51b)            | check  Check that an expression is true (non-zero). 
`define `[`check_string`](#debug_8h_1a7815306b9d49d852a9a3658493457ad2)            | check_string  Check that an expression is true (non-zero) with an explanation. 
`define `[`require`](#debug_8h_1a38a61c69561923a5402af2ae718efe48)            | require  Requires that an expression evaluate to true. 
`define `[`require_string`](#debug_8h_1a5d1334664ee9b47f6764a98e894758e5)            | require_string  Requires that an expression evaluate to true with an explanation. 
`define `[`require_quiet`](#debug_8h_1a3b6ad49f54b0d9261326d2b66744dcdf)            | require_quiet  Requires that an expression evaluate to true. 
`define `[`require_noerr`](#debug_8h_1a02c3df4b13f819669925ada472a62162)            | require_noerr  Require that an error code is noErr (0). 
`define `[`require_noerr_string`](#debug_8h_1a8d9b38f0b5293590b9637098fb67651f)            | require_noerr_string  Require that an error code is noErr (0). 
`define `[`require_noerr_action_string`](#debug_8h_1a640247fef12b0c53780f021f3a738620)            | require_noerr_action_string  Require that an error code is noErr (0). 
`define `[`require_noerr_quiet`](#debug_8h_1a1607344c6ff3f694527458dcd73a6fbf)            | require_noerr_quiet  Require that an error code is noErr (0). 
`define `[`require_noerr_action`](#debug_8h_1aa60121841639f3b5700b19a1526a5232)            | require_noerr_action  Require that an error code is noErr (0) with an action to execute otherwise. 
`define `[`require_noerr_action_quiet`](#debug_8h_1a16f33c6ca26bcd92165c23a8cff1d28f)            | require_noerr_action_quiet  Require that an error code is noErr (0) with an action to execute otherwise. 
`define `[`require_action`](#debug_8h_1af4a91824c6ca0f3dea55d5cac7319b65)            | require_action  Requires that an expression evaluate to true with an action to execute otherwise. 
`define `[`require_action_string`](#debug_8h_1a46ec6dd3ae533fecdaaa01bd14d38c9d)            | require_action_string  Requires that an expression evaluate to true with an explanation and action to execute otherwise. 
`define `[`require_action_quiet`](#debug_8h_1a509a09fd01a9417030de240e23309a29)            | require_action_quiet  Requires that an expression evaluate to true with an action to execute otherwise. 
`define `[`EV_RPC`](#event__type__code_8h_1a0301dee4a6cd294e5785ceeef1bf350d)            | remote procedure call
`define `[`EV_YUNIO`](#event__type__code_8h_1a76eaa816a287255eb5f1ed14f7d3f8e7)            | YunIO event
`define `[`CODE_YUNIO_CMD_START`](#event__type__code_8h_1aba35a26b23239b1c56a9676ee603779e)            | 
`define `[`CODE_YUNIO_CMD_RETRY`](#event__type__code_8h_1a47ec5168cdec719a3dbda4fbcfe474c8)            | 
`define `[`CODE_YUNIO_CMD_DISCONNECT`](#event__type__code_8h_1ae4913311e0efbb286e6d2c42987ef048)            | 
`define `[`CODE_YUNIO_ON_CONNECTED`](#event__type__code_8h_1a362b0eb4c8313b25c1453fcc6038fa82)            | 
`define `[`CODE_YUNIO_ON_DISCONNECTED`](#event__type__code_8h_1a1eabd57d7a20736fb8bbbaf83d69f625)            | 
`define `[`CODE_YUNIO_ON_CONNECT_FAILED`](#event__type__code_8h_1a665e9a7ed9e041797f1c7d084c75d635)            | 
`define `[`CODE_YUNIO_ON_READ_ERROR`](#event__type__code_8h_1a36dd8c784a3696387fb8a4a41fe5ed0d)            | 
`define `[`CODE_YUNIO_ON_WRITE_ERROR`](#event__type__code_8h_1ae67439a6da29b5fedcfcf3df9836c1de)            | 
`define `[`CODE_YUNIO_ON_HEARTBIT_ERROR`](#event__type__code_8h_1aa1fdf9296cf62a927e203093be4f65f8)            | 
`define `[`CODE_YUNIO_PUBLISH_SUCCESS`](#event__type__code_8h_1acd3a765e3e0a493f8ac75f7b0c24ff98)            | 
`define `[`CODE_YUNIO_PUBLISH_TIMEOUT`](#event__type__code_8h_1a519dd4f2b65cedae88d93f87611272cc)            | 
`define `[`EV_OTA`](#event__type__code_8h_1a05ca485881a2fca9af8df4ce1a3c7161)            | OTA event define
`define `[`CODE_OTA_ON_RESULT`](#event__type__code_8h_1a69134d232ce1a9ec4c8908047432bc5f)            | 
`define `[`EV_DEVICE_REGISTER`](#event__type__code_8h_1aa81d53a7a06db605eefbc7eb029adff1)            | register device service
`define `[`CODE_REGISTER_ON_RESULT`](#event__type__code_8h_1afeab333349391d542547c62a17c7df99)            | 
`define `[`VALUE_REGISTER_SUCCESS`](#event__type__code_8h_1ab4405c9496ed7b7dc9ccdeba3e71622b)            | 
`define `[`EV_ACTIVATE_ID2`](#event__type__code_8h_1acd49d70c2da07796cc6d0a4701764655)            | id2 device activate
`define `[`CODE_ACTIVATE_ID2_ON_RESULT`](#event__type__code_8h_1ae588a3b1506388e1e4000f0e7f1b7f47)            | 
`define `[`VALUE_ACTIVATE_ID2_SUCCESS`](#event__type__code_8h_1ae180ba1eac7475a8fc9ee647b44bdf70)            | 
`define `[`VALUE_ACTIVATE_ID2_FAILURE`](#event__type__code_8h_1a7f071a4c27ead5f427f23ac1ffd7a920)            | 
`define `[`EV_DDA`](#event__type__code_8h_1a4686104546a71295852ba0d45584d22f)            | 
`define `[`CODE_DDA_ON_CONNECTED`](#event__type__code_8h_1a2c6c90a212b6bea6127fec313b8813d2)            | 
`define `[`EV_KEY`](#event__type__code_8h_1aa9584901daa5b7200abdacdfe218d5a4)            | General key define
`define `[`CODE_RECORD`](#event__type__code_8h_1aa925181f7645de59a7d218b7c79936b5)            | 
`define `[`CODE_VOLUME`](#event__type__code_8h_1acc49cc13805369c0190c5aa752d5ca1b)            | 
`define `[`CODE_VOLUME_INC`](#event__type__code_8h_1aed012967e7de26cc18efb7c78cc84039)            | 
`define `[`CODE_VOLUME_DEC`](#event__type__code_8h_1a38a1d0e2c14589ddb221dffc4bb95d1a)            | 
`define `[`CODE_PLAY_PAUSE`](#event__type__code_8h_1a26740dd70f77d076e150ed6dc769367a)            | 
`define `[`CODE_MUTE`](#event__type__code_8h_1aea55db8f253daf6c3df2ccfc12c138a4)            | 
`define `[`CODE_CHANNEL`](#event__type__code_8h_1adf8e4c622814da7db42c0c5a04dd5925)            | 
`define `[`CODE_NEXT`](#event__type__code_8h_1a337e1658f59196532919c6cffbc84dd5)            | 
`define `[`CODE_RECORD_PRE`](#event__type__code_8h_1a6d8dc80f5c3d65dfceabc76ba072ed96)            | 
`define `[`CODE_RESET`](#event__type__code_8h_1a18ef3160b336403f58e06ad82cd27b0c)            | 
`define `[`CODE_STATUS`](#event__type__code_8h_1a98a3000197dd30db07eef3ea20e043e8)            | 
`define `[`CODE_ELINK`](#event__type__code_8h_1ae526abf106427bd8682b2f8a2aa0d4d0)            | 
`define `[`CODE_BOOT`](#event__type__code_8h_1a56e6b0a0af7525ebc142be51bc06376b)            | 
`define `[`VALUE_KEY_UP`](#event__type__code_8h_1a18c95eac934bcd5f31cbc15e5faa9848)            | General key value
`define `[`VALUE_KEY_DOWN`](#event__type__code_8h_1ad8676fc64fcc50d77cbb30a6f6451602)            | 
`define `[`VALUE_KEY_CLICK`](#event__type__code_8h_1a2016497eff08711631e0c7f3094cbec5)            | 
`define `[`VALUE_KEY_LTCLICK`](#event__type__code_8h_1a288238de1c198646573c3b4bf22049a7)            | 
`define `[`VALUE_KEY_LLTCLICK`](#event__type__code_8h_1a5af2139a43b34324c8da361c6de13461)            | 
`define `[`VALUE_KEY_DBCLICK`](#event__type__code_8h_1a4155a36940fea0efc7723e8063dad70a)            | 
`define `[`VALUE_SYS_CHN_CONNECTED`](#event__type__code_8h_1a6e56c1652de4daef8550d5f84091da04)            | General channel value
`define `[`VALUE_SYS_CHN_CONNECTING`](#event__type__code_8h_1a6bd67dd198a9429be41e6ae077045d9d)            | 
`define `[`VALUE_SYS_CHN_DISCONNECTED`](#event__type__code_8h_1a09e030c8a3742da88ee243d84f9ab4df)            | 
`define `[`EV_KNOD`](#event__type__code_8h_1a7561835fdc52884ae351f3d1c8707f62)            | Reserve event
`define `[`EV_SD`](#event__type__code_8h_1aa0cf0d8f26da1e38eae13820a0f918d8)            | SD card event
`define `[`CODE_SD_PLUG`](#event__type__code_8h_1a8a4d9c6e8d812dffc5b1e3cfca6bffd9)            | 
`define `[`VALUE_SD_OUT`](#event__type__code_8h_1abd13c583e4aed8f9287544b550eac641)            | 
`define `[`VALUE_SD_IN`](#event__type__code_8h_1ae613a15618fe24a25e4d25af0d8a9bc9)            | 
`define `[`EV_LAN`](#event__type__code_8h_1a4418dd932546faa7c76a82551cbf2ec7)            | LAN Driver event
`define `[`VALUE_LAN_OUT`](#event__type__code_8h_1a97a50f51f457015798b50e267002b02a)            | 
`define `[`VALUE_LAN_IN`](#event__type__code_8h_1aea9231d5013b03ae10d322cdf2e04b5a)            | 
`define `[`EV_NET`](#event__type__code_8h_1afcc5c1afcb31498d6d6fab5f8d895763)            | Net event define
`define `[`CODE_NET_DHCP_START`](#event__type__code_8h_1a4473f3177039bc46084cf4657ec3eea0)            | 
`define `[`CODE_NET_DHCP_RESULT`](#event__type__code_8h_1a51b4d9b5a7c35bdb7d4b1a81d7408ddc)            | 
`define `[`CODE_NET_IP_STATIC`](#event__type__code_8h_1ae94777d34b632126e35491a2e46f451e)            | 
`define `[`CODE_NET_STATUS`](#event__type__code_8h_1a2fc16177218ab0bf725c58bc78aafd22)            | 
`define `[`VALUE_NET_LAN_OK`](#event__type__code_8h_1a1af32b66c65117cf5af0d873c92e862e)            | 
`define `[`VALUE_NET_WIFI_OK`](#event__type__code_8h_1a94e1c51bd2c039a0b17b769672a54c87)            | 
`define `[`EV_USB`](#event__type__code_8h_1a25481c1736533f043bd694c8b8481a49)            | Usb driver event
`define `[`VALUE_USB_OUT`](#event__type__code_8h_1a3eee9e8af3da5fc738cb1e5fceb753a6)            | 
`define `[`VALUE_USB_IN`](#event__type__code_8h_1af13a9e43c14dbc95c7ee80fded24b54d)            | 
`define `[`EV_PM`](#event__type__code_8h_1ad6e79eabda6d405708ab1da1478b2dcb)            | PM event
`define `[`CODE_PM_ENTER_INFORM`](#event__type__code_8h_1ace9af06e9a426f1ff423e476da9eb09a)            | 
`define `[`CODE_PM_ENTER`](#event__type__code_8h_1a9f691c2019efc88b6af8e27218a01457)            | 
`define `[`CODE_PM_DONE`](#event__type__code_8h_1ae8b3f4532d3e8ae510feb8f387e25d9e)            | 
`define `[`CODE_PM_QUIT`](#event__type__code_8h_1a18b14bd80e5eb27975aa823ef893cd6c)            | 
`define `[`CODE_PM_SHUTDOWN_INFORM`](#event__type__code_8h_1aec04b475e3d3c1b05829b5cd07127b12)            | 
`define `[`CODE_PM_STARTUP_INFORM`](#event__type__code_8h_1a4a86976084db619153264b47c5e4dbf1)            | 
`define `[`CODE_PM_LOWPOWER_INFORM`](#event__type__code_8h_1ae34b18ddd5ed57a4f73c21e2f5e17811)            | 
`define `[`CODE_PM_POWERRECOVER_INFORM`](#event__type__code_8h_1ad8b02cdf5ac9fee21d55901ebd5bf028)            | 
`define `[`CODE_PM_START_HEARTBEAT_INFORM`](#event__type__code_8h_1ae565b11624375b038002ce642bc3f6d0)            | 
`define `[`CODE_PM_STOP_HEARTBEAT_INFORM`](#event__type__code_8h_1a53abbce3515afb2393f2cc4226fd3041)            | 
`define `[`VALUE_PM_IDLE_INFORM`](#event__type__code_8h_1a3aac3ca91309689137c5f62beeca7175)            | 
`define `[`VALUE_PM_POWERBUTTON_INFORM`](#event__type__code_8h_1aa9da806c1ccda20fc9efd2f12570570c)            | 
`define `[`EV_FS`](#event__type__code_8h_1a50c2573a7958214f358e3e37f9e487e7)            | File system event
`define `[`CODE_FSYS_SD_LOAD`](#event__type__code_8h_1a0eb7096243ec8a63c9214041f7b5409e)            | 
`define `[`CODE_FSYS_UDISK_LOAD`](#event__type__code_8h_1aad0f91872d01b1d79f068adbfb53e996)            | 
`define `[`CODE_FSYS_FLASH_LOAD`](#event__type__code_8h_1aabdda409bd5e2ef1808f4fdf006c80f3)            | 
`define `[`CODE_FSYS_SD_SPACE`](#event__type__code_8h_1afb953c2fd02c23dccdfb83bd7dc0d18c)            | 
`define `[`CODE_FSYS_UDISK_SPACE`](#event__type__code_8h_1adb38130dcf75957a0b20a7998ecf4745)            | 
`define `[`CODE_FSYS_FLASH_SPACE`](#event__type__code_8h_1a98b3dd57c012289afb4a1bf491651256)            | 
`define `[`EV_BT`](#event__type__code_8h_1ad8aeb5ad90a02ca788dc6ef752e521d4)            | Bluetooth
`define `[`CODE_BT_DEVICE_CONNECT`](#event__type__code_8h_1a156fe8642b3fa3a7293bee0e641368bb)            | 
`define `[`CODE_BT_DEVICE_DISCONNECT`](#event__type__code_8h_1a30eb27a707bdc52401b30f7063515fce)            | 
`define `[`CODE_BT_MODE_ON`](#event__type__code_8h_1a3d5d6be2d588ad3f89ba2702c9bc8159)            | 
`define `[`CODE_BT_MODE_OFF`](#event__type__code_8h_1a92221d85861d6627b1184c2893536734)            | 
`define `[`EV_DLNA`](#event__type__code_8h_1ae8d9c6efe080c9657dfc6ba48f2b4d6a)            | DLNA
`define `[`CODE_DLNA_DEVICE_CONNECT`](#event__type__code_8h_1a9d6dbdd9d73ed9b91add2084e53899a7)            | 
`define `[`CODE_DLNA_DEVICE_DISCONNECT`](#event__type__code_8h_1a0e421ca3249c21714df46c82094371c5)            | 
`define `[`CODE_DLNA_MODE_ON`](#event__type__code_8h_1adc95490785c84a27bd5e75731fff84d0)            | 
`define `[`CODE_DLNA_MODE_OFF`](#event__type__code_8h_1a33a7b2fcc4d32b8bb55af607da381386)            | 
`define `[`EV_AIRPLAY`](#event__type__code_8h_1a52b6aa120ee216c7743c77e74b8afdd9)            | AIRPLAY
`define `[`CODE_AIRPLAY_DEVICE_CONNECT`](#event__type__code_8h_1a46096186dcea96f7d9712afff415dc78)            | 
`define `[`CODE_AIRPLAY_DEVICE_DISCONNECT`](#event__type__code_8h_1ad45bcf356361e76aa11ce20efa4f20e5)            | 
`define `[`CODE_AIRPLAY_MODE_ON`](#event__type__code_8h_1a186e513fd1c1a7fd7d139952a24cc862)            | 
`define `[`CODE_AIRPLAY_MODE_OFF`](#event__type__code_8h_1a4b48d0bdc73bf8f9c7a8769f38a8ec81)            | 
`define `[`AOS_LOG_LEVEL`](#log__impl_8h_1aa261952d3b777bbb745470f58ce7abdc)            | 
`define `[`AOS_LL_V_NONE`](#log__impl_8h_1a0479c76780f74081e2230b6f6789ec63)            | 
`define `[`AOS_LL_V_ALL`](#log__impl_8h_1a3d48a5e0dc40a98effe1f1a01da9cbbe)            | 
`define `[`AOS_LL_V_FATAL`](#log__impl_8h_1af84ef8d893da4fe00bdcbac07fd53e9f)            | 
`define `[`AOS_LL_V_ERROR`](#log__impl_8h_1aed3b3779ff60e041e998c458d6e5dc71)            | 
`define `[`AOS_LL_V_WARN`](#log__impl_8h_1a5c2d038ed8be7b94e3a00f92163f3f58)            | 
`define `[`AOS_LL_V_INFO`](#log__impl_8h_1aaedc2d9d1d3781636b3a10eb53e3b986)            | 
`define `[`AOS_LL_V_DEBUG`](#log__impl_8h_1a0ce70689bb93323dbff1b0030d1e5f47)            | 
`define `[`COL_DEF`](#log__impl_8h_1a9c1b34fcf28ff990ad9eea3c064641bd)            | 
`define `[`COL_RED`](#log__impl_8h_1a87d30d2657caae38d671f052cb9cc0e7)            | 
`define `[`COL_GRE`](#log__impl_8h_1a9cdb9d058a13d2b954d52c13ebf6f90d)            | 
`define `[`COL_BLU`](#log__impl_8h_1a84a127ed8baebd354118b6d7518ca9fa)            | 
`define `[`COL_YEL`](#log__impl_8h_1a864e4193bd767df90391580c9a7c04d1)            | 
`define `[`COL_WHE`](#log__impl_8h_1aa53304ea5f14313a7bf74298da4a13dc)            | 
`define `[`COL_CYN`](#log__impl_8h_1ae0a857bf983563d0f0b299c07d836b76)            | 
`define `[`COL_MAG`](#log__impl_8h_1a8517113b9d0649078b3a75176a5f5573)            | 
`define `[`GLOBAL_LOG_TAG`](#log__impl_8h_1ad8439b492ab23cc1748b5f50549ef62a)            | 
`define `[`log_print`](#log__impl_8h_1a3898392e09a1bebd13240c082c6ce816)            | 
`define `[`void_func`](#log__impl_8h_1a80ffa8067a17fce16c75107d7e073657)            | 
`define `[`LOG_IMPL`](#log__impl_8h_1ad2ddc7261600d1a356896072632ee519)            | 
`define `[`LOGD_IMPL`](#log__impl_8h_1ad2c421cdb04bb625d04819febb3ac951)            | 
`define `[`LOGF_IMPL`](#log__impl_8h_1a9258df246c14776566d9d3c8bb311425)            | 
`define `[`LOGE_IMPL`](#log__impl_8h_1a372bc53d0eaf1b108a89e95eb1d323bb)            | 
`define `[`LOGW_IMPL`](#log__impl_8h_1a69e38bb28b849f032de3a3da88577805)            | 
`define `[`LOGI_IMPL`](#log__impl_8h_1a11c506b1d4a87801d46c9062c5fc1f58)            | 
`define `[`AOS_WAIT_FOREVER`](#kernel_8h_1ace7b5d4663ba617a23da0ac13acd6ea9)            | 
`define `[`AOS_DEFAULT_APP_PRI`](#kernel_8h_1af68dd1e94330d50f154d26e8f40b6520)            | 
`define `[`aos_offsetof`](#list_8h_1a8cc696677b989b172f5ab8a938b06d1b)            | 
`define `[`aos_container_of`](#list_8h_1ab351f3482972778a52453d4cf00f273c)            | 
`define `[`dlist_entry`](#list_8h_1aa90e0ac71281846733410d0625524d02)            | 
`define `[`AOS_DLIST_INIT`](#list_8h_1ad84316f170c0ed94abff6bee5ca3986d)            | 
`define `[`dlist_first_entry`](#list_8h_1af1a183b22309a4a18139101e0b8dc5be)            | 
`define `[`dlist_for_each`](#list_8h_1a85c0c0944bdf6463f332c38d02ee1b69)            | 
`define `[`dlist_for_each_safe`](#list_8h_1a3b0134cd9d9839dbf4188a814fe19bd2)            | 
`define `[`dlist_for_each_entry`](#list_8h_1ac613bf70e3c79057a81c158113c50455)            | 
`define `[`dlist_for_each_entry_safe`](#list_8h_1a32b2914cd25f6124306ae66c046deb1d)            | 
`define `[`list_entry`](#list_8h_1a26c976b7f654e70df318c1843e5094de)            | list_entry - get the struct for this entry : the &struct list_head pointer. : the type of the struct this is embedded in. : the name of the list_struct within the struct.
`define `[`dlist_for_each_entry_reverse`](#list_8h_1aaa882b0cf8af3cc7245e51a6b1095f4c)            | list_for_each_entry_reverse_t - iterate backwards over list of given type. : the type * to use as a loop cursor. : the head for your list. : the name of the list_head within the struct. : the type of the struct this is embedded in.
`define `[`dlist_entry_number`](#list_8h_1a3f5a888135b513cb5ee39f534842e062)            | 
`define `[`AOS_DLIST_HEAD_INIT`](#list_8h_1ae00de76a37aadf228d5da0e6295736af)            | 
`define `[`AOS_DLIST_HEAD`](#list_8h_1a6707b3b791b349124111c7c9e5b777dd)            | 
`define `[`slist_for_each_entry`](#list_8h_1a2b49a24c73d18c6175de98419869d1ac)            | 
`define `[`slist_for_each_entry_safe`](#list_8h_1aff7c0edb74de8e67a0c1cc15c4b06e8e)            | 
`define `[`AOS_SLIST_HEAD_INIT`](#list_8h_1afc7b63732b51ec4d92227018f6d71494)            | 
`define `[`AOS_SLIST_HEAD`](#list_8h_1a350fd389591b7bf3da3e81baed9fbbee)            | 
`define `[`slist_entry`](#list_8h_1a7345be2c3717197378d0c294603a92f9)            | 
`define `[`slist_first_entry`](#list_8h_1af97027b393b390597759c365c6820c0f)            | 
`define `[`slist_entry_number`](#list_8h_1a6b07c04dad0d85b6e31f4a4cec20d808)            | 
`define `[`LOGF`](#log_8h_1acb7268fb6c63c18aa7d372642e9c9994)            | fatal log
`define `[`LOGE`](#log_8h_1a0d0173d9a0b62a413f2b6dc5cb45b68d)            | error log
`define `[`LOGW`](#log_8h_1ad10099153d2aa027c77b7109f9c82b68)            | warning log
`define `[`LOGI`](#log_8h_1a834da07fe3197a064a151e6972ecb9ae)            | information log
`define `[`LOGD`](#log_8h_1ab2bb4d01d7fa560ad13a9cfc3b32fcbc)            | debug log
`define `[`LOG`](#log_8h_1a388edf12256bf73c3a8ee9734c3bd841)            | log at warning level
`define `[`_MBEDYLS_SSL_H_`](#mbedtls__ssl_8h_1ae8ccc1f5599f1ccd025b19e8be958f02)            | 
`define `[`EV_ALL`](#yloop_8h_1ab185d5d92c1a1df99920c5ba833f5372)            | special event filter
`define `[`EV_FLAG_URGENT`](#yloop_8h_1a399f2a3958f2a832817221506c15e898)            | 
`define `[`EV_SYS`](#yloop_8h_1a8fdc7aaa2a13ab9489d7b45b9ef50568)            | system event
`define `[`CODE_SYS_ON_STARTING`](#yloop_8h_1a0ba0b0ce2794b076ea7537d111501005)            | 
`define `[`CODE_SYS_ON_START_COMPLETED`](#yloop_8h_1a5b1bc45a2bccaa3caa0497194c99d30e)            | 
`define `[`CODE_SYS_ON_START_FAILED`](#yloop_8h_1a8ade53665e324a90cb4a6606d266613b)            | 
`define `[`CODE_SYS_ON_IDLE`](#yloop_8h_1ac4797216e21ccb95a9896faf7dfbf37e)            | 
`define `[`CODE_SYS_ON_START_FOTA`](#yloop_8h_1afea94dfbfa2188fe73ed0d11d6e2ef31)            | 
`define `[`CODE_SYS_ON_ALINK_ONLINE`](#yloop_8h_1a199221e59559593d02d55951040ebf57)            | 
`define `[`CODE_SYS_ON_ALINK_OFFLINE`](#yloop_8h_1a86733bdbdb0f179abde321e5a1c5be39)            | 
`define `[`CODE_SYS_ON_MQTT_READ`](#yloop_8h_1ae4ebb708cb88da0bce93013e7ef7024d)            | 
`define `[`EV_WIFI`](#yloop_8h_1affc4055fea07f15553fc8db17a6e120a)            | WiFi event
`define `[`CODE_WIFI_CMD_RECONNECT`](#yloop_8h_1acda03b652239c2edec40254bed44d221)            | 
`define `[`CODE_WIFI_ON_CONNECTED`](#yloop_8h_1a427d380cb8889ff699407a4dd2f95bf6)            | 
`define `[`CODE_WIFI_ON_DISCONNECT`](#yloop_8h_1a8d95529b42f69e41c5220afd63f10028)            | 
`define `[`CODE_WIFI_ON_PRE_GOT_IP`](#yloop_8h_1ab55425e200c93b06bd26576c263dc91c)            | 
`define `[`CODE_WIFI_ON_GOT_IP`](#yloop_8h_1a4df6dc893a96f082d77db6dd86594d61)            | 
`define `[`EV_MESH`](#yloop_8h_1ad75a94b05f00c645c42912d796db5593)            | Mesh event
`define `[`CODE_MESH_STARTED`](#yloop_8h_1afd5af39eea4e80307e35a132b2b512f4)            | 
`define `[`CODE_MESH_ATTACHED`](#yloop_8h_1a8b1a74be071365257f6864ecfff707ee)            | 
`define `[`CODE_MESH_DETACHED`](#yloop_8h_1abbfc2d842eb104b7897884775c0c94b2)            | 
`define `[`CODE_MESH_CONNECTED`](#yloop_8h_1a77de4213aee74d827a703cd286d10e5e)            | 
`define `[`CODE_MESH_DISCONNECTED`](#yloop_8h_1a7fd68538cd58d9d2dec4b92a8efec0b6)            | 
`define `[`EV_USER`](#yloop_8h_1a5a9c2af33336fd505ae51bdad7f65435)            | user app start 0x1000 - 0x7fff
`define `[`SENSOR_TYPE_TEMPERATURE`](#sensor_8h_1afb4ae0506fc7cd6743247dae31528d46)            | 
`define `[`PAR_OPT_READ_POS`](#flash_8h_1ab1e58b6e8ff6f3761bdf24c04478c7f6)            | 
`define `[`PAR_OPT_WRITE_POS`](#flash_8h_1a68ff33d27eb40be97075ac7acc28b1dc)            | 
`define `[`PAR_OPT_READ_MASK`](#flash_8h_1a0b707d2a64f885c6386592c581470077)            | 
`define `[`PAR_OPT_WRITE_MASK`](#flash_8h_1a19bd5124832592851507c6febb93a65d)            | 
`define `[`PAR_OPT_READ_DIS`](#flash_8h_1a4f5a8817f87909dd93f8b655236bfa97)            | 
`define `[`PAR_OPT_READ_EN`](#flash_8h_1ad38fd963b47f4417058bde27626cec60)            | 
`define `[`PAR_OPT_WRITE_DIS`](#flash_8h_1a2e3aedc128cf4fc5c1962e9229ef00e9)            | 
`define `[`PAR_OPT_WRITE_EN`](#flash_8h_1a06797fb3f63772e5b3b7b72edd7ae86b)            | 
`define `[`TRACE_HAl_H`](#trace_8h_1a9476de8495ed6e38c8f7c1beac7af296)            | 
`enum `[`ALINK_LOG_LEVEL`](#group__wifi__debug_1gaf17ae4b2877b06aff2343711faadbddb)            | log level def.
`enum `[`ALINK_WIFI_CALLBACK`](#group__wifi__callback_1ga3b5fd33d4b23fc88f44e05173ecd2f21)            | alink callback event
`enum `[`@0`](#cloud_8h_1a06fc87d81c62e9abb8790b6e5713c55b)            | 
`enum `[`log_level_bit`](#log__impl_8h_1a3a413ca4b2647ce48fa4506e9b928bc6)            | 
`enum `[`aos_log_level_t`](#log_8h_1ab5415466dbe3b11b98f39d2c428bac16)            | log level definition.
`enum `[`@1`](#base_8h_1adf764cbdea00d65edcd07bb9953ad2b7)            | HAL common error code.
`enum `[`hal_partition_t`](#flash_8h_1a1ff07b8a9c096b1b8ca7847be7c6e097)            | 
`enum `[`hal_flash_t`](#flash_8h_1ad6e8fb5585076e4fc4986317027ab76d)            | 
`enum `[`gpio_config_t`](#gpio_8h_1a9f109d20988917f140f5d55ed9a71385)            | Pin configuration
`enum `[`gpio_irq_trigger_t`](#gpio_8h_1aa3de939093227b362c7ea6d942ecae9d)            | GPIO interrupt trigger
`enum `[`hal_uart_data_width_t`](#uart_8h_1a631222ce1f55203f7456a62df1adaeaa)            | UART data width
`enum `[`hal_uart_stop_bits_t`](#uart_8h_1aef51ce06a2c07532c061b3ebd5e22d25)            | UART stop bits
`enum `[`hal_uart_flow_control_t`](#uart_8h_1a33928493a14b4828cb32e778d1af482d)            | UART flow control
`enum `[`hal_uart_parity_t`](#uart_8h_1a67ed44b4958988acbd6cbccbe7d83b60)            | UART parity
`enum `[`wlan_sec_type_e`](#group__aos__hal__wifi_1gafa47b09f4b5246c3b1176fd9c75cf827)            | 
`enum `[`hal_wifi_event_t`](#group__aos__hal__wifi_1ga83730d6c7cd3928caaa3cf4aa0415a24)            | 
`enum `[`hal_wifi_type_t`](#group__aos__hal__wifi_1ga9c6cd73d1b386384fea4dc5be8a25adc)            | 
`enum `[`@2`](#group__aos__hal__wifi_1ga99fb83031ce9923c84392b4e92f956b5)            | 
`public void `[`alink_set_loglevel`](#group__wifi__debug_1ga3779729957441942a2abc98feb002181)`(enum `[`ALINK_LOG_LEVEL`](#group__wifi__debug_1gaf17ae4b2877b06aff2343711faadbddb)` loglevel)`            | log level control
`public int `[`alink_enable_sandbox_mode`](#group__wifi__debug_1gadd42d7fcac8cb0bc0f7c4c23c1fccd9b)`(void)`            | enable sandbox mode, for debug
`public int `[`alink_enable_daily_mode`](#group__wifi__debug_1gaaabf9975f8812dc1a58db3e813763daf)`(const char * server_ip,int port)`            | enable daily mode, for debug
`public int `[`alink_start`](#group__wifi__entry_1gaa51c9013febdbb0b58ab1ac901fea792)`(void)`            | entry function. start alink gateway service.
`public int `[`alink_wait_connect`](#group__wifi__entry_1ga1f5065903c84c98cf02a0f65ccd6e3f6)`(int timeout_ms)`            | waiting alink connect to aliyun server
`public int `[`alink_end`](#group__wifi__entry_1ga4e4e661d611f8fbc8cb360dda9d6ffb0)`(void)`            | destroy alink service and free resources
`public int `[`alink_factory_reset`](#group__wifi__entry_1ga95f9d8016cde456e7b7cb9b89acad413)`(void)`            | reset user account binding.
`public int `[`alink_report`](#group__wifi__report_1gadc5c42911beda8c2c3534c404363c273)`(const char * method,char * json_buffer)`            | report alink message, it is a fundamental func.
`public int `[`alink_report_rawdata`](#group__wifi__report_1ga7c9f73105a6ebacc8525ceb4ee2556dc)`(const char * rawdata,int len)`            | 
`public int `[`alink_register_callback`](#group__wifi__callback_1ga2f49a6c4440868578138dc4e38f10e74)`(unsigned char cb_type,void * cb_func)`            | register misc callback
`public int `[`awss_start`](#group__wifi__awss_1ga20454ef4cbebf8584d9d071ebd3f898c)`(void)`            | start awss service, block method, block until awss succeed, or timeout(see Note).
`public int `[`awss_stop`](#group__wifi__awss_1gaf64ac3d619f49ed0fea96579f984ca17)`(void)`            | calling this func force awss_start exit.
`public int32_t `[`aos_uart_send`](#aos_8h_1a3f4a0f0c0e677838365d0010bcb1f111)`(void * data,uint32_t size,uint32_t timeout)`            | Transmit data on a UART interface.
`public inline static int `[`cli_register_command`](#cli_8h_1af707e2241ff13add871d94da00d5422f)`(const struct `[`cli_command`](#structcli__command)` * command)`            | 
`public inline static int `[`cli_unregister_command`](#cli_8h_1a4beb8962840fd1ca27675ceaae42a6b8)`(const struct `[`cli_command`](#structcli__command)` * command)`            | 
`public inline static int `[`cli_register_commands`](#cli_8h_1a77b4f1228666e61699c58b8c19309a1b)`(const struct `[`cli_command`](#structcli__command)` * commands,int num_commands)`            | 
`public inline static int `[`cli_unregister_commands`](#cli_8h_1ade5a38c362a8841320ff22b5fe8e2447)`(const struct `[`cli_command`](#structcli__command)` * commands,int num_commands)`            | 
`public inline static int `[`aos_cli_init`](#cli_8h_1acd9d10d2482f8f228c0dcb57e8ea78f4)`(void)`            | 
`public inline static int `[`aos_cli_stop`](#cli_8h_1ac9c42106010c7ae9b962e2310abf851a)`(void)`            | 
`public int `[`aos_cloud_register_callback`](#cloud_8h_1ab3bd028a3acd80c60bc7e6a7e461d93b)`(int cb_type,`[`aos_cloud_cb_t`](#cloud_8h_1a22ca1348c62b436e4bde1610673e77e7)` cb)`            | Register cloud event callback.
`public int `[`aos_cloud_report`](#cloud_8h_1aec9446932fef9166c9b4f1f61b36fb23)`(const char * method,const char * json_buffer,void(*)(void *) done_cb,void * arg)`            | Report event to cloud.
`public void `[`aos_cloud_trigger`](#cloud_8h_1a1d2fd4d25b1689ea4503d4c87ac5c67b)`(int cb_type,const char * json_buffer)`            | trigger specific event, used by Cloud Backend
`public void `[`aos_cloud_register_backend`](#cloud_8h_1a3636a6e0a1ac9b6c90fc43c0afb79627)`(int(*)(const char *method, const char *json_buffer) report)`            | register Cloud Backend
`public inline static unsigned int `[`aos_log_get_level`](#log__impl_8h_1a24579a47d3fe3782ad920fa667a41d6d)`(void)`            | 
`public int `[`csp_printf`](#log__impl_8h_1a3f07b35189b67e500454b2b818ba1574)`(const char * fmt,...)`            | 
`public void `[`aos_reboot`](#kernel_8h_1aaa9ebda2d7e29737cfa7272058e215b1)`(void)`            | System reboot
`public int `[`aos_get_hz`](#kernel_8h_1ae8d852bd8f91b585e3a3b35b87482a8c)`(void)`            | get HZ
`public const char * `[`aos_version_get`](#kernel_8h_1acd94826d0fbcf02968bc1b73ed4dc24e)`(void)`            | Get kernel version
`public const char * `[`aos_strerror`](#kernel_8h_1acbb3042eb3786c26f862feaf1d841114)`(int errnum)`            | get error information 
`public int `[`aos_task_new`](#kernel_8h_1ac3e5819f79305744325c60c53221e81c)`(const char * name,void(*)(void *) fn,void * arg,int stack_size)`            | Create a task([threadRhino&other-kernel][MainLoopnoRTOS])
`public int `[`aos_task_new_ext`](#kernel_8h_1a75ed0d26eba3aa9304533166b751af9f)`(`[`aos_task_t`](#kernel_8h_1a8331188bdef4856ea654e31c05a7827e)` * task,const char * name,void(*)(void *) fn,void * arg,int stack_size,int prio)`            | Create a task([threadRhino&other-kernel][MainLoopnoRTOS])
`public void `[`aos_task_exit`](#kernel_8h_1a4f8364a78b8c797ac86ee5de9f0b05c5)`(int code)`            | exit a task 
`public const char * `[`aos_task_name`](#kernel_8h_1adbb65e60cc107a65d3d45b578fbf7a9e)`(void)`            | get task name
`public int `[`aos_task_key_create`](#kernel_8h_1ad81cdd2fa83909ccbaa151e29ae1aea0)`(`[`aos_task_key_t`](#kernel_8h_1ac2e6e434ccf67117e3b1f00483d4b364)` * key)`            | create a task key 
`public void `[`aos_task_key_delete`](#kernel_8h_1ac93f559c867c74e62ecdaffbb0c5d38b)`(`[`aos_task_key_t`](#kernel_8h_1ac2e6e434ccf67117e3b1f00483d4b364)` key)`            | delete a task key 
`public int `[`aos_task_setspecific`](#kernel_8h_1abc5849757e768e073914dd672f661b51)`(`[`aos_task_key_t`](#kernel_8h_1ac2e6e434ccf67117e3b1f00483d4b364)` key,void * vp)`            | associate a task-specific value with a key 
`public void * `[`aos_task_getspecific`](#kernel_8h_1a3d04253f30128f0f443b7b08646472e5)`(`[`aos_task_key_t`](#kernel_8h_1ac2e6e434ccf67117e3b1f00483d4b364)` key)`            | get the value currently bound to the specified key 
`public int `[`aos_mutex_new`](#kernel_8h_1a39a39b90a25ef280ba26bef68120a57d)`(`[`aos_mutex_t`](#kernel_8h_1ace8bc8c4f45849bf1239ef25cdbc2f7e)` * mutex)`            | alloc a mutex 
`public void `[`aos_mutex_free`](#kernel_8h_1aad3b88f3a77b2a1139c2e8023f77919d)`(`[`aos_mutex_t`](#kernel_8h_1ace8bc8c4f45849bf1239ef25cdbc2f7e)` * mutex)`            | free a mutex 
`public int `[`aos_mutex_lock`](#kernel_8h_1ae33d2cc601477493d159eaae9dafd433)`(`[`aos_mutex_t`](#kernel_8h_1ace8bc8c4f45849bf1239ef25cdbc2f7e)` * mutex,unsigned int timeout)`            | lock a mutex 
`public int `[`aos_mutex_unlock`](#kernel_8h_1ac0d44d29a69cc71cb5d921cc12df646b)`(`[`aos_mutex_t`](#kernel_8h_1ace8bc8c4f45849bf1239ef25cdbc2f7e)` * mutex)`            | unlock a mutex 
`public int `[`aos_mutex_is_valid`](#kernel_8h_1a5c0600e105761364fe15cba496341148)`(`[`aos_mutex_t`](#kernel_8h_1ace8bc8c4f45849bf1239ef25cdbc2f7e)` * mutex)`            | This function will check if mutex is valid 
`public int `[`aos_sem_new`](#kernel_8h_1a7b4c81682a9a9b9ed039e9bd1ee668cb)`(`[`aos_sem_t`](#kernel_8h_1a4f2e4d746fc4b086c6fab52ce8b1a117)` * sem,int count)`            | alloc a semaphore 
`public void `[`aos_sem_free`](#kernel_8h_1a8280f3374a68d03e68b7998c16e3e10a)`(`[`aos_sem_t`](#kernel_8h_1a4f2e4d746fc4b086c6fab52ce8b1a117)` * sem)`            | destroy a semaphore 
`public int `[`aos_sem_wait`](#kernel_8h_1addd37f144a0d2ab1aff2796d0ea0b6b8)`(`[`aos_sem_t`](#kernel_8h_1a4f2e4d746fc4b086c6fab52ce8b1a117)` * sem,unsigned int timeout)`            | acquire a semaphore 
`public void `[`aos_sem_signal`](#kernel_8h_1a88f5c9ab76c15d6046be6bad0e9eadd0)`(`[`aos_sem_t`](#kernel_8h_1a4f2e4d746fc4b086c6fab52ce8b1a117)` * sem)`            | release a semaphore 
`public int `[`aos_sem_is_valid`](#kernel_8h_1a312b401df7136fc6676f8b391d3db2d0)`(`[`aos_sem_t`](#kernel_8h_1a4f2e4d746fc4b086c6fab52ce8b1a117)` * sem)`            | This function will check if semaphore is valid 
`public void `[`aos_sem_signal_all`](#kernel_8h_1a53070c6fcdb7f8fbef1a8eb4a26fd7cf)`(`[`aos_sem_t`](#kernel_8h_1a4f2e4d746fc4b086c6fab52ce8b1a117)` * sem)`            | release all semaphore 
`public int `[`aos_queue_new`](#kernel_8h_1a5326decc24a0481168a84fa1d69f1548)`(`[`aos_queue_t`](#kernel_8h_1ad783cc298941621eda3f9f05d656d613)` * queue,void * buf,unsigned int size,int max_msg)`            | This function will create a queue 
`public void `[`aos_queue_free`](#kernel_8h_1a8d136c68d53e64e5adc77ed641c8874c)`(`[`aos_queue_t`](#kernel_8h_1ad783cc298941621eda3f9f05d656d613)` * queue)`            | This function will delete a queue 
`public int `[`aos_queue_send`](#kernel_8h_1a51536bfc868ae28bf2699b875175b39c)`(`[`aos_queue_t`](#kernel_8h_1ad783cc298941621eda3f9f05d656d613)` * queue,void * msg,unsigned int size)`            | This function will send a msg to the front of a queue 
`public int `[`aos_queue_recv`](#kernel_8h_1a0b872ba513dd489162e71ac081c24762)`(`[`aos_queue_t`](#kernel_8h_1ad783cc298941621eda3f9f05d656d613)` * queue,unsigned int ms,void * msg,unsigned int * size)`            | This function will receive msg from a queue 
`public int `[`aos_queue_is_valid`](#kernel_8h_1ac8b31749bf7998f9e0e06cc534a02e01)`(`[`aos_queue_t`](#kernel_8h_1ad783cc298941621eda3f9f05d656d613)` * queue)`            | This function will check if queue is valid 
`public void * `[`aos_queue_buf_ptr`](#kernel_8h_1a11ac192f58dcf3fb7827261abb0a1e5f)`(`[`aos_queue_t`](#kernel_8h_1ad783cc298941621eda3f9f05d656d613)` * queue)`            | This function will return buf ptr if queue is inited 
`public int `[`aos_sched_disable`](#kernel_8h_1a1068e110d5a7d5753fdfe8305c9df769)`(void)`            | This function will disable kernel sched 
`public int `[`aos_sched_enable`](#kernel_8h_1ae969ba05e2dc9319acda865d080d8f5a)`(void)`            | This function will enable kernel sched 
`public int `[`aos_timer_new`](#kernel_8h_1a65bf6c43ffbc83fb3b2dea492a6113fd)`(`[`aos_timer_t`](#kernel_8h_1a0e761beb1932038b7d24c918c2a59c89)` * timer,void(*)(void *, void *) fn,void * arg,int ms,int repeat)`            | This function will create a timer 
`public void `[`aos_timer_free`](#kernel_8h_1a35c10dcc1344edf1f6953571f9be5b2f)`(`[`aos_timer_t`](#kernel_8h_1a0e761beb1932038b7d24c918c2a59c89)` * timer)`            | This function will delete a timer 
`public int `[`aos_timer_start`](#kernel_8h_1ab0d3ca7374c1b73d9b1163b34134f42a)`(`[`aos_timer_t`](#kernel_8h_1a0e761beb1932038b7d24c918c2a59c89)` * timer)`            | This function will start a timer 
`public int `[`aos_timer_stop`](#kernel_8h_1aea7b86d5fa4798a95049190e745907dd)`(`[`aos_timer_t`](#kernel_8h_1a0e761beb1932038b7d24c918c2a59c89)` * timer)`            | This function will stop a timer 
`public int `[`aos_timer_change`](#kernel_8h_1a2b17bb6230d0b9d567754612c5430e03)`(`[`aos_timer_t`](#kernel_8h_1a0e761beb1932038b7d24c918c2a59c89)` * timer,int ms)`            | This function will change attributes of a timer 
`public int `[`aos_workqueue_create`](#kernel_8h_1a7aa3b1afb11951c46eab1d0b43c37226)`(`[`aos_workqueue_t`](#structaos__workqueue__t)` * workqueue,int pri,int stack_size)`            | This function will creat a workqueue 
`public void `[`aos_workqueue_del`](#kernel_8h_1a944dbd969c5416fdd3c0defa62be5681)`(`[`aos_workqueue_t`](#structaos__workqueue__t)` * workqueue)`            | This function will delete a workqueue 
`public int `[`aos_work_init`](#kernel_8h_1ae853d1d6ed0e64b996cf7303d0cdf22c)`(`[`aos_work_t`](#kernel_8h_1a1e7c04d7e97812526bfea771f1f3d6c3)` * work,void(*)(void *) fn,void * arg,int dly)`            | This function will initialize a work 
`public void `[`aos_work_destroy`](#kernel_8h_1ab4b4a876cb5f99870464437fdf1d8473)`(`[`aos_work_t`](#kernel_8h_1a1e7c04d7e97812526bfea771f1f3d6c3)` * work)`            | This function will destroy a work 
`public int `[`aos_work_run`](#kernel_8h_1ad4996714a1cf9618dc4063097a8bd8cd)`(`[`aos_workqueue_t`](#structaos__workqueue__t)` * workqueue,`[`aos_work_t`](#kernel_8h_1a1e7c04d7e97812526bfea771f1f3d6c3)` * work)`            | This function will run a work on a workqueue 
`public int `[`aos_work_sched`](#kernel_8h_1a5efd9714085578c4fc2919f88ddf713d)`(`[`aos_work_t`](#kernel_8h_1a1e7c04d7e97812526bfea771f1f3d6c3)` * work)`            | This function will run a work on the default workqueue 
`public int `[`aos_work_cancel`](#kernel_8h_1a468f8735777d13a035291cb8db664d02)`(`[`aos_work_t`](#kernel_8h_1a1e7c04d7e97812526bfea771f1f3d6c3)` * work)`            | This function will cancel a work on the default workqueue 
`public void * `[`aos_realloc`](#kernel_8h_1acdbdecb39b5b77bc30b2c76b368a2322)`(void * mem,unsigned int size)`            | realloc memory 
`public void * `[`aos_malloc`](#kernel_8h_1ace6ec1b819481718629380a6ab9b3d57)`(unsigned int size)`            | alloc memory 
`public void * `[`aos_zalloc`](#kernel_8h_1ad8074d67714dc589918cce73ab6ec751)`(unsigned int size)`            | alloc memory and clear to zero 
`public void `[`aos_alloc_trace`](#kernel_8h_1a99e4fd7a1b3afda2122f5c005a3a4fe8)`(void * addr,size_t allocator)`            | trace alloced mems 
`public void `[`aos_free`](#kernel_8h_1a12a6358720769a6489f381d860fe6dc4)`(void * mem)`            | free memory 
`public long long `[`aos_now`](#kernel_8h_1af3cea202def3ac1612449897bee0b481)`(void)`            | get current time in nano seconds 
`public long long `[`aos_now_ms`](#kernel_8h_1ab0f5a75d2da6e526862decdf11a2574f)`(void)`            | get current time in mini seconds 
`public void `[`aos_msleep`](#kernel_8h_1ad02a268f96460567b93155324510a0c5)`(int ms)`            | msleep 
`public int `[`aos_kv_set`](#kv_8h_1a18e25fc9b6cc24c1fddfcc11d8726087)`(const char * key,const void * value,int len,int sync)`            | add another KV pair.
`public int `[`aos_kv_get`](#kv_8h_1afa4c842f059c069a6ca43de194f78d05)`(const char * key,void * buffer,int * buffer_len)`            | get the KV value stored in  by its key .
`public int `[`aos_kv_del`](#kv_8h_1a711e19ff624c05b9b41d3c11e2ac44fe)`(const char * key)`            | delete the KV pair by its key .
`public inline static void `[`__dlist_add`](#list_8h_1acfac6035fb611ca4b1653183d1a1d268)`(`[`dlist_t`](#list_8h_1aeedb54ed9ac69e4fc599452bbc7eccbe)` * node,`[`dlist_t`](#list_8h_1aeedb54ed9ac69e4fc599452bbc7eccbe)` * prev,`[`dlist_t`](#list_8h_1aeedb54ed9ac69e4fc599452bbc7eccbe)` * next)`            | 
`public inline static void `[`dlist_add`](#list_8h_1ab5fd92793cd02313e7a6e9f78d16bd57)`(`[`dlist_t`](#list_8h_1aeedb54ed9ac69e4fc599452bbc7eccbe)` * node,`[`dlist_t`](#list_8h_1aeedb54ed9ac69e4fc599452bbc7eccbe)` * queue)`            | 
`public inline static void `[`dlist_add_tail`](#list_8h_1a7c8b4b86bc1355262e8cf9754d5e7ad6)`(`[`dlist_t`](#list_8h_1aeedb54ed9ac69e4fc599452bbc7eccbe)` * node,`[`dlist_t`](#list_8h_1aeedb54ed9ac69e4fc599452bbc7eccbe)` * queue)`            | 
`public inline static void `[`dlist_del`](#list_8h_1a44be29dcbde5e33d8b1631fd573c9263)`(`[`dlist_t`](#list_8h_1aeedb54ed9ac69e4fc599452bbc7eccbe)` * node)`            | 
`public inline static void `[`dlist_init`](#list_8h_1afb5ee572477c0667e9c24a8103ae5703)`(`[`dlist_t`](#list_8h_1aeedb54ed9ac69e4fc599452bbc7eccbe)` * node)`            | 
`public inline static void `[`INIT_AOS_DLIST_HEAD`](#list_8h_1a5516c031b59eeab86a60ed3e476eca7d)`(`[`dlist_t`](#list_8h_1aeedb54ed9ac69e4fc599452bbc7eccbe)` * list)`            | 
`public inline static int `[`dlist_empty`](#list_8h_1a90536260cd9ef225666f9722ebcd6737)`(const `[`dlist_t`](#list_8h_1aeedb54ed9ac69e4fc599452bbc7eccbe)` * head)`            | 
`public inline static void `[`slist_add`](#list_8h_1a48d4ba068d5100a34df0cb301ef931b9)`(`[`slist_t`](#list_8h_1adeee7753df41046b42a3cc5f094ff098)` * node,`[`slist_t`](#list_8h_1adeee7753df41046b42a3cc5f094ff098)` * head)`            | 
`public inline static void `[`slist_add_tail`](#list_8h_1aede1ac1e67d228efdfd4f8b44683fef0)`(`[`slist_t`](#list_8h_1adeee7753df41046b42a3cc5f094ff098)` * node,`[`slist_t`](#list_8h_1adeee7753df41046b42a3cc5f094ff098)` * head)`            | 
`public inline static void `[`slist_del`](#list_8h_1ac077ea4258f54c8e970b2007a3b4f770)`(`[`slist_t`](#list_8h_1adeee7753df41046b42a3cc5f094ff098)` * node,`[`slist_t`](#list_8h_1adeee7753df41046b42a3cc5f094ff098)` * head)`            | 
`public inline static int `[`slist_empty`](#list_8h_1aa10779953f2682ed895d5c94d38da154)`(const `[`slist_t`](#list_8h_1adeee7753df41046b42a3cc5f094ff098)` * head)`            | 
`public inline static void `[`slist_init`](#list_8h_1ab5500b0449c2960689eb04df286a4f64)`(`[`slist_t`](#list_8h_1adeee7753df41046b42a3cc5f094ff098)` * head)`            | 
`public void `[`aos_set_log_level`](#log_8h_1ae17ac5be96340be7f2ad09073f5f2438)`(`[`aos_log_level_t`](#log_8h_1ab5415466dbe3b11b98f39d2c428bac16)` log_level)`            | log level control
`public void * `[`mbedtls_ssl_connect`](#mbedtls__ssl_8h_1ac8e25eeaeab85591aaac6c4d2fe448b7)`(void * tcp_fd,const char * ca_cert,int ca_cert_len)`            | 
`public int `[`mbedtls_ssl_send`](#mbedtls__ssl_8h_1a0ebe89132557545e0bacc6a612b75e78)`(void * ssl,const char * buffer,int length)`            | 
`public int `[`mbedtls_ssl_recv`](#mbedtls__ssl_8h_1ae9d48c1e1dcc277ebf4717f91c074706)`(void * ssl,char * buffer,int length)`            | 
`public int `[`mbedtls_ssl_close`](#mbedtls__ssl_8h_1a577aa17f3fed0a15fe7078445cf8302a)`(void * ssl)`            | 
`public const char * `[`get_aos_product_model`](#version_8h_1aa58affac87db6f69d55668da06a1a4ce)`(void)`            | 
`public const char * `[`get_aos_os_version`](#version_8h_1aee496d8bd359a7bef37c106e3fbd9964)`(void)`            | 
`public const char * `[`get_aos_kernel_version`](#version_8h_1ac337492dbb8856b786c1d8c4c3624ede)`(void)`            | 
`public const char * `[`get_aos_app_version`](#version_8h_1a4f0f840603fc141346cb94f49c9e79f3)`(void)`            | 
`public const char * `[`get_aos_device_name`](#version_8h_1a15e74ca877fc06f74ee6e4a6986d67fc)`(void)`            | 
`public void `[`dump_sys_info`](#version_8h_1a9346d6c941c5456a760587f57b31021b)`(void)`            | 
`public int `[`aos_open`](#vfs_8h_1aef54e3c41eba34f466fe5aa9f246b0f4)`(const char * path,int flags)`            | open the file or device by its path .
`public int `[`aos_close`](#vfs_8h_1a906713ae1aee479aebe9386e0a63c144)`(int fd)`            | close the file or device by its fd .
`public ssize_t `[`aos_read`](#vfs_8h_1a1cf12ef52cc88e8e20c5cbbb186a6d56)`(int fd,void * buf,size_t nbytes)`            | read the contents of a file or device into a buffer.
`public ssize_t `[`aos_write`](#vfs_8h_1aa1df432533c08eae84f46a50702f4b48)`(int fd,const void * buf,size_t nbytes)`            | write the contents of a buffer to file or device
`public int `[`aos_ioctl`](#vfs_8h_1a8133136684b26ab56a9323ae4e7e1f99)`(int fd,int cmd,unsigned long arg)`            | This is a wildcard API for sending controller specific commands.
`public int `[`aos_poll`](#vfs_8h_1a03a7a25b0cfac42b7bb65284a3fc1bde)`(struct pollfd * fds,int nfds,int timeout)`            | A mechanism to multiplex input/output over a set of file handles(file descriptors). For every file handle provided, poll() examines it for any events registered for that particular file handle.
`public int `[`aos_fcntl`](#vfs_8h_1afd56065fdc737494d0fca200331279dc)`(int fd,int cmd,int val)`            | performs one of the operations described below on the open file descriptor . The operation is determined by .
`public off_t `[`aos_lseek`](#vfs_8h_1ac698dbacfd3361e86f4f64b8c8e333e5)`(int fd,off_t offset,int whence)`            | move the file position to a given offset from from a given location
`public int `[`aos_sync`](#vfs_8h_1ad678b7cef27c2db4a00fdaeb9faa4ab5)`(int fd)`            | flush any buffers associated with the file
`public int `[`aos_stat`](#vfs_8h_1a8e1efc5812e6b42ab3b16437f8737fb6)`(const char * path,struct stat * st)`            | store information about the file in a stat structure
`public int `[`aos_unlink`](#vfs_8h_1a7aa7b5d755eb1602425ee011c65e163e)`(const char * path)`            | remove a file from the filesystem.
`public int `[`aos_rename`](#vfs_8h_1aafc67bc9a25656f35eea035e36566cd2)`(const char * oldpath,const char * newpath)`            | rename a file in the filesystem.
`public `[`aos_dir_t`](#structaos__dir__t)` * `[`aos_opendir`](#vfs_8h_1aa0c6a7f420b357e153995c66dfda39dc)`(const char * path)`            | open a directory on the filesystem
`public int `[`aos_closedir`](#vfs_8h_1abcf24fbeac59408f74f5ded76f4575e5)`(`[`aos_dir_t`](#structaos__dir__t)` * dir)`            | 
`public `[`aos_dirent_t`](#structaos__dirent__t)` * `[`aos_readdir`](#vfs_8h_1ab5f5731375aec689bd8365c3dd0300ce)`(`[`aos_dir_t`](#structaos__dir__t)` * dir)`            | 
`public int `[`aos_mkdir`](#vfs_8h_1a81549a9314547bb741f823bc5c5283ed)`(const char * path)`            | create the directory, if they do not already exist.
`public int `[`aos_register_event_filter`](#yloop_8h_1ae3324303aa3a911b01709b8e5d106aa5)`(uint16_t type,`[`aos_event_cb`](#yloop_8h_1ae6cbb49016d564e65ca5338cb69d6185)` cb,void * priv)`            | Register system event filter callback.
`public int `[`aos_unregister_event_filter`](#yloop_8h_1af2001a3071743d68d2f1c6ec151ce6f5)`(uint16_t type,`[`aos_event_cb`](#yloop_8h_1ae6cbb49016d564e65ca5338cb69d6185)` cb,void * priv)`            | Unregister native event callback.
`public int `[`aos_post_event`](#yloop_8h_1ad5da1aeb283d518df00e420c0a9112b7)`(uint16_t type,uint16_t code,unsigned long value)`            | Post local event.
`public int `[`aos_poll_read_fd`](#yloop_8h_1a3f457aa0c5536e9e87da66bc606e35cc)`(int fd,`[`aos_poll_call_t`](#yloop_8h_1a7f61fff1d584f548770634ff74b9542c)` action,void * param)`            | Register a poll event in main loop.
`public void `[`aos_cancel_poll_read_fd`](#yloop_8h_1a2dcdc7bf91430300946e0688ae3db02e)`(int fd,`[`aos_poll_call_t`](#yloop_8h_1a7f61fff1d584f548770634ff74b9542c)` action,void * param)`            | Cancel a poll event to be executed in main loop.
`public int `[`aos_post_delayed_action`](#yloop_8h_1a8a48d02d905c2d0c7d7768af7ac0a3d6)`(int ms,`[`aos_call_t`](#yloop_8h_1ad5156dbeffd3153f16cffed15f2a26fe)` action,void * arg)`            | Post a delayed action to be executed in main loop.
`public void `[`aos_cancel_delayed_action`](#yloop_8h_1a7fe6a4f879719ee04d1a24c7f8c73486)`(int ms,`[`aos_call_t`](#yloop_8h_1ad5156dbeffd3153f16cffed15f2a26fe)` action,void * arg)`            | Cancel a delayed action to be executed in main loop.
`public int `[`aos_schedule_call`](#yloop_8h_1a7016fd75f6deb04517416399dcbbd594)`(`[`aos_call_t`](#yloop_8h_1ad5156dbeffd3153f16cffed15f2a26fe)` action,void * arg)`            | Schedule a callback in next event loop.
`public `[`aos_loop_t`](#yloop_8h_1a654b2a49d4665eeb1d24b1b2195de6a5)` `[`aos_loop_init`](#yloop_8h_1a19622d95d4b65bff57b549e9b8c93155)`(void)`            | init a per-task event loop
`public `[`aos_loop_t`](#yloop_8h_1a654b2a49d4665eeb1d24b1b2195de6a5)` `[`aos_current_loop`](#yloop_8h_1a0eafe54e0bba4d333828ae02533a28ba)`(void)`            | get current event loop
`public void `[`aos_loop_run`](#yloop_8h_1a67c03238fac573432b77b2a957fad2b9)`(void)`            | start event loop
`public void `[`aos_loop_exit`](#yloop_8h_1aad0299c429ba51bfebff02e355773ad9)`(void)`            | exit event loop, [aos_loop_run()](#yloop_8h_1a67c03238fac573432b77b2a957fad2b9) will return
`public void `[`aos_loop_destroy`](#yloop_8h_1abbca6051ca7795fb409a32677513635f)`(void)`            | free event loop resources
`public int `[`aos_loop_schedule_call`](#yloop_8h_1afd6d962757a7b9facf290828ab9b5014)`(`[`aos_loop_t`](#yloop_8h_1a654b2a49d4665eeb1d24b1b2195de6a5)` * loop,`[`aos_call_t`](#yloop_8h_1ad5156dbeffd3153f16cffed15f2a26fe)` action,void * arg)`            | Schedule a callback specified event loop.
`public void * `[`aos_loop_schedule_work`](#yloop_8h_1adeabf846886d65a22e1780e1060d725b)`(int ms,`[`aos_call_t`](#yloop_8h_1ad5156dbeffd3153f16cffed15f2a26fe)` action,void * arg1,`[`aos_call_t`](#yloop_8h_1ad5156dbeffd3153f16cffed15f2a26fe)` fini_cb,void * arg2)`            | Schedule a work to be executed in workqueue.
`public void `[`aos_cancel_work`](#yloop_8h_1a0eb3dd015bc0328943d482f6fab26fee)`(void * work,`[`aos_call_t`](#yloop_8h_1ad5156dbeffd3153f16cffed15f2a26fe)` action,void * arg1)`            | Cancel a work.
`public void `[`hal_ota_register_module`](#ota_8h_1ae04bc1ef38c25b8a9fd3cbb89d01dd7f)`(`[`hal_ota_module_t`](#ota_8h_1a79874c02235fecf1b91f43df20615aba)` * module)`            | Arch register a new module before HAL startup.
`public `[`hal_stat_t`](#ota_8h_1a6e643831d8c39930387ae58893022b80)` `[`hal_ota_init`](#ota_8h_1a36b5f7a97e5ba81dc3f203469b9beff7)`()`            | init ota partition
`public `[`hal_stat_t`](#ota_8h_1a6e643831d8c39930387ae58893022b80)` `[`hal_ota_write`](#ota_8h_1ac00ef7e39e0f3367a4df0b7f1fd915cf)`(`[`hal_ota_module_t`](#ota_8h_1a79874c02235fecf1b91f43df20615aba)` * m,volatile uint32_t * off_set,uint8_t * in_buf,uint32_t in_buf_len)`            | Write data to an area on ota partition.
`public `[`hal_stat_t`](#ota_8h_1a6e643831d8c39930387ae58893022b80)` `[`hal_ota_read`](#ota_8h_1ab759bbc68bc3388adba4400b629d43dd)`(`[`hal_ota_module_t`](#ota_8h_1a79874c02235fecf1b91f43df20615aba)` * m,volatile uint32_t * off_set,uint8_t * out_buf,uint32_t out_buf_len)`            | Read data from an area on ota Flash to data buffer in RAM.
`public `[`hal_stat_t`](#ota_8h_1a6e643831d8c39930387ae58893022b80)` `[`hal_ota_set_boot`](#ota_8h_1a157e3c5b5601442eb6edd3cb77ca0f6d)`(`[`hal_ota_module_t`](#ota_8h_1a79874c02235fecf1b91f43df20615aba)` * m,void * something)`            | Set boot options when ota reboot.
`public `[`hal_ota_module_t`](#ota_8h_1a79874c02235fecf1b91f43df20615aba)` * `[`hal_ota_get_default_module`](#ota_8h_1a9027084f6f3e908d38c1c65421bb529c)`(void)`            | Get the default ota module.
`public void `[`hal_sensor_register_module`](#sensor_8h_1a4d45c191e22cbddcc7f2d8cd2f3fbe8a)`(`[`hal_sensor_module_t`](#sensor_8h_1abd00ba6504caa64728ba1f70aed57ad4)` * module)`            | Arch register a new module before HAL startup.
`public int `[`hal_sensor_init`](#sensor_8h_1ad8e5e6bc01cf056fd3c26c9126b4505e)`(void)`            | HAL sensor init .
`public int `[`hal_sensor_get_sensor_list`](#sensor_8h_1a38795c14d032c998f64e13e8da0ab541)`(`[`hal_sensor_module_t`](#sensor_8h_1abd00ba6504caa64728ba1f70aed57ad4)` * m,`[`sensor_node_t`](#structsensor__node__t)` const ** list)`            | enbale sensor with type
`public int `[`hal_sensor_enable`](#sensor_8h_1a2d7da10d08b399eab3d150bc03d0c15d)`(`[`hal_sensor_module_t`](#sensor_8h_1abd00ba6504caa64728ba1f70aed57ad4)` * m,`[`sensor_type`](#sensor_8h_1afa273d6585462db941727d44e9b50320)` type)`            | enable sensor with type
`public int `[`hal_sensor_disable`](#sensor_8h_1af70ead5d0558ffc2fd1ec80b9e267d3c)`(`[`hal_sensor_module_t`](#sensor_8h_1abd00ba6504caa64728ba1f70aed57ad4)` * m,`[`sensor_type`](#sensor_8h_1afa273d6585462db941727d44e9b50320)` type)`            | disable sensor with type
`public int `[`hal_sensor_read`](#sensor_8h_1a15f8ee6beb053bf33fa77b96113363d2)`(`[`hal_sensor_module_t`](#sensor_8h_1abd00ba6504caa64728ba1f70aed57ad4)` * m,`[`sensor_type`](#sensor_8h_1afa273d6585462db941727d44e9b50320)` type,char * buf,int buf_size)`            | read sensor data when enable sensor
`public `[`hal_sensor_module_t`](#sensor_8h_1abd00ba6504caa64728ba1f70aed57ad4)` * `[`hal_sensor_get_default_module`](#sensor_8h_1a5126efa2c800aa8d900fc2775ff971ca)`(void)`            | Get the default sensor module.
`public `[`hal_sensor_module_t`](#sensor_8h_1abd00ba6504caa64728ba1f70aed57ad4)` * `[`hal_sensor_get_next_module`](#sensor_8h_1a94e69d6b8eeca793904cde6b9fa45ae0)`(`[`hal_sensor_module_t`](#sensor_8h_1abd00ba6504caa64728ba1f70aed57ad4)` * m)`            | Get the next sensor HAL
`public int32_t `[`hal_adc_init`](#adc_8h_1ac1bde467ed8ffbb24747442d60c888c0)`(`[`adc_dev_t`](#structadc__dev__t)` * adc)`            | Initialises an ADC interface
`public int32_t `[`hal_adc_value_get`](#adc_8h_1a9fcd2b50607d73642515034cd4ea21ac)`(`[`adc_dev_t`](#structadc__dev__t)` * adc,void * output,uint32_t timeout)`            | Takes a single sample from an ADC interface
`public int32_t `[`hal_adc_finalize`](#adc_8h_1a0bd4fcde73ce5792ee9cdd96b6bf999a)`(`[`adc_dev_t`](#structadc__dev__t)` * adc)`            | De-initialises an ADC interface
`public `[`hal_logic_partition_t`](#structhal__logic__partition__t)` * `[`hal_flash_get_info`](#flash_8h_1a953a4ec1ce382dde733219f6e83c6e1b)`(`[`hal_partition_t`](#flash_8h_1a1ff07b8a9c096b1b8ca7847be7c6e097)` in_partition)`            | Get the infomation of the specified flash area.
`public int32_t `[`hal_flash_erase`](#flash_8h_1a3d3a2ca9f773c996517b5e57882146a1)`(`[`hal_partition_t`](#flash_8h_1a1ff07b8a9c096b1b8ca7847be7c6e097)` in_partition,uint32_t off_set,uint32_t size)`            | Erase an area on a Flash logical partition.
`public int32_t `[`hal_flash_write`](#flash_8h_1a113a623b5268888f7e52e2655da69419)`(`[`hal_partition_t`](#flash_8h_1a1ff07b8a9c096b1b8ca7847be7c6e097)` in_partition,uint32_t * off_set,const void * in_buf,uint32_t in_buf_len)`            | Write data to an area on a Flash logical partition.
`public int32_t `[`hal_flash_read`](#flash_8h_1aa0b51f3833bf23e62753d5cc46c47bba)`(`[`hal_partition_t`](#flash_8h_1a1ff07b8a9c096b1b8ca7847be7c6e097)` in_partition,uint32_t * off_set,void * out_buf,uint32_t in_buf_len)`            | Read data from an area on a Flash to data buffer in RAM.
`public int32_t `[`hal_flash_enable_secure`](#flash_8h_1a7eddbd75e2521d13a29d4e8c27ece172)`(`[`hal_partition_t`](#flash_8h_1a1ff07b8a9c096b1b8ca7847be7c6e097)` partition,uint32_t off_set,uint32_t size)`            | Set security options on a logical partition.
`public int32_t `[`hal_flash_dis_secure`](#flash_8h_1a337f2c48f9b8b022f5626905850a4112)`(`[`hal_partition_t`](#flash_8h_1a1ff07b8a9c096b1b8ca7847be7c6e097)` partition,uint32_t off_set,uint32_t size)`            | Disable security options on a logical partition.
`public int32_t `[`hal_gpio_init`](#gpio_8h_1ac57ec79537271096af3777e1c45c544b)`(`[`gpio_dev_t`](#structgpio__dev__t)` * gpio)`            | Initialises a GPIO pin.
`public int32_t `[`hal_gpio_output_high`](#gpio_8h_1a62e07155dba33b68f93fc1ba59c70e01)`(`[`gpio_dev_t`](#structgpio__dev__t)` * gpio)`            | Sets an output GPIO pin high.
`public int32_t `[`hal_gpio_output_low`](#gpio_8h_1af08f7d3868b152865f233024d03a5cbf)`(`[`gpio_dev_t`](#structgpio__dev__t)` * gpio)`            | Sets an output GPIO pin low.
`public int32_t `[`hal_gpio_output_toggle`](#gpio_8h_1a1e54c6ad05ddbbc3d71a81420f4fe3c9)`(`[`gpio_dev_t`](#structgpio__dev__t)` * gpio)`            | Trigger an output GPIO pin
`public int8_t `[`hal_gpio_input_get`](#gpio_8h_1a781421b55faf20bc846088eb2f25b0a0)`(`[`gpio_dev_t`](#structgpio__dev__t)` * gpio,uint32_t * value)`            | Get the state of an input GPIO pin.
`public int32_t `[`hal_gpio_enable_irq`](#gpio_8h_1ac4c46681d4431397cf3780d29ee49810)`(`[`gpio_dev_t`](#structgpio__dev__t)` * gpio,`[`gpio_irq_trigger_t`](#gpio_8h_1aa3de939093227b362c7ea6d942ecae9d)` trigger,`[`gpio_irq_handler_t`](#gpio_8h_1a6c24dd1a7635d1d71b38a99ec7f556a9)` handler,void * arg)`            | Enables an interrupt trigger for an input GPIO pin.
`public int32_t `[`hal_gpio_disable_irq`](#gpio_8h_1a59745b705cd8ca10a0618eb98250f6ac)`(`[`gpio_dev_t`](#structgpio__dev__t)` * gpio)`            | Disables an interrupt trigger for an input GPIO pin.
`public int32_t `[`hal_gpio_clear_irq`](#gpio_8h_1aba2eed8dca6ec95f136ce990d64912ac)`(`[`gpio_dev_t`](#structgpio__dev__t)` * gpio)`            | Disables an interrupt trigger for an input GPIO pin.
`public int32_t `[`hal_gpio_finalize`](#gpio_8h_1a9e97bba47999735b48c7e35e1d786ca1)`(`[`gpio_dev_t`](#structgpio__dev__t)` * gpio)`            | DeInitialises a GPIO pin.
`public int32_t `[`hal_i2c_init`](#i2c_8h_1a4ab0930e597f8c6356f1c3df72e5f542)`(`[`i2c_dev_t`](#structi2c__dev__t)` * i2c)`            | Initialises an I2C interface.
`public int32_t `[`hal_i2c_master_send`](#i2c_8h_1ae17c7459872ec0d1d32ecd9bee53a488)`(`[`i2c_dev_t`](#structi2c__dev__t)` * i2c,uint16_t dev_addr,uint8_t * data,uint16_t size,uint32_t timeout)`            | i2c master send
`public int32_t `[`hal_i2c_master_recv`](#i2c_8h_1a68e2d241b51e4b1850746ca7d6ff64e3)`(`[`i2c_dev_t`](#structi2c__dev__t)` * i2c,uint16_t dev_addr,uint8_t * data,uint16_t size,uint32_t timeout)`            | i2c master recv
`public int32_t `[`hal_i2C_slave_send`](#i2c_8h_1a373a4789903405c6c175f98bd3bb1433)`(`[`i2c_dev_t`](#structi2c__dev__t)` * i2c,uint8_t * data,uint16_t size,uint32_t timeout)`            | hal_i2C_slave_send
`public int32_t `[`hal_i2c_slave_recv`](#i2c_8h_1ae0e628510faec1a53f895293f7708141)`(`[`i2c_dev_t`](#structi2c__dev__t)` * i2c,uint8_t * data,uint16_t size,uint32_t timeout)`            | Initialises an I2C interface.
`public int32_t `[`hal_i2c_mem_write`](#i2c_8h_1aef74611174cc14fda761d39b544a0ecd)`(`[`i2c_dev_t`](#structi2c__dev__t)` * i2c,uint16_t dev_addr,uint16_t mem_addr,uint16_t mem_addr_size,uint8_t * data,uint16_t size,uint32_t timeout)`            | i2c mem write
`public int32_t `[`hal_i2c_mem_read`](#i2c_8h_1af4cb082a770305a10c3f73471a2505b5)`(`[`i2c_dev_t`](#structi2c__dev__t)` * i2c,uint16_t dev_addr,uint16_t mem_addr,uint16_t mem_addr_size,uint8_t * data,uint16_t size,uint32_t timeout)`            | i2c master mem read
`public int32_t `[`hal_i2c_finalize`](#i2c_8h_1a569cc76c576b14ee6f501dfe8982936a)`(`[`i2c_dev_t`](#structi2c__dev__t)` * i2c)`            | Deinitialises an I2C device.
`public int32_t `[`hal_pwm_init`](#pwm_8h_1a3efaaee5a76c75a33617a68efa5e31fc)`(`[`pwm_dev_t`](#structpwm__dev__t)` * pwm)`            | Initialises a PWM pin.
`public int32_t `[`hal_pwm_start`](#pwm_8h_1a7789f0b361e257a3039a024c5e7f7f58)`(`[`pwm_dev_t`](#structpwm__dev__t)` * pwm)`            | Starts PWM output on a PWM interface.
`public int32_t `[`hal_pwm_stop`](#pwm_8h_1a6f00e8ed683f28dead5f9e806c591ca0)`(`[`pwm_dev_t`](#structpwm__dev__t)` * pwm)`            | Stops output on a PWM pin.
`public int32_t `[`hal_random_num_read`](#rng_8h_1a720a55ef8b558ac9818aaaaf1a99837c)`(`[`random_dev_t`](#structrandom__dev__t)` random,void * in_buf,int32_t bytes)`            | Fill in a memory buffer with random data.
`public void `[`hal_rtc_init`](#rtc_8h_1a630bfe4df4611ac545d75d335cb84a3e)`(`[`rtc_dev_t`](#structrtc__dev__t)` * rtc)`            | This function will initialize the on board CPU real time clock.
`public int32_t `[`hal_rtc_get_time`](#rtc_8h_1a90a23a2ef5852bcbd5f2a13d2dc4e358)`(`[`rtc_dev_t`](#structrtc__dev__t)` * rtc,`[`rtc_time_t`](#structrtc__time__t)` * time)`            | This function will return the value of time read from the on board CPU real time clock. Time value must be given in the format of the structure hal_rtc_time_t.
`public int32_t `[`hal_rtc_set_time`](#rtc_8h_1ad5258cee7509b7499d1005079244f42d)`(`[`rtc_dev_t`](#structrtc__dev__t)` * rtc,`[`rtc_time_t`](#structrtc__time__t)` * time)`            | This function will set MCU RTC time to a new value. Time value must be given in the format of the structure hal_rtc_time_t.
`public int32_t `[`hal_spi_init`](#spi_8h_1a4b4db09ed0654e035de01ecf137bc7a7)`(`[`spi_dev_t`](#structspi__dev__t)` * spi)`            | Initialises the SPI interface for a given SPI device.
`public int32_t `[`hal_spi_send`](#spi_8h_1a9cfd278d57d98559f13fa5a2e534b148)`(`[`spi_dev_t`](#structspi__dev__t)` * spi,uint8_t * data,uint16_t size,uint32_t timeout)`            | spi_send
`public int32_t `[`hal_spi_recv`](#spi_8h_1ab6aa5dc6e45d8520cd02749fbbe9a269)`(`[`spi_dev_t`](#structspi__dev__t)` * spi,uint8_t * data,uint16_t size,uint32_t timeout)`            | spi_recv
`public int32_t `[`hal_spi_send_recv`](#spi_8h_1ab5782dc347f5f8fbfe9b30e24c1590bb)`(`[`spi_dev_t`](#structspi__dev__t)` * spi,uint8_t * tx_data,uint16_t tx_size,uint8_t * rx_data,uint16_t rx_size,uint32_t timeout)`            | spi send data and recv
`public int32_t `[`hal_spi_finalize`](#spi_8h_1af6f3489747e78677520c0f925eb817ef)`(`[`spi_dev_t`](#structspi__dev__t)` * spi)`            | De-initialises a SPI interface.
`public void `[`hal_timer_init`](#timer_8h_1a1a01785016b4d418c3d2628a3cbfdb9e)`(`[`hal_timer_t`](#structhal__timer__t)` * tmr,unsigned int period,unsigned char auto_reload,unsigned char ch,`[`hal_timer_cb_t`](#timer_8h_1a9b138d5db3c7e07032743eddcadc5f4c)` cb,void * arg)`            | init a hardware timer
`public int32_t `[`hal_timer_start`](#timer_8h_1a9403a0f2305d71b5c273a75b101d741f)`(`[`hal_timer_t`](#structhal__timer__t)` * tmr)`            | init a hardware timer
`public void `[`hal_timer_stop`](#timer_8h_1ad1a680cfce89b4d45e5256182159ac8d)`(`[`hal_timer_t`](#structhal__timer__t)` * tmr)`            | stop a hardware timer
`public int32_t `[`hal_uart_init`](#uart_8h_1ac1cd14ca3a6309b8415af1e1116162ad)`(`[`uart_dev_t`](#structuart__dev__t)` * uart)`            | Initialises a UART interface.
`public int32_t `[`hal_uart_send`](#uart_8h_1ab24afb895d0984c443fe3a89c4dcd5a8)`(`[`uart_dev_t`](#structuart__dev__t)` * uart,void * data,uint32_t size,uint32_t timeout)`            | Transmit data on a UART interface.
`public int32_t `[`hal_uart_recv`](#uart_8h_1aa28ee6a023473235f91d882c1db0430a)`(`[`uart_dev_t`](#structuart__dev__t)` * uart,void * data,uint32_t expect_size,uint32_t * recv_size,uint32_t timeout)`            | Receive data on a UART interface.
`public int32_t `[`hal_uart_finalize`](#uart_8h_1afd25ecf40a406f15b79534fee86e4271)`(`[`uart_dev_t`](#structuart__dev__t)` * uart)`            | Deinitialises a UART interface.
`public int32_t `[`hal_wdg_init`](#wdg_8h_1ae8d1d233f207b0dafb967e0a50fcad6b)`(`[`wdg_dev_t`](#structwdg__dev__t)` * wdg)`            | This function will initialize the on board CPU hardware watch dog 
`public void `[`hal_wdg_reload`](#wdg_8h_1a9fe79ef45a21dd5c6f1199eda5e21253)`(`[`wdg_dev_t`](#structwdg__dev__t)` * wdg)`            | Reload watchdog counter. 
`public int32_t `[`hal_wdg_finalize`](#wdg_8h_1ada475e22a5cdf6a261a5e6f56d5b9214)`(`[`wdg_dev_t`](#structwdg__dev__t)` * wdg)`            | This function performs any platform-specific cleanup needed for hardware watch dog. 
`public void * `[`trace_hal_init`](#trace_8h_1a97528b8c8622b9a882552c26402ea561)`(void)`            | 
`public ssize_t `[`trace_hal_send`](#trace_8h_1a723b3bcc8f7ffdb612127ef3d768fbe3)`(void * handle,void * buf,size_t len)`            | 
`public ssize_t `[`trace_hal_recv`](#trace_8h_1ae95a981721aa0ab5d7b92408d49afb9a)`(void * handle,void * buf)`            | 
`public void `[`trace_hal_deinit`](#trace_8h_1ab514b3d34cdc784dab7498f5c9574866)`(void * handle)`            | 
`public `[`hal_wifi_module_t`](#structhal__wifi__module__t)` * `[`hal_wifi_get_default_module`](#group__aos__hal__wifi_1ga566b8f91f7325b94b2672af6ee9e9792)`(void)`            | Get the default wifi instance. The system may have more than 1 wifi instance, this API return the default one.
`public void `[`hal_wifi_register_module`](#group__aos__hal__wifi_1gae63e89d8196178248779fac0acdbddf4)`(`[`hal_wifi_module_t`](#structhal__wifi__module__t)` * m)`            | Regster a wifi instance to the HAL Framework.
`public int `[`hal_wifi_init`](#group__aos__hal__wifi_1gad0f9198f876afee6ec2fa498c853fd2e)`(void)`            | Initialize WiFi instances 
`public void `[`hal_wifi_get_mac_addr`](#group__aos__hal__wifi_1ga6d6d2c8d07f5b80b9f0c23f3d05ace80)`(`[`hal_wifi_module_t`](#structhal__wifi__module__t)` * m,uint8_t * mac)`            | 
`public int `[`hal_wifi_start`](#group__aos__hal__wifi_1ga4fb4774e8247d115d457eed457acb9b6)`(`[`hal_wifi_module_t`](#structhal__wifi__module__t)` * m,`[`hal_wifi_init_type_t`](#structhal__wifi__init__type__t)` * init_para)`            | 
`public int `[`hal_wifi_start_adv`](#group__aos__hal__wifi_1ga694965de667c13b1380fda9eedda1601)`(`[`hal_wifi_module_t`](#structhal__wifi__module__t)` * m,`[`hal_wifi_init_type_adv_t`](#structhal__wifi__init__type__adv__t)` * init_para_adv)`            | 
`public int `[`hal_wifi_get_ip_stat`](#group__aos__hal__wifi_1ga05cb0f3bdfcf73dcb862c894aef1c355)`(`[`hal_wifi_module_t`](#structhal__wifi__module__t)` * m,`[`hal_wifi_ip_stat_t`](#structhal__wifi__ip__stat__t)` * out_net_para,`[`hal_wifi_type_t`](#group__aos__hal__wifi_1ga9c6cd73d1b386384fea4dc5be8a25adc)` wifi_type)`            | 
`public int `[`hal_wifi_get_link_stat`](#group__aos__hal__wifi_1gad21b72cfba15bc51dc232ff1d7b8e3e3)`(`[`hal_wifi_module_t`](#structhal__wifi__module__t)` * m,`[`hal_wifi_link_stat_t`](#structhal__wifi__link__stat__t)` * out_stat)`            | 
`public void `[`hal_wifi_start_scan`](#group__aos__hal__wifi_1ga45482258f138aa8dc654a62903cb9cce)`(`[`hal_wifi_module_t`](#structhal__wifi__module__t)` * m)`            | 
`public void `[`hal_wifi_start_scan_adv`](#group__aos__hal__wifi_1ga1ee2b973dd8c784d8c7bb0b62b317cf9)`(`[`hal_wifi_module_t`](#structhal__wifi__module__t)` * m)`            | 
`public int `[`hal_wifi_power_off`](#group__aos__hal__wifi_1ga356cb12cb844304ba82baf4fe7b2e39c)`(`[`hal_wifi_module_t`](#structhal__wifi__module__t)` * m)`            | 
`public int `[`hal_wifi_power_on`](#group__aos__hal__wifi_1gacb7504fd7489f48484ad465ff8b35889)`(`[`hal_wifi_module_t`](#structhal__wifi__module__t)` * m)`            | 
`public int `[`hal_wifi_suspend`](#group__aos__hal__wifi_1ga747082505fd08e36af0b25e819e28731)`(`[`hal_wifi_module_t`](#structhal__wifi__module__t)` * m)`            | 
`public int `[`hal_wifi_suspend_station`](#group__aos__hal__wifi_1ga1e83e196a0be456be4b37f4cee524818)`(`[`hal_wifi_module_t`](#structhal__wifi__module__t)` * m)`            | 
`public int `[`hal_wifi_suspend_soft_ap`](#group__aos__hal__wifi_1ga6a47820504b46b4a96baacce00cbd5b4)`(`[`hal_wifi_module_t`](#structhal__wifi__module__t)` * m)`            | 
`public int `[`hal_wifi_set_channel`](#group__aos__hal__wifi_1gaf3de80f45f31dd80dbbf0f1dacca0ec7)`(`[`hal_wifi_module_t`](#structhal__wifi__module__t)` * m,int ch)`            | 
`public void `[`hal_wifi_start_wifi_monitor`](#group__aos__hal__wifi_1gaa26d3158ef4961dfd5c8359aad7970da)`(`[`hal_wifi_module_t`](#structhal__wifi__module__t)` * m)`            | 
`public void `[`hal_wifi_stop_wifi_monitor`](#group__aos__hal__wifi_1ga3ad81dbe6f917782f84e404effb49381)`(`[`hal_wifi_module_t`](#structhal__wifi__module__t)` * m)`            | 
`public void `[`hal_wifi_register_monitor_cb`](#group__aos__hal__wifi_1gab8d8dadf29c391633e02d369ff645ec3)`(`[`hal_wifi_module_t`](#structhal__wifi__module__t)` * m,`[`monitor_data_cb_t`](#group__aos__hal__wifi_1ga42c3d0c8c75e00b79323b460b4ae589c)` fn)`            | 
`public void `[`hal_wifi_start_debug_mode`](#group__aos__hal__wifi_1ga3357287dece311d15428f91e848931ed)`(`[`hal_wifi_module_t`](#structhal__wifi__module__t)` * m)`            | 
`public void `[`hal_wifi_stop_debug_mode`](#group__aos__hal__wifi_1ga7f942f8856082a8deee80b9913d81edb)`(`[`hal_wifi_module_t`](#structhal__wifi__module__t)` * m)`            | 
`public void `[`hal_wifi_install_event`](#group__aos__hal__wifi_1gabb2676da0387cf522a0a9c4abc9a4210)`(`[`hal_wifi_module_t`](#structhal__wifi__module__t)` * m,const `[`hal_wifi_event_cb_t`](#structhal__wifi__event__cb__t)` * cb)`            | Set the event callback function array for the wifi.
`struct `[`adc_config_t`](#structadc__config__t) | 
`struct `[`adc_dev_t`](#structadc__dev__t) | 
`struct `[`aos_dir_t`](#structaos__dir__t) | 
`struct `[`aos_dirent_t`](#structaos__dirent__t) | 
`struct `[`aos_hdl_t`](#structaos__hdl__t) | 
`struct `[`aos_workqueue_t`](#structaos__workqueue__t) | 
`struct `[`boot_table_t`](#structboot__table__t) | 
`struct `[`cli_command`](#structcli__command) | Structure for registering CLI commands
`struct `[`cli_st`](#structcli__st) | 
`struct `[`dlist_s`](#structdlist__s) | 
`struct `[`gpio_dev_t`](#structgpio__dev__t) | 
`struct `[`hal_logic_partition_t`](#structhal__logic__partition__t) | 
`struct `[`hal_module_base_t`](#structhal__module__base__t) | HAL Module define.
`struct `[`hal_ota_module_s`](#structhal__ota__module__s) | 
`struct `[`hal_sensor_module_s`](#structhal__sensor__module__s) | 
`struct `[`hal_timer_t`](#structhal__timer__t) | 
`struct `[`hal_wifi_ap_info_adv_t`](#structhal__wifi__ap__info__adv__t) | 
`struct `[`hal_wifi_event_cb_t`](#structhal__wifi__event__cb__t) | The event call back function called at specific events occurred.
`struct `[`hal_wifi_init_type_adv_t`](#structhal__wifi__init__type__adv__t) | 
`struct `[`hal_wifi_init_type_t`](#structhal__wifi__init__type__t) | 
`struct `[`hal_wifi_ip_stat_t`](#structhal__wifi__ip__stat__t) | 
`struct `[`hal_wifi_link_info_s`](#structhal__wifi__link__info__s) | 
`struct `[`hal_wifi_link_stat_t`](#structhal__wifi__link__stat__t) | 
`struct `[`hal_wifi_module_s`](#structhal__wifi__module__s) | 
`struct `[`hal_wifi_module_t`](#structhal__wifi__module__t) | The Wifi module for manufacture to implement.
`struct `[`hal_wifi_scan_result_adv_t`](#structhal__wifi__scan__result__adv__t) | 
`struct `[`hal_wifi_scan_result_t`](#structhal__wifi__scan__result__t) | Scan result using normal scan.
`struct `[`i2c_config_t`](#structi2c__config__t) | 
`struct `[`i2c_dev_t`](#structi2c__dev__t) | 
`struct `[`input_event_t`](#structinput__event__t) | aos event structure
`struct `[`pwm_config_t`](#structpwm__config__t) | 
`struct `[`pwm_dev_t`](#structpwm__dev__t) | 
`struct `[`random_dev_t`](#structrandom__dev__t) | 
`struct `[`rtc_dev_t`](#structrtc__dev__t) | 
`struct `[`rtc_time_t`](#structrtc__time__t) | RTC time
`struct `[`sensor_node_t`](#structsensor__node__t) | 
`struct `[`slist_s`](#structslist__s) | 
`struct `[`spi_config_t`](#structspi__config__t) | 
`struct `[`spi_dev_t`](#structspi__dev__t) | 
`struct `[`uart_config_t`](#structuart__config__t) | UART configuration
`struct `[`uart_dev_t`](#structuart__dev__t) | 
`struct `[`wdg_config_t`](#structwdg__config__t) | 
`struct `[`wdg_dev_t`](#structwdg__dev__t) | 

## Members

#### `define `[`ALINK_WAIT_FOREVER`](#group__wifi__entry_1ga24e84b646981469702aabfb6da1e9b5f) 

#### `define `[`MAX_COMMANDS`](#cli_8h_1a4b2b20c68bee625b7dc737c4d05699fd) 

#### `define `[`INBUF_SIZE`](#cli_8h_1a6378f14810330164b7fb66f3334b2a27) 

#### `define `[`OUTBUF_SIZE`](#cli_8h_1a3df829d6427c2cd4fbd387268040cc65) 

#### `define `[`CLI_ARGS`](#cli_8h_1a32dbd9172ae6648a0197494b96925799) 

#### `define `[`cmd_printf`](#cli_8h_1a195767ec31ec406a0c1ee072bbf5929a) 

#### `define `[`SHORT_FILE`](#debug_8h_1ae262b34c650329f4896e6c3adeaf99d0) 

#### `define `[`debug_print_assert`](#debug_8h_1aa497f2a6a03dd57dc3ee43f9af17d053) 

#### `define `[`unlikely`](#debug_8h_1a84a1f426a227f1448ec65947ac42919e) 

#### `define `[`check`](#debug_8h_1ac7484fb87785e637ebc2895cb5d5a51b) 

check  Check that an expression is true (non-zero). 

If expression evalulates to false, this prints debugging information (actual expression string, file, line number, function name, etc.) using the default debugging output method.

Code inside [check()](#debug_8h_1ac7484fb87785e637ebc2895cb5d5a51b) statements is not compiled into production builds.

#### `define `[`check_string`](#debug_8h_1a7815306b9d49d852a9a3658493457ad2) 

check_string  Check that an expression is true (non-zero) with an explanation. 

If expression evalulates to false, this prints debugging information (actual expression string, file, line number, function name, etc.) using the default debugging output method.

Code inside [check()](#debug_8h_1ac7484fb87785e637ebc2895cb5d5a51b) statements is not compiled into production builds.

#### `define `[`require`](#debug_8h_1a38a61c69561923a5402af2ae718efe48) 

require  Requires that an expression evaluate to true. 

If expression evalulates to false, this prints debugging information (actual expression string, file, line number, function name, etc.) using the default debugging output method then jumps to a label.

#### `define `[`require_string`](#debug_8h_1a5d1334664ee9b47f6764a98e894758e5) 

require_string  Requires that an expression evaluate to true with an explanation. 

If expression evalulates to false, this prints debugging information (actual expression string, file, line number, function name, etc.) and a custom explanation string using the default debugging output method then jumps to a label.

#### `define `[`require_quiet`](#debug_8h_1a3b6ad49f54b0d9261326d2b66744dcdf) 

require_quiet  Requires that an expression evaluate to true. 

If expression evalulates to false, this jumps to a label. No debugging information is printed.

#### `define `[`require_noerr`](#debug_8h_1a02c3df4b13f819669925ada472a62162) 

require_noerr  Require that an error code is noErr (0). 

If the error code is non-0, this prints debugging information (actual expression string, file, line number, function name, etc.) using the default debugging output method then jumps to a label.

#### `define `[`require_noerr_string`](#debug_8h_1a8d9b38f0b5293590b9637098fb67651f) 

require_noerr_string  Require that an error code is noErr (0). 

If the error code is non-0, this prints debugging information (actual expression string, file, line number, function name, etc.), and a custom explanation string using the default debugging output method using the default debugging output method then jumps to a label.

#### `define `[`require_noerr_action_string`](#debug_8h_1a640247fef12b0c53780f021f3a738620) 

require_noerr_action_string  Require that an error code is noErr (0). 

If the error code is non-0, this prints debugging information (actual expression string, file, line number, function name, etc.), and a custom explanation string using the default debugging output method using the default debugging output method then executes an action and jumps to a label.

#### `define `[`require_noerr_quiet`](#debug_8h_1a1607344c6ff3f694527458dcd73a6fbf) 

require_noerr_quiet  Require that an error code is noErr (0). 

If the error code is non-0, this jumps to a label. No debugging information is printed.

#### `define `[`require_noerr_action`](#debug_8h_1aa60121841639f3b5700b19a1526a5232) 

require_noerr_action  Require that an error code is noErr (0) with an action to execute otherwise. 

If the error code is non-0, this prints debugging information (actual expression string, file, line number, function name, etc.) using the default debugging output method then executes an action and jumps to a label.

#### `define `[`require_noerr_action_quiet`](#debug_8h_1a16f33c6ca26bcd92165c23a8cff1d28f) 

require_noerr_action_quiet  Require that an error code is noErr (0) with an action to execute otherwise. 

If the error code is non-0, this executes an action and jumps to a label. No debugging information is printed.

#### `define `[`require_action`](#debug_8h_1af4a91824c6ca0f3dea55d5cac7319b65) 

require_action  Requires that an expression evaluate to true with an action to execute otherwise. 

If expression evalulates to false, this prints debugging information (actual expression string, file, line number, function name, etc.) using the default debugging output method then executes an action and jumps to a label.

#### `define `[`require_action_string`](#debug_8h_1a46ec6dd3ae533fecdaaa01bd14d38c9d) 

require_action_string  Requires that an expression evaluate to true with an explanation and action to execute otherwise. 

If expression evalulates to false, this prints debugging information (actual expression string, file, line number, function name, etc.) and a custom explanation string using the default debugging output method then executes an action and jumps to a label.

#### `define `[`require_action_quiet`](#debug_8h_1a509a09fd01a9417030de240e23309a29) 

require_action_quiet  Requires that an expression evaluate to true with an action to execute otherwise. 

If expression evalulates to false, this executes an action and jumps to a label. No debugging information is printed.

#### `define `[`EV_RPC`](#event__type__code_8h_1a0301dee4a6cd294e5785ceeef1bf350d) 

remote procedure call

#### `define `[`EV_YUNIO`](#event__type__code_8h_1a76eaa816a287255eb5f1ed14f7d3f8e7) 

YunIO event

#### `define `[`CODE_YUNIO_CMD_START`](#event__type__code_8h_1aba35a26b23239b1c56a9676ee603779e) 

#### `define `[`CODE_YUNIO_CMD_RETRY`](#event__type__code_8h_1a47ec5168cdec719a3dbda4fbcfe474c8) 

#### `define `[`CODE_YUNIO_CMD_DISCONNECT`](#event__type__code_8h_1ae4913311e0efbb286e6d2c42987ef048) 

#### `define `[`CODE_YUNIO_ON_CONNECTED`](#event__type__code_8h_1a362b0eb4c8313b25c1453fcc6038fa82) 

#### `define `[`CODE_YUNIO_ON_DISCONNECTED`](#event__type__code_8h_1a1eabd57d7a20736fb8bbbaf83d69f625) 

#### `define `[`CODE_YUNIO_ON_CONNECT_FAILED`](#event__type__code_8h_1a665e9a7ed9e041797f1c7d084c75d635) 

#### `define `[`CODE_YUNIO_ON_READ_ERROR`](#event__type__code_8h_1a36dd8c784a3696387fb8a4a41fe5ed0d) 

#### `define `[`CODE_YUNIO_ON_WRITE_ERROR`](#event__type__code_8h_1ae67439a6da29b5fedcfcf3df9836c1de) 

#### `define `[`CODE_YUNIO_ON_HEARTBIT_ERROR`](#event__type__code_8h_1aa1fdf9296cf62a927e203093be4f65f8) 

#### `define `[`CODE_YUNIO_PUBLISH_SUCCESS`](#event__type__code_8h_1acd3a765e3e0a493f8ac75f7b0c24ff98) 

#### `define `[`CODE_YUNIO_PUBLISH_TIMEOUT`](#event__type__code_8h_1a519dd4f2b65cedae88d93f87611272cc) 

#### `define `[`EV_OTA`](#event__type__code_8h_1a05ca485881a2fca9af8df4ce1a3c7161) 

OTA event define

#### `define `[`CODE_OTA_ON_RESULT`](#event__type__code_8h_1a69134d232ce1a9ec4c8908047432bc5f) 

#### `define `[`EV_DEVICE_REGISTER`](#event__type__code_8h_1aa81d53a7a06db605eefbc7eb029adff1) 

register device service

#### `define `[`CODE_REGISTER_ON_RESULT`](#event__type__code_8h_1afeab333349391d542547c62a17c7df99) 

#### `define `[`VALUE_REGISTER_SUCCESS`](#event__type__code_8h_1ab4405c9496ed7b7dc9ccdeba3e71622b) 

#### `define `[`EV_ACTIVATE_ID2`](#event__type__code_8h_1acd49d70c2da07796cc6d0a4701764655) 

id2 device activate

#### `define `[`CODE_ACTIVATE_ID2_ON_RESULT`](#event__type__code_8h_1ae588a3b1506388e1e4000f0e7f1b7f47) 

#### `define `[`VALUE_ACTIVATE_ID2_SUCCESS`](#event__type__code_8h_1ae180ba1eac7475a8fc9ee647b44bdf70) 

#### `define `[`VALUE_ACTIVATE_ID2_FAILURE`](#event__type__code_8h_1a7f071a4c27ead5f427f23ac1ffd7a920) 

#### `define `[`EV_DDA`](#event__type__code_8h_1a4686104546a71295852ba0d45584d22f) 

#### `define `[`CODE_DDA_ON_CONNECTED`](#event__type__code_8h_1a2c6c90a212b6bea6127fec313b8813d2) 

#### `define `[`EV_KEY`](#event__type__code_8h_1aa9584901daa5b7200abdacdfe218d5a4) 

General key define

#### `define `[`CODE_RECORD`](#event__type__code_8h_1aa925181f7645de59a7d218b7c79936b5) 

#### `define `[`CODE_VOLUME`](#event__type__code_8h_1acc49cc13805369c0190c5aa752d5ca1b) 

#### `define `[`CODE_VOLUME_INC`](#event__type__code_8h_1aed012967e7de26cc18efb7c78cc84039) 

#### `define `[`CODE_VOLUME_DEC`](#event__type__code_8h_1a38a1d0e2c14589ddb221dffc4bb95d1a) 

#### `define `[`CODE_PLAY_PAUSE`](#event__type__code_8h_1a26740dd70f77d076e150ed6dc769367a) 

#### `define `[`CODE_MUTE`](#event__type__code_8h_1aea55db8f253daf6c3df2ccfc12c138a4) 

#### `define `[`CODE_CHANNEL`](#event__type__code_8h_1adf8e4c622814da7db42c0c5a04dd5925) 

#### `define `[`CODE_NEXT`](#event__type__code_8h_1a337e1658f59196532919c6cffbc84dd5) 

#### `define `[`CODE_RECORD_PRE`](#event__type__code_8h_1a6d8dc80f5c3d65dfceabc76ba072ed96) 

#### `define `[`CODE_RESET`](#event__type__code_8h_1a18ef3160b336403f58e06ad82cd27b0c) 

#### `define `[`CODE_STATUS`](#event__type__code_8h_1a98a3000197dd30db07eef3ea20e043e8) 

#### `define `[`CODE_ELINK`](#event__type__code_8h_1ae526abf106427bd8682b2f8a2aa0d4d0) 

#### `define `[`CODE_BOOT`](#event__type__code_8h_1a56e6b0a0af7525ebc142be51bc06376b) 

#### `define `[`VALUE_KEY_UP`](#event__type__code_8h_1a18c95eac934bcd5f31cbc15e5faa9848) 

General key value

#### `define `[`VALUE_KEY_DOWN`](#event__type__code_8h_1ad8676fc64fcc50d77cbb30a6f6451602) 

#### `define `[`VALUE_KEY_CLICK`](#event__type__code_8h_1a2016497eff08711631e0c7f3094cbec5) 

#### `define `[`VALUE_KEY_LTCLICK`](#event__type__code_8h_1a288238de1c198646573c3b4bf22049a7) 

#### `define `[`VALUE_KEY_LLTCLICK`](#event__type__code_8h_1a5af2139a43b34324c8da361c6de13461) 

#### `define `[`VALUE_KEY_DBCLICK`](#event__type__code_8h_1a4155a36940fea0efc7723e8063dad70a) 

#### `define `[`VALUE_SYS_CHN_CONNECTED`](#event__type__code_8h_1a6e56c1652de4daef8550d5f84091da04) 

General channel value

#### `define `[`VALUE_SYS_CHN_CONNECTING`](#event__type__code_8h_1a6bd67dd198a9429be41e6ae077045d9d) 

#### `define `[`VALUE_SYS_CHN_DISCONNECTED`](#event__type__code_8h_1a09e030c8a3742da88ee243d84f9ab4df) 

#### `define `[`EV_KNOD`](#event__type__code_8h_1a7561835fdc52884ae351f3d1c8707f62) 

Reserve event

#### `define `[`EV_SD`](#event__type__code_8h_1aa0cf0d8f26da1e38eae13820a0f918d8) 

SD card event

#### `define `[`CODE_SD_PLUG`](#event__type__code_8h_1a8a4d9c6e8d812dffc5b1e3cfca6bffd9) 

#### `define `[`VALUE_SD_OUT`](#event__type__code_8h_1abd13c583e4aed8f9287544b550eac641) 

#### `define `[`VALUE_SD_IN`](#event__type__code_8h_1ae613a15618fe24a25e4d25af0d8a9bc9) 

#### `define `[`EV_LAN`](#event__type__code_8h_1a4418dd932546faa7c76a82551cbf2ec7) 

LAN Driver event

#### `define `[`VALUE_LAN_OUT`](#event__type__code_8h_1a97a50f51f457015798b50e267002b02a) 

#### `define `[`VALUE_LAN_IN`](#event__type__code_8h_1aea9231d5013b03ae10d322cdf2e04b5a) 

#### `define `[`EV_NET`](#event__type__code_8h_1afcc5c1afcb31498d6d6fab5f8d895763) 

Net event define

#### `define `[`CODE_NET_DHCP_START`](#event__type__code_8h_1a4473f3177039bc46084cf4657ec3eea0) 

#### `define `[`CODE_NET_DHCP_RESULT`](#event__type__code_8h_1a51b4d9b5a7c35bdb7d4b1a81d7408ddc) 

#### `define `[`CODE_NET_IP_STATIC`](#event__type__code_8h_1ae94777d34b632126e35491a2e46f451e) 

#### `define `[`CODE_NET_STATUS`](#event__type__code_8h_1a2fc16177218ab0bf725c58bc78aafd22) 

#### `define `[`VALUE_NET_LAN_OK`](#event__type__code_8h_1a1af32b66c65117cf5af0d873c92e862e) 

#### `define `[`VALUE_NET_WIFI_OK`](#event__type__code_8h_1a94e1c51bd2c039a0b17b769672a54c87) 

#### `define `[`EV_USB`](#event__type__code_8h_1a25481c1736533f043bd694c8b8481a49) 

Usb driver event

#### `define `[`VALUE_USB_OUT`](#event__type__code_8h_1a3eee9e8af3da5fc738cb1e5fceb753a6) 

#### `define `[`VALUE_USB_IN`](#event__type__code_8h_1af13a9e43c14dbc95c7ee80fded24b54d) 

#### `define `[`EV_PM`](#event__type__code_8h_1ad6e79eabda6d405708ab1da1478b2dcb) 

PM event

#### `define `[`CODE_PM_ENTER_INFORM`](#event__type__code_8h_1ace9af06e9a426f1ff423e476da9eb09a) 

#### `define `[`CODE_PM_ENTER`](#event__type__code_8h_1a9f691c2019efc88b6af8e27218a01457) 

#### `define `[`CODE_PM_DONE`](#event__type__code_8h_1ae8b3f4532d3e8ae510feb8f387e25d9e) 

#### `define `[`CODE_PM_QUIT`](#event__type__code_8h_1a18b14bd80e5eb27975aa823ef893cd6c) 

#### `define `[`CODE_PM_SHUTDOWN_INFORM`](#event__type__code_8h_1aec04b475e3d3c1b05829b5cd07127b12) 

#### `define `[`CODE_PM_STARTUP_INFORM`](#event__type__code_8h_1a4a86976084db619153264b47c5e4dbf1) 

#### `define `[`CODE_PM_LOWPOWER_INFORM`](#event__type__code_8h_1ae34b18ddd5ed57a4f73c21e2f5e17811) 

#### `define `[`CODE_PM_POWERRECOVER_INFORM`](#event__type__code_8h_1ad8b02cdf5ac9fee21d55901ebd5bf028) 

#### `define `[`CODE_PM_START_HEARTBEAT_INFORM`](#event__type__code_8h_1ae565b11624375b038002ce642bc3f6d0) 

#### `define `[`CODE_PM_STOP_HEARTBEAT_INFORM`](#event__type__code_8h_1a53abbce3515afb2393f2cc4226fd3041) 

#### `define `[`VALUE_PM_IDLE_INFORM`](#event__type__code_8h_1a3aac3ca91309689137c5f62beeca7175) 

#### `define `[`VALUE_PM_POWERBUTTON_INFORM`](#event__type__code_8h_1aa9da806c1ccda20fc9efd2f12570570c) 

#### `define `[`EV_FS`](#event__type__code_8h_1a50c2573a7958214f358e3e37f9e487e7) 

File system event

#### `define `[`CODE_FSYS_SD_LOAD`](#event__type__code_8h_1a0eb7096243ec8a63c9214041f7b5409e) 

#### `define `[`CODE_FSYS_UDISK_LOAD`](#event__type__code_8h_1aad0f91872d01b1d79f068adbfb53e996) 

#### `define `[`CODE_FSYS_FLASH_LOAD`](#event__type__code_8h_1aabdda409bd5e2ef1808f4fdf006c80f3) 

#### `define `[`CODE_FSYS_SD_SPACE`](#event__type__code_8h_1afb953c2fd02c23dccdfb83bd7dc0d18c) 

#### `define `[`CODE_FSYS_UDISK_SPACE`](#event__type__code_8h_1adb38130dcf75957a0b20a7998ecf4745) 

#### `define `[`CODE_FSYS_FLASH_SPACE`](#event__type__code_8h_1a98b3dd57c012289afb4a1bf491651256) 

#### `define `[`EV_BT`](#event__type__code_8h_1ad8aeb5ad90a02ca788dc6ef752e521d4) 

Bluetooth

#### `define `[`CODE_BT_DEVICE_CONNECT`](#event__type__code_8h_1a156fe8642b3fa3a7293bee0e641368bb) 

#### `define `[`CODE_BT_DEVICE_DISCONNECT`](#event__type__code_8h_1a30eb27a707bdc52401b30f7063515fce) 

#### `define `[`CODE_BT_MODE_ON`](#event__type__code_8h_1a3d5d6be2d588ad3f89ba2702c9bc8159) 

#### `define `[`CODE_BT_MODE_OFF`](#event__type__code_8h_1a92221d85861d6627b1184c2893536734) 

#### `define `[`EV_DLNA`](#event__type__code_8h_1ae8d9c6efe080c9657dfc6ba48f2b4d6a) 

DLNA

#### `define `[`CODE_DLNA_DEVICE_CONNECT`](#event__type__code_8h_1a9d6dbdd9d73ed9b91add2084e53899a7) 

#### `define `[`CODE_DLNA_DEVICE_DISCONNECT`](#event__type__code_8h_1a0e421ca3249c21714df46c82094371c5) 

#### `define `[`CODE_DLNA_MODE_ON`](#event__type__code_8h_1adc95490785c84a27bd5e75731fff84d0) 

#### `define `[`CODE_DLNA_MODE_OFF`](#event__type__code_8h_1a33a7b2fcc4d32b8bb55af607da381386) 

#### `define `[`EV_AIRPLAY`](#event__type__code_8h_1a52b6aa120ee216c7743c77e74b8afdd9) 

AIRPLAY

#### `define `[`CODE_AIRPLAY_DEVICE_CONNECT`](#event__type__code_8h_1a46096186dcea96f7d9712afff415dc78) 

#### `define `[`CODE_AIRPLAY_DEVICE_DISCONNECT`](#event__type__code_8h_1ad45bcf356361e76aa11ce20efa4f20e5) 

#### `define `[`CODE_AIRPLAY_MODE_ON`](#event__type__code_8h_1a186e513fd1c1a7fd7d139952a24cc862) 

#### `define `[`CODE_AIRPLAY_MODE_OFF`](#event__type__code_8h_1a4b48d0bdc73bf8f9c7a8769f38a8ec81) 

#### `define `[`AOS_LOG_LEVEL`](#log__impl_8h_1aa261952d3b777bbb745470f58ce7abdc) 

#### `define `[`AOS_LL_V_NONE`](#log__impl_8h_1a0479c76780f74081e2230b6f6789ec63) 

#### `define `[`AOS_LL_V_ALL`](#log__impl_8h_1a3d48a5e0dc40a98effe1f1a01da9cbbe) 

#### `define `[`AOS_LL_V_FATAL`](#log__impl_8h_1af84ef8d893da4fe00bdcbac07fd53e9f) 

#### `define `[`AOS_LL_V_ERROR`](#log__impl_8h_1aed3b3779ff60e041e998c458d6e5dc71) 

#### `define `[`AOS_LL_V_WARN`](#log__impl_8h_1a5c2d038ed8be7b94e3a00f92163f3f58) 

#### `define `[`AOS_LL_V_INFO`](#log__impl_8h_1aaedc2d9d1d3781636b3a10eb53e3b986) 

#### `define `[`AOS_LL_V_DEBUG`](#log__impl_8h_1a0ce70689bb93323dbff1b0030d1e5f47) 

#### `define `[`COL_DEF`](#log__impl_8h_1a9c1b34fcf28ff990ad9eea3c064641bd) 

#### `define `[`COL_RED`](#log__impl_8h_1a87d30d2657caae38d671f052cb9cc0e7) 

#### `define `[`COL_GRE`](#log__impl_8h_1a9cdb9d058a13d2b954d52c13ebf6f90d) 

#### `define `[`COL_BLU`](#log__impl_8h_1a84a127ed8baebd354118b6d7518ca9fa) 

#### `define `[`COL_YEL`](#log__impl_8h_1a864e4193bd767df90391580c9a7c04d1) 

#### `define `[`COL_WHE`](#log__impl_8h_1aa53304ea5f14313a7bf74298da4a13dc) 

#### `define `[`COL_CYN`](#log__impl_8h_1ae0a857bf983563d0f0b299c07d836b76) 

#### `define `[`COL_MAG`](#log__impl_8h_1a8517113b9d0649078b3a75176a5f5573) 

#### `define `[`GLOBAL_LOG_TAG`](#log__impl_8h_1ad8439b492ab23cc1748b5f50549ef62a) 

#### `define `[`log_print`](#log__impl_8h_1a3898392e09a1bebd13240c082c6ce816) 

#### `define `[`void_func`](#log__impl_8h_1a80ffa8067a17fce16c75107d7e073657) 

#### `define `[`LOG_IMPL`](#log__impl_8h_1ad2ddc7261600d1a356896072632ee519) 

#### `define `[`LOGD_IMPL`](#log__impl_8h_1ad2c421cdb04bb625d04819febb3ac951) 

#### `define `[`LOGF_IMPL`](#log__impl_8h_1a9258df246c14776566d9d3c8bb311425) 

#### `define `[`LOGE_IMPL`](#log__impl_8h_1a372bc53d0eaf1b108a89e95eb1d323bb) 

#### `define `[`LOGW_IMPL`](#log__impl_8h_1a69e38bb28b849f032de3a3da88577805) 

#### `define `[`LOGI_IMPL`](#log__impl_8h_1a11c506b1d4a87801d46c9062c5fc1f58) 

#### `define `[`AOS_WAIT_FOREVER`](#kernel_8h_1ace7b5d4663ba617a23da0ac13acd6ea9) 

#### `define `[`AOS_DEFAULT_APP_PRI`](#kernel_8h_1af68dd1e94330d50f154d26e8f40b6520) 

#### `define `[`aos_offsetof`](#list_8h_1a8cc696677b989b172f5ab8a938b06d1b) 

#### `define `[`aos_container_of`](#list_8h_1ab351f3482972778a52453d4cf00f273c) 

#### `define `[`dlist_entry`](#list_8h_1aa90e0ac71281846733410d0625524d02) 

#### `define `[`AOS_DLIST_INIT`](#list_8h_1ad84316f170c0ed94abff6bee5ca3986d) 

#### `define `[`dlist_first_entry`](#list_8h_1af1a183b22309a4a18139101e0b8dc5be) 

#### `define `[`dlist_for_each`](#list_8h_1a85c0c0944bdf6463f332c38d02ee1b69) 

#### `define `[`dlist_for_each_safe`](#list_8h_1a3b0134cd9d9839dbf4188a814fe19bd2) 

#### `define `[`dlist_for_each_entry`](#list_8h_1ac613bf70e3c79057a81c158113c50455) 

#### `define `[`dlist_for_each_entry_safe`](#list_8h_1a32b2914cd25f6124306ae66c046deb1d) 

#### `define `[`list_entry`](#list_8h_1a26c976b7f654e70df318c1843e5094de) 

list_entry - get the struct for this entry : the &struct list_head pointer. : the type of the struct this is embedded in. : the name of the list_struct within the struct.

#### `define `[`dlist_for_each_entry_reverse`](#list_8h_1aaa882b0cf8af3cc7245e51a6b1095f4c) 

list_for_each_entry_reverse_t - iterate backwards over list of given type. : the type * to use as a loop cursor. : the head for your list. : the name of the list_head within the struct. : the type of the struct this is embedded in.

#### `define `[`dlist_entry_number`](#list_8h_1a3f5a888135b513cb5ee39f534842e062) 

#### `define `[`AOS_DLIST_HEAD_INIT`](#list_8h_1ae00de76a37aadf228d5da0e6295736af) 

#### `define `[`AOS_DLIST_HEAD`](#list_8h_1a6707b3b791b349124111c7c9e5b777dd) 

#### `define `[`slist_for_each_entry`](#list_8h_1a2b49a24c73d18c6175de98419869d1ac) 

#### `define `[`slist_for_each_entry_safe`](#list_8h_1aff7c0edb74de8e67a0c1cc15c4b06e8e) 

#### `define `[`AOS_SLIST_HEAD_INIT`](#list_8h_1afc7b63732b51ec4d92227018f6d71494) 

#### `define `[`AOS_SLIST_HEAD`](#list_8h_1a350fd389591b7bf3da3e81baed9fbbee) 

#### `define `[`slist_entry`](#list_8h_1a7345be2c3717197378d0c294603a92f9) 

#### `define `[`slist_first_entry`](#list_8h_1af97027b393b390597759c365c6820c0f) 

#### `define `[`slist_entry_number`](#list_8h_1a6b07c04dad0d85b6e31f4a4cec20d808) 

#### `define `[`LOGF`](#log_8h_1acb7268fb6c63c18aa7d372642e9c9994) 

fatal log

#### Parameters
* `mod` string description of module 

* `fmt` same as printf() usage

#### `define `[`LOGE`](#log_8h_1a0d0173d9a0b62a413f2b6dc5cb45b68d) 

error log

#### Parameters
* `mod` string description of module 

* `fmt` same as printf() usage

#### `define `[`LOGW`](#log_8h_1ad10099153d2aa027c77b7109f9c82b68) 

warning log

#### Parameters
* `mod` string description of module 

* `fmt` same as printf() usage

#### `define `[`LOGI`](#log_8h_1a834da07fe3197a064a151e6972ecb9ae) 

information log

#### Parameters
* `mod` string description of module 

* `fmt` same as printf() usage

#### `define `[`LOGD`](#log_8h_1ab2bb4d01d7fa560ad13a9cfc3b32fcbc) 

debug log

#### Parameters
* `mod` string description of module 

* `fmt` same as printf() usage

#### `define `[`LOG`](#log_8h_1a388edf12256bf73c3a8ee9734c3bd841) 

log at warning level

#### Parameters
* `fmt` same as printf() usage

#### `define `[`_MBEDYLS_SSL_H_`](#mbedtls__ssl_8h_1ae8ccc1f5599f1ccd025b19e8be958f02) 

#### `define `[`EV_ALL`](#yloop_8h_1ab185d5d92c1a1df99920c5ba833f5372) 

special event filter

#### `define `[`EV_FLAG_URGENT`](#yloop_8h_1a399f2a3958f2a832817221506c15e898) 

#### `define `[`EV_SYS`](#yloop_8h_1a8fdc7aaa2a13ab9489d7b45b9ef50568) 

system event

#### `define `[`CODE_SYS_ON_STARTING`](#yloop_8h_1a0ba0b0ce2794b076ea7537d111501005) 

#### `define `[`CODE_SYS_ON_START_COMPLETED`](#yloop_8h_1a5b1bc45a2bccaa3caa0497194c99d30e) 

#### `define `[`CODE_SYS_ON_START_FAILED`](#yloop_8h_1a8ade53665e324a90cb4a6606d266613b) 

#### `define `[`CODE_SYS_ON_IDLE`](#yloop_8h_1ac4797216e21ccb95a9896faf7dfbf37e) 

#### `define `[`CODE_SYS_ON_START_FOTA`](#yloop_8h_1afea94dfbfa2188fe73ed0d11d6e2ef31) 

#### `define `[`CODE_SYS_ON_ALINK_ONLINE`](#yloop_8h_1a199221e59559593d02d55951040ebf57) 

#### `define `[`CODE_SYS_ON_ALINK_OFFLINE`](#yloop_8h_1a86733bdbdb0f179abde321e5a1c5be39) 

#### `define `[`CODE_SYS_ON_MQTT_READ`](#yloop_8h_1ae4ebb708cb88da0bce93013e7ef7024d) 

#### `define `[`EV_WIFI`](#yloop_8h_1affc4055fea07f15553fc8db17a6e120a) 

WiFi event

#### `define `[`CODE_WIFI_CMD_RECONNECT`](#yloop_8h_1acda03b652239c2edec40254bed44d221) 

#### `define `[`CODE_WIFI_ON_CONNECTED`](#yloop_8h_1a427d380cb8889ff699407a4dd2f95bf6) 

#### `define `[`CODE_WIFI_ON_DISCONNECT`](#yloop_8h_1a8d95529b42f69e41c5220afd63f10028) 

#### `define `[`CODE_WIFI_ON_PRE_GOT_IP`](#yloop_8h_1ab55425e200c93b06bd26576c263dc91c) 

#### `define `[`CODE_WIFI_ON_GOT_IP`](#yloop_8h_1a4df6dc893a96f082d77db6dd86594d61) 

#### `define `[`EV_MESH`](#yloop_8h_1ad75a94b05f00c645c42912d796db5593) 

Mesh event

#### `define `[`CODE_MESH_STARTED`](#yloop_8h_1afd5af39eea4e80307e35a132b2b512f4) 

#### `define `[`CODE_MESH_ATTACHED`](#yloop_8h_1a8b1a74be071365257f6864ecfff707ee) 

#### `define `[`CODE_MESH_DETACHED`](#yloop_8h_1abbfc2d842eb104b7897884775c0c94b2) 

#### `define `[`CODE_MESH_CONNECTED`](#yloop_8h_1a77de4213aee74d827a703cd286d10e5e) 

#### `define `[`CODE_MESH_DISCONNECTED`](#yloop_8h_1a7fd68538cd58d9d2dec4b92a8efec0b6) 

#### `define `[`EV_USER`](#yloop_8h_1a5a9c2af33336fd505ae51bdad7f65435) 

user app start 0x1000 - 0x7fff

#### `define `[`SENSOR_TYPE_TEMPERATURE`](#sensor_8h_1afb4ae0506fc7cd6743247dae31528d46) 

#### `define `[`PAR_OPT_READ_POS`](#flash_8h_1ab1e58b6e8ff6f3761bdf24c04478c7f6) 

#### `define `[`PAR_OPT_WRITE_POS`](#flash_8h_1a68ff33d27eb40be97075ac7acc28b1dc) 

#### `define `[`PAR_OPT_READ_MASK`](#flash_8h_1a0b707d2a64f885c6386592c581470077) 

#### `define `[`PAR_OPT_WRITE_MASK`](#flash_8h_1a19bd5124832592851507c6febb93a65d) 

#### `define `[`PAR_OPT_READ_DIS`](#flash_8h_1a4f5a8817f87909dd93f8b655236bfa97) 

#### `define `[`PAR_OPT_READ_EN`](#flash_8h_1ad38fd963b47f4417058bde27626cec60) 

#### `define `[`PAR_OPT_WRITE_DIS`](#flash_8h_1a2e3aedc128cf4fc5c1962e9229ef00e9) 

#### `define `[`PAR_OPT_WRITE_EN`](#flash_8h_1a06797fb3f63772e5b3b7b72edd7ae86b) 

#### `define `[`TRACE_HAl_H`](#trace_8h_1a9476de8495ed6e38c8f7c1beac7af296) 

#### `enum `[`ALINK_LOG_LEVEL`](#group__wifi__debug_1gaf17ae4b2877b06aff2343711faadbddb) 

 Values                         | Descriptions                                
--------------------------------|---------------------------------------------
ALINK_LL_NONE            | disable log
ALINK_LL_FATAL            | fatal error log will output
ALINK_LL_ERROR            | error + fatal log will output
ALINK_LL_WARN            | warn + error + fatal log will output(default level)
ALINK_LL_INFO            | info + warn + error + fatal log will output
ALINK_LL_DEBUG            | debug + info + warn + error + fatal log will output
ALINK_LL_TRACE            | trace + debug + info + warn + error + fatal will output

log level def.

#### `enum `[`ALINK_WIFI_CALLBACK`](#group__wifi__callback_1ga3b5fd33d4b23fc88f44e05173ecd2f21) 

 Values                         | Descriptions                                
--------------------------------|---------------------------------------------
ALINK_CLOUD_CONNECTED            | void callback_cloud_connected(void) 
ALINK_CLOUD_DISCONNECTED            | void callback_cloud_disconnected(void) 
ALINK_GET_DEVICE_STATUS            | int callback_read_device_status(const char *params)
ALINK_SET_DEVICE_STATUS            | void callback_write_device_status(const char *params)
ALINK_GET_DEVICE_RAWDATA            | int callback_read_device_rawdata(const char *params)
ALINK_SET_DEVICE_RAWDATA            | void callback_write_device_rawdata(const char *params)

alink callback event

#### `enum `[`@0`](#cloud_8h_1a06fc87d81c62e9abb8790b6e5713c55b) 

 Values                         | Descriptions                                
--------------------------------|---------------------------------------------
CLOUD_CONNECTED            | 
CLOUD_DISCONNECTED            | 
GET_DEVICE_STATUS            | 
SET_DEVICE_STATUS            | 
GET_DEVICE_RAWDATA            | 
SET_DEVICE_RAWDATA            | 
UPGRADE_DEVICE            | 
CANCEL_UPGRADE_DEVICE            | 
GET_SUB_DEVICE_STATUS            | 
SET_SUB_DEVICE_STATUS            | 
MAX_EVENT_TYPE            | 

#### `enum `[`log_level_bit`](#log__impl_8h_1a3a413ca4b2647ce48fa4506e9b928bc6) 

 Values                         | Descriptions                                
--------------------------------|---------------------------------------------
AOS_LL_V_NONE_BIT            | 
AOS_LL_V_FATAL_BIT            | 
AOS_LL_V_ERROR_BIT            | 
AOS_LL_V_WARN_BIT            | 
AOS_LL_V_INFO_BIT            | 
AOS_LL_V_DEBUG_BIT            | 
AOS_LL_V_MAX_BIT            | 

#### `enum `[`aos_log_level_t`](#log_8h_1ab5415466dbe3b11b98f39d2c428bac16) 

log level definition.

 Values                         | Descriptions                                
--------------------------------|---------------------------------------------
AOS_LL_NONE            | disable log
AOS_LL_FATAL            | fatal log will output
AOS_LL_ERROR            | fatal + error log will output
AOS_LL_WARN            | fatal + warn + error log will output(default level)
AOS_LL_INFO            | info + warn + error log will output
AOS_LL_DEBUG            | debug + info + warn + error + fatal log will output

#### `enum `[`@1`](#base_8h_1adf764cbdea00d65edcd07bb9953ad2b7) 

HAL common error code.

 Values                         | Descriptions                                
--------------------------------|---------------------------------------------
HAL_ERR_ARG            | 
HAL_ERR_CAP            | 

#### `enum `[`hal_partition_t`](#flash_8h_1a1ff07b8a9c096b1b8ca7847be7c6e097) 

 Values                         | Descriptions                                
--------------------------------|---------------------------------------------
HAL_PARTITION_ERROR            | 
HAL_PARTITION_BOOTLOADER            | 
HAL_PARTITION_APPLICATION            | 
HAL_PARTITION_ATE            | 
HAL_PARTITION_OTA_TEMP            | 
HAL_PARTITION_RF_FIRMWARE            | 
HAL_PARTITION_PARAMETER_1            | 
HAL_PARTITION_PARAMETER_2            | 
HAL_PARTITION_PARAMETER_3            | 
HAL_PARTITION_PARAMETER_4            | 
HAL_PARTITION_BT_FIRMWARE            | 
HAL_PARTITION_MAX            | 
HAL_PARTITION_NONE            | 

#### `enum `[`hal_flash_t`](#flash_8h_1ad6e8fb5585076e4fc4986317027ab76d) 

 Values                         | Descriptions                                
--------------------------------|---------------------------------------------
HAL_FLASH_EMBEDDED            | 
HAL_FLASH_SPI            | 
HAL_FLASH_QSPI            | 
HAL_FLASH_MAX            | 
HAL_FLASH_NONE            | 

#### `enum `[`gpio_config_t`](#gpio_8h_1a9f109d20988917f140f5d55ed9a71385) 

 Values                         | Descriptions                                
--------------------------------|---------------------------------------------
INPUT_PULL_UP            | 
INPUT_PULL_DOWN            | 
INPUT_HIGH_IMPEDANCE            | 
OUTPUT_PUSH_PULL            | 
OUTPUT_OPEN_DRAIN_NO_PULL            | 
OUTPUT_OPEN_DRAIN_PULL_UP            | 

Pin configuration

#### `enum `[`gpio_irq_trigger_t`](#gpio_8h_1aa3de939093227b362c7ea6d942ecae9d) 

 Values                         | Descriptions                                
--------------------------------|---------------------------------------------
IRQ_TRIGGER_RISING_EDGE            | 
IRQ_TRIGGER_FALLING_EDGE            | 
IRQ_TRIGGER_BOTH_EDGES            | 

GPIO interrupt trigger

#### `enum `[`hal_uart_data_width_t`](#uart_8h_1a631222ce1f55203f7456a62df1adaeaa) 

 Values                         | Descriptions                                
--------------------------------|---------------------------------------------
DATA_WIDTH_5BIT            | 
DATA_WIDTH_6BIT            | 
DATA_WIDTH_7BIT            | 
DATA_WIDTH_8BIT            | 
DATA_WIDTH_9BIT            | 

UART data width

#### `enum `[`hal_uart_stop_bits_t`](#uart_8h_1aef51ce06a2c07532c061b3ebd5e22d25) 

 Values                         | Descriptions                                
--------------------------------|---------------------------------------------
STOP_BITS_1            | 
STOP_BITS_2            | 

UART stop bits

#### `enum `[`hal_uart_flow_control_t`](#uart_8h_1a33928493a14b4828cb32e778d1af482d) 

 Values                         | Descriptions                                
--------------------------------|---------------------------------------------
FLOW_CONTROL_DISABLED            | 
FLOW_CONTROL_CTS            | 
FLOW_CONTROL_RTS            | 
FLOW_CONTROL_CTS_RTS            | 

UART flow control

#### `enum `[`hal_uart_parity_t`](#uart_8h_1a67ed44b4958988acbd6cbccbe7d83b60) 

 Values                         | Descriptions                                
--------------------------------|---------------------------------------------
NO_PARITY            | 
ODD_PARITY            | 
EVEN_PARITY            | 

UART parity

#### `enum `[`wlan_sec_type_e`](#group__aos__hal__wifi_1gafa47b09f4b5246c3b1176fd9c75cf827) 

 Values                         | Descriptions                                
--------------------------------|---------------------------------------------
SECURITY_TYPE_NONE            | Open system.
SECURITY_TYPE_WEP            | Wired Equivalent Privacy. WEP security.
SECURITY_TYPE_WPA_TKIP            | WPA /w TKIP
SECURITY_TYPE_WPA_AES            | WPA /w AES
SECURITY_TYPE_WPA2_TKIP            | WPA2 /w TKIP
SECURITY_TYPE_WPA2_AES            | WPA2 /w AES
SECURITY_TYPE_WPA2_MIXED            | WPA2 /w AES or TKIP
SECURITY_TYPE_AUTO            | It is used when calling micoWlanStartAdv, MICO read security type from scan result.

#### `enum `[`hal_wifi_event_t`](#group__aos__hal__wifi_1ga83730d6c7cd3928caaa3cf4aa0415a24) 

 Values                         | Descriptions                                
--------------------------------|---------------------------------------------
NOTIFY_STATION_UP            | 
NOTIFY_STATION_DOWN            | 
NOTIFY_AP_UP            | 
NOTIFY_AP_DOWN            | 

#### `enum `[`hal_wifi_type_t`](#group__aos__hal__wifi_1ga9c6cd73d1b386384fea4dc5be8a25adc) 

 Values                         | Descriptions                                
--------------------------------|---------------------------------------------
SOFT_AP            | Act as an access point, and other station can connect, 4 stations Max
STATION            | Act as a station which can connect to an access point

#### `enum `[`@2`](#group__aos__hal__wifi_1ga99fb83031ce9923c84392b4e92f956b5) 

 Values                         | Descriptions                                
--------------------------------|---------------------------------------------
DHCP_DISABLE            | 
DHCP_CLIENT            | 
DHCP_SERVER            | 

#### `public void `[`alink_set_loglevel`](#group__wifi__debug_1ga3779729957441942a2abc98feb002181)`(enum `[`ALINK_LOG_LEVEL`](#group__wifi__debug_1gaf17ae4b2877b06aff2343711faadbddb)` loglevel)` 

log level control

#### Parameters
* `loglevel` 

#### Returns
None. 

**See also**: enum [ALINK_LOG_LEVEL](#group__wifi__debug_1gaf17ae4b2877b06aff2343711faadbddb). 

None.

#### `public int `[`alink_enable_sandbox_mode`](#group__wifi__debug_1gadd42d7fcac8cb0bc0f7c4c23c1fccd9b)`(void)` 

enable sandbox mode, for debug

#### Parameters
* `None.` 

#### Parameters
* `0` on success, otherwise -1 will return 

**See also**: None. 

None.

#### `public int `[`alink_enable_daily_mode`](#group__wifi__debug_1gaaabf9975f8812dc1a58db3e813763daf)`(const char * server_ip,int port)` 

enable daily mode, for debug

#### Parameters
* `None.` 

#### Parameters
* `0` on success, otherwise -1 will return 

**See also**: None. 

None.

#### `public int `[`alink_start`](#group__wifi__entry_1gaa51c9013febdbb0b58ab1ac901fea792)`(void)` 

entry function. start alink gateway service.

#### Parameters
* `None.` 

#### Parameters
* `0` on success, otherwise -1 will return 

**See also**: None. 

None.

#### `public int `[`alink_wait_connect`](#group__wifi__entry_1ga1f5065903c84c98cf02a0f65ccd6e3f6)`(int timeout_ms)` 

waiting alink connect to aliyun server

#### Parameters
* `timeout_ms` time in milliseconds, use ALINK_WAIT_FOREVER to wait until aliyun server is connected 

#### Parameters
* `0` when connect to server successfully, otherwise -1 will return 

**See also**: None. 

None.

#### `public int `[`alink_end`](#group__wifi__entry_1ga4e4e661d611f8fbc8cb360dda9d6ffb0)`(void)` 

destroy alink service and free resources

#### Parameters
* `None.` 

#### Parameters
* `0` on success, otherwise -1 will return 

**See also**: None. 

this func will block at most 15 seconds to stop all alink related process(thread)

#### `public int `[`alink_factory_reset`](#group__wifi__entry_1ga95f9d8016cde456e7b7cb9b89acad413)`(void)` 

reset user account binding.

#### Parameters
* `0` on success, -1 when params invalid 

**See also**: None. 

None.

#### `public int `[`alink_report`](#group__wifi__report_1gadc5c42911beda8c2c3534c404363c273)`(const char * method,char * json_buffer)` 

report alink message, it is a fundamental func.

#### Parameters
* `method` alink protocol method, i.e. "postDeviceRawData", "retrieveDeviceData". 

* `json_buffer` json format buffer, like {"OnOff":"1", "Light":"80"}. 

#### Parameters
* `0` when successfully got response from cloud, otherwise this func will block until timeout and -1 will return 

**See also**: None. 

when connection with server is unstable, this func will block until got response from server or timeout.

#### `public int `[`alink_report_rawdata`](#group__wifi__report_1ga7c9f73105a6ebacc8525ceb4ee2556dc)`(const char * rawdata,int len)` 

#### `public int `[`alink_register_callback`](#group__wifi__callback_1ga2f49a6c4440868578138dc4e38f10e74)`(unsigned char cb_type,void * cb_func)` 

register misc callback

#### Parameters
* `cb_type` callback type. 

* `cb_func` callback func pointer, func declaration see related comments.

#### Parameters
* `0` on success, otherwise -1 will return 

**See also**: enum [ALINK_WIFI_CALLBACK](#group__wifi__callback_1ga3b5fd33d4b23fc88f44e05173ecd2f21). 

None.

#### `public int `[`awss_start`](#group__wifi__awss_1ga20454ef4cbebf8584d9d071ebd3f898c)`(void)` 

start awss service, block method, block until awss succeed, or timeout(see Note).

#### Returns
0 on success, otherwise non-zero value will return   = 0: connect AP & DHCP success
  = -1: get ssid & passwd fail
  = -2: connect AP / DHCP fail

**See also**: None. 

platform_awss_get_timeout_interval_ms() return monitor timeout interval, AP connection timeout is 30s.

#### `public int `[`awss_stop`](#group__wifi__awss_1gaf64ac3d619f49ed0fea96579f984ca17)`(void)` 

calling this func force awss_start exit.

#### Parameters
* `None.` 

#### Parameters
* `0` on success, otherwise -1 will return 

**See also**: None. 

None.

#### `public int32_t `[`aos_uart_send`](#aos_8h_1a3f4a0f0c0e677838365d0010bcb1f111)`(void * data,uint32_t size,uint32_t timeout)` 

Transmit data on a UART interface.

#### Parameters
* `data` : pointer to the start of data 

* `size` : number of bytes to transmit

#### Returns
kNoErr : on success. 

#### Returns
kGeneralErr : if an error occurred with any step

#### `public inline static int `[`cli_register_command`](#cli_8h_1af707e2241ff13add871d94da00d5422f)`(const struct `[`cli_command`](#structcli__command)` * command)` 

#### `public inline static int `[`cli_unregister_command`](#cli_8h_1a4beb8962840fd1ca27675ceaae42a6b8)`(const struct `[`cli_command`](#structcli__command)` * command)` 

#### `public inline static int `[`cli_register_commands`](#cli_8h_1a77b4f1228666e61699c58b8c19309a1b)`(const struct `[`cli_command`](#structcli__command)` * commands,int num_commands)` 

#### `public inline static int `[`cli_unregister_commands`](#cli_8h_1ade5a38c362a8841320ff22b5fe8e2447)`(const struct `[`cli_command`](#structcli__command)` * commands,int num_commands)` 

#### `public inline static int `[`aos_cli_init`](#cli_8h_1acd9d10d2482f8f228c0dcb57e8ea78f4)`(void)` 

#### `public inline static int `[`aos_cli_stop`](#cli_8h_1ac9c42106010c7ae9b962e2310abf851a)`(void)` 

#### `public int `[`aos_cloud_register_callback`](#cloud_8h_1ab3bd028a3acd80c60bc7e6a7e461d93b)`(int cb_type,`[`aos_cloud_cb_t`](#cloud_8h_1a22ca1348c62b436e4bde1610673e77e7)` cb)` 

Register cloud event callback.

#### Parameters
* `cb_type` event type interested 

* `cb` cloud event callback 

#### Parameters
* `0` success 

* `<0` failure

#### `public int `[`aos_cloud_report`](#cloud_8h_1aec9446932fef9166c9b4f1f61b36fb23)`(const char * method,const char * json_buffer,void(*)(void *) done_cb,void * arg)` 

Report event to cloud.

#### Parameters
* `method` remote method name 

* `json_buffer` method's payload 

* `done_cb` report done callback 

* `arg` private data passed to done_cb 

#### Parameters
* `0` success 

* `<0` failure

#### `public void `[`aos_cloud_trigger`](#cloud_8h_1a1d2fd4d25b1689ea4503d4c87ac5c67b)`(int cb_type,const char * json_buffer)` 

trigger specific event, used by Cloud Backend

#### Parameters
* `cb_type` event type 

* `json_buffer` payload 

#### Returns
None

#### `public void `[`aos_cloud_register_backend`](#cloud_8h_1a3636a6e0a1ac9b6c90fc43c0afb79627)`(int(*)(const char *method, const char *json_buffer) report)` 

register Cloud Backend

#### Parameters
* `report` called when user do aos_cloud_report 

#### Returns
None

#### `public inline static unsigned int `[`aos_log_get_level`](#log__impl_8h_1a24579a47d3fe3782ad920fa667a41d6d)`(void)` 

#### `public int `[`csp_printf`](#log__impl_8h_1a3f07b35189b67e500454b2b818ba1574)`(const char * fmt,...)` 

#### `public void `[`aos_reboot`](#kernel_8h_1aaa9ebda2d7e29737cfa7272058e215b1)`(void)` 

System reboot

#### `public int `[`aos_get_hz`](#kernel_8h_1ae8d852bd8f91b585e3a3b35b87482a8c)`(void)` 

get HZ

#### `public const char * `[`aos_version_get`](#kernel_8h_1acd94826d0fbcf02968bc1b73ed4dc24e)`(void)` 

Get kernel version

#### Returns
the operation status, RHINO_SUCCESS is OK, others is error

#### `public const char * `[`aos_strerror`](#kernel_8h_1acbb3042eb3786c26f862feaf1d841114)`(int errnum)` 

get error information 
#### Parameters
* `errnum` the error number

#### Returns
: error information

#### `public int `[`aos_task_new`](#kernel_8h_1ac3e5819f79305744325c60c53221e81c)`(const char * name,void(*)(void *) fn,void * arg,int stack_size)` 

Create a task([threadRhino&other-kernel][MainLoopnoRTOS])

#### Parameters
* `name` task name, any string 

* `fn` task function 

* `arg` any pointer, will give to your task-function as argument 

* `stacksize` stacksize in bytes

#### Returns
: task code

#### `public int `[`aos_task_new_ext`](#kernel_8h_1a75ed0d26eba3aa9304533166b751af9f)`(`[`aos_task_t`](#kernel_8h_1a8331188bdef4856ea654e31c05a7827e)` * task,const char * name,void(*)(void *) fn,void * arg,int stack_size,int prio)` 

Create a task([threadRhino&other-kernel][MainLoopnoRTOS])

#### Parameters
* `task` handle 

* `name` task name, any string 

* `fn` task function 

* `arg` any pointer, will give to your task-function as argument 

* `stack_buf` stack-buf: if stack_buf==NULL, provided by kernel 

* `stack_size` stacksize in bytes 

* `prio` priority value, smaller the stronger

#### Returns
: task code

#### `public void `[`aos_task_exit`](#kernel_8h_1a4f8364a78b8c797ac86ee5de9f0b05c5)`(int code)` 

exit a task 
#### Parameters
* `code` the id which aos_task_new returned

#### `public const char * `[`aos_task_name`](#kernel_8h_1adbb65e60cc107a65d3d45b578fbf7a9e)`(void)` 

get task name

#### `public int `[`aos_task_key_create`](#kernel_8h_1ad81cdd2fa83909ccbaa151e29ae1aea0)`(`[`aos_task_key_t`](#kernel_8h_1ac2e6e434ccf67117e3b1f00483d4b364)` * key)` 

create a task key 
#### Parameters
* `key` pointer of key object 

#### Returns
the check status, 0 is OK, -1 indicates invalid

#### `public void `[`aos_task_key_delete`](#kernel_8h_1ac93f559c867c74e62ecdaffbb0c5d38b)`(`[`aos_task_key_t`](#kernel_8h_1ac2e6e434ccf67117e3b1f00483d4b364)` key)` 

delete a task key 
#### Parameters
* `key` key object

#### `public int `[`aos_task_setspecific`](#kernel_8h_1abc5849757e768e073914dd672f661b51)`(`[`aos_task_key_t`](#kernel_8h_1ac2e6e434ccf67117e3b1f00483d4b364)` key,void * vp)` 

associate a task-specific value with a key 
#### Parameters
* `key` key object 

* `vp` pointer of a task-specific value 

#### Returns
the check status, 0 is OK, -1 indicates invalid

#### `public void * `[`aos_task_getspecific`](#kernel_8h_1a3d04253f30128f0f443b7b08646472e5)`(`[`aos_task_key_t`](#kernel_8h_1ac2e6e434ccf67117e3b1f00483d4b364)` key)` 

get the value currently bound to the specified key 
#### Parameters
* `key` key object

#### `public int `[`aos_mutex_new`](#kernel_8h_1a39a39b90a25ef280ba26bef68120a57d)`(`[`aos_mutex_t`](#kernel_8h_1ace8bc8c4f45849bf1239ef25cdbc2f7e)` * mutex)` 

alloc a mutex 
#### Parameters
* `mutex` pointer of mutex object,mutex object must be alloced, hdl pointer in aos_mutex_t will refer a kernel obj internally

#### `public void `[`aos_mutex_free`](#kernel_8h_1aad3b88f3a77b2a1139c2e8023f77919d)`(`[`aos_mutex_t`](#kernel_8h_1ace8bc8c4f45849bf1239ef25cdbc2f7e)` * mutex)` 

free a mutex 
#### Parameters
* `mutex` mutex object,mem refered by hdl pointer in aos_mutex_t will be freed internally

#### `public int `[`aos_mutex_lock`](#kernel_8h_1ae33d2cc601477493d159eaae9dafd433)`(`[`aos_mutex_t`](#kernel_8h_1ace8bc8c4f45849bf1239ef25cdbc2f7e)` * mutex,unsigned int timeout)` 

lock a mutex 
#### Parameters
* `mutex` mutex object,it contains kernel obj pointer which aos_mutex_new alloced

#### `public int `[`aos_mutex_unlock`](#kernel_8h_1ac0d44d29a69cc71cb5d921cc12df646b)`(`[`aos_mutex_t`](#kernel_8h_1ace8bc8c4f45849bf1239ef25cdbc2f7e)` * mutex)` 

unlock a mutex 
#### Parameters
* `mutex` mutex object,,it contains kernel obj pointer which oc_mutex_new alloced

#### `public int `[`aos_mutex_is_valid`](#kernel_8h_1a5c0600e105761364fe15cba496341148)`(`[`aos_mutex_t`](#kernel_8h_1ace8bc8c4f45849bf1239ef25cdbc2f7e)` * mutex)` 

This function will check if mutex is valid 
#### Parameters
* `mutex` pointer to the mutex 

#### Returns
the check status, RHINO_TRUE is OK, RHINO_FALSE indicates invalid

#### `public int `[`aos_sem_new`](#kernel_8h_1a7b4c81682a9a9b9ed039e9bd1ee668cb)`(`[`aos_sem_t`](#kernel_8h_1a4f2e4d746fc4b086c6fab52ce8b1a117)` * sem,int count)` 

alloc a semaphore 
#### Parameters
* `sem` pointer of semaphore object,semaphore object must be alloced, hdl pointer in aos_sem_t will refer a kernel obj internally 

* `count` initial semaphore counter

#### `public void `[`aos_sem_free`](#kernel_8h_1a8280f3374a68d03e68b7998c16e3e10a)`(`[`aos_sem_t`](#kernel_8h_1a4f2e4d746fc4b086c6fab52ce8b1a117)` * sem)` 

destroy a semaphore 
#### Parameters
* `sem` pointer of semaphore object,mem refered by hdl pointer in aos_sem_t will be freed internally

#### `public int `[`aos_sem_wait`](#kernel_8h_1addd37f144a0d2ab1aff2796d0ea0b6b8)`(`[`aos_sem_t`](#kernel_8h_1a4f2e4d746fc4b086c6fab52ce8b1a117)` * sem,unsigned int timeout)` 

acquire a semaphore 
#### Parameters
* `sem` semaphore object,,it contains kernel obj pointer which aos_sem_new alloced 

* `timeout` waiting until timeout in milliseconds

#### `public void `[`aos_sem_signal`](#kernel_8h_1a88f5c9ab76c15d6046be6bad0e9eadd0)`(`[`aos_sem_t`](#kernel_8h_1a4f2e4d746fc4b086c6fab52ce8b1a117)` * sem)` 

release a semaphore 
#### Parameters
* `sem` semaphore object,,it contains kernel obj pointer which aos_sem_new alloced

#### `public int `[`aos_sem_is_valid`](#kernel_8h_1a312b401df7136fc6676f8b391d3db2d0)`(`[`aos_sem_t`](#kernel_8h_1a4f2e4d746fc4b086c6fab52ce8b1a117)` * sem)` 

This function will check if semaphore is valid 
#### Parameters
* `sem` pointer to the semaphore 

#### Returns
the check status, RHINO_TRUE is OK, RHINO_FALSE indicates invalid

#### `public void `[`aos_sem_signal_all`](#kernel_8h_1a53070c6fcdb7f8fbef1a8eb4a26fd7cf)`(`[`aos_sem_t`](#kernel_8h_1a4f2e4d746fc4b086c6fab52ce8b1a117)` * sem)` 

release all semaphore 
#### Parameters
* `sem` semaphore object,,it contains kernel obj pointer which aos_sem_new alloced

#### `public int `[`aos_queue_new`](#kernel_8h_1a5326decc24a0481168a84fa1d69f1548)`(`[`aos_queue_t`](#kernel_8h_1ad783cc298941621eda3f9f05d656d613)` * queue,void * buf,unsigned int size,int max_msg)` 

This function will create a queue 
#### Parameters
* `queue` pointer to the queue(the space is provided by user) 

* `buf` buf of the queue(provided by user) 

* `size` the bytes of the buf 

* `max_msg` the max size of the msg 

#### Returns
the operation status, 0 is OK, others is error

#### `public void `[`aos_queue_free`](#kernel_8h_1a8d136c68d53e64e5adc77ed641c8874c)`(`[`aos_queue_t`](#kernel_8h_1ad783cc298941621eda3f9f05d656d613)` * queue)` 

This function will delete a queue 
#### Parameters
* `queue` pointer to the queue 

#### Returns
the operation status, RHINO_SUCCESS is OK, others is error

#### `public int `[`aos_queue_send`](#kernel_8h_1a51536bfc868ae28bf2699b875175b39c)`(`[`aos_queue_t`](#kernel_8h_1ad783cc298941621eda3f9f05d656d613)` * queue,void * msg,unsigned int size)` 

This function will send a msg to the front of a queue 
#### Parameters
* `queue` pointer to the queue 

* `msg` msg to send 

* `size` size of the msg 

#### Returns
the operation status, 0 is OK, others is error

#### `public int `[`aos_queue_recv`](#kernel_8h_1a0b872ba513dd489162e71ac081c24762)`(`[`aos_queue_t`](#kernel_8h_1ad783cc298941621eda3f9f05d656d613)` * queue,unsigned int ms,void * msg,unsigned int * size)` 

This function will receive msg from a queue 
#### Parameters
* `queue` pointer to the queue 

* `ms` ms to wait before receive 

* `msg` buf to save msg 

* `size` size of the msg 

#### Returns
the operation status, 0 is OK, others is error

#### `public int `[`aos_queue_is_valid`](#kernel_8h_1ac8b31749bf7998f9e0e06cc534a02e01)`(`[`aos_queue_t`](#kernel_8h_1ad783cc298941621eda3f9f05d656d613)` * queue)` 

This function will check if queue is valid 
#### Parameters
* `queue` pointer to the queue 

#### Returns
the check status, RHINO_TRUE is OK, RHINO_FALSE indicates invalid

#### `public void * `[`aos_queue_buf_ptr`](#kernel_8h_1a11ac192f58dcf3fb7827261abb0a1e5f)`(`[`aos_queue_t`](#kernel_8h_1ad783cc298941621eda3f9f05d656d613)` * queue)` 

This function will return buf ptr if queue is inited 
#### Parameters
* `queue` pointer to the queue 

#### Returns
the check status, NULL is error

#### `public int `[`aos_sched_disable`](#kernel_8h_1a1068e110d5a7d5753fdfe8305c9df769)`(void)` 

This function will disable kernel sched 
#### Returns
the operation status, 0 is OK, others is error

#### `public int `[`aos_sched_enable`](#kernel_8h_1ae969ba05e2dc9319acda865d080d8f5a)`(void)` 

This function will enable kernel sched 
#### Returns
the operation status, 0 is OK, others is error

#### `public int `[`aos_timer_new`](#kernel_8h_1a65bf6c43ffbc83fb3b2dea492a6113fd)`(`[`aos_timer_t`](#kernel_8h_1a0e761beb1932038b7d24c918c2a59c89)` * timer,void(*)(void *, void *) fn,void * arg,int ms,int repeat)` 

This function will create a timer 
#### Parameters
* `timer` pointer to the timer 

* `fn` callbak of the timer 

* `arg` the argument of the callback 

* `ms` ms of the normal timer triger 

* `repeat` repeat or not when the timer is created 

#### Returns
the operation status, 0 is OK, others is error

#### `public void `[`aos_timer_free`](#kernel_8h_1a35c10dcc1344edf1f6953571f9be5b2f)`(`[`aos_timer_t`](#kernel_8h_1a0e761beb1932038b7d24c918c2a59c89)` * timer)` 

This function will delete a timer 
#### Parameters
* `timer` pointer to a timer 

#### Returns
the operation status, 0 is OK, others is error

#### `public int `[`aos_timer_start`](#kernel_8h_1ab0d3ca7374c1b73d9b1163b34134f42a)`(`[`aos_timer_t`](#kernel_8h_1a0e761beb1932038b7d24c918c2a59c89)` * timer)` 

This function will start a timer 
#### Parameters
* `timer` pointer to the timer 

#### Returns
the operation status, 0 is OK, others is error

#### `public int `[`aos_timer_stop`](#kernel_8h_1aea7b86d5fa4798a95049190e745907dd)`(`[`aos_timer_t`](#kernel_8h_1a0e761beb1932038b7d24c918c2a59c89)` * timer)` 

This function will stop a timer 
#### Parameters
* `timer` pointer to the timer 

#### Returns
the operation status, 0 is OK, others is error

#### `public int `[`aos_timer_change`](#kernel_8h_1a2b17bb6230d0b9d567754612c5430e03)`(`[`aos_timer_t`](#kernel_8h_1a0e761beb1932038b7d24c918c2a59c89)` * timer,int ms)` 

This function will change attributes of a timer 
#### Parameters
* `timer` pointer to the timer 

* `ms` ms of the timer triger 

#### Returns
the operation status, 0 is OK, others is error

#### `public int `[`aos_workqueue_create`](#kernel_8h_1a7aa3b1afb11951c46eab1d0b43c37226)`(`[`aos_workqueue_t`](#structaos__workqueue__t)` * workqueue,int pri,int stack_size)` 

This function will creat a workqueue 
#### Parameters
* `workqueue` the workqueue to be created 

* `pri` the priority of the worker 

* `stack_size` the size of the worker-stack 

#### Returns
the operation status, 0 is OK, others is error

#### `public void `[`aos_workqueue_del`](#kernel_8h_1a944dbd969c5416fdd3c0defa62be5681)`(`[`aos_workqueue_t`](#structaos__workqueue__t)` * workqueue)` 

This function will delete a workqueue 
#### Parameters
* `workqueue` the workqueue to be deleted 

#### Returns
the operation status, 0 is OK, others is error

#### `public int `[`aos_work_init`](#kernel_8h_1ae853d1d6ed0e64b996cf7303d0cdf22c)`(`[`aos_work_t`](#kernel_8h_1a1e7c04d7e97812526bfea771f1f3d6c3)` * work,void(*)(void *) fn,void * arg,int dly)` 

This function will initialize a work 
#### Parameters
* `work` the work to be initialized 

* `fn` the call back function to run 

* `arg` the paraments of the function 

* `dly` ms to delay before run 

#### Returns
the operation status, 0 is OK, others is error

#### `public void `[`aos_work_destroy`](#kernel_8h_1ab4b4a876cb5f99870464437fdf1d8473)`(`[`aos_work_t`](#kernel_8h_1a1e7c04d7e97812526bfea771f1f3d6c3)` * work)` 

This function will destroy a work 
#### Parameters
* `work` the work to be destroied 

#### Returns
None

#### `public int `[`aos_work_run`](#kernel_8h_1ad4996714a1cf9618dc4063097a8bd8cd)`(`[`aos_workqueue_t`](#structaos__workqueue__t)` * workqueue,`[`aos_work_t`](#kernel_8h_1a1e7c04d7e97812526bfea771f1f3d6c3)` * work)` 

This function will run a work on a workqueue 
#### Parameters
* `workqueue` the workqueue to run work 

* `work` the work to run 

#### Returns
the operation status, 0 is OK, others is error

#### `public int `[`aos_work_sched`](#kernel_8h_1a5efd9714085578c4fc2919f88ddf713d)`(`[`aos_work_t`](#kernel_8h_1a1e7c04d7e97812526bfea771f1f3d6c3)` * work)` 

This function will run a work on the default workqueue 
#### Parameters
* `work` the work to run 

#### Returns
the operation status, 0 is OK, others is error

#### `public int `[`aos_work_cancel`](#kernel_8h_1a468f8735777d13a035291cb8db664d02)`(`[`aos_work_t`](#kernel_8h_1a1e7c04d7e97812526bfea771f1f3d6c3)` * work)` 

This function will cancel a work on the default workqueue 
#### Parameters
* `work` the work to cancel 

#### Returns
the operation status, 0 is OK, others is error

#### `public void * `[`aos_realloc`](#kernel_8h_1acdbdecb39b5b77bc30b2c76b368a2322)`(void * mem,unsigned int size)` 

realloc memory 
#### Parameters
* `mem` `current` memory address point 

* `size` new size of the mem to remalloc 

#### Returns
the operation status, NULL is error, others is memory address

#### `public void * `[`aos_malloc`](#kernel_8h_1ace6ec1b819481718629380a6ab9b3d57)`(unsigned int size)` 

alloc memory 
#### Parameters
* `size` size of the mem to malloc 

#### Returns
the operation status, NULL is error, others is memory address

#### `public void * `[`aos_zalloc`](#kernel_8h_1ad8074d67714dc589918cce73ab6ec751)`(unsigned int size)` 

alloc memory and clear to zero 
#### Parameters
* `size` size of the mem to malloc 

#### Returns
the operation status, NULL is error, others is memory address

#### `public void `[`aos_alloc_trace`](#kernel_8h_1a99e4fd7a1b3afda2122f5c005a3a4fe8)`(void * addr,size_t allocator)` 

trace alloced mems 
#### Parameters
* `addr` pointer of the mem alloced by malloc 

* `allocator` buildin_address

#### `public void `[`aos_free`](#kernel_8h_1a12a6358720769a6489f381d860fe6dc4)`(void * mem)` 

free memory 
#### Parameters
* `ptr` address point of the mem

#### `public long long `[`aos_now`](#kernel_8h_1af3cea202def3ac1612449897bee0b481)`(void)` 

get current time in nano seconds 
#### Returns
elapsed time in nano seconds from system starting

#### `public long long `[`aos_now_ms`](#kernel_8h_1ab0f5a75d2da6e526862decdf11a2574f)`(void)` 

get current time in mini seconds 
#### Returns
elapsed time in mini seconds from system starting

#### `public void `[`aos_msleep`](#kernel_8h_1ad02a268f96460567b93155324510a0c5)`(int ms)` 

msleep 
#### Parameters
* `ms` sleep time in milliseconds

#### `public int `[`aos_kv_set`](#kv_8h_1a18e25fc9b6cc24c1fddfcc11d8726087)`(const char * key,const void * value,int len,int sync)` 

add another KV pair.

#### Parameters
*

#### `public int `[`aos_kv_get`](#kv_8h_1afa4c842f059c069a6ca43de194f78d05)`(const char * key,void * buffer,int * buffer_len)` 

get the KV value stored in  by its key .

#### Parameters
*

#### `public int `[`aos_kv_del`](#kv_8h_1a711e19ff624c05b9b41d3c11e2ac44fe)`(const char * key)` 

delete the KV pair by its key .

#### Parameters
*

#### `public inline static void `[`__dlist_add`](#list_8h_1acfac6035fb611ca4b1653183d1a1d268)`(`[`dlist_t`](#list_8h_1aeedb54ed9ac69e4fc599452bbc7eccbe)` * node,`[`dlist_t`](#list_8h_1aeedb54ed9ac69e4fc599452bbc7eccbe)` * prev,`[`dlist_t`](#list_8h_1aeedb54ed9ac69e4fc599452bbc7eccbe)` * next)` 

#### `public inline static void `[`dlist_add`](#list_8h_1ab5fd92793cd02313e7a6e9f78d16bd57)`(`[`dlist_t`](#list_8h_1aeedb54ed9ac69e4fc599452bbc7eccbe)` * node,`[`dlist_t`](#list_8h_1aeedb54ed9ac69e4fc599452bbc7eccbe)` * queue)` 

#### `public inline static void `[`dlist_add_tail`](#list_8h_1a7c8b4b86bc1355262e8cf9754d5e7ad6)`(`[`dlist_t`](#list_8h_1aeedb54ed9ac69e4fc599452bbc7eccbe)` * node,`[`dlist_t`](#list_8h_1aeedb54ed9ac69e4fc599452bbc7eccbe)` * queue)` 

#### `public inline static void `[`dlist_del`](#list_8h_1a44be29dcbde5e33d8b1631fd573c9263)`(`[`dlist_t`](#list_8h_1aeedb54ed9ac69e4fc599452bbc7eccbe)` * node)` 

#### `public inline static void `[`dlist_init`](#list_8h_1afb5ee572477c0667e9c24a8103ae5703)`(`[`dlist_t`](#list_8h_1aeedb54ed9ac69e4fc599452bbc7eccbe)` * node)` 

#### `public inline static void `[`INIT_AOS_DLIST_HEAD`](#list_8h_1a5516c031b59eeab86a60ed3e476eca7d)`(`[`dlist_t`](#list_8h_1aeedb54ed9ac69e4fc599452bbc7eccbe)` * list)` 

#### `public inline static int `[`dlist_empty`](#list_8h_1a90536260cd9ef225666f9722ebcd6737)`(const `[`dlist_t`](#list_8h_1aeedb54ed9ac69e4fc599452bbc7eccbe)` * head)` 

#### `public inline static void `[`slist_add`](#list_8h_1a48d4ba068d5100a34df0cb301ef931b9)`(`[`slist_t`](#list_8h_1adeee7753df41046b42a3cc5f094ff098)` * node,`[`slist_t`](#list_8h_1adeee7753df41046b42a3cc5f094ff098)` * head)` 

#### `public inline static void `[`slist_add_tail`](#list_8h_1aede1ac1e67d228efdfd4f8b44683fef0)`(`[`slist_t`](#list_8h_1adeee7753df41046b42a3cc5f094ff098)` * node,`[`slist_t`](#list_8h_1adeee7753df41046b42a3cc5f094ff098)` * head)` 

#### `public inline static void `[`slist_del`](#list_8h_1ac077ea4258f54c8e970b2007a3b4f770)`(`[`slist_t`](#list_8h_1adeee7753df41046b42a3cc5f094ff098)` * node,`[`slist_t`](#list_8h_1adeee7753df41046b42a3cc5f094ff098)` * head)` 

#### `public inline static int `[`slist_empty`](#list_8h_1aa10779953f2682ed895d5c94d38da154)`(const `[`slist_t`](#list_8h_1adeee7753df41046b42a3cc5f094ff098)` * head)` 

#### `public inline static void `[`slist_init`](#list_8h_1ab5500b0449c2960689eb04df286a4f64)`(`[`slist_t`](#list_8h_1adeee7753df41046b42a3cc5f094ff098)` * head)` 

#### `public void `[`aos_set_log_level`](#log_8h_1ae17ac5be96340be7f2ad09073f5f2438)`(`[`aos_log_level_t`](#log_8h_1ab5415466dbe3b11b98f39d2c428bac16)` log_level)` 

log level control

#### Parameters
* `log_level` 

**See also**: [aos_log_level_t](#log_8h_1ab5415466dbe3b11b98f39d2c428bac16).

#### `public void * `[`mbedtls_ssl_connect`](#mbedtls__ssl_8h_1ac8e25eeaeab85591aaac6c4d2fe448b7)`(void * tcp_fd,const char * ca_cert,int ca_cert_len)` 

#### `public int `[`mbedtls_ssl_send`](#mbedtls__ssl_8h_1a0ebe89132557545e0bacc6a612b75e78)`(void * ssl,const char * buffer,int length)` 

#### `public int `[`mbedtls_ssl_recv`](#mbedtls__ssl_8h_1ae9d48c1e1dcc277ebf4717f91c074706)`(void * ssl,char * buffer,int length)` 

#### `public int `[`mbedtls_ssl_close`](#mbedtls__ssl_8h_1a577aa17f3fed0a15fe7078445cf8302a)`(void * ssl)` 

#### `public const char * `[`get_aos_product_model`](#version_8h_1aa58affac87db6f69d55668da06a1a4ce)`(void)` 

#### `public const char * `[`get_aos_os_version`](#version_8h_1aee496d8bd359a7bef37c106e3fbd9964)`(void)` 

#### `public const char * `[`get_aos_kernel_version`](#version_8h_1ac337492dbb8856b786c1d8c4c3624ede)`(void)` 

#### `public const char * `[`get_aos_app_version`](#version_8h_1a4f0f840603fc141346cb94f49c9e79f3)`(void)` 

#### `public const char * `[`get_aos_device_name`](#version_8h_1a15e74ca877fc06f74ee6e4a6986d67fc)`(void)` 

#### `public void `[`dump_sys_info`](#version_8h_1a9346d6c941c5456a760587f57b31021b)`(void)` 

#### `public int `[`aos_open`](#vfs_8h_1aef54e3c41eba34f466fe5aa9f246b0f4)`(const char * path,int flags)` 

open the file or device by its path .

#### Parameters
*

#### `public int `[`aos_close`](#vfs_8h_1a906713ae1aee479aebe9386e0a63c144)`(int fd)` 

close the file or device by its fd .

#### Parameters
*

#### `public ssize_t `[`aos_read`](#vfs_8h_1a1cf12ef52cc88e8e20c5cbbb186a6d56)`(int fd,void * buf,size_t nbytes)` 

read the contents of a file or device into a buffer.

#### Parameters
*

#### `public ssize_t `[`aos_write`](#vfs_8h_1aa1df432533c08eae84f46a50702f4b48)`(int fd,const void * buf,size_t nbytes)` 

write the contents of a buffer to file or device

#### Parameters
*

#### `public int `[`aos_ioctl`](#vfs_8h_1a8133136684b26ab56a9323ae4e7e1f99)`(int fd,int cmd,unsigned long arg)` 

This is a wildcard API for sending controller specific commands.

#### Parameters
*

#### `public int `[`aos_poll`](#vfs_8h_1a03a7a25b0cfac42b7bb65284a3fc1bde)`(struct pollfd * fds,int nfds,int timeout)` 

A mechanism to multiplex input/output over a set of file handles(file descriptors). For every file handle provided, poll() examines it for any events registered for that particular file handle.

#### Parameters
*

#### `public int `[`aos_fcntl`](#vfs_8h_1afd56065fdc737494d0fca200331279dc)`(int fd,int cmd,int val)` 

performs one of the operations described below on the open file descriptor . The operation is determined by .

#### Parameters
*

#### `public off_t `[`aos_lseek`](#vfs_8h_1ac698dbacfd3361e86f4f64b8c8e333e5)`(int fd,off_t offset,int whence)` 

move the file position to a given offset from from a given location

#### Parameters
*

#### `public int `[`aos_sync`](#vfs_8h_1ad678b7cef27c2db4a00fdaeb9faa4ab5)`(int fd)` 

flush any buffers associated with the file

#### Parameters
*

#### `public int `[`aos_stat`](#vfs_8h_1a8e1efc5812e6b42ab3b16437f8737fb6)`(const char * path,struct stat * st)` 

store information about the file in a stat structure

#### Parameters
*

#### `public int `[`aos_unlink`](#vfs_8h_1a7aa7b5d755eb1602425ee011c65e163e)`(const char * path)` 

remove a file from the filesystem.

#### Parameters
*

#### `public int `[`aos_rename`](#vfs_8h_1aafc67bc9a25656f35eea035e36566cd2)`(const char * oldpath,const char * newpath)` 

rename a file in the filesystem.

#### Parameters
*

#### `public `[`aos_dir_t`](#structaos__dir__t)` * `[`aos_opendir`](#vfs_8h_1aa0c6a7f420b357e153995c66dfda39dc)`(const char * path)` 

open a directory on the filesystem

#### Parameters
*

#### `public int `[`aos_closedir`](#vfs_8h_1abcf24fbeac59408f74f5ded76f4575e5)`(`[`aos_dir_t`](#structaos__dir__t)` * dir)` 

#### `public `[`aos_dirent_t`](#structaos__dirent__t)` * `[`aos_readdir`](#vfs_8h_1ab5f5731375aec689bd8365c3dd0300ce)`(`[`aos_dir_t`](#structaos__dir__t)` * dir)` 

#### `public int `[`aos_mkdir`](#vfs_8h_1a81549a9314547bb741f823bc5c5283ed)`(const char * path)` 

create the directory, if they do not already exist.

#### Parameters
*

#### `public int `[`aos_register_event_filter`](#yloop_8h_1ae3324303aa3a911b01709b8e5d106aa5)`(uint16_t type,`[`aos_event_cb`](#yloop_8h_1ae6cbb49016d564e65ca5338cb69d6185)` cb,void * priv)` 

Register system event filter callback.

#### Parameters
* `type` event type interested 

* `aos_event_cb` system event callback 

* `private_data` data to be bypassed to cb 

#### Returns
None

#### `public int `[`aos_unregister_event_filter`](#yloop_8h_1af2001a3071743d68d2f1c6ec151ce6f5)`(uint16_t type,`[`aos_event_cb`](#yloop_8h_1ae6cbb49016d564e65ca5338cb69d6185)` cb,void * priv)` 

Unregister native event callback.

#### Parameters
* `aos_event_cb` system event callback

#### `public int `[`aos_post_event`](#yloop_8h_1ad5da1aeb283d518df00e420c0a9112b7)`(uint16_t type,uint16_t code,unsigned long value)` 

Post local event.

#### Parameters
* `type` event type 

* `code` event code 

* `value` event value 

#### Parameters
* `>0` success 

* `<=0` failure 

**See also**: [input_event_t](#structinput__event__t)

#### `public int `[`aos_poll_read_fd`](#yloop_8h_1a3f457aa0c5536e9e87da66bc606e35cc)`(int fd,`[`aos_poll_call_t`](#yloop_8h_1a7f61fff1d584f548770634ff74b9542c)` action,void * param)` 

Register a poll event in main loop.

#### Parameters
* `fd` poll fd 

* `action` action to be executed 

* `param` private data past to action 

#### Returns
==0 succeed 

#### Returns
!=0 failed

#### `public void `[`aos_cancel_poll_read_fd`](#yloop_8h_1a2dcdc7bf91430300946e0688ae3db02e)`(int fd,`[`aos_poll_call_t`](#yloop_8h_1a7f61fff1d584f548770634ff74b9542c)` action,void * param)` 

Cancel a poll event to be executed in main loop.

#### Parameters
* `fd` poll fd 

* `action` action to be executed 

* `param` private data past to action 

#### Returns
None 

all the parameters must be the same as aos_poll_read_fd

#### `public int `[`aos_post_delayed_action`](#yloop_8h_1a8a48d02d905c2d0c7d7768af7ac0a3d6)`(int ms,`[`aos_call_t`](#yloop_8h_1ad5156dbeffd3153f16cffed15f2a26fe)` action,void * arg)` 

Post a delayed action to be executed in main loop.

#### Parameters
* `ms` milliseconds to wait 

* `action` action to be executed 

* `arg` private data past to action 

#### Returns
==0 succeed 

#### Returns
!=0 failed 

This function must be called under main loop context. after 'action' is fired, resource will be automatically released.

#### `public void `[`aos_cancel_delayed_action`](#yloop_8h_1a7fe6a4f879719ee04d1a24c7f8c73486)`(int ms,`[`aos_call_t`](#yloop_8h_1ad5156dbeffd3153f16cffed15f2a26fe)` action,void * arg)` 

Cancel a delayed action to be executed in main loop.

#### Parameters
* `ms` milliseconds to wait, -1 means don't care 

* `action` action to be executed 

* `arg` private data past to action 

#### Returns
None 

all the parameters must be the same as aos_post_delayed_action

#### `public int `[`aos_schedule_call`](#yloop_8h_1a7016fd75f6deb04517416399dcbbd594)`(`[`aos_call_t`](#yloop_8h_1ad5156dbeffd3153f16cffed15f2a26fe)` action,void * arg)` 

Schedule a callback in next event loop.

#### Parameters
* `action` action to be executed 

* `arg` private data past to action 

#### Parameters
* `>=0` success 

* `<0` failure 

Unlike aos_post_delayed_action, this function can be called from non-aos-main-loop context.

#### `public `[`aos_loop_t`](#yloop_8h_1a654b2a49d4665eeb1d24b1b2195de6a5)` `[`aos_loop_init`](#yloop_8h_1a19622d95d4b65bff57b549e9b8c93155)`(void)` 

init a per-task event loop

#### Parameters
* `None` 

#### Parameters
* `==NULL` failure 

* `!=NULL` success

#### `public `[`aos_loop_t`](#yloop_8h_1a654b2a49d4665eeb1d24b1b2195de6a5)` `[`aos_current_loop`](#yloop_8h_1a0eafe54e0bba4d333828ae02533a28ba)`(void)` 

get current event loop

#### Parameters
* `None` 

#### Parameters
* `default` event loop

#### `public void `[`aos_loop_run`](#yloop_8h_1a67c03238fac573432b77b2a957fad2b9)`(void)` 

start event loop

#### Parameters
* `None` 

#### Parameters
* `None` 

this function won't return until aos_loop_exit called

#### `public void `[`aos_loop_exit`](#yloop_8h_1aad0299c429ba51bfebff02e355773ad9)`(void)` 

exit event loop, [aos_loop_run()](#yloop_8h_1a67c03238fac573432b77b2a957fad2b9) will return

#### Parameters
* `None` 

#### Parameters
* `None` 

this function must be called from the task runninng the event loop

#### `public void `[`aos_loop_destroy`](#yloop_8h_1abbca6051ca7795fb409a32677513635f)`(void)` 

free event loop resources

#### Parameters
* `None` 

#### Parameters
* `None` 

this function should be called after [aos_loop_run()](#yloop_8h_1a67c03238fac573432b77b2a957fad2b9) return

#### `public int `[`aos_loop_schedule_call`](#yloop_8h_1afd6d962757a7b9facf290828ab9b5014)`(`[`aos_loop_t`](#yloop_8h_1a654b2a49d4665eeb1d24b1b2195de6a5)` * loop,`[`aos_call_t`](#yloop_8h_1ad5156dbeffd3153f16cffed15f2a26fe)` action,void * arg)` 

Schedule a callback specified event loop.

#### Parameters
* `loop` event loop to be scheduled, NULL for default main loop 

* `action` action to be executed 

* `arg` private data past to action 

#### Parameters
* `>=0` success 

* `<0` failure 

Unlike aos_post_delayed_action, this function can be called from non-aos-main-loop context.

#### `public void * `[`aos_loop_schedule_work`](#yloop_8h_1adeabf846886d65a22e1780e1060d725b)`(int ms,`[`aos_call_t`](#yloop_8h_1ad5156dbeffd3153f16cffed15f2a26fe)` action,void * arg1,`[`aos_call_t`](#yloop_8h_1ad5156dbeffd3153f16cffed15f2a26fe)` fini_cb,void * arg2)` 

Schedule a work to be executed in workqueue.

#### Parameters
* `ms` milliseconds to delay before execution, 0 means immediately 

* `action` action to be executed 

* `arg1` private data past to action 

* `fini_cb` finish callback to be executed after action is done in current event loop 

* `arg2` private data past to fini_cb 

#### Parameters
* `0` failure 

* `!0` work handle 

this function can be called from non-aos-main-loop context.

#### `public void `[`aos_cancel_work`](#yloop_8h_1a0eb3dd015bc0328943d482f6fab26fee)`(void * work,`[`aos_call_t`](#yloop_8h_1ad5156dbeffd3153f16cffed15f2a26fe)` action,void * arg1)` 

Cancel a work.

#### Parameters
* `work` work to be cancelled 

* `action` action to be cancelled 

* `arg1` private data past to action 

#### Parameters
* `None`

#### `public void `[`hal_ota_register_module`](#ota_8h_1ae04bc1ef38c25b8a9fd3cbb89d01dd7f)`(`[`hal_ota_module_t`](#ota_8h_1a79874c02235fecf1b91f43df20615aba)` * module)` 

Arch register a new module before HAL startup.

#### `public `[`hal_stat_t`](#ota_8h_1a6e643831d8c39930387ae58893022b80)` `[`hal_ota_init`](#ota_8h_1a36b5f7a97e5ba81dc3f203469b9beff7)`()` 

init ota partition

when ota start ,maybe it need init something 

#### Returns
0 : On success. 

#### Returns
1 : If an error occurred with any step

#### `public `[`hal_stat_t`](#ota_8h_1a6e643831d8c39930387ae58893022b80)` `[`hal_ota_write`](#ota_8h_1ac00ef7e39e0f3367a4df0b7f1fd915cf)`(`[`hal_ota_module_t`](#ota_8h_1a79874c02235fecf1b91f43df20615aba)` * m,volatile uint32_t * off_set,uint8_t * in_buf,uint32_t in_buf_len)` 

Write data to an area on ota partition.

#### Parameters
* `m` :Refer the ota module which will be used,default module will be used if value is NULL 

* `off_set` : Point to the start address that the data is written to, and point to the last unwritten address after this function is returned, so you can call this function serval times without update this start address. 

* `inbuf` : point to the data buffer that will be written to flash 

* `in_buf_len` : The length of the buffer

#### Returns
0 : On success. 

#### Returns
1 : If an error occurred with any step

#### `public `[`hal_stat_t`](#ota_8h_1a6e643831d8c39930387ae58893022b80)` `[`hal_ota_read`](#ota_8h_1ab759bbc68bc3388adba4400b629d43dd)`(`[`hal_ota_module_t`](#ota_8h_1a79874c02235fecf1b91f43df20615aba)` * m,volatile uint32_t * off_set,uint8_t * out_buf,uint32_t out_buf_len)` 

Read data from an area on ota Flash to data buffer in RAM.

#### Parameters
* `m` :Refer the ota module which will be used,default module will be used if value is NULL 

* `off_set` : Point to the start address that the data is read, and point to the last unread address after this function is returned, so you can call this function serval times without update this start address. 

* `out_buf` : Point to the data buffer that stores the data read from flash 

* `out_buf_len` : The length of the buffer

#### Returns
0 : On success. 

#### Returns
1 : If an error occurred with any step

#### `public `[`hal_stat_t`](#ota_8h_1a6e643831d8c39930387ae58893022b80)` `[`hal_ota_set_boot`](#ota_8h_1a157e3c5b5601442eb6edd3cb77ca0f6d)`(`[`hal_ota_module_t`](#ota_8h_1a79874c02235fecf1b91f43df20615aba)` * m,void * something)` 

Set boot options when ota reboot.

#### Parameters
* `m` :Refer the ota module which will be used,default module will be used if value is NULL 

* `something` : boot parms 

#### Returns
kNoErr : On success. 

#### Returns
kGeneralErr : If an error occurred with any step

#### `public `[`hal_ota_module_t`](#ota_8h_1a79874c02235fecf1b91f43df20615aba)` * `[`hal_ota_get_default_module`](#ota_8h_1a9027084f6f3e908d38c1c65421bb529c)`(void)` 

Get the default ota module.

#### Returns
return the first registered ota module ,which is the head of module list

#### `public void `[`hal_sensor_register_module`](#sensor_8h_1a4d45c191e22cbddcc7f2d8cd2f3fbe8a)`(`[`hal_sensor_module_t`](#sensor_8h_1abd00ba6504caa64728ba1f70aed57ad4)` * module)` 

Arch register a new module before HAL startup.

#### `public int `[`hal_sensor_init`](#sensor_8h_1ad8e5e6bc01cf056fd3c26c9126b4505e)`(void)` 

HAL sensor init .

#### Returns
return result, 0 if init success, -1 if fail

#### `public int `[`hal_sensor_get_sensor_list`](#sensor_8h_1a38795c14d032c998f64e13e8da0ab541)`(`[`hal_sensor_module_t`](#sensor_8h_1abd00ba6504caa64728ba1f70aed57ad4)` * m,`[`sensor_node_t`](#structsensor__node__t)` const ** list)` 

enbale sensor with type

[in] Refer the sensor module which will be used,default module will be used if value is NULL [in] The list of the sensor which will be return

#### Returns
return num ot sensor, negative value indicates an error

#### `public int `[`hal_sensor_enable`](#sensor_8h_1a2d7da10d08b399eab3d150bc03d0c15d)`(`[`hal_sensor_module_t`](#sensor_8h_1abd00ba6504caa64728ba1f70aed57ad4)` * m,`[`sensor_type`](#sensor_8h_1afa273d6585462db941727d44e9b50320)` type)` 

enable sensor with type

[in] Refer the sensor module which will be used,default module will be used if value is NULL [in] The type of the sensor which must be supplied

#### Returns
return 0 if enable ok, negative value indicates an error

#### `public int `[`hal_sensor_disable`](#sensor_8h_1af70ead5d0558ffc2fd1ec80b9e267d3c)`(`[`hal_sensor_module_t`](#sensor_8h_1abd00ba6504caa64728ba1f70aed57ad4)` * m,`[`sensor_type`](#sensor_8h_1afa273d6585462db941727d44e9b50320)` type)` 

disable sensor with type

[in] Refer the sensor module which will be used,default module will be used if value is NULL [in] The type of the sensor which must be supplied

#### Returns
return 0 if disable ok, negative value indicates an error

#### `public int `[`hal_sensor_read`](#sensor_8h_1a15f8ee6beb053bf33fa77b96113363d2)`(`[`hal_sensor_module_t`](#sensor_8h_1abd00ba6504caa64728ba1f70aed57ad4)` * m,`[`sensor_type`](#sensor_8h_1afa273d6585462db941727d44e9b50320)` type,char * buf,int buf_size)` 

read sensor data when enable sensor

[in] Refer the sensor module which will be used,default module will be used if value is NULL [in] The type of the sensor which must be supplied [in] receive buf for sensor data [in] the size buf of input 
#### Returns
return 0 if read ok, negative value indicates an error

#### `public `[`hal_sensor_module_t`](#sensor_8h_1abd00ba6504caa64728ba1f70aed57ad4)` * `[`hal_sensor_get_default_module`](#sensor_8h_1a5126efa2c800aa8d900fc2775ff971ca)`(void)` 

Get the default sensor module.

#### Returns
return the first registered sensor module ,which is the head of module list

#### `public `[`hal_sensor_module_t`](#sensor_8h_1abd00ba6504caa64728ba1f70aed57ad4)` * `[`hal_sensor_get_next_module`](#sensor_8h_1a94e69d6b8eeca793904cde6b9fa45ae0)`(`[`hal_sensor_module_t`](#sensor_8h_1abd00ba6504caa64728ba1f70aed57ad4)` * m)` 

Get the next sensor HAL

The system may have more than 1 sensor HAL instances.

#### Returns
Instance pointer or NULL

#### `public int32_t `[`hal_adc_init`](#adc_8h_1ac1bde467ed8ffbb24747442d60c888c0)`(`[`adc_dev_t`](#structadc__dev__t)` * adc)` 

Initialises an ADC interface

Prepares an ADC hardware interface for sampling

#### Parameters
* `adc` : the interface which should be initialised

#### Returns
0 : on success. 

#### Returns
EIO : if an error occurred with any step

#### `public int32_t `[`hal_adc_value_get`](#adc_8h_1a9fcd2b50607d73642515034cd4ea21ac)`(`[`adc_dev_t`](#structadc__dev__t)` * adc,void * output,uint32_t timeout)` 

Takes a single sample from an ADC interface

Takes a single sample from an ADC interface

#### Parameters
* `adc` : the interface which should be sampled 

* `output` : pointer to a variable which will receive the sample 

* `timeout` : ms timeout 

#### Returns
0 : on success. 

#### Returns
EIO : if an error occurred with any step

#### `public int32_t `[`hal_adc_finalize`](#adc_8h_1a0bd4fcde73ce5792ee9cdd96b6bf999a)`(`[`adc_dev_t`](#structadc__dev__t)` * adc)` 

De-initialises an ADC interface

Turns off an ADC hardware interface

#### Parameters
* `adc` : the interface which should be de-initialised

#### Returns
0 : on success. 

#### Returns
EIO : if an error occurred with any step

#### `public `[`hal_logic_partition_t`](#structhal__logic__partition__t)` * `[`hal_flash_get_info`](#flash_8h_1a953a4ec1ce382dde733219f6e83c6e1b)`(`[`hal_partition_t`](#flash_8h_1a1ff07b8a9c096b1b8ca7847be7c6e097)` in_partition)` 

Get the infomation of the specified flash area.

#### Parameters
* `in_partition` The target flash logical partition which should be erased

#### Returns
HAL_logi_partition struct

#### `public int32_t `[`hal_flash_erase`](#flash_8h_1a3d3a2ca9f773c996517b5e57882146a1)`(`[`hal_partition_t`](#flash_8h_1a1ff07b8a9c096b1b8ca7847be7c6e097)` in_partition,uint32_t off_set,uint32_t size)` 

Erase an area on a Flash logical partition.

Erase on an address will erase all data on a sector that the address is belonged to, this function does not save data that beyond the address area but in the affected sector, the data will be lost.

#### Parameters
* `in_partition` : The target flash logical partition which should be erased 

* `off_set` : Start address of the erased flash area 

* `size` : Size of the erased flash area

#### Returns
0 : On success. 

#### Returns
EIO : If an error occurred with any step

#### `public int32_t `[`hal_flash_write`](#flash_8h_1a113a623b5268888f7e52e2655da69419)`(`[`hal_partition_t`](#flash_8h_1a1ff07b8a9c096b1b8ca7847be7c6e097)` in_partition,uint32_t * off_set,const void * in_buf,uint32_t in_buf_len)` 

Write data to an area on a Flash logical partition.

#### Parameters
* `in_partition` : The target flash logical partition which should be read which should be written 

* `off_set` : Point to the start address that the data is written to, and point to the last unwritten address after this function is returned, so you can call this function serval times without update this start address. 

* `inBuffer` : point to the data buffer that will be written to flash 

* `inBufferLength` : The length of the buffer

#### Returns
0 : On success. 

#### Returns
EIO : If an error occurred with any step

#### `public int32_t `[`hal_flash_read`](#flash_8h_1aa0b51f3833bf23e62753d5cc46c47bba)`(`[`hal_partition_t`](#flash_8h_1a1ff07b8a9c096b1b8ca7847be7c6e097)` in_partition,uint32_t * off_set,void * out_buf,uint32_t in_buf_len)` 

Read data from an area on a Flash to data buffer in RAM.

#### Parameters
* `in_partition` : The target flash logical partition which should be read 

* `off_set` : Point to the start address that the data is read, and point to the last unread address after this function is returned, so you can call this function serval times without update this start address. 

* `outBuffer` : Point to the data buffer that stores the data read from flash 

* `inBufferLength` : The length of the buffer

#### Returns
0 : On success. 

#### Returns
EIO : If an error occurred with any step

#### `public int32_t `[`hal_flash_enable_secure`](#flash_8h_1a7eddbd75e2521d13a29d4e8c27ece172)`(`[`hal_partition_t`](#flash_8h_1a1ff07b8a9c096b1b8ca7847be7c6e097)` partition,uint32_t off_set,uint32_t size)` 

Set security options on a logical partition.

#### Parameters
* `partition` : The target flash logical partition 

* `offset` : Point to the start address that the data is read, and point to the last unread address after this function is returned, so you can call this function serval times without update this start address. 

* `size` : Size of enabled flash area

#### Returns
0 : On success. 

#### Returns
EIO : If an error occurred with any step

#### `public int32_t `[`hal_flash_dis_secure`](#flash_8h_1a337f2c48f9b8b022f5626905850a4112)`(`[`hal_partition_t`](#flash_8h_1a1ff07b8a9c096b1b8ca7847be7c6e097)` partition,uint32_t off_set,uint32_t size)` 

Disable security options on a logical partition.

#### Parameters
* `partition` : The target flash logical partition 

* `offset` : Point to the start address that the data is read, and point to the last unread address after this function is returned, so you can call this function serval times without update this start address. 

* `size` : Size of disabled flash area

#### Returns
0 : On success. 

#### Returns
EIO : If an error occurred with any step

#### `public int32_t `[`hal_gpio_init`](#gpio_8h_1ac57ec79537271096af3777e1c45c544b)`(`[`gpio_dev_t`](#structgpio__dev__t)` * gpio)` 

Initialises a GPIO pin.

Prepares a GPIO pin for use.

#### Parameters
* `gpio` : the gpio pin which should be initialised 

* `configuration` : A structure containing the required gpio configuration

#### Returns
0 : on success. 

#### Returns
EIO : if an error occurred with any step

#### `public int32_t `[`hal_gpio_output_high`](#gpio_8h_1a62e07155dba33b68f93fc1ba59c70e01)`(`[`gpio_dev_t`](#structgpio__dev__t)` * gpio)` 

Sets an output GPIO pin high.

Using this function on a gpio pin which is set to input mode is undefined.

#### Parameters
* `gpio` : the gpio pin which should be set high

#### Returns
0 : on success. 

#### Returns
EIO : if an error occurred with any step

#### `public int32_t `[`hal_gpio_output_low`](#gpio_8h_1af08f7d3868b152865f233024d03a5cbf)`(`[`gpio_dev_t`](#structgpio__dev__t)` * gpio)` 

Sets an output GPIO pin low.

Using this function on a gpio pin which is set to input mode is undefined.

#### Parameters
* `gpio` : the gpio pin which should be set low

#### Returns
0 : on success. 

#### Returns
EIO : if an error occurred with any step

#### `public int32_t `[`hal_gpio_output_toggle`](#gpio_8h_1a1e54c6ad05ddbbc3d71a81420f4fe3c9)`(`[`gpio_dev_t`](#structgpio__dev__t)` * gpio)` 

Trigger an output GPIO pin

Trigger an output GPIO pin's output. Using this function on a gpio pin which is set to input mode is undefined.

#### Parameters
* `gpio` : the gpio pin which should be set low

#### Returns
0 : on success. 

#### Returns
EIO : if an error occurred with any step

#### `public int8_t `[`hal_gpio_input_get`](#gpio_8h_1a781421b55faf20bc846088eb2f25b0a0)`(`[`gpio_dev_t`](#structgpio__dev__t)` * gpio,uint32_t * value)` 

Get the state of an input GPIO pin.

Get the state of an input GPIO pin. Using this function on a gpio pin which is set to output mode will return an undefined value.

#### Parameters
* `gpio` : the gpio pin which should be read 

* `value` : gpio value 

#### Returns
0 : on success 

#### Returns
EIO : if an error occurred with any step

#### `public int32_t `[`hal_gpio_enable_irq`](#gpio_8h_1ac4c46681d4431397cf3780d29ee49810)`(`[`gpio_dev_t`](#structgpio__dev__t)` * gpio,`[`gpio_irq_trigger_t`](#gpio_8h_1aa3de939093227b362c7ea6d942ecae9d)` trigger,`[`gpio_irq_handler_t`](#gpio_8h_1a6c24dd1a7635d1d71b38a99ec7f556a9)` handler,void * arg)` 

Enables an interrupt trigger for an input GPIO pin.

Enables an interrupt trigger for an input GPIO pin. Using this function on a gpio pin which is set to output mode is undefined.

#### Parameters
* `gpio` : the gpio pin which will provide the interrupt trigger 

* `trigger` : the type of trigger (rising/falling edge) 

* `handler` : a function pointer to the interrupt handler 

* `arg` : an argument that will be passed to the interrupt handler

#### Returns
0 : on success. 

#### Returns
EIO : if an error occurred with any step

#### `public int32_t `[`hal_gpio_disable_irq`](#gpio_8h_1a59745b705cd8ca10a0618eb98250f6ac)`(`[`gpio_dev_t`](#structgpio__dev__t)` * gpio)` 

Disables an interrupt trigger for an input GPIO pin.

Disables an interrupt trigger for an input GPIO pin. Using this function on a gpio pin which has not been set up using hal_gpio_input_irq_enable is undefined.

#### Parameters
* `gpio` : the gpio pin which provided the interrupt trigger

#### Returns
0 : on success. 

#### Returns
EIO : if an error occurred with any step

#### `public int32_t `[`hal_gpio_clear_irq`](#gpio_8h_1aba2eed8dca6ec95f136ce990d64912ac)`(`[`gpio_dev_t`](#structgpio__dev__t)` * gpio)` 

Disables an interrupt trigger for an input GPIO pin.

Disables an interrupt trigger for an input GPIO pin. Using this function on a gpio pin which has not been set up using hal_gpio_input_irq_enable is undefined.

#### Parameters
* `gpio` : the gpio pin which provided the interrupt trigger

#### Returns
0 : on success. 

#### Returns
EIO : if an error occurred with any step

#### `public int32_t `[`hal_gpio_finalize`](#gpio_8h_1a9e97bba47999735b48c7e35e1d786ca1)`(`[`gpio_dev_t`](#structgpio__dev__t)` * gpio)` 

DeInitialises a GPIO pin.

Set a GPIO pin in default state.

#### Parameters
* `gpio` : the gpio pin which should be deinitialised

#### Returns
0 : on success. 

#### Returns
EIO : if an error occurred with any step

#### `public int32_t `[`hal_i2c_init`](#i2c_8h_1a4ab0930e597f8c6356f1c3df72e5f542)`(`[`i2c_dev_t`](#structi2c__dev__t)` * i2c)` 

Initialises an I2C interface.

Prepares an I2C hardware interface for communication as a master or slave

#### Parameters
* `device` : the device for which the i2c port should be initialised 

#### Returns
0 : on success. 

#### Returns
EIO : if an error occurred during initialisation

#### `public int32_t `[`hal_i2c_master_send`](#i2c_8h_1ae17c7459872ec0d1d32ecd9bee53a488)`(`[`i2c_dev_t`](#structi2c__dev__t)` * i2c,uint16_t dev_addr,uint8_t * data,uint16_t size,uint32_t timeout)` 

i2c master send

#### Parameters
* `i2c` : the i2c device 

* `dev_addr` : device address 

* `data` : i2c send data 

* `size` : i2c send data size 

* `timeout` : timeout in ms 

#### Returns
0 : on success. 

#### Returns
EIO : if an error occurred during initialisation

#### `public int32_t `[`hal_i2c_master_recv`](#i2c_8h_1a68e2d241b51e4b1850746ca7d6ff64e3)`(`[`i2c_dev_t`](#structi2c__dev__t)` * i2c,uint16_t dev_addr,uint8_t * data,uint16_t size,uint32_t timeout)` 

i2c master recv

#### Parameters
* `i2c` : the i2c device 

* `dev_addr` : device address 

* `data` : i2c receive data 

* `size` : i2c receive data size 

* `timeout` : timeout in ms 

#### Returns
0 : on success. 

#### Returns
EIO : if an error occurred during initialisation

#### `public int32_t `[`hal_i2C_slave_send`](#i2c_8h_1a373a4789903405c6c175f98bd3bb1433)`(`[`i2c_dev_t`](#structi2c__dev__t)` * i2c,uint8_t * data,uint16_t size,uint32_t timeout)` 

hal_i2C_slave_send

#### Parameters
* `i2c` : the i2c device 

* `data` : i2c slave send data 

* `size` : i2c slave send data size 

* `timeout` : timeout in ms 

#### Returns
0 : on success. 

#### Returns
EIO : if an error occurred during initialisation

#### `public int32_t `[`hal_i2c_slave_recv`](#i2c_8h_1ae0e628510faec1a53f895293f7708141)`(`[`i2c_dev_t`](#structi2c__dev__t)` * i2c,uint8_t * data,uint16_t size,uint32_t timeout)` 

Initialises an I2C interface.

#### Parameters
* `i2c` : tthe i2c device 

* `data` : i2c slave receive data 

* `size` : i2c slave receive data size 

* `timeout` : timeout in ms 

#### Returns
0 : on success. 

#### Returns
EIO : if an error occurred during initialisation

#### `public int32_t `[`hal_i2c_mem_write`](#i2c_8h_1aef74611174cc14fda761d39b544a0ecd)`(`[`i2c_dev_t`](#structi2c__dev__t)` * i2c,uint16_t dev_addr,uint16_t mem_addr,uint16_t mem_addr_size,uint8_t * data,uint16_t size,uint32_t timeout)` 

i2c mem write

#### Parameters
* `i2c` : the i2c device 

* `dev_addr` : device address 

* `mem_addr` : mem address 

* `mem_addr_size` : mem address 

* `data` : i2c master send data 

* `size` : i2c master send data size 

* `timeout` : timeout in ms 

#### Returns
0 : on success. 

#### Returns
EIO : if an error occurred during initialisation

#### `public int32_t `[`hal_i2c_mem_read`](#i2c_8h_1af4cb082a770305a10c3f73471a2505b5)`(`[`i2c_dev_t`](#structi2c__dev__t)` * i2c,uint16_t dev_addr,uint16_t mem_addr,uint16_t mem_addr_size,uint8_t * data,uint16_t size,uint32_t timeout)` 

i2c master mem read

#### Parameters
* `i2c` : the i2c device 

* `dev_addr` : device address 

* `mem_addr` : mem address 

* `mem_addr_size` : mem address 

* `data` : i2c master send data 

* `size` : i2c master send data size 

* `timeout` : timeout in ms 

#### Returns
0 : on success. 

#### Returns
EIO : if an error occurred during initialisation

#### `public int32_t `[`hal_i2c_finalize`](#i2c_8h_1a569cc76c576b14ee6f501dfe8982936a)`(`[`i2c_dev_t`](#structi2c__dev__t)` * i2c)` 

Deinitialises an I2C device.

#### Parameters
* `device` : the i2c device 

#### Returns
0 : on success. 

#### Returns
EIO : if an error occurred during deinitialisation

#### `public int32_t `[`hal_pwm_init`](#pwm_8h_1a3efaaee5a76c75a33617a68efa5e31fc)`(`[`pwm_dev_t`](#structpwm__dev__t)` * pwm)` 

Initialises a PWM pin.

Prepares a Pulse-Width Modulation pin for use. Does not start the PWM output (use MicoPwmStart).

#### Parameters
* `pwm` : the PWM device 

#### Returns
0 : on success. 

#### Returns
EIO : if an error occurred with any step

#### `public int32_t `[`hal_pwm_start`](#pwm_8h_1a7789f0b361e257a3039a024c5e7f7f58)`(`[`pwm_dev_t`](#structpwm__dev__t)` * pwm)` 

Starts PWM output on a PWM interface.

Starts Pulse-Width Modulation signal output on a PWM pin

#### Parameters
* `pwm` : the PWM device 

#### Returns
0 : on success. 

#### Returns
EIO : if an error occurred with any step

#### `public int32_t `[`hal_pwm_stop`](#pwm_8h_1a6f00e8ed683f28dead5f9e806c591ca0)`(`[`pwm_dev_t`](#structpwm__dev__t)` * pwm)` 

Stops output on a PWM pin.

Stops Pulse-Width Modulation signal output on a PWM pin

#### Parameters
* `pwm` : the PWM device 

#### Returns
0 : on success. 

#### Returns
EIO : if an error occurred with any step

#### `public int32_t `[`hal_random_num_read`](#rng_8h_1a720a55ef8b558ac9818aaaaf1a99837c)`(`[`random_dev_t`](#structrandom__dev__t)` random,void * in_buf,int32_t bytes)` 

Fill in a memory buffer with random data.

#### Parameters
* `random` : the random device 

* `inBuffer` : Point to a valid memory buffer, this function will fill in this memory with random numbers after executed 

* `inByteCount` : Length of the memory buffer (bytes)

#### Returns
0 : on success. 

#### Returns
EIO : if an error occurred with any step

#### `public void `[`hal_rtc_init`](#rtc_8h_1a630bfe4df4611ac545d75d335cb84a3e)`(`[`rtc_dev_t`](#structrtc__dev__t)` * rtc)` 

This function will initialize the on board CPU real time clock.

This function should be called by MICO system when initializing clocks, so It is not needed to be called by application 

#### Parameters
* `rtc` : rtc device 

#### Returns
0 : on success. 

#### Returns
EIO : if an error occurred with any step

#### `public int32_t `[`hal_rtc_get_time`](#rtc_8h_1a90a23a2ef5852bcbd5f2a13d2dc4e358)`(`[`rtc_dev_t`](#structrtc__dev__t)` * rtc,`[`rtc_time_t`](#structrtc__time__t)` * time)` 

This function will return the value of time read from the on board CPU real time clock. Time value must be given in the format of the structure hal_rtc_time_t.

#### Parameters
* `rtc` : rtc device 

* `time` : pointer to a time structure

#### Returns
0 : on success. 

#### Returns
EIO : if an error occurred with any step

#### `public int32_t `[`hal_rtc_set_time`](#rtc_8h_1ad5258cee7509b7499d1005079244f42d)`(`[`rtc_dev_t`](#structrtc__dev__t)` * rtc,`[`rtc_time_t`](#structrtc__time__t)` * time)` 

This function will set MCU RTC time to a new value. Time value must be given in the format of the structure hal_rtc_time_t.

#### Parameters
* `rtc` : rtc device 

* `time` : pointer to a time structure

#### Returns
0 : on success. 

#### Returns
EIO : if an error occurred with any step

#### `public int32_t `[`hal_spi_init`](#spi_8h_1a4b4db09ed0654e035de01ecf137bc7a7)`(`[`spi_dev_t`](#structspi__dev__t)` * spi)` 

Initialises the SPI interface for a given SPI device.

Prepares a SPI hardware interface for communication as a master

#### Parameters
* `spi` : the spi device 

#### Returns
0 : on success. 

#### Returns
EIO : if the SPI device could not be initialised

#### `public int32_t `[`hal_spi_send`](#spi_8h_1a9cfd278d57d98559f13fa5a2e534b148)`(`[`spi_dev_t`](#structspi__dev__t)` * spi,uint8_t * data,uint16_t size,uint32_t timeout)` 

spi_send

#### Parameters
* `spi` : the spi device 

* `data` : spi send data 

* `size` : spi send data size 

* `timeout` : timeout in ms 

#### Returns
0 : on success. 

#### Returns
EIO : if the SPI device could not be initialised

#### `public int32_t `[`hal_spi_recv`](#spi_8h_1ab6aa5dc6e45d8520cd02749fbbe9a269)`(`[`spi_dev_t`](#structspi__dev__t)` * spi,uint8_t * data,uint16_t size,uint32_t timeout)` 

spi_recv

#### Parameters
* `spi` : the spi device 

* `data` : spi recv data 

* `size` : spi recv data size 

* `timeout` : timeout in ms 

#### Returns
0 : on success. 

#### Returns
EIO : if the SPI device could not be initialised

#### `public int32_t `[`hal_spi_send_recv`](#spi_8h_1ab5782dc347f5f8fbfe9b30e24c1590bb)`(`[`spi_dev_t`](#structspi__dev__t)` * spi,uint8_t * tx_data,uint16_t tx_size,uint8_t * rx_data,uint16_t rx_size,uint32_t timeout)` 

spi send data and recv

#### Parameters
* `spi` : the spi device 

* `tx_data` : spi send data 

* `rx_data` : spi recv data 

* `tx_size` : spi data to be sent 

* `rx_size` : spi data to be recv 

* `timeout` : timeout in ms 

#### Returns
kNoErr : on success. 

#### Returns
kGeneralErr : if the SPI device could not be initialised

#### `public int32_t `[`hal_spi_finalize`](#spi_8h_1af6f3489747e78677520c0f925eb817ef)`(`[`spi_dev_t`](#structspi__dev__t)` * spi)` 

De-initialises a SPI interface.

Turns off a SPI hardware interface

#### Parameters
* `spi` : the SPI device to be de-initialised

#### Returns
0 : on success. 

#### Returns
EIO : if an error occurred

#### `public void `[`hal_timer_init`](#timer_8h_1a1a01785016b4d418c3d2628a3cbfdb9e)`(`[`hal_timer_t`](#structhal__timer__t)` * tmr,unsigned int period,unsigned char auto_reload,unsigned char ch,`[`hal_timer_cb_t`](#timer_8h_1a9b138d5db3c7e07032743eddcadc5f4c)` cb,void * arg)` 

init a hardware timer

#### Parameters
* `tmr` timer struct 

* `period` micro seconds for repeat timer trigger 

* `auto_reoad` set to 0, if you just need oneshot timer 

* `cb` callback to be triggered after useconds  timer channel 

* `arg` passed to cb 

period auto auto auto *----|-----|-----|-----|

#### `public int32_t `[`hal_timer_start`](#timer_8h_1a9403a0f2305d71b5c273a75b101d741f)`(`[`hal_timer_t`](#structhal__timer__t)` * tmr)` 

init a hardware timer

#### Parameters
* `None` 

#### Parameters
* `0` == success EIO == failure

#### `public void `[`hal_timer_stop`](#timer_8h_1ad1a680cfce89b4d45e5256182159ac8d)`(`[`hal_timer_t`](#structhal__timer__t)` * tmr)` 

stop a hardware timer

#### Parameters
* `tmr` timer struct 

* `cb` callback to be triggered after useconds 

* `arg` passed to cb

#### `public int32_t `[`hal_uart_init`](#uart_8h_1ac1cd14ca3a6309b8415af1e1116162ad)`(`[`uart_dev_t`](#structuart__dev__t)` * uart)` 

Initialises a UART interface.

Prepares an UART hardware interface for communications

#### Parameters
* `uart` : the interface which should be initialised 

* `config` : UART configuration structure 

* `optional_rx_buffer` : Pointer to an optional RX ring buffer

#### Returns
0 : on success. 

#### Returns
EIO : if an error occurred with any step

#### `public int32_t `[`hal_uart_send`](#uart_8h_1ab24afb895d0984c443fe3a89c4dcd5a8)`(`[`uart_dev_t`](#structuart__dev__t)` * uart,void * data,uint32_t size,uint32_t timeout)` 

Transmit data on a UART interface.

#### Parameters
* `uart` : the UART interface 

* `data` : pointer to the start of data 

* `size` : number of bytes to transmit

#### Returns
0 : on success. 

#### Returns
EIO : if an error occurred with any step

#### `public int32_t `[`hal_uart_recv`](#uart_8h_1aa28ee6a023473235f91d882c1db0430a)`(`[`uart_dev_t`](#structuart__dev__t)` * uart,void * data,uint32_t expect_size,uint32_t * recv_size,uint32_t timeout)` 

Receive data on a UART interface.

#### Parameters
* `uart` : the UART interface 

* `data` : pointer to the buffer which will store incoming data 

* `size` : number of bytes to receive 

* `timeout` : timeout in milisecond

#### Returns
0 : on success. 

#### Returns
EIO : if an error occurred with any step

#### `public int32_t `[`hal_uart_finalize`](#uart_8h_1afd25ecf40a406f15b79534fee86e4271)`(`[`uart_dev_t`](#structuart__dev__t)` * uart)` 

Deinitialises a UART interface.

#### Parameters
* `uart` : the interface which should be deinitialised

#### Returns
0 : on success. 

#### Returns
EIO : if an error occurred with any step

#### `public int32_t `[`hal_wdg_init`](#wdg_8h_1ae8d1d233f207b0dafb967e0a50fcad6b)`(`[`wdg_dev_t`](#structwdg__dev__t)` * wdg)` 

This function will initialize the on board CPU hardware watch dog 
#### Parameters
* `wdg` : the watch dog device 

#### Returns
0 : on success. 

#### Returns
EIO : if an error occurred with any step

#### `public void `[`hal_wdg_reload`](#wdg_8h_1a9fe79ef45a21dd5c6f1199eda5e21253)`(`[`wdg_dev_t`](#structwdg__dev__t)` * wdg)` 

Reload watchdog counter. 
#### Parameters
* `wdg` : the watch dog device 

* `none` 

#### Returns
none

#### `public int32_t `[`hal_wdg_finalize`](#wdg_8h_1ada475e22a5cdf6a261a5e6f56d5b9214)`(`[`wdg_dev_t`](#structwdg__dev__t)` * wdg)` 

This function performs any platform-specific cleanup needed for hardware watch dog. 
#### Parameters
* `wdg` : the watch dog device 

#### Returns
0 : on success. 

#### Returns
EIO : if an error occurred with any step

#### `public void * `[`trace_hal_init`](#trace_8h_1a97528b8c8622b9a882552c26402ea561)`(void)` 

#### `public ssize_t `[`trace_hal_send`](#trace_8h_1a723b3bcc8f7ffdb612127ef3d768fbe3)`(void * handle,void * buf,size_t len)` 

#### `public ssize_t `[`trace_hal_recv`](#trace_8h_1ae95a981721aa0ab5d7b92408d49afb9a)`(void * handle,void * buf)` 

#### `public void `[`trace_hal_deinit`](#trace_8h_1ab514b3d34cdc784dab7498f5c9574866)`(void * handle)` 

#### `public `[`hal_wifi_module_t`](#structhal__wifi__module__t)` * `[`hal_wifi_get_default_module`](#group__aos__hal__wifi_1ga566b8f91f7325b94b2672af6ee9e9792)`(void)` 

Get the default wifi instance. The system may have more than 1 wifi instance, this API return the default one.

#### Parameters
* `None` 

#### Parameters
* `==NULL` no instances registered 

* `!=NULL` instance pointer

#### `public void `[`hal_wifi_register_module`](#group__aos__hal__wifi_1gae63e89d8196178248779fac0acdbddf4)`(`[`hal_wifi_module_t`](#structhal__wifi__module__t)` * m)` 

Regster a wifi instance to the HAL Framework.

#### Parameters
* `module` the wifi instance 

#### Returns
None

#### `public int `[`hal_wifi_init`](#group__aos__hal__wifi_1gad0f9198f876afee6ec2fa498c853fd2e)`(void)` 

Initialize WiFi instances 
#### Parameters
* `None` 

#### Parameters
* `==` 0 success 

* `!=0` failure 

This is supposed to be called during system boot, not supposed to be called by user module directly

#### `public void `[`hal_wifi_get_mac_addr`](#group__aos__hal__wifi_1ga6d6d2c8d07f5b80b9f0c23f3d05ace80)`(`[`hal_wifi_module_t`](#structhal__wifi__module__t)` * m,uint8_t * mac)` 

#### `public int `[`hal_wifi_start`](#group__aos__hal__wifi_1ga4fb4774e8247d115d457eed457acb9b6)`(`[`hal_wifi_module_t`](#structhal__wifi__module__t)` * m,`[`hal_wifi_init_type_t`](#structhal__wifi__init__type__t)` * init_para)` 

#### `public int `[`hal_wifi_start_adv`](#group__aos__hal__wifi_1ga694965de667c13b1380fda9eedda1601)`(`[`hal_wifi_module_t`](#structhal__wifi__module__t)` * m,`[`hal_wifi_init_type_adv_t`](#structhal__wifi__init__type__adv__t)` * init_para_adv)` 

#### `public int `[`hal_wifi_get_ip_stat`](#group__aos__hal__wifi_1ga05cb0f3bdfcf73dcb862c894aef1c355)`(`[`hal_wifi_module_t`](#structhal__wifi__module__t)` * m,`[`hal_wifi_ip_stat_t`](#structhal__wifi__ip__stat__t)` * out_net_para,`[`hal_wifi_type_t`](#group__aos__hal__wifi_1ga9c6cd73d1b386384fea4dc5be8a25adc)` wifi_type)` 

#### `public int `[`hal_wifi_get_link_stat`](#group__aos__hal__wifi_1gad21b72cfba15bc51dc232ff1d7b8e3e3)`(`[`hal_wifi_module_t`](#structhal__wifi__module__t)` * m,`[`hal_wifi_link_stat_t`](#structhal__wifi__link__stat__t)` * out_stat)` 

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

#### Parameters
* `m` The wifi instance, NULL for default 

* `cb` The event callback function info 

#### Returns
None 

Please don't do time consuming work in these callbacks

# struct `adc_config_t` 

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
`public uint32_t `[`sampling_cycle`](#structadc__config__t_1ac5c9b2b7036d07a1c39ca25d8c9b061d) | 

## Members

#### `public uint32_t `[`sampling_cycle`](#structadc__config__t_1ac5c9b2b7036d07a1c39ca25d8c9b061d) 

# struct `adc_dev_t` 

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
`public uint8_t `[`adc`](#structadc__dev__t_1a8f15e732d516d397c43cd1cac8e46dae) | 
`public `[`adc_config_t`](#structadc__config__t)` `[`config`](#structadc__dev__t_1ab7bffa841d196c594823699aeeb7d992) | 
`public void * `[`priv`](#structadc__dev__t_1a0cc268164670dc249fc85611c144bc3b) | 

## Members

#### `public uint8_t `[`adc`](#structadc__dev__t_1a8f15e732d516d397c43cd1cac8e46dae) 

#### `public `[`adc_config_t`](#structadc__config__t)` `[`config`](#structadc__dev__t_1ab7bffa841d196c594823699aeeb7d992) 

#### `public void * `[`priv`](#structadc__dev__t_1a0cc268164670dc249fc85611c144bc3b) 

# struct `aos_dir_t` 

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
`public int `[`dd_vfs_fd`](#structaos__dir__t_1acc32cb2c98e7ca1e018a45e6f114dc80) | 
`public int `[`dd_rsv`](#structaos__dir__t_1a7ef5d0af21144f997372f1928fd999ec) | 

## Members

#### `public int `[`dd_vfs_fd`](#structaos__dir__t_1acc32cb2c98e7ca1e018a45e6f114dc80) 

#### `public int `[`dd_rsv`](#structaos__dir__t_1a7ef5d0af21144f997372f1928fd999ec) 

# struct `aos_dirent_t` 

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
`public int `[`d_ino`](#structaos__dirent__t_1a9bd680fca6d1f7d3f796562fbff3a677) | 
`public uint8_t `[`d_type`](#structaos__dirent__t_1a652a204c017b603d885a8bf7ffd07662) | 
`public char `[`d_name`](#structaos__dirent__t_1ad46b4f591981d2611b9d0a0b7ef4f27f) | 

## Members

#### `public int `[`d_ino`](#structaos__dirent__t_1a9bd680fca6d1f7d3f796562fbff3a677) 

#### `public uint8_t `[`d_type`](#structaos__dirent__t_1a652a204c017b603d885a8bf7ffd07662) 

#### `public char `[`d_name`](#structaos__dirent__t_1ad46b4f591981d2611b9d0a0b7ef4f27f) 

# struct `aos_hdl_t` 

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
`public void * `[`hdl`](#structaos__hdl__t_1aeb48605dca77e2ab6c6571a9b251fad9) | 

## Members

#### `public void * `[`hdl`](#structaos__hdl__t_1aeb48605dca77e2ab6c6571a9b251fad9) 

# struct `aos_workqueue_t` 

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
`public void * `[`hdl`](#structaos__workqueue__t_1a536dc4eb26cd55cf55146b7b1e5fbda9) | 
`public void * `[`stk`](#structaos__workqueue__t_1a446b911dfebeae3743dde27ad07b7821) | 

## Members

#### `public void * `[`hdl`](#structaos__workqueue__t_1a536dc4eb26cd55cf55146b7b1e5fbda9) 

#### `public void * `[`stk`](#structaos__workqueue__t_1a446b911dfebeae3743dde27ad07b7821) 

# struct `boot_table_t` 

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
`public uint32_t `[`start_address`](#structboot__table__t_1a38829ad8570cc9ad3f59e3c928e02ea9) | 
`public uint32_t `[`length`](#structboot__table__t_1a12590d63f9180d90e072fc6dd47fbbc5) | 
`public uint8_t `[`version`](#structboot__table__t_1a4b2fc6e18945aecf679b8dd817b1b07d) | 
`public uint8_t `[`type`](#structboot__table__t_1aa8ae40f4598a6658af8464f32529b790) | 
`public uint8_t `[`upgrade_type`](#structboot__table__t_1a23f09774844ddb42c26af0e6091bdc6f) | 
`public uint16_t `[`crc`](#structboot__table__t_1a0decc9ccb49f195a76948ff79c32534b) | 
`public uint8_t `[`reserved`](#structboot__table__t_1af02f384553742a35f956e59cead43507) | 

## Members

#### `public uint32_t `[`start_address`](#structboot__table__t_1a38829ad8570cc9ad3f59e3c928e02ea9) 

#### `public uint32_t `[`length`](#structboot__table__t_1a12590d63f9180d90e072fc6dd47fbbc5) 

#### `public uint8_t `[`version`](#structboot__table__t_1a4b2fc6e18945aecf679b8dd817b1b07d) 

#### `public uint8_t `[`type`](#structboot__table__t_1aa8ae40f4598a6658af8464f32529b790) 

#### `public uint8_t `[`upgrade_type`](#structboot__table__t_1a23f09774844ddb42c26af0e6091bdc6f) 

#### `public uint16_t `[`crc`](#structboot__table__t_1a0decc9ccb49f195a76948ff79c32534b) 

#### `public uint8_t `[`reserved`](#structboot__table__t_1af02f384553742a35f956e59cead43507) 

# struct `cli_command` 

Structure for registering CLI commands

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
`public const char * `[`name`](#structcli__command_1a83cc311c7d2e771e1b095e7fe487cd08) | The name of the CLI command
`public const char * `[`help`](#structcli__command_1aae28593ccc4863d9e56ef0a45d6dfd93) | The help text associated with the command
`public void(* `[`function`](#structcli__command_1a62db0c7aba24d582e62d5d321e115de1) | The function that should be invoked for this command.

## Members

#### `public const char * `[`name`](#structcli__command_1a83cc311c7d2e771e1b095e7fe487cd08) 

The name of the CLI command

#### `public const char * `[`help`](#structcli__command_1aae28593ccc4863d9e56ef0a45d6dfd93) 

The help text associated with the command

#### `public void(* `[`function`](#structcli__command_1a62db0c7aba24d582e62d5d321e115de1) 

The function that should be invoked for this command.

# struct `cli_st` 

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
`public int `[`initialized`](#structcli__st_1aa165bb8d705f8162fdef9caf248e9d24) | 
`public const struct `[`cli_command`](#structcli__command)` * `[`commands`](#structcli__st_1ae6267c542eb3ea592f7b84cc3963acce) | 
`public unsigned int `[`num_commands`](#structcli__st_1a2720d0c5493080bb0de32a08980aa3be) | 
`public int `[`echo_disabled`](#structcli__st_1a358ff9f628880448c1dcfefa7fe124a7) | 
`public unsigned int `[`bp`](#structcli__st_1a18ec0d6b894c3ca6f69f18ba72193b2d) | 
`public char `[`inbuf`](#structcli__st_1a96b76565516c442eb570f6a0c5f458a0) | 
`public char `[`outbuf`](#structcli__st_1a8cddb6553f21346e722581d363532314) | 

## Members

#### `public int `[`initialized`](#structcli__st_1aa165bb8d705f8162fdef9caf248e9d24) 

#### `public const struct `[`cli_command`](#structcli__command)` * `[`commands`](#structcli__st_1ae6267c542eb3ea592f7b84cc3963acce) 

#### `public unsigned int `[`num_commands`](#structcli__st_1a2720d0c5493080bb0de32a08980aa3be) 

#### `public int `[`echo_disabled`](#structcli__st_1a358ff9f628880448c1dcfefa7fe124a7) 

#### `public unsigned int `[`bp`](#structcli__st_1a18ec0d6b894c3ca6f69f18ba72193b2d) 

#### `public char `[`inbuf`](#structcli__st_1a96b76565516c442eb570f6a0c5f458a0) 

#### `public char `[`outbuf`](#structcli__st_1a8cddb6553f21346e722581d363532314) 

# struct `dlist_s` 

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
`public struct `[`dlist_s`](#structdlist__s)` * `[`prev`](#structdlist__s_1a35235eec0fd190a9734fc2dba92ad71e) | 
`public struct `[`dlist_s`](#structdlist__s)` * `[`next`](#structdlist__s_1a0b7ae7507f6ad05a6dde02e964b24b9d) | 

## Members

#### `public struct `[`dlist_s`](#structdlist__s)` * `[`prev`](#structdlist__s_1a35235eec0fd190a9734fc2dba92ad71e) 

#### `public struct `[`dlist_s`](#structdlist__s)` * `[`next`](#structdlist__s_1a0b7ae7507f6ad05a6dde02e964b24b9d) 

# struct `gpio_dev_t` 

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
`public uint8_t `[`port`](#structgpio__dev__t_1ae39e80b64c13f46536b46b6ad404d0a1) | 
`public `[`gpio_config_t`](#gpio_8h_1a9f109d20988917f140f5d55ed9a71385)` `[`config`](#structgpio__dev__t_1a62fb19cb05198974e6f6a26da8f12762) | 
`public void * `[`priv`](#structgpio__dev__t_1a957b1c60e7e9f4c990519ea353e9d63f) | 

## Members

#### `public uint8_t `[`port`](#structgpio__dev__t_1ae39e80b64c13f46536b46b6ad404d0a1) 

#### `public `[`gpio_config_t`](#gpio_8h_1a9f109d20988917f140f5d55ed9a71385)` `[`config`](#structgpio__dev__t_1a62fb19cb05198974e6f6a26da8f12762) 

#### `public void * `[`priv`](#structgpio__dev__t_1a957b1c60e7e9f4c990519ea353e9d63f) 

# struct `hal_logic_partition_t` 

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
`public `[`hal_flash_t`](#flash_8h_1ad6e8fb5585076e4fc4986317027ab76d)` `[`partition_owner`](#structhal__logic__partition__t_1ad75fd480c3bd88c6b0f07d1fc2f440b0) | 
`public const char * `[`partition_description`](#structhal__logic__partition__t_1af89475ae7ce468f0e153db5b6686c8dd) | 
`public uint32_t `[`partition_start_addr`](#structhal__logic__partition__t_1a5d4665d55094278d3e2ca4b9639d0216) | 
`public uint32_t `[`partition_length`](#structhal__logic__partition__t_1a8e01a8760d2001357fab02315f670804) | 
`public uint32_t `[`partition_options`](#structhal__logic__partition__t_1a4f36f9a67fae10932b9ad5b47e32cfff) | 

## Members

#### `public `[`hal_flash_t`](#flash_8h_1ad6e8fb5585076e4fc4986317027ab76d)` `[`partition_owner`](#structhal__logic__partition__t_1ad75fd480c3bd88c6b0f07d1fc2f440b0) 

#### `public const char * `[`partition_description`](#structhal__logic__partition__t_1af89475ae7ce468f0e153db5b6686c8dd) 

#### `public uint32_t `[`partition_start_addr`](#structhal__logic__partition__t_1a5d4665d55094278d3e2ca4b9639d0216) 

#### `public uint32_t `[`partition_length`](#structhal__logic__partition__t_1a8e01a8760d2001357fab02315f670804) 

#### `public uint32_t `[`partition_options`](#structhal__logic__partition__t_1a4f36f9a67fae10932b9ad5b47e32cfff) 

# struct `hal_module_base_t` 

HAL Module define.

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
`public `[`dlist_t`](#list_8h_1aeedb54ed9ac69e4fc599452bbc7eccbe)` `[`list`](#structhal__module__base__t_1a2432f19946eb8b33b9bcd36bbf79c465) | 
`public int `[`magic`](#structhal__module__base__t_1ab88d0d0666b4a2f394de5c26f2a24a5a) | 
`public const char * `[`name`](#structhal__module__base__t_1a826df816d4125caccce5b5d86a2a2aaf) | 
`public void * `[`priv_dev`](#structhal__module__base__t_1a8abdb80f07459b9de7f78533e250a218) | 

## Members

#### `public `[`dlist_t`](#list_8h_1aeedb54ed9ac69e4fc599452bbc7eccbe)` `[`list`](#structhal__module__base__t_1a2432f19946eb8b33b9bcd36bbf79c465) 

#### `public int `[`magic`](#structhal__module__base__t_1ab88d0d0666b4a2f394de5c26f2a24a5a) 

#### `public const char * `[`name`](#structhal__module__base__t_1a826df816d4125caccce5b5d86a2a2aaf) 

#### `public void * `[`priv_dev`](#structhal__module__base__t_1a8abdb80f07459b9de7f78533e250a218) 

# struct `hal_ota_module_s` 

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
`public `[`hal_module_base_t`](#structhal__module__base__t)` `[`base`](#structhal__ota__module__s_1a9ec38a2267572548228c5e248104c580) | 
`public int(* `[`init`](#structhal__ota__module__s_1a1a7677b91d28045fef73901657b9311e) | 
`public int(* `[`ota_write`](#structhal__ota__module__s_1ad8a89e8c9e6c19b2a32eafeadf30aa56) | 
`public int(* `[`ota_read`](#structhal__ota__module__s_1ada89794cbd309bf7bfd95ebb802161e5) | 
`public int(* `[`ota_set_boot`](#structhal__ota__module__s_1a7f44125e7ba0dbbd4a809263bddedfb0) | 

## Members

#### `public `[`hal_module_base_t`](#structhal__module__base__t)` `[`base`](#structhal__ota__module__s_1a9ec38a2267572548228c5e248104c580) 

#### `public int(* `[`init`](#structhal__ota__module__s_1a1a7677b91d28045fef73901657b9311e) 

#### `public int(* `[`ota_write`](#structhal__ota__module__s_1ad8a89e8c9e6c19b2a32eafeadf30aa56) 

#### `public int(* `[`ota_read`](#structhal__ota__module__s_1ada89794cbd309bf7bfd95ebb802161e5) 

#### `public int(* `[`ota_set_boot`](#structhal__ota__module__s_1a7f44125e7ba0dbbd4a809263bddedfb0) 

# struct `hal_sensor_module_s` 

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
`public `[`hal_module_base_t`](#structhal__module__base__t)` `[`base`](#structhal__sensor__module__s_1ab9e477357fa58652c1e4885bbb291058) | 
`public int(* `[`init`](#structhal__sensor__module__s_1a754c92c4c0954643ac00d11f879d614c) | 
`public int(* `[`get_sensor_list`](#structhal__sensor__module__s_1a6c532c0c2d9c280cbf746c19566fa877) | 
`public int(* `[`enable`](#structhal__sensor__module__s_1a051992b20bc84fc795d6618b6318b037) | 
`public int(* `[`disable`](#structhal__sensor__module__s_1a0b24509491252cb5543f9e0a763f0f1c) | 
`public int(* `[`read`](#structhal__sensor__module__s_1a2fb74b2828a0a2bbea993c4604d163e9) | 

## Members

#### `public `[`hal_module_base_t`](#structhal__module__base__t)` `[`base`](#structhal__sensor__module__s_1ab9e477357fa58652c1e4885bbb291058) 

#### `public int(* `[`init`](#structhal__sensor__module__s_1a754c92c4c0954643ac00d11f879d614c) 

#### `public int(* `[`get_sensor_list`](#structhal__sensor__module__s_1a6c532c0c2d9c280cbf746c19566fa877) 

#### `public int(* `[`enable`](#structhal__sensor__module__s_1a051992b20bc84fc795d6618b6318b037) 

#### `public int(* `[`disable`](#structhal__sensor__module__s_1a0b24509491252cb5543f9e0a763f0f1c) 

#### `public int(* `[`read`](#structhal__sensor__module__s_1a2fb74b2828a0a2bbea993c4604d163e9) 

# struct `hal_timer_t` 

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
`public int8_t `[`ch`](#structhal__timer__t_1a3bdc80942908e6fe67cda75ee3ceeee4) | 
`public void * `[`priv`](#structhal__timer__t_1aebf8a6a4178011f1437eb4d0214babea) | 
`public `[`hal_timer_cb_t`](#timer_8h_1a9b138d5db3c7e07032743eddcadc5f4c)` `[`cb`](#structhal__timer__t_1ac57f7ae827c1f750f6f742aa3bd695d0) | 
`public void * `[`arg`](#structhal__timer__t_1a116e8fc78bc129c685bb0b0b2b4ec387) | 

## Members

#### `public int8_t `[`ch`](#structhal__timer__t_1a3bdc80942908e6fe67cda75ee3ceeee4) 

#### `public void * `[`priv`](#structhal__timer__t_1aebf8a6a4178011f1437eb4d0214babea) 

#### `public `[`hal_timer_cb_t`](#timer_8h_1a9b138d5db3c7e07032743eddcadc5f4c)` `[`cb`](#structhal__timer__t_1ac57f7ae827c1f750f6f742aa3bd695d0) 

#### `public void * `[`arg`](#structhal__timer__t_1a116e8fc78bc129c685bb0b0b2b4ec387) 

# struct `hal_wifi_ap_info_adv_t` 

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
`public char `[`ssid`](#group__aos__hal__wifi_1gab97c5edaddbcd747a436b7bc4066e0cf) | SSID of the wlan that needs to be connected. Example: "SSID String".
`public char `[`bssid`](#group__aos__hal__wifi_1ga8713c9dbb1cbdeab82867943e07a3687) | BSSID of the wlan needs to be connected. Example: {0xC8 0x93 0x46 0x11 0x22 0x33}.
`public uint8_t `[`channel`](#group__aos__hal__wifi_1gaa8ec1977817edd442348b75333bccc1e) | Wlan's RF frequency, channel 0-13. 1-13 means a fixed channelthat can speed up a connection procedure, 0 is not a fixed input means all channels are possible
`public uint8_t `[`security`](#group__aos__hal__wifi_1gac32e003765458a1353cfcff816fb52f8) | 

## Members

#### `public char `[`ssid`](#group__aos__hal__wifi_1gab97c5edaddbcd747a436b7bc4066e0cf) 

SSID of the wlan that needs to be connected. Example: "SSID String".

#### `public char `[`bssid`](#group__aos__hal__wifi_1ga8713c9dbb1cbdeab82867943e07a3687) 

BSSID of the wlan needs to be connected. Example: {0xC8 0x93 0x46 0x11 0x22 0x33}.

#### `public uint8_t `[`channel`](#group__aos__hal__wifi_1gaa8ec1977817edd442348b75333bccc1e) 

Wlan's RF frequency, channel 0-13. 1-13 means a fixed channelthat can speed up a connection procedure, 0 is not a fixed input means all channels are possible

#### `public uint8_t `[`security`](#group__aos__hal__wifi_1gac32e003765458a1353cfcff816fb52f8) 

# struct `hal_wifi_event_cb_t` 

The event call back function called at specific events occurred.

For HAL implementors, these callbacks must be called under normal task context, not from interrupt.

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
`public void(* `[`connect_fail`](#group__aos__hal__wifi_1ga9ae38c6f66bbbca462248729ac62bbed) | 
`public void(* `[`ip_got`](#group__aos__hal__wifi_1ga26e52baf5969a54bf61a4d39d32e8e83) | 
`public void(* `[`stat_chg`](#group__aos__hal__wifi_1ga5ad9e64a48dbcc03e9ee7c4965142dd8) | 
`public void(* `[`scan_compeleted`](#group__aos__hal__wifi_1ga1475767c8c0fe9b0b142ffdec67b2d91) | 
`public void(* `[`scan_adv_compeleted`](#group__aos__hal__wifi_1ga43a7c08333d37fa391bc7f631afe3b40) | 
`public void(* `[`para_chg`](#group__aos__hal__wifi_1gab93fdd5be84b245935e7dfbff14da4b1) | 
`public void(* `[`fatal_err`](#group__aos__hal__wifi_1gae0bfec3b6833156df75b6dfdffffedaf) | 

## Members

#### `public void(* `[`connect_fail`](#group__aos__hal__wifi_1ga9ae38c6f66bbbca462248729ac62bbed) 

#### `public void(* `[`ip_got`](#group__aos__hal__wifi_1ga26e52baf5969a54bf61a4d39d32e8e83) 

#### `public void(* `[`stat_chg`](#group__aos__hal__wifi_1ga5ad9e64a48dbcc03e9ee7c4965142dd8) 

#### `public void(* `[`scan_compeleted`](#group__aos__hal__wifi_1ga1475767c8c0fe9b0b142ffdec67b2d91) 

#### `public void(* `[`scan_adv_compeleted`](#group__aos__hal__wifi_1ga43a7c08333d37fa391bc7f631afe3b40) 

#### `public void(* `[`para_chg`](#group__aos__hal__wifi_1gab93fdd5be84b245935e7dfbff14da4b1) 

#### `public void(* `[`fatal_err`](#group__aos__hal__wifi_1gae0bfec3b6833156df75b6dfdffffedaf) 

# struct `hal_wifi_init_type_adv_t` 

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
`public `[`hal_wifi_ap_info_adv_t`](#structhal__wifi__ap__info__adv__t)` `[`ap_info`](#group__aos__hal__wifi_1ga6b7951a00e2c8e9e0f55ec9715895fcb) | apinfo_adv_t.
`public char `[`key`](#group__aos__hal__wifi_1ga28b1d5b7f4115ca21abd252dd5588c62) | Security key or PMK of the wlan.
`public int `[`key_len`](#group__aos__hal__wifi_1ga791f3f6cbcf87d291dbefaff7a40d708) | The length of the key.
`public char `[`local_ip_addr`](#group__aos__hal__wifi_1ga2db049faf64992f223af5aacf503f26a) | Static IP configuration, Local IP address.
`public char `[`net_mask`](#group__aos__hal__wifi_1gaa9cc1c0fae9b2c5f0e4895384c697c4a) | Static IP configuration, Netmask.
`public char `[`gateway_ip_addr`](#group__aos__hal__wifi_1ga8947e0b10f4530d17bc9e82ea5c802c6) | Static IP configuration, Router IP address.
`public char `[`dns_server_ip_addr`](#group__aos__hal__wifi_1ga2896b13395bbdd92a87faa72edc7a211) | Static IP configuration, DNS server IP address.
`public char `[`dhcp_mode`](#group__aos__hal__wifi_1gafa1eee67a2d57fb5f8757db3ebf1c0bf) | DHCP mode, DHCP_Disable, DHCP_Client and DHCP_Server.
`public char `[`reserved`](#group__aos__hal__wifi_1gadaa1028b296df8866108bd90ba98848f) | 
`public int `[`wifi_retry_interval`](#group__aos__hal__wifi_1gae6cc0791bf3eb8c4f96744bf3292ad69) | Retry interval if an error is occured when connecting an access point, time unit is millisecond.

## Members

#### `public `[`hal_wifi_ap_info_adv_t`](#structhal__wifi__ap__info__adv__t)` `[`ap_info`](#group__aos__hal__wifi_1ga6b7951a00e2c8e9e0f55ec9715895fcb) 

apinfo_adv_t.

#### `public char `[`key`](#group__aos__hal__wifi_1ga28b1d5b7f4115ca21abd252dd5588c62) 

Security key or PMK of the wlan.

#### `public int `[`key_len`](#group__aos__hal__wifi_1ga791f3f6cbcf87d291dbefaff7a40d708) 

The length of the key.

#### `public char `[`local_ip_addr`](#group__aos__hal__wifi_1ga2db049faf64992f223af5aacf503f26a) 

Static IP configuration, Local IP address.

#### `public char `[`net_mask`](#group__aos__hal__wifi_1gaa9cc1c0fae9b2c5f0e4895384c697c4a) 

Static IP configuration, Netmask.

#### `public char `[`gateway_ip_addr`](#group__aos__hal__wifi_1ga8947e0b10f4530d17bc9e82ea5c802c6) 

Static IP configuration, Router IP address.

#### `public char `[`dns_server_ip_addr`](#group__aos__hal__wifi_1ga2896b13395bbdd92a87faa72edc7a211) 

Static IP configuration, DNS server IP address.

#### `public char `[`dhcp_mode`](#group__aos__hal__wifi_1gafa1eee67a2d57fb5f8757db3ebf1c0bf) 

DHCP mode, DHCP_Disable, DHCP_Client and DHCP_Server.

#### `public char `[`reserved`](#group__aos__hal__wifi_1gadaa1028b296df8866108bd90ba98848f) 

#### `public int `[`wifi_retry_interval`](#group__aos__hal__wifi_1gae6cc0791bf3eb8c4f96744bf3292ad69) 

Retry interval if an error is occured when connecting an access point, time unit is millisecond.

# struct `hal_wifi_init_type_t` 

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
`public char `[`wifi_mode`](#group__aos__hal__wifi_1ga3d3f2ef140b99762aee445cd74eba664) | DHCP mode: wlanInterfaceTypedef.
`public char `[`wifi_ssid`](#group__aos__hal__wifi_1ga1376e376e57125bb10822c9b6221ea5a) | SSID of the wlan needs to be connected.
`public char `[`wifi_key`](#group__aos__hal__wifi_1gacc2905d956802e5dab08813b5919d25b) | Security key of the wlan needs to be connected, ignored in an open system.
`public char `[`local_ip_addr`](#group__aos__hal__wifi_1gad7c8eb2f908bbf0603cb9f8c4202b0d2) | Static IP configuration, Local IP address.
`public char `[`net_mask`](#group__aos__hal__wifi_1gaf9009032cd98d42ca02b8431666e4960) | Static IP configuration, Netmask.
`public char `[`gateway_ip_addr`](#group__aos__hal__wifi_1gab34248637652bff30ec2635767d83ee9) | Static IP configuration, Router IP address.
`public char `[`dns_server_ip_addr`](#group__aos__hal__wifi_1gac243e0cfa50a6f72ef2e9d9d88f8b37d) | Static IP configuration, DNS server IP address.
`public char `[`dhcp_mode`](#group__aos__hal__wifi_1ga02bb7f0c46604cc26d0517d6b9ca64a1) | DHCP mode, DHCP_Disable, DHCP_Client and DHCP_Server.
`public char `[`reserved`](#group__aos__hal__wifi_1gabc6aff8e1c1ca16e4d0e19ad1af6c0e6) | 
`public int `[`wifi_retry_interval`](#group__aos__hal__wifi_1gaf201d372ba47fef48f251e241712377f) | Retry interval if an error is occured when connecting an access point, time unit is millisecond.

## Members

#### `public char `[`wifi_mode`](#group__aos__hal__wifi_1ga3d3f2ef140b99762aee445cd74eba664) 

DHCP mode: wlanInterfaceTypedef.

#### `public char `[`wifi_ssid`](#group__aos__hal__wifi_1ga1376e376e57125bb10822c9b6221ea5a) 

SSID of the wlan needs to be connected.

#### `public char `[`wifi_key`](#group__aos__hal__wifi_1gacc2905d956802e5dab08813b5919d25b) 

Security key of the wlan needs to be connected, ignored in an open system.

#### `public char `[`local_ip_addr`](#group__aos__hal__wifi_1gad7c8eb2f908bbf0603cb9f8c4202b0d2) 

Static IP configuration, Local IP address.

#### `public char `[`net_mask`](#group__aos__hal__wifi_1gaf9009032cd98d42ca02b8431666e4960) 

Static IP configuration, Netmask.

#### `public char `[`gateway_ip_addr`](#group__aos__hal__wifi_1gab34248637652bff30ec2635767d83ee9) 

Static IP configuration, Router IP address.

#### `public char `[`dns_server_ip_addr`](#group__aos__hal__wifi_1gac243e0cfa50a6f72ef2e9d9d88f8b37d) 

Static IP configuration, DNS server IP address.

#### `public char `[`dhcp_mode`](#group__aos__hal__wifi_1ga02bb7f0c46604cc26d0517d6b9ca64a1) 

DHCP mode, DHCP_Disable, DHCP_Client and DHCP_Server.

#### `public char `[`reserved`](#group__aos__hal__wifi_1gabc6aff8e1c1ca16e4d0e19ad1af6c0e6) 

#### `public int `[`wifi_retry_interval`](#group__aos__hal__wifi_1gaf201d372ba47fef48f251e241712377f) 

Retry interval if an error is occured when connecting an access point, time unit is millisecond.

# struct `hal_wifi_ip_stat_t` 

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
`public uint8_t `[`dhcp`](#group__aos__hal__wifi_1gaed0288ae22808853c57482a7c74b1134) | DHCP mode: DHCP_Disable, DHCP_Client, DHCP_Server.
`public char `[`ip`](#group__aos__hal__wifi_1ga47a33fb293f4d0af34252582d9bbf9ca) | Local IP address on the target wlan interface: wlanInterfaceTypedef.
`public char `[`gate`](#group__aos__hal__wifi_1ga30168a3c39294acf72b81fe51f5a3688) | Router IP address on the target wlan interface: wlanInterfaceTypedef.
`public char `[`mask`](#group__aos__hal__wifi_1ga7d42f3ec9463507fdb91103d7384b0e7) | Netmask on the target wlan interface: wlanInterfaceTypedef.
`public char `[`dns`](#group__aos__hal__wifi_1ga9858430f7a675cbad3f56470f16a7d73) | DNS server IP address.
`public char `[`mac`](#group__aos__hal__wifi_1gae0add659da3b9d229e01a35e57050b84) | MAC address, example: "C89346112233".
`public char `[`broadcastip`](#group__aos__hal__wifi_1ga5b56228095ad05461c135e480f65573f) | 

## Members

#### `public uint8_t `[`dhcp`](#group__aos__hal__wifi_1gaed0288ae22808853c57482a7c74b1134) 

DHCP mode: DHCP_Disable, DHCP_Client, DHCP_Server.

#### `public char `[`ip`](#group__aos__hal__wifi_1ga47a33fb293f4d0af34252582d9bbf9ca) 

Local IP address on the target wlan interface: wlanInterfaceTypedef.

#### `public char `[`gate`](#group__aos__hal__wifi_1ga30168a3c39294acf72b81fe51f5a3688) 

Router IP address on the target wlan interface: wlanInterfaceTypedef.

#### `public char `[`mask`](#group__aos__hal__wifi_1ga7d42f3ec9463507fdb91103d7384b0e7) 

Netmask on the target wlan interface: wlanInterfaceTypedef.

#### `public char `[`dns`](#group__aos__hal__wifi_1ga9858430f7a675cbad3f56470f16a7d73) 

DNS server IP address.

#### `public char `[`mac`](#group__aos__hal__wifi_1gae0add659da3b9d229e01a35e57050b84) 

MAC address, example: "C89346112233".

#### `public char `[`broadcastip`](#group__aos__hal__wifi_1ga5b56228095ad05461c135e480f65573f) 

# struct `hal_wifi_link_info_s` 

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
`public int8_t `[`rssi`](#group__aos__hal__wifi_1ga486b2765504d1783266a9bad89173428) | rssi value of received packet

## Members

#### `public int8_t `[`rssi`](#group__aos__hal__wifi_1ga486b2765504d1783266a9bad89173428) 

rssi value of received packet

# struct `hal_wifi_link_stat_t` 

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
`public int `[`is_connected`](#group__aos__hal__wifi_1ga916eefdf4f4d8ca8b8df95129c07f8e4) | The link to wlan is established or not, 0: disconnected, 1: connected.
`public int `[`wifi_strength`](#group__aos__hal__wifi_1ga92b5ba3cbcdb4a94ac9483af9133d624) | Signal strength of the current connected AP
`public uint8_t `[`ssid`](#group__aos__hal__wifi_1ga32875f213fccbf4cc26f19bbdb83abb7) | SSID of the current connected wlan
`public uint8_t `[`bssid`](#group__aos__hal__wifi_1ga7131883307e268e7c93fc1e1a73722de) | BSSID of the current connected wlan
`public int `[`channel`](#group__aos__hal__wifi_1gae5fa184f70eb840afc2d0d5a4d9ca9d7) | Channel of the current connected wlan

## Members

#### `public int `[`is_connected`](#group__aos__hal__wifi_1ga916eefdf4f4d8ca8b8df95129c07f8e4) 

The link to wlan is established or not, 0: disconnected, 1: connected.

#### `public int `[`wifi_strength`](#group__aos__hal__wifi_1ga92b5ba3cbcdb4a94ac9483af9133d624) 

Signal strength of the current connected AP

#### `public uint8_t `[`ssid`](#group__aos__hal__wifi_1ga32875f213fccbf4cc26f19bbdb83abb7) 

SSID of the current connected wlan

#### `public uint8_t `[`bssid`](#group__aos__hal__wifi_1ga7131883307e268e7c93fc1e1a73722de) 

BSSID of the current connected wlan

#### `public int `[`channel`](#group__aos__hal__wifi_1gae5fa184f70eb840afc2d0d5a4d9ca9d7) 

Channel of the current connected wlan

# struct `hal_wifi_module_s` 

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
`public `[`hal_module_base_t`](#structhal__module__base__t)` `[`base`](#group__aos__hal__wifi_1gab84d8d230e40e1209b8150780bb15475) | 
`public const `[`hal_wifi_event_cb_t`](#structhal__wifi__event__cb__t)` * `[`ev_cb`](#group__aos__hal__wifi_1ga52fd13db5939109e41a6f11c7b0dd008) | 
`public int(* `[`init`](#group__aos__hal__wifi_1ga95dff476ea204f6870290af9d6b2ad41) | 
`public void(* `[`get_mac_addr`](#group__aos__hal__wifi_1ga04b776a310c14e9912e57ff34a175325) | 
`public int(* `[`start`](#group__aos__hal__wifi_1ga94e44d2540e692e3d2efc746e86626ea) | 
`public int(* `[`start_adv`](#group__aos__hal__wifi_1ga750caaba1f62477871d5217d12f65c1f) | 
`public int(* `[`get_ip_stat`](#group__aos__hal__wifi_1ga707cadeead0da028b1d6b5243c18900c) | 
`public int(* `[`get_link_stat`](#group__aos__hal__wifi_1gabb507e301f7f57f953fd26697dec580d) | 
`public void(* `[`start_scan`](#group__aos__hal__wifi_1gad48c4c184bba3cc27a586210849a223d) | 
`public void(* `[`start_scan_adv`](#group__aos__hal__wifi_1ga1b84ac2534fc197f67759fb0b6cb6c43) | 
`public int(* `[`power_off`](#group__aos__hal__wifi_1ga69d0abd8ba10cb784511a358bb7b3bb7) | 
`public int(* `[`power_on`](#group__aos__hal__wifi_1ga77467283034d025bea6fd53f59412c82) | 
`public int(* `[`suspend`](#group__aos__hal__wifi_1gac0578fa36fa49585ed9051ad40b70a78) | 
`public int(* `[`suspend_station`](#group__aos__hal__wifi_1ga9c2a49b64de903f670d19d263eda6271) | 
`public int(* `[`suspend_soft_ap`](#group__aos__hal__wifi_1ga7a433bfbbe79074a85b87a57f7521ea0) | 
`public int(* `[`set_channel`](#group__aos__hal__wifi_1ga82214a1288de0e66edc5438ac7e26fb9) | 
`public void(* `[`start_monitor`](#group__aos__hal__wifi_1ga231ec2946d6e261aa51b2f7a3d21bf52) | 
`public void(* `[`stop_monitor`](#group__aos__hal__wifi_1ga7b76b2e974e526a25581c5d921a9537e) | 
`public void(* `[`register_monitor_cb`](#group__aos__hal__wifi_1ga02fbfdbee1e30b6b509dbea8896748ac) | 
`public void(* `[`register_wlan_mgnt_monitor_cb`](#group__aos__hal__wifi_1gab40f7b61e9eb6a585c9872d315513006) | 
`public int(* `[`wlan_send_80211_raw_frame`](#group__aos__hal__wifi_1ga1c0f13ce75fb7802c3584ed99a78161c) | 
`public void(* `[`start_debug_mode`](#group__aos__hal__wifi_1ga652a542258eecb507ef7ae088a9a5c06) | 
`public void(* `[`stop_debug_mode`](#group__aos__hal__wifi_1ga1d0d8052ddf439981e1571f87917678e) | 

## Members

#### `public `[`hal_module_base_t`](#structhal__module__base__t)` `[`base`](#group__aos__hal__wifi_1gab84d8d230e40e1209b8150780bb15475) 

#### `public const `[`hal_wifi_event_cb_t`](#structhal__wifi__event__cb__t)` * `[`ev_cb`](#group__aos__hal__wifi_1ga52fd13db5939109e41a6f11c7b0dd008) 

#### `public int(* `[`init`](#group__aos__hal__wifi_1ga95dff476ea204f6870290af9d6b2ad41) 

#### `public void(* `[`get_mac_addr`](#group__aos__hal__wifi_1ga04b776a310c14e9912e57ff34a175325) 

#### `public int(* `[`start`](#group__aos__hal__wifi_1ga94e44d2540e692e3d2efc746e86626ea) 

#### `public int(* `[`start_adv`](#group__aos__hal__wifi_1ga750caaba1f62477871d5217d12f65c1f) 

#### `public int(* `[`get_ip_stat`](#group__aos__hal__wifi_1ga707cadeead0da028b1d6b5243c18900c) 

#### `public int(* `[`get_link_stat`](#group__aos__hal__wifi_1gabb507e301f7f57f953fd26697dec580d) 

#### `public void(* `[`start_scan`](#group__aos__hal__wifi_1gad48c4c184bba3cc27a586210849a223d) 

#### `public void(* `[`start_scan_adv`](#group__aos__hal__wifi_1ga1b84ac2534fc197f67759fb0b6cb6c43) 

#### `public int(* `[`power_off`](#group__aos__hal__wifi_1ga69d0abd8ba10cb784511a358bb7b3bb7) 

#### `public int(* `[`power_on`](#group__aos__hal__wifi_1ga77467283034d025bea6fd53f59412c82) 

#### `public int(* `[`suspend`](#group__aos__hal__wifi_1gac0578fa36fa49585ed9051ad40b70a78) 

#### `public int(* `[`suspend_station`](#group__aos__hal__wifi_1ga9c2a49b64de903f670d19d263eda6271) 

#### `public int(* `[`suspend_soft_ap`](#group__aos__hal__wifi_1ga7a433bfbbe79074a85b87a57f7521ea0) 

#### `public int(* `[`set_channel`](#group__aos__hal__wifi_1ga82214a1288de0e66edc5438ac7e26fb9) 

#### `public void(* `[`start_monitor`](#group__aos__hal__wifi_1ga231ec2946d6e261aa51b2f7a3d21bf52) 

#### `public void(* `[`stop_monitor`](#group__aos__hal__wifi_1ga7b76b2e974e526a25581c5d921a9537e) 

#### `public void(* `[`register_monitor_cb`](#group__aos__hal__wifi_1ga02fbfdbee1e30b6b509dbea8896748ac) 

#### `public void(* `[`register_wlan_mgnt_monitor_cb`](#group__aos__hal__wifi_1gab40f7b61e9eb6a585c9872d315513006) 

#### `public int(* `[`wlan_send_80211_raw_frame`](#group__aos__hal__wifi_1ga1c0f13ce75fb7802c3584ed99a78161c) 

#### `public void(* `[`start_debug_mode`](#group__aos__hal__wifi_1ga652a542258eecb507ef7ae088a9a5c06) 

#### `public void(* `[`stop_debug_mode`](#group__aos__hal__wifi_1ga1d0d8052ddf439981e1571f87917678e) 

# struct `hal_wifi_module_t` 

The Wifi module for manufacture to implement.

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------

## Members

# struct `hal_wifi_scan_result_adv_t` 

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
`public char `[`ap_num`](#group__aos__hal__wifi_1ga83cdf51a8e04deccdeae9ed2dabd6f63) | The number of access points found in scanning.
`public char `[`ssid`](#group__aos__hal__wifi_1gadeced914f0ee19fafbd8d9f260556726) | The SSID of an access point.
`public char `[`ap_power`](#group__aos__hal__wifi_1ga4b1dffaf9e6afb9feb77bb9610e50ec5) | Signal strength, min:0, max:100
`public char `[`bssid`](#group__aos__hal__wifi_1gac688d9e732122225e921de83e5885247) | The BSSID of an access point.
`public char `[`channel`](#group__aos__hal__wifi_1ga2a9883afbd7a620803b439277a9015fb) | The RF frequency, 1-13
`public uint8_t `[`security`](#group__aos__hal__wifi_1ga73b0abdc3e03a036fe5851f7c05ea926) | Security type, wlan_sec_type_t
`public struct hal_wifi_scan_result_adv_t::@4 * `[`ap_list`](#group__aos__hal__wifi_1gae10c483a97d93f6b26a7891b444776d1) | 

## Members

#### `public char `[`ap_num`](#group__aos__hal__wifi_1ga83cdf51a8e04deccdeae9ed2dabd6f63) 

The number of access points found in scanning.

#### `public char `[`ssid`](#group__aos__hal__wifi_1gadeced914f0ee19fafbd8d9f260556726) 

The SSID of an access point.

#### `public char `[`ap_power`](#group__aos__hal__wifi_1ga4b1dffaf9e6afb9feb77bb9610e50ec5) 

Signal strength, min:0, max:100

#### `public char `[`bssid`](#group__aos__hal__wifi_1gac688d9e732122225e921de83e5885247) 

The BSSID of an access point.

#### `public char `[`channel`](#group__aos__hal__wifi_1ga2a9883afbd7a620803b439277a9015fb) 

The RF frequency, 1-13

#### `public uint8_t `[`security`](#group__aos__hal__wifi_1ga73b0abdc3e03a036fe5851f7c05ea926) 

Security type, wlan_sec_type_t

#### `public struct hal_wifi_scan_result_adv_t::@4 * `[`ap_list`](#group__aos__hal__wifi_1gae10c483a97d93f6b26a7891b444776d1) 

# struct `hal_wifi_scan_result_t` 

Scan result using normal scan.

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
`public char `[`ap_num`](#group__aos__hal__wifi_1ga70e7dab9792ab3190a629278ff72fa7a) | The number of access points found in scanning.
`public char `[`ssid`](#group__aos__hal__wifi_1gaa72519bc6e8d6d27e26ff085ca9fc0ae) | The SSID of an access point.
`public char `[`ap_power`](#group__aos__hal__wifi_1ga1cff945c11a7727a44e3c6ece7940194) | Signal strength, min:0, max:100.
`public struct hal_wifi_scan_result_t::@3 * `[`ap_list`](#group__aos__hal__wifi_1gaeaf5d7b3e0a5859e47310beb58e7f7bf) | 

## Members

#### `public char `[`ap_num`](#group__aos__hal__wifi_1ga70e7dab9792ab3190a629278ff72fa7a) 

The number of access points found in scanning.

#### `public char `[`ssid`](#group__aos__hal__wifi_1gaa72519bc6e8d6d27e26ff085ca9fc0ae) 

The SSID of an access point.

#### `public char `[`ap_power`](#group__aos__hal__wifi_1ga1cff945c11a7727a44e3c6ece7940194) 

Signal strength, min:0, max:100.

#### `public struct hal_wifi_scan_result_t::@3 * `[`ap_list`](#group__aos__hal__wifi_1gaeaf5d7b3e0a5859e47310beb58e7f7bf) 

# struct `i2c_config_t` 

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
`public uint32_t `[`address_width`](#structi2c__config__t_1a300d22552103a7ccb58a12883b44067e) | 
`public uint32_t `[`freq`](#structi2c__config__t_1a3cb91c4f0c325721cd3cf0acc1b4d575) | 

## Members

#### `public uint32_t `[`address_width`](#structi2c__config__t_1a300d22552103a7ccb58a12883b44067e) 

#### `public uint32_t `[`freq`](#structi2c__config__t_1a3cb91c4f0c325721cd3cf0acc1b4d575) 

# struct `i2c_dev_t` 

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
`public uint8_t `[`port`](#structi2c__dev__t_1a8ea766372206febb8e623038230e5378) | 
`public `[`i2c_config_t`](#structi2c__config__t)` `[`config`](#structi2c__dev__t_1a3dd4ad17f35b9b776ae009737da2197b) | 
`public void * `[`priv`](#structi2c__dev__t_1a877bc4790eb196369a210f7a27c1bb1e) | 

## Members

#### `public uint8_t `[`port`](#structi2c__dev__t_1a8ea766372206febb8e623038230e5378) 

#### `public `[`i2c_config_t`](#structi2c__config__t)` `[`config`](#structi2c__dev__t_1a3dd4ad17f35b9b776ae009737da2197b) 

#### `public void * `[`priv`](#structi2c__dev__t_1a877bc4790eb196369a210f7a27c1bb1e) 

# struct `input_event_t` 

aos event structure

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
`public uint32_t `[`time`](#structinput__event__t_1ad4ff0379ef91ba031b5e57b3d0036840) | The time event is generated, auto filled by aos event system
`public uint16_t `[`type`](#structinput__event__t_1abec4e033ca7a1bb5979619201b27e14c) | Event type, value < 0x1000 are used by aos system
`public uint16_t `[`code`](#structinput__event__t_1ab6a912cb751656597f1ad64837ecad6c) | Defined according to type
`public unsigned long `[`value`](#structinput__event__t_1ab3201384223a6dfe7becefe21e6d6e13) | Defined according to type/code
`public unsigned long `[`extra`](#structinput__event__t_1a49a18e449723486ab5506e8d745d5313) | Defined according to type/code

## Members

#### `public uint32_t `[`time`](#structinput__event__t_1ad4ff0379ef91ba031b5e57b3d0036840) 

The time event is generated, auto filled by aos event system

#### `public uint16_t `[`type`](#structinput__event__t_1abec4e033ca7a1bb5979619201b27e14c) 

Event type, value < 0x1000 are used by aos system

#### `public uint16_t `[`code`](#structinput__event__t_1ab6a912cb751656597f1ad64837ecad6c) 

Defined according to type

#### `public unsigned long `[`value`](#structinput__event__t_1ab3201384223a6dfe7becefe21e6d6e13) 

Defined according to type/code

#### `public unsigned long `[`extra`](#structinput__event__t_1a49a18e449723486ab5506e8d745d5313) 

Defined according to type/code

# struct `pwm_config_t` 

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
`public float `[`duty_cycle`](#structpwm__config__t_1aafeaea7bebf451f7254933221f92f439) | 
`public uint32_t `[`freq`](#structpwm__config__t_1a4bfb97d483238f81041602077bbf9323) | 

## Members

#### `public float `[`duty_cycle`](#structpwm__config__t_1aafeaea7bebf451f7254933221f92f439) 

#### `public uint32_t `[`freq`](#structpwm__config__t_1a4bfb97d483238f81041602077bbf9323) 

# struct `pwm_dev_t` 

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
`public uint8_t `[`port`](#structpwm__dev__t_1a571455f811c0211665502aaff62bc695) | 
`public `[`pwm_config_t`](#structpwm__config__t)` `[`config`](#structpwm__dev__t_1a10136f178f2b7dfbfd7f9aff64568bbc) | 
`public void * `[`priv`](#structpwm__dev__t_1af8f857b9f5313bd1975ea4a9c2246fa4) | 

## Members

#### `public uint8_t `[`port`](#structpwm__dev__t_1a571455f811c0211665502aaff62bc695) 

#### `public `[`pwm_config_t`](#structpwm__config__t)` `[`config`](#structpwm__dev__t_1a10136f178f2b7dfbfd7f9aff64568bbc) 

#### `public void * `[`priv`](#structpwm__dev__t_1af8f857b9f5313bd1975ea4a9c2246fa4) 

# struct `random_dev_t` 

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
`public uint8_t `[`port`](#structrandom__dev__t_1a2a6242cf140d666e98d0a6ce149bf5d1) | 
`public void * `[`priv`](#structrandom__dev__t_1a3cb7ab4c80c3e1dd58234005b1882995) | 

## Members

#### `public uint8_t `[`port`](#structrandom__dev__t_1a2a6242cf140d666e98d0a6ce149bf5d1) 

#### `public void * `[`priv`](#structrandom__dev__t_1a3cb7ab4c80c3e1dd58234005b1882995) 

# struct `rtc_dev_t` 

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
`public uint8_t `[`port`](#structrtc__dev__t_1aaa13aec880a85a91144588e95e2b91cf) | 
`public void * `[`priv`](#structrtc__dev__t_1ae3aa18ad032ecd8b4d7fd0f1a08de487) | 

## Members

#### `public uint8_t `[`port`](#structrtc__dev__t_1aaa13aec880a85a91144588e95e2b91cf) 

#### `public void * `[`priv`](#structrtc__dev__t_1ae3aa18ad032ecd8b4d7fd0f1a08de487) 

# struct `rtc_time_t` 

RTC time

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
`public uint8_t `[`sec`](#structrtc__time__t_1a9e6b7c9a15685fe8c90a969550b80e76) | 
`public uint8_t `[`min`](#structrtc__time__t_1a521dfb37091082541a7a08d527b3e5c4) | 
`public uint8_t `[`hr`](#structrtc__time__t_1a270692a5624d10a93cb0fb9df324e726) | 
`public uint8_t `[`weekday`](#structrtc__time__t_1a00d4d962ba445ab61fbfbbd89ebc54d4) | 
`public uint8_t `[`date`](#structrtc__time__t_1abaa2bf5c6fed1ec703e2dc24119b7374) | 
`public uint8_t `[`month`](#structrtc__time__t_1a72c1fb304848005b837a5966123feeb5) | 
`public uint8_t `[`year`](#structrtc__time__t_1a1fe72fc7d918a328930c354af9ad3326) | 

## Members

#### `public uint8_t `[`sec`](#structrtc__time__t_1a9e6b7c9a15685fe8c90a969550b80e76) 

#### `public uint8_t `[`min`](#structrtc__time__t_1a521dfb37091082541a7a08d527b3e5c4) 

#### `public uint8_t `[`hr`](#structrtc__time__t_1a270692a5624d10a93cb0fb9df324e726) 

#### `public uint8_t `[`weekday`](#structrtc__time__t_1a00d4d962ba445ab61fbfbbd89ebc54d4) 

#### `public uint8_t `[`date`](#structrtc__time__t_1abaa2bf5c6fed1ec703e2dc24119b7374) 

#### `public uint8_t `[`month`](#structrtc__time__t_1a72c1fb304848005b837a5966123feeb5) 

#### `public uint8_t `[`year`](#structrtc__time__t_1a1fe72fc7d918a328930c354af9ad3326) 

# struct `sensor_node_t` 

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
`public `[`sensor_type`](#sensor_8h_1afa273d6585462db941727d44e9b50320)` `[`type`](#structsensor__node__t_1a786838b9b1f9fe62175bca9759b9cbe4) | 
`public const char * `[`sensor_name`](#structsensor__node__t_1a53d1f3dcc04ad216ca61df18ff7ffe9e) | 

## Members

#### `public `[`sensor_type`](#sensor_8h_1afa273d6585462db941727d44e9b50320)` `[`type`](#structsensor__node__t_1a786838b9b1f9fe62175bca9759b9cbe4) 

#### `public const char * `[`sensor_name`](#structsensor__node__t_1a53d1f3dcc04ad216ca61df18ff7ffe9e) 

# struct `slist_s` 

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
`public struct `[`slist_s`](#structslist__s)` * `[`next`](#structslist__s_1a0fe502febb779ff4b2243c59d13fa826) | 

## Members

#### `public struct `[`slist_s`](#structslist__s)` * `[`next`](#structslist__s_1a0fe502febb779ff4b2243c59d13fa826) 

# struct `spi_config_t` 

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
`public uint32_t `[`mode`](#structspi__config__t_1a10afede6b824e2e9e01c2d0b1819aa23) | 
`public uint32_t `[`freq`](#structspi__config__t_1af8b4b9033931adeaf0aec27eb38ce393) | 

## Members

#### `public uint32_t `[`mode`](#structspi__config__t_1a10afede6b824e2e9e01c2d0b1819aa23) 

#### `public uint32_t `[`freq`](#structspi__config__t_1af8b4b9033931adeaf0aec27eb38ce393) 

# struct `spi_dev_t` 

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
`public uint8_t `[`port`](#structspi__dev__t_1a9ae23abf41d0073e6ffbc5b1d38c4fa3) | 
`public `[`spi_config_t`](#structspi__config__t)` `[`config`](#structspi__dev__t_1ab7c1e4ab2d918c0e87148c9e538dd274) | 
`public void * `[`priv`](#structspi__dev__t_1a717f4ad49d8e6dea13cccfbd2c28300c) | 

## Members

#### `public uint8_t `[`port`](#structspi__dev__t_1a9ae23abf41d0073e6ffbc5b1d38c4fa3) 

#### `public `[`spi_config_t`](#structspi__config__t)` `[`config`](#structspi__dev__t_1ab7c1e4ab2d918c0e87148c9e538dd274) 

#### `public void * `[`priv`](#structspi__dev__t_1a717f4ad49d8e6dea13cccfbd2c28300c) 

# struct `uart_config_t` 

UART configuration

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
`public uint32_t `[`baud_rate`](#structuart__config__t_1a988fe3be69cba628a241033f1b16f35e) | 
`public `[`hal_uart_data_width_t`](#uart_8h_1a631222ce1f55203f7456a62df1adaeaa)` `[`data_width`](#structuart__config__t_1a98e3f985aac45435986be5e14fe47b76) | 
`public `[`hal_uart_parity_t`](#uart_8h_1a67ed44b4958988acbd6cbccbe7d83b60)` `[`parity`](#structuart__config__t_1a33b566783011bf57508e65a9b60dc7de) | 
`public `[`hal_uart_stop_bits_t`](#uart_8h_1aef51ce06a2c07532c061b3ebd5e22d25)` `[`stop_bits`](#structuart__config__t_1a24881f4d7db115b05e72b4854ab81767) | 
`public `[`hal_uart_flow_control_t`](#uart_8h_1a33928493a14b4828cb32e778d1af482d)` `[`flow_control`](#structuart__config__t_1a8052316f7700cb2f3999cba2019e5d5c) | 

## Members

#### `public uint32_t `[`baud_rate`](#structuart__config__t_1a988fe3be69cba628a241033f1b16f35e) 

#### `public `[`hal_uart_data_width_t`](#uart_8h_1a631222ce1f55203f7456a62df1adaeaa)` `[`data_width`](#structuart__config__t_1a98e3f985aac45435986be5e14fe47b76) 

#### `public `[`hal_uart_parity_t`](#uart_8h_1a67ed44b4958988acbd6cbccbe7d83b60)` `[`parity`](#structuart__config__t_1a33b566783011bf57508e65a9b60dc7de) 

#### `public `[`hal_uart_stop_bits_t`](#uart_8h_1aef51ce06a2c07532c061b3ebd5e22d25)` `[`stop_bits`](#structuart__config__t_1a24881f4d7db115b05e72b4854ab81767) 

#### `public `[`hal_uart_flow_control_t`](#uart_8h_1a33928493a14b4828cb32e778d1af482d)` `[`flow_control`](#structuart__config__t_1a8052316f7700cb2f3999cba2019e5d5c) 

# struct `uart_dev_t` 

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
`public uint8_t `[`port`](#structuart__dev__t_1a87c3a3c5be21833204d5da753d56d8e8) | 
`public `[`uart_config_t`](#structuart__config__t)` `[`config`](#structuart__dev__t_1a034bb106fc2ddb2a00821b72255db94b) | 
`public void * `[`priv`](#structuart__dev__t_1accf065585c37d52cea2468640da1014f) | 

## Members

#### `public uint8_t `[`port`](#structuart__dev__t_1a87c3a3c5be21833204d5da753d56d8e8) 

#### `public `[`uart_config_t`](#structuart__config__t)` `[`config`](#structuart__dev__t_1a034bb106fc2ddb2a00821b72255db94b) 

#### `public void * `[`priv`](#structuart__dev__t_1accf065585c37d52cea2468640da1014f) 

# struct `wdg_config_t` 

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
`public uint32_t `[`timeout`](#structwdg__config__t_1a516d44bf98c4ba69400135bb732d897e) | 

## Members

#### `public uint32_t `[`timeout`](#structwdg__config__t_1a516d44bf98c4ba69400135bb732d897e) 

# struct `wdg_dev_t` 

## Summary

 Members                        | Descriptions                                
--------------------------------|---------------------------------------------
`public uint8_t `[`port`](#structwdg__dev__t_1a786cf92373aac7c9a42dd347d7b2a5d2) | 
`public `[`wdg_config_t`](#structwdg__config__t)` `[`config`](#structwdg__dev__t_1af51b548a8c3ea402b6021fc36649b49a) | 
`public void * `[`priv`](#structwdg__dev__t_1a9e5e3b763ff5a2008e5e80415a57061d) | 

## Members

#### `public uint8_t `[`port`](#structwdg__dev__t_1a786cf92373aac7c9a42dd347d7b2a5d2) 

#### `public `[`wdg_config_t`](#structwdg__config__t)` `[`config`](#structwdg__dev__t_1af51b548a8c3ea402b6021fc36649b49a) 

#### `public void * `[`priv`](#structwdg__dev__t_1a9e5e3b763ff5a2008e5e80415a57061d) 

Generated by [Moxygen](https://sourcey.com/moxygen)