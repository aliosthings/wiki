AliOS Things 是 AliOS 家族旗下的、面向 IoT 领域的、轻量级物联网嵌入式操作系统。文本旨在给大家示范一下其中的lorawanapp的示例，完成一个lorawan网络的构建和数据传输，并通过该示例让大家对AliOS Things有一个粗浅的了解。


## 如下分别介绍了基于VSC, IAR, Keil三个Toolchain的工程示例：
- [基于VSC](https://github.com/alibaba/AliOS-Things/wiki/AliOS-Things-lorawanapp(VSC))
- [基于IAR](https://github.com/alibaba/AliOS-Things/wiki/AliOS-Things-lorawanapp(IAR))
- [基于Keil](https://github.com/alibaba/AliOS-Things/wiki/AliOS-Things-lorawanapp(Keil))

## 不同Toolchain下代码大小比较
   |    Compiler    | Flash(KB) | RAM(KB) | Optimization Level |
   | -------------- | --------- | ------- | ------------------ |
   | gcc            |  61.26    | 6.67    | -Os                |
   | iccarm(IAR)    |  43.83    | 6.18    | -O3                |
   | armcc(Keil)    |  42.64    | 6.20    | -O3                |


*因为Lorawan内有浮点运算，而大部分跑lorawan的mcu均不含硬件浮点能力，所以需要软件实现，不同编译器会有比较大的代码差异。

## 结语

这边给大家介绍了一个AliOS Things的lorawan示例，因为是系统级的示例，相对比较复杂，步骤比较多，难免有错漏的地方，大家看到了请指正，此外因为该示例是lorawan网络的初始实现，细节部分不完善，如API的接口，函数封装不够细致等等，但主要目的是让大家了解AliOS Things的使用和lorawan网络的应用，让大家有一个感性的认识，希望大家可以以此为起点，去感受AliOS Things的易用和强大，以及快速实现lorawan的部署和测试。