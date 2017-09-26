# 目录
  * [1 多bin的编译方式](#1多bin的编译方式)
  * [2 链接脚本ld文件修改](#2链接脚本ld文件修改)
  * [3 系统的修改](#3系统的修改)
  * [4 Makefile修改](#4Makefile修改)
------
# 1多bin的编译方式  
以mk3060平台为例：
 * 单bin编译： aos make helloworld@mk3060
 * app bin编译：aos make helloworld@mk3060 BINS=app
 * kernel bin编译：aos make helloworld@mk3060 BINS=kernel

# 2链接脚本ld文件修改  
多bin编译意味着有app bin和kernl bin的编译，这意味着有对应的[app.ld](https://github.com/alibaba/AliOS/platform/mcu/beken/linkinfo)和[kernel.ld](https://github.com/alibaba/AliOS/platform/mcu/beken/linkinfo)。
  
ld文件的实现格式和单bin一致，主要需要提供如下一点：
* 在kernel.ld文件中需要设置app.bin的起始位置，以让kernel能够跳转到app中执行。

  如果参考实现与开发者实现一致，可以直接拷贝存放在对应的平台(platform)下面。

# 3系统的修改
* 多bin编译方式，需要在增加syscall层，我们在kernel模块增加了syscall_tbl.c，在app模块增加了usyscall_uapi.c,
作为kernel和app的api桥梁。如果开发者有kernel模块需要暴露给app的，需要按照现在做法在syscall_tbl.c和usyscall_uapi.c
中增加相应的api。
* 对kernel和app都要使用的全局变量，如在kernel中使用全局变量a，需要在syscall层中暴露get_a和set_a的函数，这样开发者可以
在app中同时使用此全局变量。

# 4Makefile修改
AliOS可以以组件化的方式弹性组合，所以在每个组件的makefile文件中，增加了$(NAME)_TYPE变量，可选kernel、app、share三种模式，
如果选择kernel，则编译进入kernel bin，如果选择app，则编译进入app bin，如果为share，则会进入kernel和app bin，如果不填写，
默认进入app bin，完成上述修改后，需要修改对应平台(platform)下相关Makefile。