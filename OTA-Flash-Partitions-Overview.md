## 1. 需求简介

AliOS Things 由于功能需要，维护了一张flash分区表，这张表包括bootloader区、Application区、OTA TMP区以及parameters区，如下图：

![](https://img.alicdn.com/tfs/TB1imUwG3mTBuNjy1XbXXaMrVXa-278-405.png)

上图的分区的简介:

|分区名称|分区描述|
|--|--|
|Bootloader区|存储bootloader固件，引导启动整个系统，有些支持OTA代码copy等|
|Application区|当原地升级时，此分区为APP程序运行区；当乒乓升级（A,B分区）时，此分区为APP程序运行A区，与APP程序运行B区（OTA Tmp）交替存储下载的固件并运行对应的程序。|
|OTA Tmp区|当原地升级时，此分区用于存放OTA的下载固件；当乒乓升级（A,B分区）时，此分区为APP程序运行B区，与APP程序运行A区（Application）交替存储下载的固件并运行对应的程序。|
|Parameters1区|OTA参数存储区|
|Parameters2区|KV存储区|
|Parameters3区|用户自定义（Mk3060,b_l475e两个板子的KV存储区）|
|Parameters4区|安全相关的参数存储区|

## 2. 分区大小划分规则

1. 获取芯片平台的Flash大小
2. 获取bootloader信息，包括：bootloader支持的升级类型（原地还是乒乓）、bootloader跳转地址（如果是乒乓会有两个跳转地址）；
3. 跟据bootloader获取的信息，划分整个Flash；

### Bootloader支持原地升级

原地升级flash大小划分方法表:

|分区名|起始地址|分区大小|
|--|--|--|
|Bootloader区|芯片Flash 起始地址|bootloader跳转地址与Flash起始地址差值|
|Application区|Bootloader 跳转地址|需要用户根据实际情况自己评估Application的大小|
|OTA Tmp 区|Application 分区结束地址|与Application尽量保持一致，如果支持差分可适当小些，用户需根据实际情况自己评估|
|Parameters1区|OTA Tmp 分区结束地址|一般是4Kbytes|
|Parameters2区|Parameters1分区结束地址|一般是8Kbytes|
|Parameters3区|Parameters2分区结束地址|一般是4Kbytes|
|Parameters4区|Parameters3分区结束地址|一般是4Kbytes|

### Bootloader 支持乒乓升级

乒乓升级flash大小划分方法表:

|分区名|起始地址|分区大小|
|--|--|--|
|Bootloader区|芯片Flash 起始地址|bootloader跳转地址与Flash起始地址差值|
|Application区|Bootloader 跳转地址1|Bootloader跳转地址2与bootloader跳转地址1之间的差值（如果bootloader给出flash擦除范围，以bootloader给出大小为准）|
|OTA Tmp 区|Bootloader 跳转地址2|与Application区大小一致|
|Parameters1区|OTA Tmp 分区结束地址|一般是4Kbytes|
|Parameters2区|Parameters1分区结束地址|一般是8Kbytes|
|Parameters3区|Parameters2分区结束地址|一般是4Kbytes|
|Parameters4区|Parameters3分区结束地址|一般是4Kbytes|

> 注意：
> 1.	从安全角度考虑，建议用户使用乒乓升级方式，并支持版本回滚；如果用户考虑成本因素采用原地升级方式，因误操作，升级了不正确的固件，导致设备变砖，用户需要自己承担责任。
> 2.	除了以上定义的flash分区之外，有些芯片或者模组还有一些配置文件需要烧写到Flash固定地址，所以确保以上分区不能与这些配置文件的地址空间相覆盖或者重叠；
> 3.	以上分区一旦定义好之后不能轻易更改，否则会造成数据丢失；如果客户需要添加自定义分区，需在分区表索引定义的尾部顺次添加不能中间插入

## 3. 示例

根据以上的划分原则，以esp8266 Flash大小为2Mbytes 升级空间为1024x1024模组为例划分各分区：

1.	获取Flash 大小：Flash size = 2M bytes；地址空间为：0x000000 ~ 0x200000
2.	Bootloader信息：
    1. 支持乒乓升级；
    2. Bootloader 跳转地址1 = 0x1000 ; 
    3. Bootloader 跳转地址2 = 0x101000；
Application区理论大小为：0x101000 – 0x1000 = 0x100000;
3.	根据模组厂商文档，需要烧的配置文件:
    由文档可知地址：0x1FC000 ～ 0x200000 为配置文件存储区，所以parameters1~parameters4 只能从0x1FC000向低地址划分，即：
    Parameters1 起始地址：0x1f6000 大小：0x1000
    Parameters2 起始地址：0x1f7000 大小：0x2000
    Parameters3 起始地址：0x1f9000 大小：0x1000
    Parameters4 起始地址：0x1FA000 大小：0x1000
4.	Application区和OTA Tmp区划分：
    根据步骤3可知OTA Tmp区的范围只能是parameters1 – bootloader跳转地址2， 即：0x1f6000 - 0x101000 = 0xF5000; 由于是乒乓升级，application区的大小应该和OTA Tmp区大小相等；
    由以上4个步骤可完成整个分区表的划分，具体可查看：aos/board/esp8266/board.c文件。 

