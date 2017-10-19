# 目录
- [1 硬件环境准备](#1-硬件环境准备)
    - [1.1 MK3060模组](#11-mk3060模组)
    - [1.2 串口线](#12-串口线)
    - [1.3 调试器](#13-调试器)
    - [1.4 调试器](#14-连接示例)
- [2 Windows环境配置](#2-windows环境配置)
    - [2.1 aos-cube安装](#21-aos-cube安装)
    - [2.2 交叉工具链](#22-交叉工具链)
    - [2.3 驱动安装](#23-驱动安装)
      - [2.3.1 串口驱动](#231-串口驱动)
      - [2.3.2 JTAG驱动](#232-jtag驱动)
- [3 Linux环境配置](#3-linux环境配置)
    - [3.1 依赖及aos-cube安装](#31-依赖及aos-cube安装)
    - [3.2 交叉工具链](#32-交叉工具链)
    - [3.3 minicom串口配置](#33-minicom串口配置)
- [4 J-Link烧写与调试](#4-j-link烧写与调试)
    - [4.1 OpenOCD](#41-openocd)
    - [4.2 J-Link烧写](#42-j-link烧写)
    - [4.3 J-Link调试](#43-j-link调试)
   
# 1 硬件环境准备
以庆科 MK3060 模组为例，介绍 AliOS Things 硬件环境的搭建，其他模组的硬件环境可参考本节。

## 1.1 mk3060模组
MK3060 是基于 ARM 核的 Wi-Fi 模组：

![](https://img.alicdn.com/tfs/TB1dkGJdwoQMeJjy0FoXXcShVXa-4160-2336.jpg)

## 1.2 串口线
MK3060 的串口已经通过miniusb接口接出，通过 miniusb-usb 线将串口与 PC 连接起来:

![](https://img.alicdn.com/tfs/TB16paGdwoQMeJjy0FnXXb8gFXa-4160-2336.jpg)

## 1.3 调试器
支持 Jlink 调试器:

![](https://img.alicdn.com/tfs/TB1bXEjg3MPMeJjy1XcXXXpppXa-4160-2336.jpg)

## 1.4 连接示例
连接好的硬件环境:

![](https://img.alicdn.com/tfs/TB1ThvGg3MPMeJjy1XdXXasrXXa-4160-2336.jpg)

# 2 windows环境配置
## 2.1 aos-cube安装
aos-cube 是 AliOS Things 在 Python 下面开发的项目管理工具包，依赖 Python 2.7 版本（在Python 2.7.14 版本上验证测试通过）。在 Python 官网下载对应的 2.7 版本的 [Python](https://www.python.org/downloads/) MSI 安装文件，安装时，选择 **pip** 和 **add python.exe to Path** 两个选项：

![](https://img.alicdn.com/tfs/TB1SlHyjqmgSKJjSspiXXXyJFXa-798-688.png)

安装配置完成 Python 后，使用 pip 安装 aos-cube：

`> pip install aos-cube`

## 2.2 交叉工具链
Windows 工具链可以在链接 [GCC](https://launchpad.net/gcc-arm-embedded/+download) 下载 Windows的exe安装，勾选 Add path to environment variable 选项：

![](https://img.alicdn.com/tfs/TB16JofcWagSKJjy0FaXXb0dpXa-865-620.png)

在 AliOS Things 源码的目录下面，运行：

```
$ aos make helloworld@mk3060
```

编译 mk3060 板子的 helloworld 示例程序。

## 2.3 驱动安装
### 2.3.1 串口驱动
**FTDI系列**

FTDI驱动，在 [FTDI](http://www.ftdichip.com/Drivers/D2XX.htm) 下载 Windows 驱动程序并安装。

对应驱动安装完成后，连接设备，可在计算机 - 设备管理 - 端口，查看对应转换端口状态：

![](https://img.alicdn.com/tfs/TB1Fflnd3MPMeJjy1XcXXXpppXa-864-633.png)

驱动安装完成后，连接串口线，配置串口参数。在 MobaXterm Personal Edition 下，以MK3060为例，Session - Serial，选择端口，波特率为921600， Advanced Serial setting 里面，Software 选择 Minicom （allow manual COM port setting）：

![](https://img.alicdn.com/tfs/TB1Fg4ibjihSKJjy0FiXXcuiFXa-865-522.png)

对应参数配置好一会，点击 OK 按钮，查看串口日志。

### 2.3.2 jtag驱动
**J-Link**

J-Link 驱动可在 [SEGGER J-Link驱动下载地址](https://www.segger.com/downloads/jlink/) 下，选择 J-Link Software and Documentation Pack，选择 J-Link Software and Documentation pack for Windows 下载安装：

![](https://img.alicdn.com/tfs/TB1s4L9bLNNTKJjSspfXXbXIFXa-865-466.png)

安装完成 J-Link 驱动后，需要安装 J-Link 的 libusb 驱动 [zadig](http://zadig.akeo.ie/)，下载后解压缩，运行 zadig.exe 或 zadig_xp.exe（Window XP系统）：

![](https://img.alicdn.com/tfs/TB1xyN2fgMPMeJjy1XcXXXpppXa-865-432.png)

选择 J-Link，driver 选择libusb-win32（v1.2.6.0），点击 Replace Driver，返回 successful 说明 libusb 安装成功：

![](https://img.alicdn.com/tfs/TB1OHStfgMPMeJjy1XcXXXpppXa-865-512.png)

关闭 zadig.exe，可在计算机 - 设备管理，查看 J-Link 识别状态：

![](https://img.alicdn.com/tfs/TB1XZcYaWagSKJjy0FhXXcrbFXa-865-568.png)

连接 J-Link 烧写或者调试。  

**如果此时还是没法连接上 J-Link，在 J-Link 的 libusb 驱动选择时，选择 libusbK (v3.0.7.0) 尝试（由于不同厂家的使用的 J-Link 固件版本不同，libusb-win32（v1.2.6.0）可以无法正常工作）。**

# 3 linux环境配置
## 3.1 依赖及aos-cube安装
以 Ubuntu 16.04 LTS (Xenial Xerus) 64-bit PC 版本为例，安装下列 pkg：

```
$ sudo apt-get install -y python
$ sudo apt-get install -y gcc-multilib
$ sudo apt-get install -y libssl-dev libssl-dev:i386
$ sudo apt-get install -y libncurses5-dev libncurses5-dev:i386
$ sudo apt-get install -y libreadline-dev libreadline-dev:i386
$ sudo apt-get install -y python-pip
$ sudo apt-get install -y minicom
$ sudo pip install aos-cube
```
## 3.2 交叉工具链
Linux 工具链可以在链接 [GCC](https://launchpad.net/gcc-arm-embedded/+download) 下载 Linux 压缩包，解压缩，在 .bashrc 里面配置
 TOOLCHAIN_PATH 路径（**注意：路径最后一个下划线 / 添加到路径**）：

![](https://img.alicdn.com/tfs/TB1GnAGg3oQMeJjy0FpXXcTxpXa-865-413.png)

在 AliOS Things 源码的目录下面，运行：

```
$ aos make helloworld@mk3060
```

编译 mk3060 板子的 helloworld 示例程序。

## 3.3 minicom串口配置
配置串口参数（以MK3060为例），配置文件（/etc/minicom/minirc.dfl）内容 ：

```
pu port             /dev/ttyUSB0
pu baudrate         921600
pu bits             8
pu parity           N
pu stopbits         1
pu rtscts           No
```

启动 minicom，查看串口日志。

# 4 j-link烧写与调试
## 4.1 openocd
j-link 烧写与调试，依赖于 [OpenOCD](https://files.alicdn.com/tpsservice/6b3d60f77fcfeb00979bbd27c16b17e3.zip)，下载后解压，拷贝的AliOS Things源码的 build 目录下：

![](https://img.alicdn.com/tfs/TB1AVBOnMMPMeJjy1XcXXXpppXa-1003-466.png)

## 4.2 j-link烧写
以 MK3060 为例，在编译的时候，带上jlink烧写参数：

`$aos make helloworld@mk3060 JTAG=jlink download`

会通过J-Link烧写固件到板子上。

## 4.3 j-link调试
以MK3060为例，首先按住boot按键，不要松开，再按一下reset键，松开reset键，进入bootloader模式：

![](https://img.alicdn.com/tfs/TB1KjVFhgMPMeJjy1XcXXXpppXa-865-792.png)

**Window调试**  

在AliOS Things源码目录下面，分别运行 OpenOCD 命令和 gdb命令。

在一个 CMD 窗口下面启动OpenOCD：

 `$.\build\OpenOCD\Win32\openocd -f .\\build\OpenOCD\interface\jlink.cfg -f .\\build\OpenOCD\beken\beken.cfg -f .\\build\OpenOCD\beken\beken_gdb_jtag.cfg -l out\openocd_log.txt`

在另外一个 CMD 窗口，启动 gdb：

`$ arm-none-eabi-gdb -x=.gdbinit -ex 'target remote localhost:3333' ./out/eclipse_debug/last_built.elf --tui`

**Linux 调试**  

在AliOS Things源码目录下面，分别运行 OpenOCD 命令和 gdb命令。

在一个 Shell 窗口启动OpenOCD：

 `$ ./build/OpenOCD/Linux64/openocd  -f  build/OpenOCD/interface/jlink.cfg -f  build/OpenOCD/beken.cfg -f  build/OpenOCD/beken_gdb_jtag.cfg -l out/openocd_log.txt`

在另外一个 Shell 窗口启动 gdb：

`$ arm-none-eabi-gdb -x=.gdbinit -ex 'target remote localhost:3333' ./out/eclipse_debug/last_built.elf --tui`

gdb 里面设置断点，打印堆栈信息（MK3060最大支持两个断点）。


