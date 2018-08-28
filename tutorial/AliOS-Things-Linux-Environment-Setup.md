# linux环境配置

可以尝试爱好者提供的一键安装脚本：[Setup Script for Linux/Mac](https://alios-things-public.oss-cn-hangzhou.aliyuncs.com/setup_linux_osx.sh)。

## 安装python和aos-cube
aos-cube是 AliOS Things 基于Python开发的项目管理工具包，依赖 Python 2.7 版本（64bits，2.7.14已验证）。主要分为两部分：python和pip安装、基于pip安装aos-cube及相关的依赖包。
> 注意：请安装 python 2.7
```
# 安装python和pip
$ sudo apt-get install -y python
$ sudo apt-get install -y python-pip

# 完成python和pip安装后，再安装依赖库和aos-cube，步骤如下：
$ python -m pip install setuptools
$ python -m pip install wheel
$ python -m pip install aos-cube

# 如果在安装aos-cube遇到网络问题，可使用国内镜像源，步骤如下：
### 安装/升级 pip
$python -m pip install --trusted-host=mirrors.aliyun.com -i https://mirrors.aliyun.com/pypi/simple/ --upgrade pip

### 基于pip依次安装第三方包和aos-cube
$ pip install --trusted-host=mirrors.aliyun.com -i https://mirrors.aliyun.com/pypi/simple/   setuptools
$ pip install --trusted-host=mirrors.aliyun.com -i https://mirrors.aliyun.com/pypi/simple/   wheel
$ pip install --trusted-host=mirrors.aliyun.com -i https://mirrors.aliyun.com/pypi/simple/   aos-cube

### 如需要使用doubanio作备用源，如需指定版本，可改成如aos-cube==0.2.50
$ pip install  --trusted-host pypi.doubanio.com -i  http://pypi.doubanio.com/simple/  aos-cube
```
因涉及多种开发环境和具体版本的依赖，针对开发者的实际情况，还给出一种简单方便且不影响当前系统环境的方法----基于虚拟环境virtualenv的方法，以便备用。前提：上述python和pip安装完成；具体步骤如下：
```
# pip 安装 virtualenv, 如安装成功，可以在pip list查看版本
$ python -m pip install virtualenv

# 如遇网络问题，可使用阿里云镜像
$ pip install --trusted-host=mirrors.aliyun.com -i https://mirrors.aliyun.com/pypi/simple/ virtualenv

# 建立虚拟环境，如安装到~/venv(可更改)
$ virtualenv  ~/venv --no-download

# 启动虚拟环境，下面执行使用 '.'
$ . ~/venv/bin/activate

# 安装 aos-cube和必要的依赖包
$ `请参考上述b)aos-cube及相关依赖安装`

# 退出虚拟环境
$ deactivate
```

## 交叉工具链

在 AliOS Things 源码的目录下面，运行：

```
$ aos make helloworld@mk3060
```

编译 mk3060 板子的 helloworld 示例程序。
根据所选的平台，会自动下载相应的工具链。

## minicom串口配置
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

## 一些小技巧
Linux 操作串口及 j-link 会有root权限要求，尤其在使用 AliOS-Things Studio时候，对串口及 j-link 的权限需要先做配置：
- `$ sudo usermod -a -G dialout $(whoami)`,添加当前用户到 dialout 组，提供直接使用串口能力。
- `$lsubs` 找到 j-link 厂商ID。如：`Bus 002 Device 008: ID 1366:0105 SEGGER`,厂商ID为1366，新建`/etc/udev/rules.d/99-stlink-v2.rules`文件，在文件里面添加规则:`SUBSYSTEM=="usb", ATTR{idVendor}=="1366", MODE="666", GROUP="plugdev"`。

配置操作串口及 j-link权限后，重启系统生效。