# 概述
本文将描述如何基于AliOS源码进行应用开发，涉及的内容包括：硬件环境准备、开发环境搭建、如何创建第一个应用程序、AliOS主要开发组件的使用等。

# 硬件环境准备
本文以庆科MK3060模组为例。AliOS还可以运行在其他模组上，硬件环境的搭建请参照本节。

## MK3060模组
MK3060模组ARM核的Wi-Fi模组，可以运行AliOS。
<img>

## 串口线
<img>

## 调试器
<img>

## 连接示例
<img>

# 开发环境搭建
AliOS开发环境的搭建请参照：[AliOS Environment Setup](https://github.com/alibaba/AliOS/wiki/AliOS-Environment-Setup)

AliOS的开发支持IDE和命令行工具，本文的讲述基于AliOS Studio IDE。关于AliOS Studio的安装和使用，请参照：[AliOS Studio](https://github.com/alibaba/AliOS/wiki/AliOS-Studio)
# AliOS应用开发步骤
AliOS的应用开发步骤主要包括工程目录的创建、工程Makefile编写、源码编写、工程编译、程序烧录、调试等步骤。
## 创建工程目录
AliOS的应用工程一般放在“example”目录下，用户也可以根据需要在其他目录下创建应用工程的目录。
## 添加Makefile
Makefile用于指定应用的名称、使用到的源文件、依赖的组件、全局符号等。下面是helloworld.mk文件的内容：

`NAME := helloworld  ## 指定应用名称`

`$(NAME)_SOURCES := helloworld.c  ## 指定使用的源文件`

`$(NAME)_COMPONENTS += cli  ## 指定依赖的组件，本例使用cli组件`

`GLOBAL_DEFINES      += YOS_NO_WIFI ## 定义全局符号`

## 添加源码
所有的源码文件放置在应用工程目录下，开发者可以根据自行组织源码文件/目录。AliOS的应用程序入口为：
`int application_start(int argc, char *argv[])`

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
<img>

## 创建Makefile
在hellworld工程目录下，创建helloworld.mk文件，并添加Makefile内容：

`NAME := helloworld`

`$(NAME)_SOURCES := helloworld.c`

## 创建源文件
在hellworld工程目录下，创建helloworld.c文件，并添加一下源代码：

`#include <aos/aos.h>`

`#include "helloworld.h"`

`static void app_delayed_action(void *arg)`

`{`

`    printf("%s:%d %s\r\n", __func__, __LINE__, yos_task_name());`

`    yos_post_delayed_action(5000, app_delayed_action, NULL);`

`}`

`int application_start(int argc, char *argv[])`

`{`

`    yos_post_delayed_action(1000, app_delayed_action, NULL);`

`    yos_loop_run();`
`}`

## 编译、烧录和运行
请按照前述章节对helloworld应用进行编译和烧录，烧录后启动模组，hellworld应用启动后串口打印如下：
<img>

# AliOS开发组件介绍
## cli
AliOS应用开发中可以支持命令行，并且可以添加用户自定义命令。当需要注册或撤销自定义命令时，可以借助“cli”组件。
### 头文件：
`<aos/cli.h>`
### 组件依赖：
`$(NAME)_COMPONENTS += cli`
### 接口举例
`int cli_register_command(const struct cli_command *command); //注册一个命令`
`int cli_register_commands(const struct cli_command *commands, int num_commands); //注册多个命令`
`int cli_unregister_command(const struct cli_command *command); //撤销命令`

## log
使用“log”组件可以定义和使用不同级别的日志打印。

# 总结