STM32F4系列板卡和STM32L4系列板卡生成Keil工程基本一样，仅区别在"配置Keil工程及生成代码"章节。本文以STM32L4系列板卡为例。
## 准备材料:
Keil MDK IDE, ST CubeMX Version 4.27.0 或以上版本（官网下载地址[https://www.st.com/en/development-tools/stm32cubemx.html](https://www.st.com/en/development-tools/stm32cubemx.html)）
一块STM32L4系列板卡（本文以NUCLEO-STM32L433RC为例），一块庆科MK3060或3165板卡（已烧录AT固件）

## 简单介绍
PDSC和PACK是AliOS Things Plugin重要的2个文件，其中PDSC是制作及获取PACK的规则文件，根据PDSC规则将AliOS Things代码，ST CubeMX依赖的配置组(\*\_Configs.xml和\*\_Modes.xml)以及一些Doc文件打包就做成了PACK规则文件。
目前打包的AliOS Things位于仓库[https://github.com/alibaba/AliOS-Things/tree/developer](https://github.com/alibaba/AliOS-Things/tree/developer)，每隔一段时间，会将该代码PACK一次制作成的PACK上传至OSS托管服务器供开发者下载，开发者也可以根据PDSC自行制作PACK文件。
## 安装AliOS Things Plugin最新PACK包
### 在线下载AliOS Things 针对CubeMX的Plugin PACK的规则文件地址:
[https://mirrors.aliyun.com/AliOS-Things/Alibaba.AliOSThings.pdsc](https://mirrors.aliyun.com/AliOS-Things/Alibaba.AliOSThings.pdsc)
打开CubeMX--菜单栏help--Manage Embedded Software Packages, 在打开的对话框下测选择"from url"--在user Defined Packs Manager对话框--New--填入上述地址，选择"check"


![image.png | left | 826x473](https://cdn.nlark.com/lark/0/2018/png/109792/1537171979883-3b0728b8-eea1-4331-80ef-2a5853e119b5.png "")


check通过点击OK，勾选checkbox，下载该插件。
### 在线更新AliOS Things PACK包
每次后台有版本升级，用户仍然使用上述连接，操作步骤和上述一致的情况下，会下载到最新版本的PACK包

### 离线加载AliOS Things PACK包
离线加载AliOS Things Plugin PACK更简单，直接在Embedded Software Packages Manager中选择"From Local..."中打开已经获取到的PACK包就行，此时不需要PDSC文件。


![image.png | left | 826x446](https://cdn.nlark.com/lark/0/2018/png/109792/1537174284501-a61994c0-b190-493e-86be-8e2ddcce5eac.png "")



## 创建CubeMX工程
1. 以NUCLEO-STM32L433RC为例创建CubeMX工程


![image.png | left | 826x394](https://cdn.nlark.com/lark/0/2018/png/109792/1536215403516-1a8bd31e-6f37-4f1d-bf56-11db3c3da7ab.png "")


2. 创建工程时提示使用开发板默认配置，这时工程已经创建好UART2口，我们将其作为CLI口，然后选择UART1口作为AT口，如下


![image.png | left | 826x519](https://cdn.nlark.com/lark/0/2018/png/109792/1536215668245-a146475f-1f7a-4255-b84b-7dce67b0be65.png "")


3. UART配置界面将所用UART的中断支持都勾选上，将其生成ISR功能反选


![image.png | left | 826x510](https://cdn.nlark.com/lark/0/2018/png/109792/1536215751054-18808f59-897f-456f-8b8c-1a0b0ef3ef77.png "")



![image.png | left | 826x604](https://cdn.nlark.com/lark/0/2018/png/109792/1536215840889-ec863635-f81f-49ed-a0d8-f0a7ee85191f.png "")



![image.png | left | 823x684](https://cdn.nlark.com/lark/0/2018/png/109792/1536215888646-bceef99d-076a-4d30-bbe8-c068f51c2ebb.png "")


## 选择AliOS Things Plugin 组件
1. <span data-type="color" style="color:rgb(38, 38, 38)"><span data-type="background" style="background-color:rgb(255, 255, 255)">通过菜单栏Project-- Select Addtinoal Software Components 界面，选择board和example下的应用: board 我们选择&quot;stm32l4xx_universal&quot;, examle 我们选择&quot;mqttapp&quot;, 并依次勾选这2个component所依赖的组件，我们以&quot;stm32l4xx_universal&quot;为例，点击status 栏的工作图标，我们知道其依赖mcu及sal 2个组件，如下图</span></span>


![image.png | left | 826x509](https://cdn.nlark.com/lark/0/2018/png/109792/1536216306694-298158b2-5a91-46c9-94d3-82d0ae106aaf.png "")


2. 选择了stm32l4xx\_cube组件之后，我们又发现其依赖很多其他组件，我们将这些组件都勾选上


![image.png | left | 798x490](https://cdn.nlark.com/lark/0/2018/png/109792/1536216399250-1aff9199-b80b-4393-9809-fd74fba6ae93.png "")


3. 按照上述步骤将board和example依赖的组件，及其组件依赖的组件全部勾选上，勾选过程中注意下述特定选择：
* vfs选择"keil"
* wifi 选择 sal\_wifi\_mk3060 （如果你使用MK3165或MK3060做上网模块）
* kv根据实际硬件选择，因为kv操作会占用大量的RAM空间，（需要按片区将数据从flash中拷贝出来，此时申请较大的RAM资源）如果你使用诸如STM32L433系列板卡（RAM只有64KByte），建议暂时不要打开kv，此时选择dummy。如果使用诸如L496（RAM达到128KByte），则可以选择实际的KV功能
* protocol\_linkkit\_iotkit有2个选项 w\_o\_TLS(不使用TLS而是用TCP直连)和withTLS（使用TLS加密策略），同样对于RAM较小的板卡（<128KByte）建议选择w\_o\_TLS
* 选择组件的原则一定遵循<span data-type="color" style="color:rgb(25, 31, 37)"><strong>从board和example 这2个组件网外衍生 只要这2个是绿的 以及这2个依赖的组件也是绿的 以及依赖的依赖是绿的 就可以了，其它没有选择的，即使是工作模式，也是没有关系的</strong></span>


4. 选择AliOS Things 插件


![image.png | left | 713x405](https://cdn.nlark.com/lark/0/2018/png/109792/1536218379872-8f92cbb1-78bd-47f9-b214-6d508e6a5ceb.png "")


## 其它设置
* ProjectSetting--Project--勾选 Do not generate the main()
* ProjectSetting--Project--Toolchain/IDE 选择MDK-ARM 
* ProjectSetting--Advaced Setting--Generated Function Calls, 取消勾选Visibitity（static）

## 生成Keil工程
菜单栏Project--Generate Code

## 配置Keil工程及生成代码
1. <span data-type="color" style="color:rgb(38, 38, 38)"><span data-type="background" style="background-color:rgb(255, 255, 255)">以生成Keil MDK工程为例, 生成工程一般勾选GNU属性，取消warning警告, 如果是linkkitapp由于有中文 除了选择gnu属性外 需要在misc control里再加上</span></span><span data-type="color" style="color:rgb(38, 38, 38)"><span data-type="background" style="background-color:rgb(255, 255, 255)"><em>--no_multibyte_chars</em></span></span><span data-type="color" style="color:rgb(38, 38, 38)"><span data-type="background" style="background-color:rgb(255, 255, 255)"> 请参见下图。如果希望KEIL MDK下编译速度快一些，并且不需要单步调试，可以在编译之前去掉DEBUG信息</span></span>



![image.png | left | 826x561](https://cdn.nlark.com/lark/0/2018/png/109792/1536219801623-27e9b1ee-b360-4a59-8965-5c291eb89016.png "")


2. <span data-type="color" style="color:rgb(38, 38, 38)"><span data-type="background" style="background-color:rgb(255, 255, 255)">misc control里添加如下信息，一般用于和云端交互时留下信息，当然你填的内容可以按照你实际板卡去填，格式暂无要求</span></span>
-DSYSINFO\_PRODUCT\_MODEL='\"ALI\_AOS\_STM32L432\"' -DSYSINFO\_DEVICE\_NAME='\"STM32L432\"'
对于<span data-type="color" style="color:#F5222D">STM32F4</span>系列板卡，由于没有默认SRAM1\_SIZE\_MAX宏，除了以上操作，还需要加-DSRAM1\_SIZE\_MAX=0x40000（举例）来将板卡RAM大小（举例为256KB）


![image.png | left | 826x555](https://cdn.nlark.com/lark/0/2018/png/109792/1536219795306-8820c556-cb42-4bcd-b06a-242562b1aac1.png "")


3. 修改uart口映射关系
在board/stm32l4xx\_universal/hal/hal\_uart\_stm32l4.h中更改如下
```plain
#define PORT_UART1 1     /* AT串口会用UART1 * /
#define PORT_UART2 0     /* DEBUG(CLI)串口使用UART2 */
```
这里我们强调一下，对于AliOS Things，目前逻辑口0专指CLI口，逻辑口1专指AT口。

对于<span data-type="color" style="color:#F5222D">STM32F4</span>系列，可以通过更改board/stm32f4xx\_universal/init/board.h中的变量PORT\_UART\_TYPE及board/stm32f4xx\_universal/init/soc\_init.c中的UART\_MAPPING\_TABLE映射表来配置所需要的逻辑串口和对应的物理串口，如下述:
```c
/*############         Logical UART Port Type used in this board  ##############
 * Please keep APP_UART_STD=0 to avoid unexpected error. Other Port value does not 
 * follow special rule.                                   
 #####################################################                  #         */
typedef enum{
    PORT_UART_STD,
    PORT_UART_AT,
    /*PORT_UART_RS485, *///Example.
    PORT_UART_SIZE,
    PORT_UART_INVALID = 255,
}PORT_UART_TYPE;
```
```c
const UART_MAPPING UART_MAPPING_TABLE[] =
{
    { PORT_UART_STD,     USART3, { USART3_IRQn,  0, 1,UART_OVERSAMPLING_16 } },
    { PORT_UART_AT,      USART6,  { USART6_IRQn , 0, 1,UART_OVERSAMPLING_16 } }
};
```

4. 修改board\_partion.c文件（STM32L4系列目前叫board.c）
Middlewares\Third\_Party\AliOSThings\aos\board\stm32l4xx\_universal\init\下面有一个board\_partition.c这个是默认使用的，适合针对1024KB Flash，假如你手中的CPU flash容量较小，建议将board\_partition\_256k\_flash\_template.c中的内容拷贝到board\_partition.c使用。当然你也可以直接调整其中的size空间。

5. 配置GPIO时钟
将CubeMX自动生成的针对GPIO的配置从Application/User/main.c中的MX\_GPIO\_Init()函数中的下述语句替换到Middlewares\Third\_Party\AliOSThings\aos\board\stm32f4xx\_universal\init\soc\_init.c中的stm32\_soc\_init()相应位置(覆盖掉*stm32\_soc\_init*()中的*MX\_GPIO\_Init(*)或者*\_\_HAL\_RCC\_GPIOX\_CLK\_ENABLE*())。
```c
  /* GPIO Ports Clock Enable */
  __HAL_RCC_GPIOC_CLK_ENABLE();
  __HAL_RCC_GPIOH_CLK_ENABLE();
  __HAL_RCC_GPIOB_CLK_ENABLE();
  __HAL_RCC_GPIOD_CLK_ENABLE();
  __HAL_RCC_GPIOG_CLK_ENABLE();
  __HAL_RCC_GPIOA_CLK_ENABLE();
```
*  *

6. 针对alicrypto模块的特殊配置
假如使用TLS方式上云，则会包含alicrypto模块。由于该模块目前使用了“模块内部路径”，对于Keil工程来讲就是“Group下的路径”，而ST Plugin 不支持此种规则编辑进PDSC文件，因此需要对这个模块进行特殊处理。后期也会进行模块整改，以期去掉这种模块内部路径或者局部路径，在整改之前，可以采用如下work around加入局部路径
../Middlewares/Third\_Party/AliOSThings/aos/security/alicrypto/mbedtls/include/mbedtls 
../Middlewares/Third\_Party/AliOSThings/aos/security/alicrypto/mbedtls/include
:


![image.png | left | 827x477](https://cdn.nlark.com/lark/0/2018/png/109792/1537179870784-965a124e-7c4f-44b7-9a14-0c05acfc759b.png "")



经过以上的配置，应该就可以生成可以运行的BIN。当然如果还想上云，记得修改其中的四元组。目前四元组位于framework\protocol\linkkit\iotkit\sdk-encap\imports\iot\_import\_product.h
