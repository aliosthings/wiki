# Window环境配置
## Cube安装
Cube依赖python 2.7版本，在官网下载对应的2.7版本的[Python](https://www.python.org/downloads/) msi文件。安装过程中，请选择add python.exe to Path，如下图所示：

打开命令行，输入python命令能找到，说明安装成功。

进入到Python的安装目录（比如Python安装在C盘，则在C:\Python27\Scripts目录下面），用easy_install安装pip：

`easy_install pip`

安装完成pip后，使用pip安装aos-cube：

`pip install aos-cube`

## 交叉工具链
AliOS默认带有Linux交叉工具链，Windows下面的工具链可以在[gcc](https://launchpad.net/gcc-arm-embedded/+download)下载对应的版本，解压缩并且重命名为Win32，复制到...\aos\build\compiler\arm-none-eabi-5_4-2016q2-20160622\目录下面：

在AliOS源码的目录下面，运行：

`aos make helloworld@mk3060`

编译mk3060板子的helloworld示例程序。

# Linux环境配置
以Ubuntu 16.04 LTS (Xenial Xerus) 64-bit PC版本为例，安装下列pkg：

```
$ sudo apt-get install -y gcc-multilib
$ sudo apt-get install -y libssl-dev libssl-dev:i386
$ sudo apt-get install -y libncurses5-dev libncurses5-dev:i386
$ sudo apt-get install -y libreadline-dev libreadline-dev:i386
$ sudo apt-get install -y python-pip
$ sudo pip install aos-cube`
```

在AliOS源码的目录下面，运行：

`aos make helloworld@mk3060`

编译mk3060板子的helloworld示例程序。

