目前，我们使用运行在Raspberry PI 3上的Bluez作为provisioner。要在Raspberry PI3上运行Bluez meshctl作为provisioner，需要对Raspberry PI的编译选项进行调整，使能一些安全相关特性，才能够正常运行meshctl。在linux上交叉编译Raspberry PI kernel。

下载Raspberry PI系统源代码

`git clone https://github.com/raspberrypi/linux.git`

使用的kernel部分git log

`commit 7d08abb35d33fceba593c2381ae0944975b21506
Author: Yevhen Kyriukha <kirgene@gmail.com>
Date:   Sun Jan 14 13:36:24 2018 +0200

    Added support for mbed AudioCODEC (TLV320AIC23B)
    
    Signed-off-by: Yevhen Kyriukha <kirgene@gmail.com>`

