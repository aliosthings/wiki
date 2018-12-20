## 0，背景
* **Developerkit**的wifi模组固件存在bug（网络断开问题），需要升级wifi固件才能解决该问题。**wifi固件升级**分**两种**情况：1，需要升级**boot**和**wifi固件**；2，**仅**需要升级**wifi固件**(无需升级boot)。
* **请先查看 1.2节中判断需要何种升级，再查看第2节中的升级。**
* 本文档配合[开发板入口](https://github.com/alibaba/AliOS-Things/wiki/Developer-Kit-Tutorial)介绍中所提的wifi模组升级。
## 1，准备
#### 1.1，环境准备：
   * 下载软件包[DK_wifi_update_package.zip](http://www.notioni.com/#/source) (含README.txt)，[USB驱动](https://www.st.com/en/development-tools/stsw-link009.html)或直接下载压缩包[en.stsw-link009-V2.0.1.zip](http://www.notioni.com/#/source) 
   * 硬件：USB转串口（推荐内置CH340芯片,如下图），windows电脑。如下图接线(丝印：WIFI DL)
   * **注：两个串口分别是：MCU调试串口，wifi模组调试串口**  
 
   ![1](https://img.alicdn.com/tfs/TB1FPlOxhjaK1RjSZFAXXbdLFXa-937-722.png) 
   ![2](https://img.alicdn.com/tfs/TB1_GXGxgHqK1RjSZFkXXX.WFXa-1328-1007.png)   
#### 1.2，判断哪种升级方式：
1. 恢复MCU出厂设置，出厂固件：00_recovery_factroy（软件包中）
2. 打开串口工具（请使用软件包中的串口工具）查看wifi模组版本号，MCU串口中**输入命令：** AT+FWVER?\r 
        ![3](https://img.alicdn.com/tfs/TB1LM80xhjaK1RjSZKzXXXVwXXa-827-444.png) 
**结果：** 若上述查看的wifi固件号为：APP-1.0.0-20180409.1719，则需要**升级boot和wifi固件**；如wifi版本号（时间戳）大于该号，则**仅需要升级wifi**固件。


## 2，升级
#### 2.1, 升级boot固件  

   * **连接wifi**，MCU串口中**输入命令：** AT+WJAP=SSID,PASSWORD\r 请使用正确的wifi用户名和密码
       ![4](https://img.alicdn.com/tfs/TB1ppXxxjTpK1RjSZKPXXa3UpXa-816-517.png)
   * **FOTA升级**，wifi连接正常后，本地电脑（**需连接同一个wifi**）打开01_boot_update（软件包）中的hfs，并将软件包中的boot_up_180615.bin拖入到hfs的左侧，并记录下正确的IP地址，如下图。在MCU串口中**输入命令：** AT+FOTA=619786,app-1.0.8-20180620.2010,http://**192.168.1.107**/boot_up_180615.bin,4821682ac03b9e23a68914021ea0d2e7\r   其中IP地址更新成实际的地址，执行后请稍微等一会（nfs中会有传输记录）
![5](https://img.alicdn.com/tfs/TB1zYxwxgDqK1RjSZSyXXaxEVXa-1749-647.png) 
    * **升级boot**，在wifi串口中**输入(wifi模组串口)命令：**  txevm -e 3\r  如下图，完成boot升级
  ![6](https://img.alicdn.com/tfs/TB1EBFCxXzqK1RjSZFCXXbbxVXa-537-722.png) 
	* **完成后关闭串口和断开电源**
#### 2.2, 升级wifi固件  

* 开发板MCU串口**未上电**，打开02_wifi_fw_update（软件包）中的bk_writer_7231.exe，烧录文件请选择软件包中的networkapp@bk7231devkitc_crc.bin，按下图配置(**wifi模组串口**)后，**先**点击烧录，**再**给开发板上电  
    ![7](https://img.alicdn.com/tfs/TB1HS8rxjDpK1RjSZFrXXa78VXa-1104-521.png)   
## 3, 升级完成：
![8](https://img.alicdn.com/tfs/TB1DF8Bxa6qK1RjSZFmXXX0PFXa-773-411.png)  
和1.2节的第2步一样，在MCU串口中输入命令：AT+FWVER?\r 可查看到版本号：APP-1.1.6-20181204.1558，该版本解决了网络问题并支持配网。  




### 文档更新

| Rev.No | Chapter | Comments | Editor | Date |
| --- | --- | -------- |  ---| --- |
| 1.0     | 0-3     |  Document initialization    | JL | 2018-12-12 |