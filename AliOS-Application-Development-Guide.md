# 概述
本文将描述如何基于AliOS源码进行应用开发，涉及的内容包括：硬件环境准备、开发环境搭建、如何创建第一个应用程序、AliOS主要开发组件的使用等。

# 硬件环境准备
本文以庆科MK3060模组为例。AliOS还可以运行在其他模组上，硬件环境的搭建请参照本节。

## MK3060模组
MK3060是ARM核的Wi-Fi模组，可以运行AliOS。
![](https://img.alicdn.com/tfs/TB1dkGJdwoQMeJjy0FoXXcShVXa-4160-2336.jpg)

## 串口线
MK3060的串口已经通过miniusb接口接出，只需要通过miniusb-usb线将串口与PC连接起来。
![](https://img.alicdn.com/tfs/TB16paGdwoQMeJjy0FnXXb8gFXa-4160-2336.jpg)

## 调试器
支持Jlink调试器。
![](https://img.alicdn.com/tfs/TB1AOuudwMPMeJjy1XdXXasrXXa-4160-2336.jpg)

## 连接示例
下图展示了连接好的硬件环境。
![](https://img.alicdn.com/tfs/TB1niqudwMPMeJjy1XdXXasrXXa-4160-2336.jpg)

# 开发环境搭建
AliOS开发环境的搭建请参照：[AliOS Environment Setup](https://github.com/alibaba/AliOS/wiki/AliOS-Environment-Setup)

AliOS的开发支持IDE和命令行工具，本文的讲述基于AliOS Studio IDE。关于AliOS Studio的安装和使用，请参照：[AliOS Studio](https://github.com/alibaba/AliOS/wiki/AliOS-Studio)
# AliOS应用开发步骤
AliOS的应用开发步骤主要包括工程目录的创建、工程Makefile编写、源码编写、工程编译、程序烧录、调试等步骤。
## 创建工程目录
AliOS的应用工程一般放在“example”目录下，用户也可以根据需要在其他目录下创建应用工程的目录。
## 添加Makefile
Makefile用于指定应用的名称、使用到的源文件、依赖的组件、全局符号等。下面是helloworld.mk文件的内容：
```
NAME := helloworld  ## 指定应用名称
$(NAME)_SOURCES := helloworld.c  ## 指定使用的源文件
$(NAME)_COMPONENTS += cli  ## 指定依赖的组件，本例使用cli组件
GLOBAL_DEFINES += YOS_NO_WIFI ## 定义全局符号
```
## 添加源码
所有的源码文件放置在应用工程目录下，开发者可以根据自行组织源码文件/目录。AliOS的应用程序入口为：
`int application_start(int argc, char *argv[]);`

所有的应用程序都必需包含`application_start`入口函数，应用程序的逻辑从该入口函数开始。

## 编译工程
使用AliOS Studio编译，请参照：[使用AliOS Studio编译](https://github.com/alibaba/AliOS/wiki/AliOS-Studio#编译)

## 烧录程序
参照：[使用AliOS Studio烧录](https://github.com/alibaba/AliOS/wiki/AliOS-Studio#烧写)

## 程序调试
参照：[使用AliOS Studio调试](https://github.com/alibaba/AliOS/wiki/AliOS-Studio#调试)

# 第一个AliOS应用
本节以helloworld工程为例来说明如何创建一个AliOS应用。
## 创建工程目录
在AliOS Studio中，在“example”目录下添加helloworld工程目录。
![](https://img.alicdn.com/tfs/TB1M_iGdwMPMeJjy1XcXXXpppXa-1115-455.png)

## 创建Makefile
在hellworld工程目录下，创建helloworld.mk文件，并添加Makefile内容：
```
NAME := helloworld
$(NAME)_SOURCES := helloworld.c
```
## 创建源文件
在hellworld工程目录下，创建helloworld.c文件，并添加一下源代码：
```
#include <aos/aos.h>

static void app_delayed_action(void *arg)
{
    printf("%s:%d %s\r\n", __func__, __LINE__, aos_task_name());
    aos_post_delayed_action(5000, app_delayed_action, NULL);
}

int application_start(int argc, char *argv[])
{
    aos_post_delayed_action(1000, app_delayed_action, NULL);
    aos_loop_run();
}
```

## 编译、烧录和运行
请按照前述章节对helloworld应用进行编译和烧录，烧录后启动模组，helloworld应用启动后串口打印如下：

![](https://img.alicdn.com/tfs/TB11fSrdwMPMeJjy1XdXXasrXXa-231-161.png)

# AliOS开发组件介绍
## cli
AliOS应用开发中可以支持命令行，并且可以添加用户自定义命令。当需要注册或撤销自定义命令时，可以借助“cli”组件。
### 头文件：
`<aos/cli.h>`
### 组件依赖：
`$(NAME)_COMPONENTS += cli`
### 接口举例
```
int cli_register_command(const struct cli_command *command);
int cli_register_commands(const struct cli_command *commands, int num_commands);
int cli_unregister_command(const struct cli_command *command);
```

下图展示了一个实际示例应用中的命令列表。

![](https://img.alicdn.com/tfs/TB1ETiGdwMPMeJjy1XcXXXpppXa-447-367.png)

## log
使用“log”组件可以定义和使用不同级别的日志打印。
### 头文件：
`aos/log.h`
### 组件依赖：
`$(NAME)_COMPONENTS += log`
### 接口示例：
```
LOGF(mod, fmt, ##__VA_ARGS__)
LOGE(mod, fmt, ##__VA_ARGS__)
LOGW(mod, fmt, ##__VA_ARGS__)
LOGI(mod, fmt, ##__VA_ARGS__)
LOGD(mod, fmt, ##__VA_ARGS__)
LOG(fmt, ##__VA_ARGS__)
```

## yloop
yloop是AliOS的一个异步框架，可以监听网络和本地事件，目前AliOS都是通过yloop管理系统事件的分发，可以最大程度的利用cpu资源，并节省系统内存开销

### 头文件：
`aos/yloop.h`
### 组件依赖：
`$(NAME)_COMPONENTS += yloop`
### 接口示例：
```
int aos_register_event_filter(uint16_t type, aos_event_cb cb, void *priv);
int aos_unregister_event_filter(uint16_t type, aos_event_cb cb, void *priv);
int aos_post_event(uint16_t type, uint16_t code, unsigned long  value);
int aos_poll_read_fd(int fd, aos_poll_call_t action, void *param);
void aos_cancel_poll_read_fd(int fd, aos_poll_call_t action, void *param);
int aos_post_delayed_action(int ms, aos_call_t action, void *arg);
int aos_schedule_call(aos_call_t action, void *arg);
int aos_loop_schedule_call(aos_loop_t *loop, aos_call_t action, void *arg);
void *aos_loop_schedule_work(int ms, aos_call_t action, void *arg1,
                             aos_call_t fini_cb, void *arg2);
void aos_cancel_work(void *work, aos_call_t action, void *arg1);
```


### 使用参考：

1 如何监听发送事件
```
task1 :
//注册监听一个EV_WIFI事件，wifi_service_event为callback
aos_register_event_filter(EV_WIFI, wifi_service_event, NULL);
//建立监听loop，阻塞当前线程
aos_loop_run()

task2:
//task2获取到了wifi got ip消息的之后，post该事件，将唤醒task1中的监听EV_WIFI的callback
aos_post_event(EV_WIFI, CODE_WIFI_ON_GOT_IP,NULL)
```


2 如何动态添加事件
```
当我们需要将某一个监听的fd放到yloop来监听时，需要在yloop的上下文中执行该操作,wifi_service_event就是yloop上下文执行的
void wifi_service_event(input_event_t *event, void *priv_data) {
    XXXX
    inf fd = connect();
    aos_poll_read_fd(fd, cb_recv, NULL);
｝
```
3 发送延时事件
```
aos_post_delayed_action，需要在yloop上下文执行
```


4 如何将action放到yloop主线程中执行
```
调用者不在yloop主线程时，可使用该函数切换到yloop主线程上下文执行
aos_schedule_call（action， NULL）
```

## kv
kv组件用于永久性存储键(Key)-值(Value)类型数据，如系统配置信息等。
### 头文件：
`aos/kv.h`
### 组件依赖：
`$(NAME)_COMPONENTS += modules.fs.kv`
### 接口示例：
```
int aos_kv_set(const char *key, const void *value, int len, int sync);
int aos_kv_get(const char *key, void *buffer, int *buffer_len);
int aos_kv_del(const char *key);
```

## alink
alink组件用于alink上云连接服务，如配网、数据上报alink等。
### 头文件：
`aos/alink.h`
### 组件依赖：
`$(NAME)_COMPONENTS += protocol.alink`
### 接口示例：
```
int alink_start(void);
int alink_end(void);
int alink_report(const char *method, char *json_buffer);
int alink_register_callback(unsigned char cb_type, void *cb_func);
int awss_start(void);
```

## kernel
所有kernel提供的组件，包括内存管理、任务管理、timer、锁、信号量、计时等接口和服务。
### 头文件：
`aos/kernel.h`
### 组件依赖：
依赖此组件不需要显式指定。
### 接口示例：
```
void *aos_malloc(unsigned int size);
void *aos_zalloc(unsigned int size);
void aos_free(void *mem);
int aos_task_new(const char *name, void (*fn)(void *), void *arg,
                 int stack_size);
void aos_task_exit(int code);
int aos_mutex_new(aos_mutex_t *mutex);
int aos_sem_new(aos_sem_t *sem, int count);
int aos_queue_new(aos_queue_t *queue, void *buf, unsigned int size,
                  int max_msg);
int aos_timer_new(aos_timer_t *timer, void (*fn)(void *, void *),
                  void *arg, int ms, int repeat);
int aos_work_sched(aos_work_t *work);
void aos_msleep(int ms);
```

## network
network组件提供网络服务，如通用的和符合POSIX标准的socket接口。
### 头文件：
`aos/network.h`
### 组件依赖：
不需要显式申明。
### 接口示例：
```
int socket (int namespace, int style, int protocol);
int send (int socket, void *buffer, size_t size, int flags);
int sendto (int socket, void *buffer, size_t size, int flags, struct sockaddr *addr, socklen_t length);
int recv (int socket, void *buffer, size_t size, int flags);
int recvfrom (int socket, void *buffer, size_t size, int flags, struct sockaddr *addr, socklen_t 
 *lengthptr);
int listen (int socket, int n);
int bind (int socket, struct sockaddr *addr, socklen_t length);
int accept (int socket, struct sockaddr *addr, socklen_t *length_ptr);
 int accept (int socket, struct sockaddr *addr, socklen_t *length_ptr);
int select (int nfds, fd_set *read-fds, fd_set *write-fds, fd_set *except-fds, struct timeval *timeout);
int close (int filedes);
```

## vfs
vfs组件是对真实文件系统操作/设备操作的一层抽象层，通过vfs组件，用户可以使用统一的接口沟通底层不同文件系统或设备。
### 头文件：
`aos/vfs.h`
### 组件依赖
不需要显式申明。
### 接口示例：
```
int aos_open(const char *path, int flags);  
int aos_close(int fd);  
ssize_t aos_read(int fd, void *buf, size_t nbytes);  
ssize_t aos_write(int fd, const void *buf, size_t nbytes);  
int aos_ioctl(int fd, int cmd, unsigned long arg);  
int aos_poll(struct pollfd *fds, int nfds, int timeout);  
int aos_fcntl(int fd, int cmd, int val);  
off_t aos_lseek(int fd, off_t offset, int whence);  
int aos_sync(int fd);  
int aos_stat(const char *path, struct stat *st);  
int aos_unlink(const char *path);  
int aos_rename(const char *oldpath, const char *newpath);  
aos_dir_t *aos_opendir(const char *path);  
int aos_closedir(aos_dir_t *dir);  
aos_dirent_t *aos_readdir(aos_dir_t *dir);  
int aos_mkdir(const char *path);
```
# 总结
本文描述了基于AliOS的应用模型，介绍了软硬件开发环境的搭建、应用开发的基本步骤。以helloworld为例，展示了如何基于AliOS进行应用开发。本文最后，还介绍了AliOS提供的丰富组件和接口，以及如何利用这个组件进行应用开发。
想了解AliOS更详细的信息，请访问[AliOS Github主页](https://github.com/alibaba/AliOS)。