# 1.整体操作流程

![ztlc.png | center | 826x251](https://img.alicdn.com/tfs/TB1FxznsmMmBKNjSZTEXXasKpXa-968-294.png "")

    ①  从app/example/中选定OTA专属测试APP：otaapp；
    ②  登录云端账号获取四元组
    ③  根据需要是否开启安全升级功能，如需要开启，需要登录云端获取公钥
    ④  将获取的四元组和公钥加到代码中，编译生成两个固件，一个低版本，一个高版本
    ⑤  将低版本的固件下载到对应的板子中
    ⑥  将高版本的固件上传到云端
    ⑦  云端推送固件，设备端接收固件，并做完整性校验，固件鉴别，以及安全验签
    ⑧  设备端完成固件校验，进入系统升级
    ⑨  系统重启后，上报版本信息，OTA完成

# 2.详细步骤讲解
### 1.选择支持OTA的APP和开发板；
AliOS Things所有的APP都放在“aos/app/example”中，otaapp专门用来测试OTA的功能，选定APP后，接下来需要选定开发板类型，AliOS Things支持很多种开发板类型，用户需要到“aos/board/”下选定匹配自己开发板的板子类型；本文假定用户选定的板子类型是mk3060;
## 2.获取四元组
用户设备连云，需要登录云端获取四元组，这里以IOT云平台为例介绍，用户登录[https://iot.console.aliyun.com/product/region/cn-shanghai](https://iot.console.aliyun.com/product/region/cn-shanghai)，进入物联网平台，如没有产品，需要创建产品如下图所示：


![cjcp.png | center | 826x338](https://img.alicdn.com/tfs/TB1L7lzspkoBKNjSZFkXXb4tFXa-1848-756.png "")

创建产品完成后，点击<span data-type="color" style="color:#00B050">设备管理---&gt;添加设备</span>，在已经创建的产品下添加一个设备，如下图所示：


![tjsb.png | center | 826x310](https://img.alicdn.com/tfs/TB14EWgscIrBKNjSZK9XXagoVXa-1866-701.png "")

完成设备添加后，平台会弹出一个设备证书，里面就有三元组了，如下图所示：


![syz.png | center | 826x353](https://img.alicdn.com/tfs/TB1GBfpsoOWBKNjSZKzXXXfWFXa-1807-772.png "")

这里可以获取Produtkey,DeviceName,DeviceSecret三元组，剩下的ProductSecret可以到<span style="color:#00B050">产品管理-----&gt;产品列表------&gt;产品名称-------&gt;查看------&gt;产品信息-----&gt;ProductSecret</span>点击<span data-type="color" style="color:#00B050">显示</span>即可获取，如下图：


![ps.png | center | 826x298](https://img.alicdn.com/tfs/TB1ll4HsBjTBKNjSZFDXXbVgVXa-1827-659.png "")


## 3.获取安全下载的公钥
<span data-type="color" style="color:red">此步骤根据用户需求，如果用户的设备需要OTA的安全验签功能，则不能跳过此步骤，如果不需要OTA的安全验签功能，可以忽略此步骤；</span>用户需要操作：<span data-type="color" style="color:#00B050">登录IOT云端------&gt;扩展服务-----&gt;固件升级开通-----&gt;固件升级------&gt;使用服务-------&gt;安全升级------&gt;产品名称------&gt;安全升级，</span>点击按钮选择开，然后点击<span data-type="color" style="color:#00B050">复制，</span>如下图：


![aqsjx.png | center | 749x596](https://img.alicdn.com/tfs/TB1g4znsmMmBKNjSZTEXXasKpXa-749-596.png "")


用户将获取到的公钥覆盖到aos/middleware/uagent/uota/src/verify/ota\_public\_key\_config.h文件中，如下图：


![gycc.png | center | 826x284](https://img.alicdn.com/tfs/TB1wHl7syMnBKNjSZFzXXc_qVXa-1114-383.png "")

## 4.生成固件
将上面步骤完成后，可以开始固件编译；终端输入otaapp@mk3060,等待编译完成，如下图：


![bjg.png | center | 826x729](https://img.alicdn.com/tfs/TB1MUqrsrsrBKNjSZFpXXcXhFXa-926-817.png "")

## 5.下载固件
由于本文是以mk3060的板子为例，所以接下来主要介绍mk3060的下载过程，其他的开发板下载操作流程类似。完成步骤4之后，到aos/out/otaapp@mk3060/binary/,将会看到如下图文件：


![wjlb.png | center | 832x275.25748502994014](https://img.alicdn.com/tfs/TB1tFa5sXooBKNjSZPhXXc2CXXa-668-221.png "")

将mk3060通过串口连接电脑，打开串口调试工具，波特率为921600，操作mk3060进入下载模式：mk3060有4个按钮，假定靠近usb口的按钮为1号按钮，需要同时按下1号+3号按钮，然后先放开1号，接着放开3号按键，此时mk3060将进入烧写模式，然后在命令行中输入write 0x13200，再选择<span data-type="color" style="color:#00B050">发送Ymodem</span>，[将编译出来的otaapp@mk3060.bin](mailto:将编译出来的otaapp@mk3060.bin)文件下载到板子中即完成了整个固件的下载。

下载完成后，重启板子，输入命令：<span data-type="color" style="color:#00B050">netmgr connect </span><span data-type="color" style="color:red">ssid passwd</span>, 命令中的ssid和passwd 对应mk3060需要连接的路由器的SSID和密码；网络连接成功后将会看到IP地址等信息，如下图所示：


![捕获1.JPG | center | 832x43.987915407854985](https://img.alicdn.com/tfs/TB1_M41sA7mBKNjSZFyXXbydFXa-662-35.jpg "")

完成配网功能后，输入命令：<span data-type="color" style="color:#00B050">OTA_APP </span><span data-type="color" style="color:red">pk dn ds </span><span data-type="color" style="color:#00B050">0 3</span><span data-type="color" style="color:black">;pk,dn,ds 分别对应三元组的Productkey,DeviceName,DeviceSecret;输入完成后，能在云端看到设备在线，如下图：</span>


![zcyx.png | center | 826x509](https://img.alicdn.com/tfs/TB13xycskZmBKNjSZPiXXXFNVXa-1297-798.png "")

从log信息中可以看到设备的devicename等信息，如果设置错误，设备会连接不成功，从log信息可以验证，设备的PK,DN,DS等信息是否正确。
## 6.向云端上传固件
修改aos/middleware/common/common.mk将版本号app-1.0.0-\$(CURRENT\_TIME)改成app-2.0.0-\$(CURRENT\_TME),然后重复步骤4，生成新的版本的固件，如下图：


![捕获2.JPG | center | 826x190](https://img.alicdn.com/tfs/TB1929ZsdknBKNjSZKPXXX6OFXa-1094-252.jpg "")

编译完成后，[将otaapp@mk3060.ota.md5.bin](mailto:将otaapp@mk3060.ota.md5.bin)上传到云端，<span data-type="color" style="color:#00B050">IOT云平台登录----&gt;物联网平台-------&gt;我的服务--------&gt;固件升级-------&gt;新增固件；</span><span data-type="color" style="color:black">此时会弹出如下图框，根据图框中带星号的标题填写内容及上传固件，需要注意的是，固件上传之前需要将固件名称中的</span><span data-type="color" style="color:#00B050">“@”</span><span data-type="color" style="color:black">和</span><span data-type="color" style="color:#00B050">“.”</span><span data-type="color" style="color:black">转换成</span><span data-type="color" style="color:#00B050">“_”</span><span data-type="color" style="color:black">只留最后一个</span><span data-type="color" style="color:#00B050">“.”</span><span data-type="color" style="color:black">;所以otaapp@mk3060.ota.md5.bin需要改成otaapp_mk3060_ota_md5.bin才能上传成功；下图中的</span><span data-type="color" style="color:#00B050">签名算法</span><span data-type="color" style="color:black">用于保证固件的完整性，以及安全功能，目前支持两种md5和sha256，我们推荐使用sha256.</span>


![scgjbb.png | center | 697.4656488549618x729](https://img.alicdn.com/tfs/TB1G706spooBKNjSZFPXXXa2XXa-752-786.png "")

上传固件完成后，点击<span data-type="color" style="color:#00B050">验证固件</span>，会弹出如下图框，这里会出现两个选项<span data-type="color" style="color:#00B050">整包</span>和<span data-type="color" style="color:#00B050">差分</span>；<span data-type="color" style="color:#00B050">整包</span>代表云端把完整的固件推送到设备端，<span data-type="color" style="color:#00B050">差分</span>代表云端会对新增的固件与设备端有相同版本的固件做差分运算，然后只把算出的差值推送到设备端（<span data-type="color" style="color:red">目前只有mk3060和esp8266支持差分</span>）；当选择整包推送，如下图，按照框图的内容标题对应填入产品的名称，这时候如果设备在线，点击固件版本号下面的框会弹出当前在线设备的版本号，选择即可，设备名称同样如此；然后点击确定，这是云端就会推送固件到设备端；


![zbsj.png | center | 705.6645326504482x729](https://img.alicdn.com/tfs/TB1gDTEsdcnBKNjSZR0XXcFqFXa-756-781.png "")

当选择差分升级时，如下图：


![cfsj.png | center | 703.2485549132947x810](https://img.alicdn.com/tfs/TB1JYh7syMnBKNjSZFzXXc_qVXa-751-865.png "")

同样填写<span data-type="color" style="color:#00B050">设备所属的产品</span><span data-type="color" style="color:black">，</span><span data-type="color" style="color:#00B050">待升级版本号</span><span data-type="color" style="color:black">和</span><span data-type="color" style="color:#00B050">差分固件名称</span><span data-type="color" style="color:black">是设备上已经运行的固件版本号，以及云端与之相对应的固件名称；</span><span data-type="color" style="color:red">切片大小需要注意，不同的模组平台切片大小不同，mk3060的平台选择64k,esp8266的平台选择16k,此处需要严格遵守；</span>最后选择要升级的设备，点击确认即可推送。
## 7.设备端校验下载的固件
固件下载完成后，设备端对固件做完整性校验，固件真伪鉴别，如果用户选择了安全升级还会有数字验签，保证设备端接收到的固件安全可靠。具体可参见如下log图：


![dlgjjb.png | center | 826x407](https://img.alicdn.com/tfs/TB1RERrssj_B1NjSZFHXXaDWpXa-1104-544.png "")

从上图中可以看到sha256校验，固件本身的MD5等鉴别等信息，如果有任何一项校验失败，系统都将升级失败，保持原样固件运行。
## 8.设备端本地系统升级
当下载的固件校验成功后，系统保存升级状态，自动重启，进入bootloader完成差分还原或者是分区跳转，完成固件升级。
## 9.设备端版本上报云端
设备完成升级后，首先会上报当前的版本号，云端判断上报的版本号是否与推送的版本号相同，相同的话就升级成功，否则失败；升级成功后云端显示如下图：


![sjcg.png | center | 826x289](https://img.alicdn.com/tfs/TB1vUWgscIrBKNjSZK9XXagoVXa-1824-637.png "")


# 3.OTA排查问题的步骤
1. 云端问题排查：产品四元组信息，固件版本，升级方式等确保正常；
2. 连接通道问题排查：检查是否上线排除连接通道问题;
3. 下载通道问题排查：可以在linux PC上运行otaapp看是否能正常从云端下载文件;
4. 设备端固件校验及写入问题排查：通过分析出差log定位，如需帮助提供设备端完整log;
    
# 4.OTA 的常见问题解答
## 1.OTA版本不匹配（ota cancel,ota version don'tmatch dev version ! ）
<span data-type="color" style="color:#767171">答：需要云端上传的固件版本和端侧的固件的版本格式相同。如设备端的版本：APP-1.0.0-20180601 </span>云端的版本应该是：APP-2.XX.XX.XX. aos的版本更改地方在aos\middleware\common\common.mk和ucube.py 下图蓝色处。
## 2.AliOSThings上传云端的OTA bin文件是哪个？
<span data-type="color" style="color:#767171">答：如mk3080是out/xxxx@mk3080/binary/ota_all.bin；mk3060是out/xxx@mk3060/binary/xxxx@mk3060.ota.md5.bin</span>
## 3.OTA升级成功后，组网信息丢失？
<span data-type="color" style="color:#767171">答：原因是OTA</span>升级过程中将组网信息的保存区域擦除了，解决办法：检查board.c的分区表，确保每个分区没有重叠。
__ __

