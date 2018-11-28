![](https://i.imgur.com/Q8Jcei1.png)

# MW31 Module Boot File Update and Program Upgrade Instructions
---

</font></br>

## 准备条件：
### 硬件：

- 1、需要升级的MW31模块

- 2、带有CH340芯片的 3.3V USB转串口线（其他串口线可能存在升级失败的问题）

### 软件：
- 1、boot更新文件：**boot_180615.bin**

- 2、升级固件版本：**xxx_crc.bin**、**xxx.ota.bin**

- 3、MD5计算工具

- 4、HFS：搭建HTTP服务器

- 5、串口调试工具：推荐使用SSCOM，波特率115200

- 6、bk_writer_7231.exe

注：以上准备条件中相应软件和工具可以前往[上海诺行信息技术有限公司网站](http://www.notioni.com/#/source)获取，硬件工具请自行准备。确保以上准备条件完备后，可开始升级

## <font color="#dd0000">注意：
1.  本文档为Developerkit上的WiFi模块MW31升级指导，有UART（即串口）升级和OTA升级两种方式。该升级只适用于在windows电脑上进行。

2.  WiFi固件版本查询方式有两种：a. 出厂原始软件下，在UART1（即USB口）输入<AT+FWVER?\r>查询；b. 烧录了其他软件，用3.3V串口线连接UART2（连接TX、RX和GND三根线，接线方式参考后文UART升级部分），然后在UART2对应的串口输入<version\r>查询。
  
3.  出厂原始程序可访问[上海诺行信息技术有限公司网站](http://www.notioni.com/#/source)下载，将Developerkit.bin文件复制到TEST虚拟盘中，自动烧录。

4.  升级开始前请先关闭电脑防火墙以及其他杀毒软件，防止FOTA操作被拒绝。

## 更新流程：
- 对于UART升级方式，针对WiFi固件版本为APP-1.0.0-20180409.1719的MW31模块，**必须先进行Boot更新**（不更新Boot强制刷机会导致MW31模组损坏），再使用UART升级。
- 对于OTA升级方式，连接WIFI后直接FOTA升级即可

升级后的版本如若再升级，直接使用UART升级或者OTA升级即可。 

注：第一次升级建议使用UART升级方式。

## 一、连接WiFi网络
### 1.开发板使用USB连接PC，电脑端的设备管理器会映射出UART1，如图：

![](https://i.imgur.com/Z68KRri.png)

### 2.使用串口调试工具打开该端口，输入”AT\r”，返回OK，说明AT指令可正常使用，如图：

![](https://i.imgur.com/aoz1ee9.jpg)

### 3.输入”AT+WJAP=ssid,password\r”，连接WiFi网络，
例如：AT+WJAP=MERCURY_E87E,12345678\r    ,如图：

![](https://i.imgur.com/oZQUpEK.jpg)

返回ok，表明已经接入WiFi网络。接入WiFi网络后，开发板上的三色LED灯会开始循环闪烁。如下图：

接入WiFi后就可以开始Boot更新了。（注意FOTA升级必须在局域网环境中进行）。

## 二、UART升级

### 1.boot更新
仅针对固件版本为APP-1.0.0-20180409.1719的WiFi模块，需要先执行Boot更新，才能进行UART升级。因此，执行boot更新前，请先查询WiFi固件版本；保证开发板中的程序为出厂原始程序。确认无误后，方可继续进行。

a.打开hfs，将boot_180615.bin文件拖入左侧虚拟文件系统中，复制窗口中的地址（确保服务器地址为本机IP，若不是请点击 菜单-IP地址 进行更改）

![](https://i.imgur.com/b4LjpUI.png)

b.在UART1输入：AT+FOTA=size,version,url,md5\r
-   size : 右键升级bin文件的属性查询，文件大小为多少字节
-   version : 版本号高于APP-1.0.0-20180409.1719即可
-   url : 服务器上面的bin文件地址
-   md5 : 为校验码，使用MD5计算工具获取 

![](https://i.imgur.com/09ABzj2.jpg)

上述参数获取后，可得到这样一条具体的指令：
AT+FOTA=619786,app-1.0.8-20180620.2010,http://192.168.9.101:8085/boot_up_180615.bin,4821682ac03b9e23a68914021ea0d2e7\r
将整条语句复制到串口工具中，发送。成功后，hfs端显示完成下载，如图:

![](https://i.imgur.com/jsBbIP9.jpg)

## 2.UART升级
Developer Kit上特别引出了MW31模块的UART2，位于WiFi模块上侧，J801的上面两个排针，有丝印WiFi DL说明。如下图：

![](https://i.imgur.com/IMwcx40.png)

### a. 在UART2中输入：txevm -e 3\r ，覆盖模块之前的boot文件，系统执行过程中串口会有信息打印，如下图
![](https://i.imgur.com/myDe6E1.png)

然后**给开发板断电，关闭串口**（否则会占用串口，导致串口升级无法完成）。  

### b. 打开bk_writer_7231.exe，烧录对象选择BK7231，点击浏览选择对应的xxx_crc.bin文件。
选择通讯端口后，**先点击烧录，再给开发板上电**。烧录成功后显示如图：

![](https://i.imgur.com/x0IA4YN.jpg)

### c.升级完成后断电重启，再打开UART2串口
输入version\r，查看版本，升级后的版本为：APP-1.0.2-20180723.1759（后续再提供升级文件请以实际版本为主），即表示升级成功。如图

![](https://i.imgur.com/5EtbfXq.jpg)

## 三、OTA升级
### 1.打开hfs，将xxx.ota.bin文件拖入左侧虚拟文件系统中，复制窗口中的地址（确保服务器地址为本机IP，若不是请点击 菜单-IP地址 进行更改）

![](https://i.imgur.com/mKNnqTt.png)

### 2.在UART1输入：AT+FOTA=size,version,url,md5\r
- size : 右键升级bin文件的属性查询，文件大小为多少字节
- version : 版本号高于APP-1.0.0-20180409.1719即可
- url : 服务器上面的bin文件地址
- md5 : 为校验码，使用MD5计算工具获取

![](https://i.imgur.com/XJEVEUj.png)

上述参数获取后，可得到这样一条具体的指令：
**AT+FOTA=511258,app-1.0.8-20180620.2010,http://10.27.100.196:8000/mw31devkitc.ota.bin,b5ba9e1c7ad876489a39ac532fbfbb28\r**
将整条语句复制到串口工具中，发送。成功后，hfs端显示完成下载，如图:

![](https://i.imgur.com/UYDevDQ.png)

成功后，**断电重启**，在UART1中输入：AT+FWVER?\r，查看版本，升级后的版本为：APP-1.0.2-20180723.1759（后续再提供升级文件请以实际版本为主），即表示升级成功，如图：

![](https://i.imgur.com/z86FDN2.png)

### 常见问题

Q：使用bk7231烧录器烧录出现“校验失败”

A：这里是使用UART升级，没有事先更新boot导致的，出现校验失败意味着wifi模组以损坏。请大家升级前务必仔细阅读文档，依次进行操作，防止出现不可挽救的问题。

Q：输入AT+FOTA指令后，没有成功执行或者没有任何响应

A：执行FOTA操作前请先检查电脑上防火墙等设置是否关闭，如若没有关闭极有可能会造成FOTA操作被拒绝。

Q：UART升级是否一定要用CH340的USB转串口线

A：强烈建议大家使用CH340的USB转串口线。实践证明，其他类型的串口线都有无法升级等问题。


# NOTE:  

购买开发板AliOS Things Starter Kit和Developer kit，请扫描天猫旗舰店二维码：

![](https://i.imgur.com/VxHonLB.png)


如若升级过程遇到问题，可扫描下图，加入钉钉技术支持群，获取在线技术支持：

![](https://i.imgur.com/rqjjjA0.jpg)
