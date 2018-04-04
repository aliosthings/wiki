# AliOS Things 认证流程
* [Step1. 移植适配](#step1)
* [Step2. 认证申请](#step2)
* [Step3. 商家自测](#step3)
* [Step4. 硬件邮寄](#step4)
* [Step5. 认证测试](#step5)
* [Step6. 颁发证书](#step6)
![](assets/process.png)

<a id="step1"></a>
### Step1. 移植适配
AliOS Things已经在GitHub开源并且提供完善的移植文档。详见 [https://github.com/alibaba/AliOS-Things.git](https://github.com/alibaba/AliOS-Things.git)

<a id="step2"></a>
### Step2. 认证申请 
认证申请步骤如下：
1. 下载 [AliOS Things 认证申请表](http://alios-things.oss-cn-shanghai.aliyuncs.com/AliOSThings/AliOS%20Things%20%E8%AE%A4%E8%AF%81%E6%8F%90%E4%BA%A4%E7%94%B3%E8%AF%B7%E8%A1%A8.xlsm)
2. 仔细阅读并完整填写申请表
3. 仔细阅读并准备申请表中所需的电子材料
4. 将 [AliOS Things 认证申请表](http://alios-things.oss-cn-shanghai.aliyuncs.com/AliOSThings/AliOS%20Things%20%E8%AE%A4%E8%AF%81%E6%8F%90%E4%BA%A4%E7%94%B3%E8%AF%B7%E8%A1%A8.xlsm) 和 该表中所需的所有电子材料压缩，命名为 `AliOS Things认证申请-{芯片型号}.zip`
5. 将以上压缩包邮件发送至[shaofa.lsf@alibaba-inc.com](mailto:shaofa.lsf@alibaba-inc.om)，邮件主题为`[AliOS Things认证申请] {公司名称}`

> **注意：**
> 1. <a style="color:#ff0000">为了避免认证申请被驳回，请务必完整填写申请表并提供全部的电子材料</a>
> 2. <a style="color:#ff0000">邮件主题不符可能导致认证申请邮件被拒收</a>
> 3. 原则上认证申请不超过两轮
> 4. 认证申请一般会在2个工作日内审核完成并以邮件反馈

<a id="step3"></a>
### Step3. 商家自测
认证申请审核通过后，阿里小二会通过[钉钉](https://www.dingtalk.com/)联系相关技术人员，引导商家自测。在此过程中需要商家登陆阿里云相关系统，请提前注册阿里云账号。
1. 商家使用阿里云账号登陆[IoT认证支撑平台](https://certification.aliyun.com)，并告知小二登陆的用户名
2. 阿里小二根据 AliOS Things认证申请表中提交的材料为商家创建自测任务
3. 商家根据自测用例列表进行自测，自测方法参见 [AliOS Things 自测指南](Manual)
4. 商家自测通过后将源码上传至GitHub

<a id="step4"></a>
### Step4. 硬件邮寄
商家自测期间可以提前邮寄硬件，邮寄内容包括但不限于：
1. 纸质版 [AliOS Things认证申请表](http://alios-things.oss-cn-shanghai.aliyuncs.com/AliOSThings/AliOS%20Things%20%E8%AE%A4%E8%AF%81%E6%8F%90%E4%BA%A4%E7%94%B3%E8%AF%B7%E8%A1%A8.xlsm)(`Step2.认证申请`中填写)
2. 开发板 5 套（含电源、连接线各5套）
3. 调试下载器 2 套（若需要）
4. 天线和通信卡 5套（若需要）
5. 通信模块 5套（若需要）
5. 串口线 5 套（Micro USB/Mini USB/DB9 RS232）
6. 杜邦线若干（若需要）
7. 等

```
邮寄地址：杭州市余杭区文一西路969号1号楼小邮局
联系电话：18557515801
收件人：少舒
```

> **注意：**
> 1. <a style="color:#ff0000">务必确保邮寄的硬件与自测的硬件相同</a>
> 2. <a style="color:#ff0000">为了避免二次邮寄，请务必一次性邮寄所有必需的硬件，邮寄前请通过钉钉或者电话确认</a>

<a id="step5"></a>
### Step5. 认证测试
在商家自测全部通过并且收到硬件后，阿里小二开始进行认证测试。认证期间会使用[阿里云云效系统](https://rdc.aliyun.com)作为缺陷管理系统，请提前注册阿里云账号。
> 原则上认证测试不超过30天

<a id="step6"></a>
### Step6. 颁发证书
待所有认证测试项全部通过后，阿里云IoT会在[IoT认证支撑平台](https://certification.aliyun.com)颁发线上的AliOS Things认证证书。