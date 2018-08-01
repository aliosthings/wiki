![](https://i.imgur.com/Q8Jcei1.png)

# MW31 Module Boot File Update and Program Upgrade Instructions
---

## <font color="#dd0000">注意：
1.	本指导文档包含WiFi模块boot文件（boot_upxxx.bin）更新和固件（mw32deckitc_crc.bin）版本升级两部分，只适用于windows平台。
2.	升级过程涉及到使用UART1（即USB口，MCU->debug(用于交互和log输出)）和UART2（BK7231 wifi模组<->MCU）。
3.	本次更新只是为WiFi模块增加支持串口升级的功能，若开发过程中不涉及对WiFi模块的程序和功能更改，可不执行该更新操作，对WiFi模块在A10（即Starter Kit板）和A20（即Developer Kit板）上的数据传输功能和性能没有影响。
4.	boot文件更新仅针对固件版本为APP-1.0.0-20180409.1719的WiFi模块，执行前请先查询固件版本，非该版本请不要执行boot更新操作。
5.	wifi模块固件版本查询有两种方式: a.如果A20使用的是出厂原始软件，可通过 UART1输入<AT+FWVER?\r>来查询。b.若A20已经烧录了自己编译的或者其它版本的软件，可通过3.3V串口线连接开发板上的UART2（至少需要连接TX，RX和GND三根线，接线方式请参考图1）后再启动对应串口的命令窗口中输入<version>来查询。
6.	若A20使用的软件版本非出厂版本，请先刷回出厂版本（出厂版本请转至[上海诺行信息技术有限公司网站](http://www.notioni.com/#/source)下载，操作步骤为alios-things/build/cmd下面有osx/linux/win的stlink烧录工具，命令行手动烧录。如win平台:$ win32/st-flash.exe erase; $ win32/st-flash.exe --reset write $path_developerkit_bin  0x08000000），避免出现AT命令不识别等问题导致升级失败。
7.	执行操作前请先关闭电脑防火墙以及杀毒软件，防止FOTA操作被拒绝。
8.	请确保更新前的准备条件完备之后再进行更新。


</font></br>

## 准备条件：
1.搭载有MW31模块的开发板，模块能够联网。  
2.boot更新文件：boot_up_180615.bin  
3.升级固件版本：mw31devkitc_crc.bin  
4.MD5计算工具  
5.搭建HTTP服务器，本文档使用第三方工具hfs  
6.基于Windows 的上位机软件《bk_writer_7231.exe》  
7.USB转串口线（推荐使用集成CH340芯片的串口线）
 
注：以上准备条件中相应软件和工具可以前往[上海诺行信息技术有限公司网站](http://www.notioni.com/#/source)获取，硬件工具请自行准备。

## 更新流程：
整体思路：先通过FOTA升级的方式打boot更新补丁，然后通过串口升级的方式升级固件版本。  
<font color="#dd0000">首先请知悉本文档所有AT指令需要通过UART1输入，串口升级需要通过UART2完成。</font>  
Developer Kit上特别引出了MW31模块的UART2，位于WiFi模块上侧，J801的上面两个排针，有丝印WiFi DL说明。如下图1：
[![Pdx23F.md.jpg](https://s1.ax1x.com/2018/07/31/Pdx23F.md.jpg)](https://imgchr.com/i/Pdx23F)


在Developer Kit上当USB线连接电脑，另一端接Developer Kit的USB ST_LINK 接口时，电脑端会映射出我们需要的UART1.：

![](https://i.imgur.com/tTzYmWA.jpg)

建议使用 SSCOM 这样的串口调试工具来进行调试，波特率 115200。



## 一、测试AT命令
在串口输入工具里面选择映射出来的端口，勾选“加时间戳和分包显示”输入"AT\r"(\r为回车符，所有的AT指令都要加这个符号，下同。）指令，返回 ok，说明系统已经正常开机。
如下图：
![](https://i.imgur.com/aoz1ee9.jpg)

## 二、接入公网 WiFi 网络
AT指令格式：AT+WJAP=SSID,PASSWORD\r  
SSID是WiFi名字，PASSWORD是密码，中间用英文逗号隔开。例如，输入的命令为：  
<font color="#dd0000">AT+WJAP=MERCURY_E87E,12345678\r</font></br>
返回ok，表明已经接入WiFi网络。接入WiFi网络后，开发板上的三色LED灯会开始循环闪烁。如下图：
![](https://i.imgur.com/oZQUpEK.jpg)


接入WiFi网络之后就可以准备FOTA升级了（注意FOTA升级必须在局域网环境中进行）。

## 三、搭建虚拟网络服务器
服务器工具如附件，点击hfs运行，把补丁文件拖入左侧，然后复制上面窗口中的地址，<font color="#dd0000">此处需要注意，服务器地址为本机IP地址，若不是请点击菜单-IP地址进行更改。</font></br>如下图。
![](https://i.imgur.com/TjDIHAI.jpg)

## 四、完善 FOTA 指令。
FOTA升级的AT指令为：AT+FOTA=(size)，(version)，(url)，(md5)\r。其中：  
size可直接通过右键升级bin文件的属性来查询，文件大小为多少字节；
version为编译的时候设定的，需要注意升级的版本要比模块本身使用的版本号要高；
url为服务器上面的bin文件地址；
md5为校验码，通过计算工具可以计算出来，如下图：
![](https://i.imgur.com/09ABzj2.jpg)


升级需要的4个参数值全部填写完成之后，我们会得到下面这样一条具体的指令语句。
AT+FOTA=619786,app-1.0.8-20180620.2010,http://192.168.9.101:8085/boot_up_180615.bin,4821682ac03b9e23a68914021ea0d2e7\r  
然后再把整条语句复制到串口工具里面，点击发送。补丁下载完成服务器端会有显示，如下图：
![](https://i.imgur.com/jsBbIP9.jpg)

到这里，升级补丁已经下载到芯片里面了，下一步通过串口进行升级。

## 五、覆盖之前的boot文件
串口线接模块的UART2（串口线也可以提前接入）。  
通过UART2输入指令：txevm -e 3  
覆盖掉模块之前的boot文件，系统执行过程中串口会有信息打印，如下图。
![](https://i.imgur.com/MLdGiVg.jpg)

然后给模块断电，关闭串口（否则会占用串口，导致串口升级无法完成）。  

## 六、通过串口升级工具升级固件
串口升级工具和升级用的固件已经打包在附件，也可以使用官方后续发布的新的升级固件。  

![](https://i.imgur.com/Wqq6qJE.jpg)

烧录对象选择 BK7231，点击浏览选择升级的固件 mw32deckitc_crc.bin 文件，设置端口，<font color="#dd0000">先点击烧录， 再给模块上电</font>，烧录成功后显示界面如下图：

<font color="#dd0000">注意：</font>此处可能出现通讯端口处COM后的数值显示不全的问题，若有此问题请修改COM值，修改方式为在设备管理器中找到对应的端口，右键选择属性，在端口设置页点击“高级”，在弹出的窗口下方即可修改COM值。

![](https://i.imgur.com/x0IA4YN.jpg)


升级完成后
<font color="#dd0000">断电重启</font>，再打开UART2串口，输入version，查看版本，升级后的版本为：APP-1.0.2-20180723.1759（后续再提供升级文件请以实际版本为主），即表示升级成功。如下图  
![](https://i.imgur.com/5EtbfXq.jpg)




# NOTE:  

购买开发板AliOS Things Starter Kit和Developer kit，请扫描天猫旗舰店二维码：

![](https://i.imgur.com/VxHonLB.png)


如若升级过程遇到问题，可扫描下图，加入钉钉技术支持群，获取在线技术支持：

![](https://i.imgur.com/rqjjjA0.jpg)
