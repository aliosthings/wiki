# 1.使用说明
### 1.1.使用对象为使用AliOS的开发者或用户
### 1.2.开发板为庆科3060
### 1.3.编译环境为安装有ubuntu linux的PC或虚拟机
### 1.4.代码路径:[https://github.com/alibaba/AliOS-Things.git](https://github.com/alibaba/AliOS-Things.git) 分支:rel\_2.0.0
### 1.5.云平台为阿里云物联网开发平台
### 1.6.参考文档
[AliOS Things OTA移植指南文档](https://github.com/alibaba/AliOS-Things/wiki/AliOS-Things-OTA-Porting-Guide)
[阿里云物联网平台固件升级文档](https://help.aliyun.com/document_detail/58328.html)
[阿里云智能生活开放平台固件升级文档](https://living.aliyun.com/doc#fxvw5z.html)

阿里云平台主要包括物联网平台和[智能生活开放平台](https://living.aliyun.com)两大平台；针对智能开放平台目前只推出了基础的整包升级服务，针对物联网平台推出了整包升级(提供基础整包固件升级)，差分升级 (提供差分增量包固件升级)，安全升级（提供安全数字签名验证升级）服务。默认选择的是整包升级，开发者或用户可以根据应用场景选择使用差分升级和安全升级。

<span data-type="color" style="color:#F5222D"><strong>使用过程如遇到问题注意先参考第4章和第5章的问题排查步骤及常见问题示例自查</strong></span><strong>。</strong>

# 2.软件框架



![image.png | left | 747x467](https://img.alicdn.com/tfs/TB1kr3JgrvpK1RjSZFqXXcXUVXa-2013-1284.png "")


# 3.操作流程


![ztlc.png | center | 826x251](https://cdn.nlark.com/lark/0/2018/png/109397/1535092321717-10ebe54b-cbe7-48e1-b753-b0e3d5b3b233.png "")


①  下载代码并选择OTA demo程序和开发板
②  登录云端账号获取四元组并开通固件升级服务
③  根据需要是否开启安全升级功能，如开启获取云端公钥
④  编译生成不同版本固件，一个低版本，一个高版本(<span data-type="color" style="color:#F5222D">注意:只能低版本往高版本升级</span>)
⑤  将低版本的固件烧录到对应的目标板子，运行demo程序OTA\_APP pk dn ds ps
⑥  待设备上线后将高版本的固件上传到云端(<span data-type="color" style="color:#F5222D">注意:固件版本要填写正确，云端对文件有规则检查如后缀，字符</span>)
⑦  云端推送固件，设备端接收固件，并做完整性校验(<span data-type="color" style="color:#F5222D">安全升级开启会验证数字签名</span>)
⑧  设备端完成固件校验，进入系统升级
⑨  系统重启后，上报新版本信息到云端(<span data-type="color" style="color:#F5222D">注意:云端检查新上报的版本与上传固件的版本一致才会显示成功</span>)
# 3.详细步骤
### 3.1.下载代码并选择OTA Demo程序和开发板
从github上下载AliOS Things代码并选择OTA Demo程序如“aos/app/example/otaapp”，otaapp专门用来测试OTA的功能，选定后接下来需要根据使用的开发板类型编译出对应的固件;
## 3.2.登录云端账号获取四元组开通固件升级服务
用户设备连云，需要登录云端获取四元组pk,dn,ds,ps，以阿里云物联网平台为例，登录[https://iot.console.aliyun.com](https://iot.console.aliyun.com/product/region/cn-shanghai)，进入物联网平台，如没有创建产品，需要创建产品如下图所示，<span data-type="color" style="color:rgb(51, 51, 51)"><span data-type="background" style="background-color:rgb(255, 255, 255)">如果未开通固件升级，选择扩展服务，单击固件升级下的使用服务。</span></span>


![cjcp.png | center | 826x338](https://img.alicdn.com/tfs/TB1L7lzspkoBKNjSZFkXXb4tFXa-1848-756.png "")

创建产品完成后，点击<span data-type="color" style="color:#00B050">设备管理---&gt;添加设备</span>，在已经创建的产品下添加一个设备，如下图所示：


![tjsb.png | center | 826x310](https://img.alicdn.com/tfs/TB14EWgscIrBKNjSZK9XXagoVXa-1866-701.png "")

完成设备添加后，平台会弹出一个设备证书，里面就有三元组了，如下图所示：


![syz.png | center | 826x353](https://img.alicdn.com/tfs/TB1GBfpsoOWBKNjSZKzXXXfWFXa-1807-772.png "")

这里可以获取pk,dn,ds三元组，ps可以到<span data-type="color" style="color:#00B050">产品管理-----&gt;产品列表------&gt;产品名称-------&gt;查看------&gt;产品信息-----&gt;ProductSecret</span>点击<span data-type="color" style="color:#00B050">显示</span>获取，如下图：


![ps.png | center | 826x298](https://img.alicdn.com/tfs/TB1ll4HsBjTBKNjSZFDXXbVgVXa-1827-659.png "")


## 3.3.从云端获取安全下载的公钥
<span data-type="color" style="color:red">如果用户的设备需要支持OTA的安全验签功能，需开启安全升级并获取公钥；否则可以忽略此步骤</span>。<span data-type="color" style="color:#00B050">登录IOT云端------&gt;扩展服务-----&gt;固件升级开通-----&gt;固件升级------&gt;使用服务-------&gt;安全升级------&gt;产品名称------&gt;安全升级，</span>点击按钮选择开，然后点击<span data-type="color" style="color:#00B050">复制，</span>如下图：


![aqsjx.png | center | 749x596](https://img.alicdn.com/tfs/TB1g4znsmMmBKNjSZTEXXasKpXa-749-596.png "")


用户将获取到的公钥覆盖到aos/middleware/uagent/uota/src/verify/ota\_public\_key\_config.h文件中，如下图：


![gycc.png | center | 826x284](https://img.alicdn.com/tfs/TB1wHl7syMnBKNjSZFzXXc_qVXa-1114-383.png "")

## 3.4.根据对应开发板编译生成两个不同版本固件
我们的开发板为mk3060(board/mk3060)，在终端输入aos make otaapp@mk3060等待编译完成，分别得到两个不同版本的固件，版本号可以通过编译时终端打印输出的开始部分的信息得到如对应红色字体为此固件版本：app\_version:<span data-type="color" style="color:#F5222D">app-1.0.0-xxxxxx，注意请记住版本号</span><span data-type="color" style="color:#262626">。 如需手动更改版本号，可以通过修改文件</span>aos/middleware/common/common.mk下app-1.0.0-\$(CURRENT\_TIME)，如改成app-2.0.0-\$(CURRENT\_TME)

## 3.5.烧录低版本固件到目标板运行demo程序
以mk3060的板子为例，所以接下来主要介绍mk3060的下载过程，其他的开发板烧写工具稍有差异但下载操作流程类似。完成步骤4之后，到aos/out/otaapp@mk3060/binary/可找到对应固件如下图所示：


![wjlb.png | center | 832x275.25748502994014](https://img.alicdn.com/tfs/TB1tFa5sXooBKNjSZPhXXc2CXXa-668-221.png "")

<span data-type="color" style="color:#262626">将mk3060通过串口连接电脑，打开串口调试工具，波特率为921600，操作mk3060进入下载模式：mk3060有4个按钮，假定靠近usb口的按钮为1号按钮，需要同时按下1号+3号按钮，然后先放开1号，接着放开3号按键，此时mk3060将进入烧写模式，然后在命令行中输入write 0x13200，再选择发送Ymodem，</span>[将编译出来的低版本](mailto:将编译出来的otaapp@mk3060.bin)<span data-type="color" style="color:#F5222D">app-1.0.0-xxxxxx</span>[固件otaapp@mk3060.bin](mailto:将编译出来的otaapp@mk3060.bin)<span data-type="color" style="color:#262626">文件烧录到目标板中，</span>重启板子，输入命令：<span data-type="color" style="color:#00B050">netmgr connect </span><span data-type="color" style="color:red">ssid passwd</span>, 命令中的ssid和passwd 对应mk3060需要连接的路由器的SSID和密码；网络连接成功后将会看到IP地址等信息，如下图所示：


![捕获1.JPG | center | 832x43.987915407854985](https://img.alicdn.com/tfs/TB1_M41sA7mBKNjSZFyXXbydFXa-662-35.jpg "")

完成配网功能后，输入命令：<span data-type="color" style="color:#00B050">OTA_APP </span><span data-type="color" style="color:red">pk dn ds  ps</span><span data-type="color" style="color:black">运行demo程序后若能在云端看到设备在线说明设备端云端连接已经建立，方可进入下一个步骤。</span>


![zcyx.png | center | 826x509](https://img.alicdn.com/tfs/TB13xycskZmBKNjSZPiXXXFNVXa-1297-798.png "")

从log信息中可以看到设备的devicename等信息，如果设置错误，设备会连接不成功，从log信息可以验证，设备的PK,DN,DS等信息是否正确。
## 3.6.待设备能正常上线，向云端上传高版本固件
修改aos/middleware/common/common.mk将版本号app-1.0.0-\$(CURRENT\_TIME)改成app-2.0.0-\$(CURRENT\_TME),然后重复步骤4，生成高版本固件版本的固件<span data-type="color" style="color:#F5222D">app-2.0.0-xxxxxx</span>，如下图：


![捕获2.JPG | center | 826x190](https://img.alicdn.com/tfs/TB1929ZsdknBKNjSZKPXXX6OFXa-1094-252.jpg "")

编译完成后，[将otaapp@mk3060.ota.md5.bin](mailto:将otaapp@mk3060.ota.md5.bin)上传到云端，<span data-type="color" style="color:#F5222D">注意固件版本要填写正确，云端对文件有规则检查如后缀，字符等；</span><span data-type="color" style="color:#00B050">IOT云平台登录----&gt;物联网平台-------&gt;我的服务--------&gt;固件升级-------&gt;新增固件；</span><span data-type="color" style="color:black">此时会弹出如下图框，根据图框中带星号的标题填写内容及上传固件，需要注意的是，固件上传之前需要将固件名称中的</span><span data-type="color" style="color:#00B050">“@”</span><span data-type="color" style="color:black">和</span><span data-type="color" style="color:#00B050">“.”</span><span data-type="color" style="color:black">转换成</span><span data-type="color" style="color:#00B050">“_”</span><span data-type="color" style="color:black">只留最后一个</span><span data-type="color" style="color:#00B050">“.”</span><span data-type="color" style="color:black">;所以otaapp@mk3060.ota.md5.bin需要改成otaapp_mk3060_ota_md5.bin才能上传成功；下图中的</span><span data-type="color" style="color:#00B050">签名算法</span><span data-type="color" style="color:black">用于保证固件的完整性，以及安全功能，目前支持两种md5和sha256，我们推荐使用sha256.</span>


![scgjbb.png | center | 697.4656488549618x729](https://img.alicdn.com/tfs/TB1G706spooBKNjSZFPXXXa2XXa-752-786.png "")

上传固件完成后，点击<span data-type="color" style="color:#00B050">验证固件</span>，会弹出如下图框提示选择<span data-type="color" style="color:#00B050">整包</span>和<span data-type="color" style="color:#00B050">差分</span><span data-type="color" style="color:#262626">升级</span>；<span data-type="color" style="color:#00B050">整包</span>代表云端把完整的固件推送到设备端，<span data-type="color" style="color:#00B050">差分</span>代表云端会对新固件与设备端有相同版本的老固件生成差分增量包后推送到设备端（<span data-type="color" style="color:red">目前只有板子mk3060和esp8266支持差分升级</span>）；当选择整包推送，如下图，按照框图的内容标题对应填入产品的名称，这时候如果设备在线，点击固件版本号下面的框会弹出当前在线设备的版本号，选择即可，设备名称同样如此；然后点击确定，这是云端就会推送固件到设备端；


![zbsj.png | center | 705.6645326504482x729](https://img.alicdn.com/tfs/TB1gDTEsdcnBKNjSZR0XXcFqFXa-756-781.png "")

当选择差分升级时，如下图：


![cfsj.png | center | 703.2485549132947x810](https://img.alicdn.com/tfs/TB1JYh7syMnBKNjSZFzXXc_qVXa-751-865.png "")

同样填写<span data-type="color" style="color:#00B050">设备所属的产品</span><span data-type="color" style="color:black">，</span><span data-type="color" style="color:#00B050">待升级版本号</span><span data-type="color" style="color:black">和</span><span data-type="color" style="color:#00B050">差分固件名称</span><span data-type="color" style="color:black">是设备上已经运行的固件版本号，以及云端与之相对应的固件名称；</span><span data-type="color" style="color:red">切片大小需要注意，不同的模组平台切片大小不同，mk3060的平台选择64k,esp8266的平台选择16k,此处需要严格遵守；</span>最后选择要升级的设备，点击确认即可推送。
## 3.7.云端推送固件，设备端下载固件，并做完整性校验
固件下载完成后，设备端对固件做完整性校验，如果用户选择了安全升级还会有数字验签，保证设备端接收到的固件安全可靠。具体可参见如下log图：


![dlgjjb.png | center | 826x407](https://img.alicdn.com/tfs/TB1RERrssj_B1NjSZFHXXaDWpXa-1104-544.png "")

从上图中可以看到sha256校验，固件本身的MD5等鉴别等信息，如果有任何一项校验失败，系统都将升级失败，保持原样固件运行。
## 3.8.设备端完成固件校验，进入系统升级
当下载的固件校验成功后，系统保存升级状态，自动重启，进入bootloader完成差分还原或者是分区跳转，完成固件升级。
## 3.9.设备端完成后新版本上报云端
设备完成升级后，首先会上报当前的版本号，云端判断上报的版本号是否与推送的版本号相同，相同的话就升级成功，否则失败；升级成功后云端显示如下图：


![sjcg.png | center | 826x289](https://img.alicdn.com/tfs/TB1vUWgscIrBKNjSZK9XXagoVXa-1824-637.png "")


# 4.问题排查步骤
4.1. 云端问题排查：产品四元组信息，固件版本，升级方式等确保正确；
4.2. 连接通道问题排查：检查是否上线，排除连接通道问题;
4.3. 下载通道问题排查：可以在linux host上运行otaapp demo看是否能正常从云端下载文件;
4.4. 设备端固件校验及写入问题排查：通过分析出差log定位，如需帮助提供设备端完整log;
    
# 5.常见问题示例
## 5.1.版本不匹配升级失败(ota cancel,ota version don'tmatch dev version!)
<span data-type="color" style="color:#8C8C8C">答：云端上传的固件版本和端侧的固件的版本格式要相同，并且云端版本要大于端侧版本。如设备端的版本:APP-1.0.0-xxxxxx，云端的版本:APP-2.0.0-xxxxxx. 手动更改版本地方：middleware\common\common.mk。</span>
## 5.2.上传云端的OTA bin文件是哪个?
<span data-type="color" style="color:#8C8C8C">答：用于云端升级的OTA bin文件与端侧离线烧录的固件可能不一样，如mk3080是out/xxxx@mk3080/binary/ota_all.bin；mk3060是out/xxx@mk3060/binary/xxxx@mk3060.ota.md5.bin</span>
## 5.3.升级成功后，网络连接信息丢失?
<span data-type="color" style="color:#8C8C8C">答：原因是OTA升级过程中将网络连接信息的保存区域擦除了，解决办法：检查board.c的分区表，确保每个分区没有重叠。</span>
## 5.4.3080网络linux环境下编译的OTA bin文件无法运行?
<span data-type="color" style="color:#8C8C8C">答：此为已知问题,3080芯片原厂提供的生成OTA bin文件的工具windows下工作正常，linux下工具脚步无法生成正常的OTA bin文件格式。</span>
__ __
