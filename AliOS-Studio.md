AliOS-Studio 是 AliOS 提供的 IDE 开发环境，目前支持 Windows，后续会支持 Linux、 MacOS 操作系统。

# 1 Studio 安装
AliOS-Studio 是 VS Code 插件，所以首先安装 VS Code ，通过插件的方式安装 AliOS-Studio。

## 1.1 VS Code 安装
在 [VS Code](https://code.visualstudio.com) 官网下载安装包并安装：

![](https://img.alicdn.com/tfs/TB1ACciXPihSKJjy0FlXXadEXXa-865-558.png)


## 1.2 AliOS-Studio安装
内测版本是通过 VS Code 打开 alios-studio.vsix 文件来安装插件（后续会发布的插件市场，可直接在插件市场中搜索安装），打开VS Code - 扩展， 选择从 VSIX 安装，打开 alios-studio.vsix 文件：

![](https://img.alicdn.com/tfs/TB1wk8zcgoQMeJjy1XaXXcSsFXa-864-640.png)

插件安装成功之后，会提示 Reload VScode，重启 VScode 后，下 bar 栏会有 Build, upload, clean…等 button：

![](https://img.alicdn.com/tfs/TB1fsREciERMeJjy0FcXXc7opXa-865-690.png)

AliOS-Studio依赖C/C++插件，在安装AliOS-Studio插件后，会提示安装C/C++插件：

![](https://img.alicdn.com/tfs/TB1sz8FcgMPMeJjy1XbXXcwxVXa-865-564.png)


# 2 项目
## 2.1 基于 AliOS 源码开发
文件 - 打开文件夹，打开 AliOS 代码目录：
![](https://img.alicdn.com/tfs/TB17cxGcgMPMeJjy1XbXXcwxVXa-865-690.png)

![](https://img.alicdn.com/tfs/TB1JvFKcgoQMeJjy0FoXXcShVXa-865-689.png)

## 2.2 创建 APP 项目
使用下 bar 栏 Create Project 或者 Ctrl + shift + P，在命令栏里面使用 alios-studio: Create Project，使用配置界面配置模板，首次使用，需要设置 SDK 路径（ AliOS 源码所在位置）：

![](https://img.alicdn.com/tfs/TB1hNJGcgMPMeJjy1XbXXcwxVXa-865-453.png)

依据模板建立APP项目：

![](https://img.alicdn.com/tfs/TB16xBGcgoQMeJjy0FpXXcTxpXa-865-452.png)

# 3 编译
直接点击下 bar 栏的 build 按钮，或者 Ctrl + shift + P，在命令栏里面使用 alios-studio: build， 编译成功之后的输出：
![](https://img.alicdn.com/tfs/TB1Emyrb.tWMKJjy0FaXXcCDpXa-865-630.png)

# 4 烧写
配置一下 COM 端口，配置端口前确认驱动安装成功，参考 [AliOS Environment Setup](https://github.com/alibaba/AliOS/wiki/AliOS-Environment-Setup)。点击Device list按键，可以出现当前检测到的 COM 端口清单。

![](https://img.alicdn.com/tfs/TB1TdxAciIRMeJjy0FbXXbnqXXa-740-552.png)

选择 COM 端口:


![](https://img.alicdn.com/tfs/TB1D_hycgMPMeJjy1XdXXasrXXa-659-664.png)

配置COM 端口的波特率，回车。


![](https://img.alicdn.com/tfs/TB1GFNHcgoQMeJjy1XaXXcSsFXa-652-590.png)

如图，输出 “open serial port com …” 表示已经成功连接到端口。

![](https://img.alicdn.com/tfs/TB1EFXIcgMPMeJjy1XbXXcwxVXa-741-663.png)

点击 upload，下载固件。

![](https://img.alicdn.com/tfs/TB1q_dIcgoQMeJjy0FnXXb8gFXa-865-731.png)

# 5 调试
固件烧写完成后，可通过串口查看日志，必要时，需要使用 JLink 单步调试。进入 bootloader 模式，调试-启动调试，进入单步调试：

![](https://img.alicdn.com/tfs/TB1VQxMcgoQMeJjy0FoXXcShVXa-865-458.png)

![](https://img.alicdn.com/tfs/TB1O7xMcgoQMeJjy0FoXXcShVXa-865-457.png)

默认设置的断点是 application_start 函数，可修改 VS Code gdb 启动配置 launch.json 修改启动断点位置。



