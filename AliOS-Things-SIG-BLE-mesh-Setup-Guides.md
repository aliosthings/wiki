目前，我们使用运行在Raspberry PI 3上的Bluez作为provisioner。要在Raspberry PI3上运行Bluez meshctl作为provisioner，需要对Raspberry PI的编译选项进行调整，使能一些安全相关特性，才能够正常运行meshctl。在linux上交叉编译Raspberry PI kernel。

下载Raspberry PI系统源代码

`git clone https://github.com/raspberrypi/linux.git`

使用的kernel部分git log

 `commit 7d08abb35d33fceba593c2381ae0944975b21506

  Author: Yevhen Kyriukha <kirgene@gmail.com>

  Date:   Sun Jan 14 13:36:24 2018 +0200

    Added support for mbed AudioCODEC (TLV320AIC23B)
    
    Signed-off-by: Yevhen Kyriukha <kirgene@gmail.com>`

设置交叉编译工具链路径。
luwang@ubuntu:~/raspberry-pi/linux$ export CCPREFIX=/home/luwang/raspberry-pi/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin/arm-linux-gnueabihf- 
luwang@ubuntu:~/raspberry-pi/linux$ ${CCPREFIX}gcc -v
Using built-in specs.
COLLECT_GCC=/home/luwang/raspberry-pi/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin/arm-linux-gnueabihf-gcc
COLLECT_LTO_WRAPPER=/home/luwang/raspberry-pi/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin/../libexec/gcc/arm-linux-gnueabihf/4.8.3/lto-wrapper
Target: arm-linux-gnueabihf
Configured with: /cbuild/slaves/oorts/crosstool-ng/builds/arm-linux-gnueabihf-raspbian-linux/.build/src/gcc-linaro-4.8-2014.01/configure --build=i686-build_pc-linux-gnu --host=i686-build_pc-linux-gnu --target=arm-linux-gnueabihf --prefix=/cbuild/slaves/oorts/crosstool-ng/builds/arm-linux-gnueabihf-raspbian-linux/install --with-sysroot=/cbuild/slaves/oorts/crosstool-ng/builds/arm-linux-gnueabihf-raspbian-linux/install/arm-linux-gnueabihf/libc --enable-languages=c,c++,fortran --disable-multilib --enable-multiarch --with-arch=armv6 --with-tune=arm1176jz-s --with-fpu=vfp --with-float=hard --with-pkgversion='crosstool-NG linaro-1.13.1-4.8-2014.01 - Linaro GCC 2013.11' --with-bugurl=https://bugs.launchpad.net/gcc-linaro --enable-__cxa_atexit --enable-libmudflap --enable-libgomp --enable-libssp --with-gmp=/cbuild/slaves/oorts/crosstool-ng/builds/arm-linux-gnueabihf-raspbian-linux/.build/arm-linux-gnueabihf/build/static --with-mpfr=/cbuild/slaves/oorts/crosstool-ng/builds/arm-linux-gnueabihf-raspbian-linux/.build/arm-linux-gnueabihf/build/static --with-mpc=/cbuild/slaves/oorts/crosstool-ng/builds/arm-linux-gnueabihf-raspbian-linux/.build/arm-linux-gnueabihf/build/static --with-isl=/cbuild/slaves/oorts/crosstool-ng/builds/arm-linux-gnueabihf-raspbian-linux/.build/arm-linux-gnueabihf/build/static --with-cloog=/cbuild/slaves/oorts/crosstool-ng/builds/arm-linux-gnueabihf-raspbian-linux/.build/arm-linux-gnueabihf/build/static --with-libelf=/cbuild/slaves/oorts/crosstool-ng/builds/arm-linux-gnueabihf-raspbian-linux/.build/arm-linux-gnueabihf/build/static --enable-threads=posix --disable-libstdcxx-pch --enable-linker-build-id --enable-plugin --enable-gold --with-local-prefix=/cbuild/slaves/oorts/crosstool-ng/builds/arm-linux-gnueabihf-raspbian-linux/install/arm-linux-gnueabihf/libc --enable-c99 --enable-long-long --with-float=hard
Thread model: posix
gcc version 4.8.3 20140106 (prerelease) (crosstool-NG linaro-1.13.1-4.8-2014.01 - Linaro GCC 2013.11) 
luwang@ubuntu:~/raspberry-pi/linux$



