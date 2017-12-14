AliOS Things is Alibaba's IoT version of AliOS Family, it's announced in [The Computing Conference](https://yunqi.aliyun.com) 2017 Hangzhou by Alibaba Cloud, and open sourced in 2017/10/20 at github:https://github.com/alibaba/AliOS-Things.

## Architecture Overview

From architectural point of view, AliOS Things adapts Layered Architecture, and Component Architecture. From bottom to top, AliOS Things includes:

- BSP: Board Support Package mainly developed and maintained by SoC Vendor
- HAL: Hardware Abstraction Layer, like WiFi, UART
- Kernel: Rhino RTOS Kernel, Yloop, VFS, KV Storage included
- Protocol Stack: LwIP TCPIP Stack, uMesh mesh networking stack included
- Security: TLS, TFS(Trusted Framework Service), TEE(Trusted Exexcution Environment)
- AOS API: AliOS Things exposed APIs for Application and Middleware
- Middleware: Alibaba's value-added and commonly seen IoT components included
- Examples: hands-on sample codes, and well tested applications such as Alinkapp

And all of the modules are organized as Component, each component has its own .mk file to describe its dependecy with other Components, which make it easy for applications to choose the components needed.

### Block Diagram

---

![block_digram](https://img.alicdn.com/tfs/TB1fKQMihrI8KJjy0FpXXb5hVXa-2330-1292.png)

### Folder structure

---

| Folder Name | Description                              |
| ----------- | ---------------------------------------- |
| board       | evaluation board such as STM32L496G-Discovery |
| build       | build infrastructure                     |
| device      | peripherals connected to MCU/SoC, such as Serial WiFi Module utilizing AT |
| example     | hands-on sample codes, well tested industry application such as alinkapp |
| framework   | IoT common components                    |
| include     | system include headers                   |
| kernel      | including Rhino, Protocol Stack          |
| platform    | including arch holding cpu related files, mcu holding SoC special files |
| security    | security components including TLS/TFS/TEE |
| tools       | cli and testbed for constructing remote device center |
| utility     | IoT common libraries such as cjson       |
| test        | UT testcases                             |

## Kernel Description

### Rhino RTOS Kernel

---

Rhino is in-house designed and developed RTOS kernel by AliOS Things team. Rhino provides ultra-small footprint, low power, priority-based/preemptive scheduling, Round-Robin scheduling, multitasking.

Rhino provides rich kernel primitives including buffer queue, ring buffer, timer, semaphore, mutex, fifo, event etc.

#### Small footprint

Rhino supportsboth static and dynamic allocation for most of the kernel objects. A memoryallocator designed for small memory block management, can support both fixedblock and variable block, multiple memory region.

Most of the kernelfeatures including workqueue, memory allocator and so on could be configurable inor out by per-build file named k_config.h. 

With the ability to scale component in and out, rhino could make the very small size of final image, which could be programmed into device which has very same flash size.

#### Low power

For the IOT device, it’s very important to consider the power consumption for hardware because the buffer of power is limited, the system consume the power faster the live time of system is shorter. Rhino kernel provides tickles idle mode of CPU to help system to save the power and extend the live time of system.

Normally, When CPU has nothing to do, CPU will execute a native instruction of the processor (WFI for ARM, HLT for IA32-bit processors) to enter a low power state, the CPU register context is maintained,and system tick clock interrupts wakes up the CPU at every tick moment.

To save more power than the normal way, rhino kernel provides tickles idle mode of CPU. When OS detect there is nothing to do in feature with a fixed duration (multiple ticks or more long), we call this fixed duration as tickles idle time, and the system tick clock is programmed to fire interrupt with tickles idle time and put CPU into C1 state(CPU execute a native instruction, WFI for ARM, HLT for IA 32-bit processors), from that point there is no system tick clock interrupt happen anymore and the system tick count stop to increase and CPU is in low power mode(C1) until tickless idle time passed and the system tick timer interrupt is fired again to wakeup CPU from C1 to C0 state, and passed ticks is compensated to system tick count.

#### Real time

Rhino provides two scheduling policy, priority-based/preemptive scheduling and round-robin scheduling. For both scheduling policy, the highest priority task is always preferred for scheduling.

A priority-based preemptive scheduler preempts the CPU when a task has a higher priority than the current task running. Thus, the kernel ensures that the CPU is always allocated to the highest priority task that is ready to run. This means that if a task with a higher priority than that of the current task becomes ready to run, the kernel immediately saves the current task's context, and switches to the context of the higher priority task.

A round-robin scheduler is going to share the CPU amongst these tasks by using time-slicing. Each task in a group of tasks with the same priority executes for a defined interval, or time slice, before relinquishing the CPU to the next task in the group. No one of them, therefore, can usurp the processor until it is blocked. When the time slice expires, the task moves to last place in the ready queue list for that priority.

#### Debug features

Rhino can support stack overflow, memory leak, memory corruption detection which help developer figure out root cause of difficult issues. Cooperating with AliOS Studio IDE, Rhino's trace function help visualize overall system activities.

### Yloop event framework

---

Yloop is an asynchronous event framework, highly considering [libuv](https://github.com/libuv/libuv) and event loop used in Embedded world. Yloop provide a mechanism to handle IO(mainly socket), timer, system events, user events in a single task which greatly reduce memory usage while avoid the complexity of multi-threading programming.

Yloop instance is bound to task context, multiple Yloop instances can be created, each bound to a single task, so that more performance can be achieved in powerful hardware.

### KV

---

Designed for flash especially NOR Flash:

- much less erase times to extend flash life
- power safe, no middle-state status will exist
- key-value friendly usage, value supports binary format data
- minimum supported flash size is 8KB

## Protocol Stack Description

To help device connected to cloud more easily, AliOS Things provide protocol stacks in flexible ways.

For IP oriented devices:

- a well tested LwIP stack is provided for directly connected SoCs, including WiFi Soc, MCU+SDIO/SPI WiFi Module etc.
- SAL(Socket Adapter Layer) for MCU attached with serial communication module such as WiFi/NB/GPRS.
- uMesh for building more complex, mesh networking topology

For non-IP devices:

- LoRaWAN stack is integrated
- BLE standard APIs, and BLE Stack

LoRaWAN and BLE Stack will be integrated in the near future.

### LwIP

---

AliOS Things maintains a TCP/IP stack based on LwIP v2.0.0, support IPv4 Only, IPv6 Only, IPv4&IPv6 Coexist. Both IPv4 and IPv6 are well tested in daily CI. IPv6 are heavily used and tested in uMesh.

### SAL(Socket Adapter Layer)

---

SAL is to provide standard Socket capabilities to serial WiFi/GPRS/NB-IoT modules. Specially, considering that AT Command is the most popular form in this scenario, a AT Parser is provided to help handling AT.

With SAL, developer can use common Socket APIs to access network, which will reduce many integration efforts of existing software components.

### uMesh

---

uMesh is a mesh implementation with following features:

- RF standards independent, currently 802.11/802.15.4/BLE are supported, more can be supported
- Routing mesh, support Tree Topology, Mesh Topology, Layered Tree&Mesh Topology
- Self healing, no single point of failures
- Low Power Mode
- EAP(Extensible Authentication Protocol) with ID<sup>2</sup>
- Seamless IPv4/IPv6 integration providing Socket programming environment 



## Security Description

### TLS

---

Inherited from mbedtls, highly optimized for footprint. 

### TFS(Trusted Framework Service)

---

Framework for accessing most of the security services such as ID<sup>2</sup>.

### ID<sup>2</sup>(Internet Device ID)

Trusted identity for Internet of things device.

### KM(Key Management)

---

Providing runtime Root Of Trust through using security capabilities of hardware.

### Ali-Crypto

---

Providing classical algorithms implementation.

### TEE(Trusted Execution Environment)

---

Providing total TEE soulution, C-Sky CK802T architecture are supported, ARMV8-M will be supported in the near feature. 

## Middleware Components

### FOTA

---

FOTA (Firmware Over Tth Air) make device firmware update easily, AliOS Things provide customized FOTA solutions according to hardware configuration. Working with Alibaba Cloud services, AliOS Things provides a end-to-end solution.

Features:

- supports rich IoT Protocols(Alink/MQTT/CoAP)
- support http/https/CoAP firmware download
- support multiple bin,delta and A/B update 
- provide OTA HAL to make porting easily

### uData

---

uData is a especial software framework for IoT smart service based on kinds of sensors,and has a general name as Sensor Hub traditionally. 

There are two parts in the uData Framework, one is in the framework layer including uData service manager, service algo, abstact model(abs), the other is in the kernel layer providing the sensor driver SDK. 

The target scope of uData service will focus on the IoT business like drone toy, smart street lamp, sweeper robot and so on. The sensor drivers not only provide the sensor SDK, but also provide the knids of sensor drivers like ALS, Barometer,temperature, accelerometer, gyro, magnetometer etc.

### IoT Protocols

---

AliOS Things supports rich cloud connection protocols:

- Alink: Alibaba Cloud Link platform, suitable for Smart Life. WiFi Provisioning component YWSS is also included.
- MQTT: standard MQTT protocol, well tested combining with Alibaba Cloud IoT Suite.
- CoAP: light weight UDP-based protocol. Together with CoAP FOTA, it is possible to build a UDP only system for like NB-IoT device.

### AT Parser

---

AT Parser provides framework for handling AT commands with connected communication modules. AT Parser handles serial stream parsing, OOB callback could be registered to handle module special AT commands. Working with SAL, application can use BSD sockets even on a AT modules.  

## Tools

### AliOS Studio IDE

---

Implemented as a VS Code Plugin, providing edit/build/debug functionalities. Refer to https://github.com/alibaba/AliOS-Things/wiki/AliOS-Things-Studio for more details.

### uDevice Center

---

Cooperating with AliOS Studio, providing developers a remote, multiple devices debug environment. With the backbone Testbed framework, organizations can easily setup a CI based on real hardware.

## Summary

AliOS Things is designed for low power, resource constrained MCU, connectivity SoC, greatly suitable for IoT devices.

For more detailed information, please refer to : https://github.com/alibaba/AliOS-Things/wiki

