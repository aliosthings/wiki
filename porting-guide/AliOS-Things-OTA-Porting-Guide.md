## 1 背景
OTA升级作为物联网设备的一项基础功能，可以快速修复软件漏洞，更新系统,对于快速迭代的物联网产品是刚性需求；目前IOT设备种类繁多，但并未提供统一的OTA升级方案，针对日益发展的IOT设备，开发者迫切需要一套云端一体化的OTA升级方案来满足快速迭代的产品开发周期，同时降低产品开发和部署的成本。

## 2 目标
对于接入AliOS Things的物联网设备，阿里巴巴云端和设备端OTA组件为用户提供云端一体化的OTA升级服务; 对于使用OTA升级服务的用户只需按照此文档实现移植层接口后就可以轻松使用阿里巴巴物联网OTA升级服务。

## 3 使用对象
<span data-type="color" style="color:windowtext">使用AliOS Things 的开发者或用户，代码路径:</span>[https://github.com/alibaba/AliOS-Things.git](https://github.com/alibaba/AliOS-Things.git)<span data-type="color" style="color:rgb(36, 41, 46)"><span data-type="background" style="background-color:rgb(255, 255, 255)"> </span></span>分支:rel\_2.0.0

## 4 移植使用说明
AliOS Things OTA设备端软件架构如下图所示，OTA核心组件为通用组件，设备端OTA整体功能移植到不同的平台和操作系统，需分别实现如图标注为__<span data-type="color" style="color:#F5222D">粉色的底层平台接口移植层</span>__和__<span data-type="color" style="color:#F5222D">操作系统接口移植层</span>__，AliOS Things<span data-type="color" style="color:#262626">操作系统移植接口已完成对接</span><span data-type="color" style="color:windowtext">，因此使用时无需移植，新芯片或者模组导入只需简单</span>__<span data-type="color" style="color:#F5222D">实现底层平台移植层接口(5个回调函数接口)</span>__<span data-type="color" style="color:#262626">就可以正常使用AliOS Things云端一体化的OTA服务</span><span data-type="color" style="color:windowtext">。差分升级需要配合boot移植差分还原模块，目前只在平台8266和3080平台上面支持。</span>




![image.png | left | 747x481](https://img.alicdn.com/tfs/TB1MUKpgPTpK1RjSZKPXXa3UpXa-1320-986.png "")


## 
## 5 移植接口详细说明

### 5.1 启动服务接口

在设备连接上阿里云之后，可以通过调用ota\_service\_init(NULL)接口启动OTA服务,默认接口参数为空，将使用系统默认烧录的四元组，也可以手动传入四元组等参数启动，默认传输协议支持MQTT，固件下载协议支持HTTPs。

```c
typedef struct {
    int   inited;  /*If is inted*/
    char  pk[PRODUCT_KEY_MAXLEN + 1];/*Product Key*/
    char  ps[PRODUCT_SECRET_MAXLEN + 1];/*Product secret*/
    char  dn[DEVICE_NAME_MAXLEN + 1];/*Device name*/
    char  ds[DEVICE_SECRET_MAXLEN + 1];/*Device secret*/
    char  uuid[64];
    int   trans_protcol;  /*default:0--> MQTT 1-->COAP*/
    int   dl_protcol;     /*default:3--> HTTPS 1-->COAP 2-->HTTP*/
    int   sign_type;      /*default:0--> sha256 1--> md5 2-->RSA*/
    int   firm_size;
    char* dl_url;         /*Dowdload URL*/
    void* h_coap;
} ota_service_manager;

int ota_service_init(ota_service_manager* context);
```

### 5.2 底层平台移植层接口

OTA回调函数的实现代码位于`platform/mcu/xxx/hal/ota_port.c,`init实现初始化OTA分区及分区固件大小检查擦除，ota\_write实现对下载数据解释后分段写入OTA分区中，ota\_read完成从flash读出数据，ota\_set\_boot用于升级成功时告诉boot下次启动到新升级的分区, ota\_rollback用于乒乓升级升级时与bootloader共同完成回滚到老的分区，在平台初始化的时候会调用hal\_ota\_register\_module(&ota\_hal\_module)注册上述回调接口。

```c
struct hal_ota_module_s {
    hal_module_base_t base;

    /* Link to HW */
    int (*init)(hal_ota_module_t *m, void *something);
    int (*ota_write)(hal_ota_module_t *m, volatile uint32_t *off_set,
                     uint8_t *in_buf , uint32_t in_buf_len);
    int (*ota_read)(hal_ota_module_t *m,  volatile uint32_t *off_set,
                    uint8_t *out_buf , uint32_t out_buf_len);
    int (*ota_set_boot)(hal_ota_module_t *m, void *something);
    int (*ota_rollback)(hal_ota_module_t *m, void *something);
};
```


### init

| 函数原型 | int (\*init)(hal\_ota\_module\_t \*m, void \*something); |
| :--- | :--- |
| 描述 | 实现初始化OTA分区及分区固件大小检查擦。 |


### 入参

<div class="bi-table">
  <table>
    <colgroup>
      <col width="104px" />
      <col width="158px" />
      <col width="265px" />
      <col width="242px" />
    </colgroup>
    <tbody>
      <tr>
        <td rowspan="1" colSpan="1">
          <div data-type="alignment" data-value="center" style="text-align:center">
            <div data-type="p"><strong>参数</strong></div>
          </div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="alignment" data-value="center" style="text-align:center">
            <div data-type="p"><strong>类型</strong></div>
          </div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="alignment" data-value="center" style="text-align:center">
            <div data-type="p"><strong>描述</strong></div>
          </div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="alignment" data-value="center" style="text-align:center">
            <div data-type="p"><strong>备注</strong></div>
          </div>
        </td>
      </tr>
      <tr>
        <td rowspan="1" colSpan="1">
          <div data-type="p">m</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">hal_ota_module_t *</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">hal_module_base_t 结构体句柄</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p"></div>
        </td>
      </tr>
      <tr>
        <td rowspan="1" colSpan="1">
          <div data-type="p">something</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">void *</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">传递初始化参数如偏移实现断点续传</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p"></div>
        </td>
      </tr>
    </tbody>
  </table>
</div>


### 返回值

<div class="bi-table">
  <table>
    <colgroup>
      <col width="206px" />
      <col width="624px" />
    </colgroup>
    <tbody>
      <tr>
        <td rowspan="1" colSpan="1">
          <div data-type="alignment" data-value="center" style="text-align:center">
            <div data-type="p"><strong>值</strong></div>
          </div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="alignment" data-value="center" style="text-align:center">
            <div data-type="p"><strong>描述</strong></div>
          </div>
        </td>
      </tr>
      <tr>
        <td rowspan="1" colSpan="1">
          <div data-type="alignment" data-value="center" style="text-align:center">
            <div data-type="p">0</div>
          </div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">初始化成功</div>
        </td>
      </tr>
      <tr>
        <td rowspan="1" colSpan="1">
          <div data-type="alignment" data-value="center" style="text-align:center">
            <div data-type="p">-1</div>
          </div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">初始化失败</div>
        </td>
      </tr>
    </tbody>
  </table>
</div>



---


### ota\_write

| __函数原型__ | int (\*ota\_write)(hal\_ota\_module\_t \*m, volatile uint32\_t \*off\_set, uint8\_t \*in\_buf , uint32\_t in\_buf\_len); |
| :--- | :--- |
| __描述__ | 写入固件到flash |


### 入参

<div class="bi-table">
  <table>
    <colgroup>
      <col width="111px" />
      <col width="174px" />
      <col width="286px" />
      <col width="258px" />
    </colgroup>
    <tbody>
      <tr>
        <td rowspan="1" colSpan="1">
          <div data-type="alignment" data-value="center" style="text-align:center">
            <div data-type="p"><strong>参数</strong></div>
          </div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="alignment" data-value="center" style="text-align:center">
            <div data-type="p"><strong>类型</strong></div>
          </div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="alignment" data-value="center" style="text-align:center">
            <div data-type="p"><strong>描述</strong></div>
          </div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="alignment" data-value="center" style="text-align:center">
            <div data-type="p"><strong>备注</strong></div>
          </div>
        </td>
      </tr>
      <tr>
        <td rowspan="1" colSpan="1">
          <div data-type="p">m</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">hal_ota_module_t *</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">hal_module_base_t 结构体句柄</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p"></div>
        </td>
      </tr>
      <tr>
        <td rowspan="1" colSpan="1">
          <div data-type="p">off_set</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">volatile uint32_t *</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">指定flash地址的偏移量（offset）</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p"></div>
        </td>
      </tr>
      <tr>
        <td rowspan="1" colSpan="1">
          <div data-type="p">in_buf</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">uint8_t *</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">需要写入的数据</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p"></div>
        </td>
      </tr>
      <tr>
        <td rowspan="1" colSpan="1">
          <div data-type="p">in_buf_len</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">uint32_t</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">需要写入的数据长度</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p"></div>
        </td>
      </tr>
    </tbody>
  </table>
</div>


### 返回值

<div class="bi-table">
  <table>
    <colgroup>
      <col width="206px" />
      <col width="624px" />
    </colgroup>
    <tbody>
      <tr>
        <td rowspan="1" colSpan="1">
          <div data-type="alignment" data-value="center" style="text-align:center">
            <div data-type="p"><strong>值</strong></div>
          </div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="alignment" data-value="center" style="text-align:center">
            <div data-type="p"><strong>描述</strong></div>
          </div>
        </td>
      </tr>
      <tr>
        <td rowspan="1" colSpan="1">
          <div data-type="alignment" data-value="center" style="text-align:center">
            <div data-type="p">0</div>
          </div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">写入数据成功</div>
        </td>
      </tr>
      <tr>
        <td rowspan="1" colSpan="1">
          <div data-type="alignment" data-value="center" style="text-align:center">
            <div data-type="p">-1</div>
          </div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">写入数据失败</div>
        </td>
      </tr>
    </tbody>
  </table>
</div>



---


## ota\_read


| __函数原型__ | int (\*ota\_read)(hal\_ota\_module\_t \*m,  volatile uint32\_t \*off\_set,uint8\_t \*out\_buf , uint32\_t out\_buf\_len); |
| :--- | :--- |
| __描述__ | 从flash中读取数据到buffer中 |


### 入参

<div class="bi-table">
  <table>
    <colgroup>
      <col width="111px" />
      <col width="174px" />
      <col width="286px" />
      <col width="258px" />
    </colgroup>
    <tbody>
      <tr>
        <td rowspan="1" colSpan="1">
          <div data-type="alignment" data-value="center" style="text-align:center">
            <div data-type="p"><strong>参数</strong></div>
          </div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="alignment" data-value="center" style="text-align:center">
            <div data-type="p"><strong>类型</strong></div>
          </div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="alignment" data-value="center" style="text-align:center">
            <div data-type="p"><strong>描述</strong></div>
          </div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="alignment" data-value="center" style="text-align:center">
            <div data-type="p"><strong>备注</strong></div>
          </div>
        </td>
      </tr>
      <tr>
        <td rowspan="1" colSpan="1">
          <div data-type="p">m</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">hal_ota_module_t *</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">hal_module_base_t 结构体句柄</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p"></div>
        </td>
      </tr>
      <tr>
        <td rowspan="1" colSpan="1">
          <div data-type="p">off_set</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">volatile uint32_t *</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">指定flash地址的偏移量（offset）</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p"></div>
        </td>
      </tr>
      <tr>
        <td rowspan="1" colSpan="1">
          <div data-type="p">out_buf</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">uint8_t *</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">读取flash数据到该buf中</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p"></div>
        </td>
      </tr>
      <tr>
        <td rowspan="1" colSpan="1">
          <div data-type="p">out_buf_len</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">uint32_t</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">需要读取的数据长度</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p"></div>
        </td>
      </tr>
    </tbody>
  </table>
</div>


### 返回值

<div class="bi-table">
  <table>
    <colgroup>
      <col width="206px" />
      <col width="624px" />
    </colgroup>
    <tbody>
      <tr>
        <td rowspan="1" colSpan="1">
          <div data-type="alignment" data-value="center" style="text-align:center">
            <div data-type="p"><strong>值</strong></div>
          </div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="alignment" data-value="center" style="text-align:center">
            <div data-type="p"><strong>描述</strong></div>
          </div>
        </td>
      </tr>
      <tr>
        <td rowspan="1" colSpan="1">
          <div data-type="alignment" data-value="center" style="text-align:center">
            <div data-type="p">0</div>
          </div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">读取数据成功</div>
        </td>
      </tr>
      <tr>
        <td rowspan="1" colSpan="1">
          <div data-type="alignment" data-value="center" style="text-align:center">
            <div data-type="p">-1</div>
          </div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">读取数据失败</div>
        </td>
      </tr>
    </tbody>
  </table>
</div>



---


## ota\_set\_boot

| __函数原型__ | int (\*ota\_set\_boot)(hal\_ota\_module\_t \*m, void \*something); |
| :--- | :--- |
| __描述__ | 设置启动参数 |


### 入参

<div class="bi-table">
  <table>
    <colgroup>
      <col width="114px" />
      <col width="173px" />
      <col width="237px" />
      <col width="302px" />
    </colgroup>
    <tbody>
      <tr>
        <td rowspan="1" colSpan="1">
          <div data-type="alignment" data-value="center" style="text-align:center">
            <div data-type="p"><strong>参数</strong></div>
          </div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="alignment" data-value="center" style="text-align:center">
            <div data-type="p"><strong>类型</strong></div>
          </div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="alignment" data-value="center" style="text-align:center">
            <div data-type="p"><strong>描述</strong></div>
          </div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="alignment" data-value="center" style="text-align:center">
            <div data-type="p"><strong>备注</strong></div>
          </div>
        </td>
      </tr>
      <tr>
        <td rowspan="1" colSpan="1">
          <div data-type="p">m</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">hal_ota_module_t *</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">hal_module_base_t 结构体句柄</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p"></div>
        </td>
      </tr>
      <tr>
        <td rowspan="1" colSpan="1">
          <div data-type="p">something</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">void *</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">升级完成传递给boot的参数</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">参数请参考下面的说明</div>
        </td>
      </tr>
    </tbody>
  </table>
</div>


### 升级完成参数

```c
typedef struct  {
    OTA_ENUM_UPDATE_TYPE update_type;
    OTA_ENUM_RESULT_TYPE result_type;
    OTA_ENUM_FIRMWARE_TYPE  firmware_type;
    uint32_t splict_size;
    uint8_t diff_version;
    uint8_t rollback;
} ota_finish_param_t;
```

详细说明：

<div class="bi-table">
  <table>
    <colgroup>
      <col width="90px" />
      <col width="90px" />
      <col width="90px" />
    </colgroup>
    <tbody>
      <tr>
        <td rowspan="3" colSpan="1">
          <div data-type="alignment" data-value="center" style="text-align:center">
            <div data-type="p"><strong>update_type</strong></div>
          </div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">OTA_KERNEL</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">更新内核</div>
        </td>
      </tr>
      <tr>
        <td rowspan="1" colSpan="1">
          <div data-type="p">OTA_APP</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">更新app</div>
        </td>
      </tr>
      <tr>
        <td rowspan="1" colSpan="1">
          <div data-type="p">OTA_ALL</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">更新内核和app</div>
        </td>
      </tr>
      <tr>
        <td rowspan="2" colSpan="1">
          <div data-type="alignment" data-value="center" style="text-align:center">
            <div data-type="p"><strong>result_type </strong></div>
          </div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">OTA_FINISH</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">更新完成</div>
        </td>
      </tr>
      <tr>
        <td rowspan="1" colSpan="1">
          <div data-type="p">OTA_BREAKPOINT</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">更新中断</div>
        </td>
      </tr>
      <tr height="34px">
        <td rowspan="2" colSpan="1">
          <div data-type="alignment" data-value="center" style="text-align:center">
            <div data-type="p"><strong>firmware_type</strong></div>
          </div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">OTA_RAW</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">升级原始整包固件</div>
        </td>
      </tr>
      <tr height="34px">
        <td rowspan="1" colSpan="1">
          <div data-type="p">OTA_DIFF</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">升级差分包固件</div>
        </td>
      </tr>
      <tr height="34px">
        <td rowspan="1" colSpan="1">
          <div data-type="alignment" data-value="center" style="text-align:center">
            <div data-type="p"><strong>splict_size</strong></div>
          </div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">差分升级分片大小</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p"></div>
        </td>
      </tr>
      <tr height="34px">
        <td rowspan="1" colSpan="1">
          <div data-type="alignment" data-value="center" style="text-align:center">
            <div data-type="p"><strong>diff_version</strong></div>
          </div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">差分升级版本标识</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p"></div>
        </td>
      </tr>
      <tr height="34px">
        <td rowspan="1" colSpan="1">
          <div data-type="alignment" data-value="center" style="text-align:center">
            <div data-type="p"><strong>rollback</strong></div>
          </div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">预留支持回滚标识</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p"></div>
        </td>
      </tr>
    </tbody>
  </table>
</div>


### 返回值

<div class="bi-table">
  <table>
    <colgroup>
      <col width="206px" />
      <col width="624px" />
    </colgroup>
    <tbody>
      <tr>
        <td rowspan="1" colSpan="1">
          <div data-type="alignment" data-value="center" style="text-align:center">
            <div data-type="p"><strong>值</strong></div>
          </div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="alignment" data-value="center" style="text-align:center">
            <div data-type="p"><strong>描述</strong></div>
          </div>
        </td>
      </tr>
      <tr>
        <td rowspan="1" colSpan="1">
          <div data-type="alignment" data-value="center" style="text-align:center">
            <div data-type="p">0</div>
          </div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">设置成功</div>
        </td>
      </tr>
      <tr>
        <td rowspan="1" colSpan="1">
          <div data-type="alignment" data-value="center" style="text-align:center">
            <div data-type="p">-1</div>
          </div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">设置失败</div>
        </td>
      </tr>
    </tbody>
  </table>
</div>


## ota\_rollback

| __函数原型__ | int (\*ota\_rollback)(hal\_ota\_module\_t \*m, void \*something);; |
| :--- | :--- |
| __描述__ | 配合boot实现升级失败启动计数回滚到老的版本 |


### 入参

<div class="bi-table">
  <table>
    <colgroup>
      <col width="114px" />
      <col width="173px" />
      <col width="237px" />
      <col width="302px" />
    </colgroup>
    <tbody>
      <tr>
        <td rowspan="1" colSpan="1">
          <div data-type="alignment" data-value="center" style="text-align:center">
            <div data-type="p"><strong>参数</strong></div>
          </div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="alignment" data-value="center" style="text-align:center">
            <div data-type="p"><strong>类型</strong></div>
          </div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="alignment" data-value="center" style="text-align:center">
            <div data-type="p"><strong>描述</strong></div>
          </div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="alignment" data-value="center" style="text-align:center">
            <div data-type="p"><strong>备注</strong></div>
          </div>
        </td>
      </tr>
      <tr>
        <td rowspan="1" colSpan="1">
          <div data-type="p">m</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">hal_ota_module_t *</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">hal_module_base_t 结构体句柄</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p"></div>
        </td>
      </tr>
      <tr>
        <td rowspan="1" colSpan="1">
          <div data-type="p">something</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">void *</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">实现回滚参数如启动计数参数</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p"></div>
        </td>
      </tr>
    </tbody>
  </table>
</div>



## 6 OTA移植demo

以linux host上demo为例子，移植实现上述底层平台移植接口（以读写文件模拟读写存储设备）后，可通过在linux host上demo验证OTA下载通道逻辑，更详细的参见[AliOS Things OTA用户使用说明文档](https://github.com/alibaba/AliOS-Things/wiki/OTA-Tutorial)。
1） 按照[AliOS Things wiki文档](https://github.com/alibaba/AliOS-Things/wiki)按装好集成编译工具，并下载好源码
2） 在编译AliOS Things OTA Linux host  Demo程序 
      aos make clean;
      aos make otaapp@linuxhost
3)  Linuxhost下运行OTA Demo程序，确保PC正常联网并获取到IP地址
     ./otaapp@linuxhost.elf


![image | left | 706x90](https://img.alicdn.com/tfs/TB1fHatgNTpK1RjSZFMXXbG_VXa-1368-174.png "")


4）从云端创建产品，获取产品信息pk，dn，ds， ps，执行命令行运行
     OTA\_APP "a16UKrlKekO" "gateway\_test01" "AT2XFOPOIbJaKfXsKeaEhabJ8TLhMQYp" "RDluqbn3LQazrdqM"


![image | left | 706x145](https://img.alicdn.com/tfs/TB1wLOngHPpK1RjSZFFXXa5PpXa-1488-305.png "")

如上图打印显示对应的ota设备pk，dn注册OTA服务成功（__<span data-type="color" style="color:rgb(245, 34, 45)">注意确保设备信息PK，DN等正确</span>__）：

5）通过云端界面选择验证固件，点击确认后可以看到设备端OTA升级开始：


![image | left | 644x586](https://img.alicdn.com/tfs/TB1VjylgPDpK1RjSZFrXXa78VXa-746-679.png "")




![image | left | 726x142](https://img.alicdn.com/tfs/TB14tOogHrpK1RjSZTEXXcWAVXa-1477-287.png "")


升级完成，在Linux host下会将文件写入到当前目录的文件名字为alinkapp@linuxhost.elf文件中。 


![image | left | 726x96](https://img.alicdn.com/tfs/TB1AlmogIbpK1RjSZFyXXX_qFXa-1480-196.png "")

6) Linuxhost上验证完下载通道后可以编译运行对应设备端目标平台固件验证：
    aos  make otaapp@mk3060
烧录固件到对应设备平台后，运行和执行下载方式通linuxhost，区别在于平台移植接口的实现与对应平台存储接口对接，将对应固件更新写入对应的存储设备，并让更新设备正常启动。
