AliOS Things是一个Layered Architecture，自下而上包含：
- BSP：芯片厂商的板级代码
- HAL：硬件抽象层
- Kernel：包含自研的Rhino内核，Yloop，VFS，KV文件系统
- Protocols：协议栈，包括TCPIP，BLE，uMesh等
- Security：各类安全组件，包括TLS，TFS安全框架，TEE(可信执行环境)
- 中间件及服务：Alink/MQTT/CoAP连接协议，FOTA，JS引擎，AT指令框架

AliOS Things也是一个Component Architecture，开发者可以以非常直观的方式增减包括上述的各类组件。

AliOS Things通过[Yloop异步事件框架](https://github.com/alibaba/AliOS-Things/wiki/Yloop-Event-Framework)，让开发者在大部分场景免去多线程开发的复杂性。同时，丰富的调试工具，包括内存泄露溢出检测，栈溢出检测，System Trace等，帮助开发者提升效率。我们称之为极简开发。

uMesh是为了丰富设备接入IP网络的方式而自研的自组网框架，它不依赖于具体的无线标准，已经支持802.11/802.15.4/BLE多种通信方式，并支持混合组网。uMesh是一种Routing Mesh实现，支持树状和网状拓扑。uMesh配合各类传感器，可以搭建各种有趣又有用的应用。