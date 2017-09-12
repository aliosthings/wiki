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
## 编译工程
## 烧录程序
## 程序调试
# 第一个AliOS应用
# AliOS开发组件
# 总结