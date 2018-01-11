# 目录
- [1 环境配置](#1-环境配置)
    - [1.1 python](#11-python)
    - [1.2 ucube](#12-ucube)
    - [1.3 工具链](#13-工具链)
- [2 工程](#2-工程)
    - [2.1 获取工程](#21-获取工程)
    - [2.2 新建工程](#22-新建工程)
- [3 组件](#3-组件)
    - [3.1 组件信息](#31-组件信息)
    - [3.2 添加组件](#32-添加组件)
    - [3.3 删除组件](#33-删除组件)
- [4 新建组件](#4-新建组件)
------
**AliOS-Things uCube** 是 AliOS-Things 项目开发管理工具（简写命令为 aos）：
1. 编译代码、Image下载、板子调试。
2. 创建模板工程，基于模板做再次开发。
3. 支持组件化，获取组件信息，组件的自由组合，满足业务场景的不同需求。

# 1 环境配置 
## 1.1 python
uCube 基于 Python（Version：2.7）语言开发，需要有 Python（Version：2.7）开发环境（Python 2.7.14 下验证测试通过）。
## 1.2 ucube
使用 pip 安装 uCube 工具（在 MacOS 和 Linux上需要 sudo）：  

`$ sudo pip install -U aos-cube`  

安装完成后， `aos --version` (aos-cube 简写命令）输出版本号。

## 1.3 工具链
使用 uCube 的编译、工程创建等功能，用到工具链。工具链的配置，参考 [AliOS Things Environment Setup](https://github.com/alibaba/AliOS-Things/wiki/AliOS-Things-Environment-Setup) 系统环境配置 -> 交叉工具链配置。
# 2 工程
## 2.1 获取工程
`aos ls` 命令查看验证测试通过的模板工程信息：
```
$ aos ls -t

                             AliOS-Things PROGRAM TARGET
|==========================================================================|
| BOARD                | APP                                               |
|==========================================================================|
| b_l475e              | mqttapp helloworld tls                            |
| linux                | alinkapp helloworld linuxapp meshapp tls yts      |
| mk3060               | alinkapp helloworld linuxapp meshapp tls          |
| esp32devkitc         | alinkapp helloworld                               |
|==========================================================================|
```
板子硬件配置为board，业务场景为app，提供app和board信息新建一个工程。

## 2.2 新建工程
`aos new` 命令新建工程信息  
### 2.2.1 已有 AliOS-Things 源码 
1. 设置本地 AliOS-Things 源码绝对路径作为 **AOS_SDK_PATH**：
```
$ aos config -g AOS_SDK_PATH /Users/oujunli/code/AliOS-Things
[AliOS-Things] /Users/oujunli/code/AliOS-Things now set as global AOS_SDK_PATH
```
2. `aos new helloworld@mk3060 helloworld`, 会新建 helloworld 目录，并在 helloworld 创建工程，进入 helloword 目录，`aos make helloworld@mk3060` 编译

### 2.2.2 用 AliOS-Things 最新源码
1. 配置 GitHub，确认可以从 GitHub 拉取代码。
2. 使用`aos new helloworld@mk3060 helloworld`, 会 clone 一份 AliOS-Things 最新源码作为 **AOS_SDK_PATH**（如果设置过 **AOS_SDK_PATH**，使用 `aos config -g -u AOS_SDK_PATH`, unset **AOS_SDK_PATH**，否则会引用到原来的 **AOS_SDK_PATH**，`aos config -l`可查看配置信息）并且在 helloworld 目录下新建工程，进入 helloword 目录，`aos make helloworld@mk3060` 编译。

# 3 组件
## 3.1 组件信息
非 AliOS-Things 工程目录下面，`aos ls -c` 可以查看 AliOS-Things 所有的组件：
```

Current directory isn't AliOS-Things program, just list all components.

                                                      AliOS-Things COMPONENTS
|===================================================================================================================|
| NAME                           | LOCATION                                                                         |
| socket_stm32wifi               | AliOS-Things/framework/fota/download/http/socket/stm32wifi                       |
| libdigest                      | AliOS-Things/utility/iotx-utils/digest                                           |
| mbedtls                        | AliOS-Things/security/mbedtls                                                    |
| App_Ble_Scan                   | AliOS-Things/example/bluetooth/ble_scan                                          |
| libid2                         | AliOS-Things/security/libid2                                                     |
| hal_init                       | AliOS-Things/platform/mcu/csky/hal_init                                          |
| MX1101                         | AliOS-Things/platform/mcu/mx1101                                                 |
| digest_algorithm_test          | AliOS-Things/test/testcase/utility/digest_algorithm_test                         |
| alinkapp                       | AliOS-Things/example/alinkapp                                                    |
| hal                            | AliOS-Things/kernel/hal                                                          |
| cli                            | AliOS-Things/tools/cli                                                           |
| base64                         | AliOS-Things/utility/base64                                                      |
...
```

在 AliOS-Things 工程目录下面（aos new TARGET），`aos ls -c` 查看 AliOS-Things 组件同时，还可以看到组件在当前项目的状态：
```

                                                      AliOS-Things COMPONENTS
|===================================================================================================================|
| NAME                           | LOCATION                                                               | STATUS  |
| socket_stm32wifi               | AliOS-Things/framework/fota/download/http/socket/stm32wifi             | unused  |
| libdigest                      | AliOS-Things/utility/iotx-utils/digest                                 | unused  |
| mbedtls                        | AliOS-Things/security/mbedtls                                          | unused  |
| App_Ble_Scan                   | AliOS-Things/example/bluetooth/ble_scan                                | unused  |
| libid2                         | AliOS-Things/security/libid2                                           | unused  |
| hal_init                       | AliOS-Things/platform/mcu/csky/hal_init                                | unused  |
| MX1101                         | AliOS-Things/platform/mcu/mx1101                                       | unused  |
| digest_algorithm_test          | AliOS-Things/test/testcase/utility/digest_algorithm_test               | unused  |
| alinkapp                       | AliOS-Things/example/alinkapp                                          | unused  |
| hal                            | AliOS-Things/kernel/hal                                                | used    |
| cli                            | AliOS-Things/tools/cli                                                 | used    |
| base64                         | AliOS-Things/utility/base64                                            | unused  |
...
```

## 3.2 添加组件
在 AliOS-Things 工程目录下面（aos new TARGET），添加一个没有使用过的组件：  
```
# aos add mesh
[AliOS-Things] Add component mesh (local) in aos/kernel/protocols/mesh
```  
```
# aos ls -c
                                                      AliOS-Things COMPONENTS
|===================================================================================================================|
| NAME                           | LOCATION                                                               | STATUS  |
...
| mesh                           | AliOS-Things/kernel/protocols/mesh                                     | used    |
...
```
mesh 组件添加成功。
组件添加后，基于组件功能开发。

支持添加 AliOS-Things 原有组件的同时，uCube 还支持通过 URL 添加组件（新建组件参考 [Add a new component example](https://github.com/alibaba/AliOS-Things/wiki/Add-a-new-component-example))：
```
# aos add https://github.com/AliOS-Things/test_component.git
[AliOS-Things] Adding component "test_component" from "https://github.com/AliOS-Things/test_component.git" at latest revision in the current branch
[AliOS-Things] Add component test_component (remote) in test_component
```
通过 URL 添加远程组件。

## 3.3 删除组件
```
# aos rm mesh
[AliOS-Things] Remove component mesh (local) in aos/kernel/protocols/mesh
```  

```
# aos ls -c
                                                      AliOS-Things COMPONENTS
|===================================================================================================================|
| NAME                           | LOCATION                                                               | STATUS  |
...
| mesh                           | AliOS-Things/kernel/protocols/mesh                                     | unused  |
...
```
删除 mesh。

# 4 新建组件
`aos new` 命令除了新建工程外，还可以新建组件：
```
# aos new helloworld
```
在当前目录根据组件模板创建 helloworld 组件。添加组件功能代码，发布到 GitHub， 通过 Git 可以共享组件功能。