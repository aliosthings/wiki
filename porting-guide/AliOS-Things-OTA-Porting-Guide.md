## 1.1 背景
OTA升级作为物联网设备的一项基础功能，可以快速修复软件漏洞，更新系统,对于快速迭代的物联网产品是刚性需求；目前IOT设备种类繁多，但并未提供统一的OTA升级方案，针对日益发展的IOT设备，开发者迫切需要一套云端一体化的OTA升级方案来满足快速迭代的产品开发周期，同时降低产品开发和部署的成本。

## 1.2 目标
对于接入AliOS Things的物联网设备，阿里巴巴云端和设备端OTA组件为用户提供云端一体化的OTA升级服务; 对于使用OTA升级服务的用户只需按照此文档实现移植层接口后就可以轻松使用阿里巴巴物联网OTA升级服务。

## 1.3 使用对象
<span data-type="color" style="color:windowtext">使用AliOS Things RTOS、AliOS Things Linux Edition的开发者或用户。</span>

## 1.4 移植指引
OTA设备端软件架构如下图所示，OTA核心组件为通用组件，设备端OTA整体功能移植到不同的平台和操作系统，需分别实现如图标注为__<span data-type="color" style="color:#F5222D">粉色的底层平台接口移植层</span>__和__<span data-type="color" style="color:#F5222D">操作系统接口移植层</span>__，如操作系统使用AliOS Things RTOS或<span data-type="color" style="color:windowtext">Linux Edition默认已内置</span><span data-type="color" style="color:#262626">支持OTA核心组件，操作系统移植接口已完成对接</span><span data-type="color" style="color:windowtext">，新芯片或者模组导入只需简单</span>__<span data-type="color" style="color:#F5222D">实现底层平台移植层接口（5个接口）</span>__<span data-type="color" style="color:#262626">就可以正常使用AliOS 云端一体化的OTA服务</span><span data-type="color" style="color:windowtext">。</span>




