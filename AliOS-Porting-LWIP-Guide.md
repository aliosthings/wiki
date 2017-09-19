AliOS提供的LwIP协议栈，开发者可以按照以下步骤完成移植工作。

**1. 网卡驱动程序**  
网卡驱动程序的移植示例代码，[参考实现](https://github.com/alibaba/AliOS/blob/master/kernel/protocols/net/netif/ethernetif.c)。  
主要涉及到以下函数的相关修改：

`    static void low_level_init(struct netif *netif);  `  
    `static err_t low_level_output(struct netif *netif, struct pbuf *p);  `  
    `static struct pbuf *low_level_input(struct netif *netif);  `  

修改完成后，源代码需要存放在对应的平台(platform)下面。  

**2. 平台相关**  
平台相关的移植示例代码，[参考实现](https://github.com/alibaba/AliOS/blob/master/platform/mcu/beken/include/lwip-2.0.2/port/arch/cc.h)。  
主要定义包括类型定义，大小端设置，内存对齐等。  
如果参考实现与开发者实现一致，可以直接拷贝存放在对应的平台(platform)下面。  

**3. LwIP配置**  
LwIP配置修改的移植示例代码，[参考实现](https://github.com/alibaba/AliOS/blob/master/platform/mcu/beken/include/lwip-2.0.2/port/lwipopts.h)。  
如果参考配置和开发者配置一致，可以直接拷贝存放在对应的平台(platform)下面。  

**4. 与OS的对接**  
与OS的对接AliOS已经默认完成，开发者可以直接使用。[实现代码](https://github.com/alibaba/AliOS/blob/master/kernel/protocols/net/port/sys_arch.c)。  

**5. Makefile修改**  
完成上述修改后，需要修改对应平台(platform)下相关Makefile，[参考实现](https://github.com/alibaba/AliOS/blob/master/platform/mcu/beken/beken.mk)。