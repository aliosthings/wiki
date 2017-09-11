# Studio安装
AliOS-Studio是VScode插件，因此分别需要安装VScode和AliOS-Studio插件。
## VScode安装
从[VScode](https://code.visualstudio.com)官网下载安装包，安装VScode。
## AliOS-Studio插件
内测版本是通过alios-studio.vsix文件来安装插件（后续会发布的插件市场，可直接在插件市场中搜索安装）：
![](https://img.alicdn.com/tfs/TB1wk8zcgoQMeJjy1XaXXcSsFXa-864-640.png)

插件安装成功之后，会提示Reload VScode，重启VScode后，下bar栏会有Build, upload, clean…等button：
![](https://img.alicdn.com/tfs/TB1fsREciERMeJjy0FcXXc7opXa-865-690.png)

AliOS-Studio依赖C/C++插件，在安装AliOS-Studio插件后，会提示安装C/C++插件：
![](https://img.alicdn.com/tfs/TB1sz8FcgMPMeJjy1XbXXcwxVXa-865-564.png)


# 项目
## 基于AliOS源码开发
文件-打开文件夹，打开AliOS代码目录：
![](https://img.alicdn.com/tfs/TB17cxGcgMPMeJjy1XbXXcwxVXa-865-690.png)

![](https://img.alicdn.com/tfs/TB1JvFKcgoQMeJjy0FoXXcShVXa-865-689.png)

## APP开发者
使用下bar栏Create Project或者Ctrl+shift+P，在命令栏里面使用alios-stuid: Create Project，使用配置界面配置模板，设置sdk路径（AliOS源码所在位置）：
![](https://img.alicdn.com/tfs/TB1hNJGcgMPMeJjy1XbXXcwxVXa-865-453.png)

依据模板建立APP项目：
![](https://img.alicdn.com/tfs/TB16xBGcgoQMeJjy0FpXXcTxpXa-865-452.png)

# 编译
有两种方式，一种直接点击下面的build即可，或者Ctrl+shift+P，在命令栏里输入命令。编译成功之后的输出界面如下显示。
![](https://img.alicdn.com/tfs/TB1Emyrb.tWMKJjy0FaXXcCDpXa-865-630.png)

# 烧写
首先要配置一下COM端口，配置端口前对应的驱动得先安装好。点击Device list按键，可以出现当前检测到的COM端口清单。
![](https://img.alicdn.com/tfs/TB1TdxAciIRMeJjy0FbXXbnqXXa-740-552.png)

选择你需要的COM端口:


![](https://img.alicdn.com/tfs/TB1D_hycgMPMeJjy1XdXXasrXXa-659-664.png)

配置好端口的波特率：921600，回车。


![](https://img.alicdn.com/tfs/TB1GFNHcgoQMeJjy1XaXXcSsFXa-652-590.png)

如图，输出“”open serial port com …“”表示已经成功连接到端口。



![](https://img.alicdn.com/tfs/TB1EFXIcgMPMeJjy1XbXXcwxVXa-741-663.png)

点击upload，下载固件。

![](https://img.alicdn.com/tfs/TB1q_dIcgoQMeJjy0FnXXb8gFXa-865-731.png)

# 调试
固件烧写完成后，可通过串口查看日志，必要时，需要使用jlink单步调试。进入bootloadr模式，调试-启动调试，进入单步调试：
![](https://img.alicdn.com/tfs/TB1VQxMcgoQMeJjy0FoXXcShVXa-865-458.png)

![](https://img.alicdn.com/tfs/TB1O7xMcgoQMeJjy0FoXXcShVXa-865-457.png)

默认设置的断点是application_start函数，可修改VScode gdb 启动配置launch.json修改启动断点位置。