![image.png | left | 747x481](https://cdn.nlark.com/lark/0/2018/png/111302/1535815192305-1cce8071-844e-4850-bbe3-765679a4c6d3.png "")



## 1.5 移植接口列表

平台移植层接口列表：
对应文件:
middleware/uagent/uota/hal/ota\_hal\_plat.h
platform/mcu/moc108/port/ota\_port.c
接口列表:

01 ota\_init\n
02 ota\_write\n
03 ota\_read
04 ota\_set\_boot
05 ota\_rollback

操作系统移植层接口列表：
对应文件:
middleware/uagent/uota/hal/ota\_hal\_os.h
middleware/uagent/uota/hal/ota\_hal\_os.c

接口列表:
01 ota\_malloc

02 ota\_free

03 ota\_mutex\_init

04 ota\_mutex\_lock

05 ota\_mutex\_unlock

06 void ota\_mutex\_destroy

07 ota\_semaphore\_init

08 ota\_semaphore\_wait

09 ota\_semaphore\_post

10 ota\_semaphore\_destroy

11 ota\_thread\_create;

12 ota\_thread\_exit

13 ota\_timer\_create

14 ota\_timer\_start

15 ota\_msleep

16 ota\_kv\_set

17 ota\_kv\_get

18 ota\_socket\_connect

19 ota\_socket\_send

20 ota\_socket\_recv

21 ota\_socket\_close

22 ota\_ssl\_connect

23 ota\_ssl\_send

24 ota\_ssl\_recv

25 ota\_hal\_mqtt\_publish

26 ota\_hal\_mqtt\_subscribe

27 ota\_hal\_mqtt\_deinit\_instance

28 ota\_hal\_mqtt\_init\_instance

## 1.6 移植接口详细说明

<div class="bi-table">
  <table>
    <colgroup>
      <col width="50px" />
      <col width="337px" />
      <col width="364px" />
    </colgroup>
    <tbody>
      <tr>
        <td rowspan="23" colSpan="1">
          <div data-type="p">底层接口</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">底层平台移植层接口（5个）</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">移植使用说明</div>
        </td>
      </tr>
      <tr>
        <td rowspan="1" colSpan="1">
          <div data-type="p">hal_stat_t hal_ota_init(void *something); hal_stat_t hal_ota_write(hal_ota_module_t *m, volatile uint32_t*off_set,uint8_t *in_buf , uint32_t len); hal_stat_t hal_ota_read(hal_ota_module_t *m, volatile uint32_t*off_set,uint8_t *out_buf, uint32_t
            len); hal_stat_t hal_ota_set_boot(hal_ota_module_t *m, void *something); hal_stat_t hal_ota_rollback(hal_ota_module_t *m, void *something);
          </div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">新芯片或模组导入需实现平台移植层5个接口函数就可以使用OTA云端一体化服务，<strong><span data-type="color" style="color:#F5222D">前三个接口移植到AliOS请参考使用标准flash hal接口实现：文件路径kernel/rhino/hal/soc/flash.h。 </span></strong>init需要实现初始化OTA分区及分区检查擦除，write实现对下载数据解释后分段写入OTA分区中，read完成从flash读出数据，
            <span
              data-type="color" style="color:#262626">set_boot用于升级成功时告诉boot下次启动到新升级的分区,rollback用于与bootloader共同完成升级失败后回滚到老的分区</span>（<span data-type="color" style="color:#F5222D"><strong>仅适用于双备份分区升级方式</strong></span>）。</div>
        </td>
      </tr>
      <tr>
        <td rowspan="1" colSpan="1">
          <div data-type="p">操作系统移植层接口（28个）</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">　</div>
        </td>
      </tr>
      <tr>
        <td rowspan="20" colSpan="1">
          <div data-type="p">void *ota_malloc(uint32_tsize); void ota_free(void *ptr); void *ota_mutex_init(void); void ota_mutex_lock(void *mutex); void ota_mutex_unlock(void *mutex); void ota_mutex_destroy(void *mutex); void *ota_semaphore_init(void); int ota_semaphore_wait(void
            *sem, uint32_t timeout_ms); void ota_semaphore_post(void *sem); void ota_semaphore_destroy(void *sem); int ota_thread_create(void **thread_handle,void *(*work_routine)(void*), void *arg, hal_os_thread_param_t *param, int *stack_used); void
            ota_thread_exit(void *thread); void *ota_timer_create(const char *name, void (*func)(void *), void*user_data); int ota_timer_start(void *t, int ms); void ota_msleep(uint32_t ms); int ota_kv_set(const char *key, const void *val, int len, int
            sync); int ota_kv_get(const char *key, void *buffer, int *buffer_len); int ota_socket_connect(char *host, int port); int ota_socket_send(int fd,  char*buf, size_t len); int ota_socket_recv(int fd,  char*buf, size_t len); void ota_socket_close(int
            fd); void* ota_ssl_connect(const char *host, uint16_t port, const char*ca_crt,uint32_t ca_crt_len); int32_t ota_ssl_send(void* ssl,  char*buf, uint32_t len); int32_t ota_ssl_recv(void* ssl,  char*buf, uint32_t len); int ota_hal_mqtt_publish(char
            *topic, int qos, void *data, int len); int ota_hal_mqtt_subscribe(char *topic, void (*cb)(char *topic, inttopic_len,                              void*payload, int payload_len, void *ctx), void *ctx); int ota_hal_mqtt_deinit_instance(void);
            int ota_hal_mqtt_init_instance(char *productKey, char *deviceName, char*deviceSecret, int maxMsgSize);
          </div>
        </td>
        <td rowspan="20" colSpan="1">
          <div data-type="p"><span data-type="color" style="color:#262626">操作系统移植层接口，AliOS Things RTOS和Linux Edition下已实现完成，无对接工作；但移植到新的操作系统上需重新确认对接（大部分可以复用）。</span></div>
        </td>
      </tr>
      <tr></tr>
      <tr></tr>
      <tr></tr>
      <tr></tr>
      <tr></tr>
      <tr></tr>
      <tr></tr>
      <tr></tr>
      <tr></tr>
      <tr></tr>
      <tr></tr>
      <tr></tr>
      <tr></tr>
      <tr></tr>
      <tr></tr>
      <tr></tr>
      <tr></tr>
      <tr></tr>
      <tr></tr>
      <tr>
        <td rowspan="1" colSpan="1">
          <div data-type="p">应用接口</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">void ota_service_init(NULL)；</div>
        </td>
        <td rowspan="1" colSpan="1">
          <div data-type="p">由系统或用户注册成为后台服务</div>
        </td>
      </tr>
    </tbody>
  </table>
</div>