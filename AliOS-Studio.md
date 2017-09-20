# 目录
  * [1 工具安装](#1工具安装)
  * [2 代码开发](#2代码开发)
  * [3 代码编译](#3代码编译)
  * [4 镜像烧写](#4镜像烧写)
  * [5 代码调试](#5代码调试)

------

AliOS-Studio 是 AliOS 提供的 IDE 开发环境，目前支持 Windows，后续会增加对 Linux、 MacOS 等操作系统的支持。

# 1工具安装
AliOS-Studio 是 VS Code 插件，所以首先安装 VS Code ，通过插件的方式安装 AliOS-Studio。

## 1.1 VS Code 安装
在 [VS Code](https://code.visualstudio.com) 官网下载安装包并安装：

![](https://img.alicdn.com/tfs/TB1ACciXPihSKJjy0FlXXadEXXa-865-558.png)


## 1.2 AliOS-Studio安装
通过VS Code插件，安装AliOS-Studio：

![](https://img.alicdn.com/tfs/TB1S4fhfgMPMeJjy1XcXXXpppXa-865-387.png)

安装完成后，会提示重启 VS Code，重启后 AliOS-Studio 插件生效。

# 2代码开发
通过VS Code - 文件 - 打开文件夹，打开 AliOS 代码目录：

![](https://img.alicdn.com/tfs/TB1xmpKbaagSKJjy0FhXXcrbFXa-865-429.png)

![](https://img.alicdn.com/tfs/TB1Fl4LbamgSKJjSsplXXaICpXa-865-447.png)

AliOS-Studio提供了常用APP模板，在 bar 栏 Create Project 或者 Ctrl + shift + P，在命令栏里面使用 alios-studio: Create Project，使用配置界面配置模板，首次使用，需要设置 SDK 路径（ AliOS 源码所在位置）：

![](https://img.alicdn.com/tfs/TB1yxHXavxNTKJjy0FjXXX6yVXa-865-458.png)

点击 Submit 按钮，根据模块配置创建APP:

![](https://img.alicdn.com/tfs/TB1gsbnfgoQMeJjy1XaXXcSsFXa-865-493.png)

在项目里面编辑代码。

# 3代码编译
点击下 bar 栏的 build 按钮，或者 Ctrl + shift + P，在命令栏里面使用 alios-studio: build， 编译成功之后的输出：

![](https://img.alicdn.com/tfs/TB1eRRYbjihSKJjy0FfXXbGzFXa-865-449.png)

在下 bar 栏可以选择APP及对应的板子，如果需要更多的编译配置选项，左侧的BUILD TARGET可以选择或者添加新的BUILD TARGET目标。

# 4镜像烧写
## 4.1 串口烧写（MK3060为例）
配置串口烧写 COM 端口（成功安装串口驱动后，才能正确的识别端口。参考 [AliOS Environment Setup](https://github.com/alibaba/AliOS/wiki/AliOS-Environment-Setup)），点击下 bar 栏的 Connect Device 按钮，或者 Ctrl + shift + P，在命令栏里面使用 alios-studio: Connect Device，选择串口的 COM 端口：

![](https://img.alicdn.com/tfs/TB1U8TEfgoQMeJjy1XaXXcSsFXa-865-442.png)

配置 COM 端口的波特率:

![](https://img.alicdn.com/tfs/TB1YjjJfgMPMeJjy1XbXXcwxVXa-865-444.png)

可以看到日志输出，进入bootloader模式（按住boot按键，再按reset按键），点击下 bar 栏的 UpLoad 按钮，或者 Ctrl + shift + P，在命令栏里面使用 alios-studio: Upload，烧写image。

## 4.2 J-Link烧写（MK3060为例）
J-Link连接模组（成功安装J-Link驱动后，才能正确建立J-Link连接。参考 [AliOS Environment Setup](https://github.com/alibaba/AliOS/wiki/AliOS-Environment-Setup)），在左侧的 BUILD TARGET 选择 alinkapp@mk3060 JTAG=jlink download：

![](https://img.alicdn.com/tfs/TB1AebMfgoQMeJjy0FpXXcTxpXa-865-441.png)

会编译并且烧写image到模组。


# 5代码调试
固件烧写完成后，可通过串口查看日志，必要时，需要使用 JLink 单步调试。进入 bootloader 模式，调试-启动调试，进入单步调试：

![](https://img.alicdn.com/tfs/TB1VQxMcgoQMeJjy0FoXXcShVXa-865-458.png)

![](https://img.alicdn.com/tfs/TB1O7xMcgoQMeJjy0FoXXcShVXa-865-457.png)

默认设置的断点是 application_start 函数，可修改 VS Code gdb 启动配置 launch.json 修改启动断点位置。



