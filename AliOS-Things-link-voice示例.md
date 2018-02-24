    随着AI技术的进步，智能语音开始将人机交互从手+眼睛的传统模式中解放出来。带给人们更便捷、更风趣、更有人情味的体验，让被操作对象变得不再只是一个死板的工具，而更像是一个有生命的助理。“帮我打开空调”，“按我的口味点份外卖吧”，“快递到哪了”…在万物互联的时代，你的所有需求只需要一句话便能实现。
    AliOS Things 集成的Link Voice SDK即可实现智能语音交互。

# 关于阿里智能语音服务
阿里智能语音服务为设备提供语音交互能力、丰富的音乐内容、智能家居控制等，并可进行专有设备技能定制（如：语音操控跑步机、按摩椅等设备）。包括：
（1）通用服务：搜歌、搜栏目、搜电台、问天气、百科、四则运算等；
（2）阿里服务：控制智能家居、充值手机费、天猫超市购物、查询电费等 （需接入账号体系，可参考SDS接入）；
（3）私有服务：操控设备、售后电话查询等 （需要技能定制，签约时请提供产品需求）。

# 功能集成
设备接入阿里语音服务，需要集成Alink SDK和Link-Voice SDK，其中Alink SDK为设备提供接入阿里IoT平台的连接、账号体系、配网、OTA等能力，而Link-Voice SDK为设备提供阿里智能语音服务。设备首先要集成了Alink SDK成为SDS平台的一个设备，才能通过集成Link-Voice SDK使用阿里智能语音服务。
Link-Voice SDK除了依赖Alink为设备完成平台接入设备管理外，还需要表格所列模块完成相应工作。其中websockets用来进行语音数据的交互；opus完成语音录制的PCM格式到opus格式的转换（服务端只接收opus格式）；cjson用来做json解析；mbedtls为alink和websockets的底层连接进行加密，为其数据传输提供安全保障。
![依赖组件](https://img.alicdn.com/tfs/TB1WsGwaKOSBuNjy0FdXXbDnVXa-648-290.png)

而目前AliOS Things已完成以上表格所有模块的移植适配工作并将其集成进来，所以我们直接使用AliOS Things便可完成愉快的智能语音开发。这里建议主mcu的Flash>=512KB;RAM>=256KB;CPU如果不支持opus硬件编码，建议CPU频率>=180Mhz。

# 开发平台准备
按理满足上一章节性能要求，并带音频录制及播放功能的开发板即可。前提是需要完成AliOS Tings的移植适配工作。本文以全志xr871evb（已完成OS适配）为例进行介绍。
本平台资源：
cpu:200Mhz cortext-M4f
RAM：448KB（部分硬件相关code需要加载到ram中运行，实际可用约280KB）
FLASH：2MB SPI FLASH

# 环境搭建及代码编译
先搭建AliOS开发环境（以linux为例）：
https://github.com/alibaba/AliOS-Things/wiki/AliOS-Things-Linux-Environment-Setup

然后从github阿里官方开源库下载最新版本的AliOS Things源码（https://github.com/alibaba/AliOS-Things）：
以linux下开发为例：
`git clone git@github.com:alibaba/AliOS-Things.git`
切换到主分支：
`git checkout master`
建议再在主分支上新建一个自己的开发分支：
`git checkout –b dev-xxx(youname):`

到目前为止环境也安装好了，代码也准备完毕，只待编译及烧录测试。
编译link-voice测试例程：
`aos make linkvoiceapp@xr871evb xr871=1`
代码烧入：
  `cd platform/mcu/xr871/tools/`
修改串口配置：
`vim settings.ini`  
将串口改成你板子的串口号，可ls /dev/tty*查看，保存退出。
![uart setting](https://img.alicdn.com/tfs/TB1HRuoaL9TBuNjy0FcXXbeiFXa-865-728.png)
代码烧写，先将全志开发板启动选择拨码开关拨至NO位置，如同所示：
![flash setting](https://img.alicdn.com/tfs/TB1p2KkaMmTBuNjy1XbXXaMrVXa-865-454.png)
然后执行
./phoenixMC_linux  开始进行代码烧写，烧写完成后再将拨码开关拨回靠串口位置，重启。

打开minicom或其他串口工具监视设备输入信息，波特率115200。
功能演示：
初次上电后先进行配网：
netmgr connect ssid psswd
其中ssid和psswd分别替换为你无线网络名及密码。
根据终端提示，待网络连接后，出现以下提示时：
![press key](https://img.alicdn.com/tfs/TB1otataQyWBuNjy0FpXXassXXa-865-231.png)
按按键2（AK2）触发语音识别功能。
![talking](https://img.alicdn.com/tfs/TB1o0ataQyWBuNjy0FpXXassXXa-865-199.png)
此时对着开发板说话，语音数据被编码、上传到云端、识别成功后返回相应信息，识别失败亦有相应提示。
示例：
1:明天上班需要带伞吗？
2.给我讲个鬼故事。
3.推荐一部悬疑电影。
4.把空调打开。

