## 1. 需求简介

AliOS Things 由于功能需要，维护了一张flash分区表，这张表包括bootloader区、Application区、OTA TMP区以及parameters区，如下图：

![](https://img.alicdn.com/tfs/TB1YLVbgNTpK1RjSZFKXXa2wXXa-965-523.jpg)

## 2. 分区大小划分规则

1. 获取芯片平台的Flash大小
2. 获取bootloader信息，包括：bootloader支持的升级类型（原地还是乒乓）、bootloader跳转地址（如果是乒乓会有两个跳转地址）；
3. 跟据bootloader获取的信息，划分整个Flash；
### 1)Bootloader支持原地升级

原地升级flash大小划分方法表:
![](https://img.alicdn.com/tfs/TB1WatbgFYqK1RjSZLeXXbXppXa-690-364.jpg)
### 2)Bootloader 支持乒乓升级

乒乓升级flash大小划分方法表:
![](https://img.alicdn.com/tfs/TB1nehdgMHqK1RjSZFkXXX.WFXa-690-367.jpg)

***注意：***
> 1.	从安全角度考虑，建议用户使用乒乓升级方式，并支持版本回滚；如果用户考虑成本因素采用原地升级方式，因误操作，升级了不正确的固件，导致设备变砖，用户需要自己承担责任。
> 2.	除了以上定义的flash分区之外，有些芯片或者模组还有一些配置文件需要烧写到Flash固定地址，所以确保以上分区不能与这些配置文件的地址空间相覆盖或者重叠；
> 3.	以上分区一旦定义好之后不能轻易更改，否则会造成数据丢失；如果客户需要添加自定义分区，需在分区表索引定义的尾部顺次添加不能中间插入

## 3. 示例

根据以上的划分原则，以esp8266 Flash大小为2Mbytes 升级空间为1024x1024模组为例划分各分区：

### 1.获取Flash 大小：
Flash size = 2M bytes；地址空间为：0x000000 ~ 0x200000
### 2.Bootloader信息:
1. 支持乒乓升级;
2. Bootloader 跳转地址1 = 0x1000;
3. Bootloader 跳转地址2 = 0x101000;

Application区理论大小为：0x101000 – 0x1000 = 0x100000;
### 3.根据模组厂商文档，需要烧的配置文件:
由文档可知地址：0x1FC000 ～ 0x200000 为配置文件存储区，所以parameters1~parameters4 只能从0x1FC000向低地址划分，即：
> Parameters1 起始地址：0x1f6000 大小：0x1000

> Parameters2 起始地址：0x1f7000 大小：0x2000

> Parameters3 起始地址：0x1f9000 大小：0x1000

> Parameters4 起始地址：0x1FA000 大小：0x1000
### 4.Application区和OTA Tmp区划分：
根据步骤3可知OTA Tmp区的范围只能是parameters1 – bootloader跳转地址2， 即：0x1f6000 - 0x101000 = 0xF5000; 由于是乒乓升级，application区的大小应该和OTA Tmp区大小相等;
由以上4个步骤可完成整个分区表的划分，具体可查看：aos/board/esp8266/board.c文件。 

