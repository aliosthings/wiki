- 开发板配置
- 代码下载
- 代码移植
- 功能调试

## 1 开发板配置
我们验证选用的开发板是基于STM32L496VGTx芯片研发的一款物联网开发板。其内核为ARM 32位Cortex-M4 CPU，最高80MHZ的主频率，1MB的闪存，320KB的SRAM，最多支持136个高速IO口，还支持SPI,CAN,I2C,I2S,USB,UART等常用的外设接口。

![](https://i.imgur.com/ColtF57.png)

单板的背面有arduino接口，当前验证使用的外接sensor主要基于I2C总线进行连接。
![](https://i.imgur.com/ZYAZCht.png)

developer kit开发板环境配置请参考链接： https://github.com/alibaba/AliOS-Things/wiki/AliOS-Things-Studio

## 2 代码下载
代码链接：https://github.com/andy2012zwj/AliOS-Things/tree/aos_udata

打开代码链接，可以通过以下方式下载代码
![](https://i.imgur.com/EPtgfHl.png)

## 3 代码移植
uData介绍以及传感器驱动移植请参考以下链接：https://github.com/alibaba/AliOS-Things/wiki/AliOS-Things-uData-Sensor-Driver-Porting-Guide.zh
以，在developer kit板上，需要注意的地方是总线配置：
```
i2c_dev_t  ####_ctx = {
    .port = 3, /*developer kit上外接I2C的port为3*/
    .config.dev_addr = 0x5D, /* 从设备I2C地址 */
};

```
## 4 功能调试
下面以developer kit板为例说明linkkit用例的调试过程。
#### 4.1 编译
example\uDataapp目录下已集成了相关的用例代码，2、3两个章节完成配置修改后，执行以下命令则可以编译用例
aos make udataapp@developerkit
![](https://i.imgur.com/6CwKRXU.png)
编译完成后，生成的可执行文件为out\udataapp@developerkit\binary\udataapp@developerkit.bin
![](https://i.imgur.com/1k2DCSk.png)
#### 4.2 文件烧录
本示例采用ST-LINK工具烧写bin文件，用户也可参考developer kit板环境配置说明中的其他方法；
![](https://i.imgur.com/gB0snoy.png)
#### 4.3 用例执行
烧录完成后，复位单板，开始运行；如果配置流程没有错误，则可以在串口看到sensor通过udata上报的数据。
