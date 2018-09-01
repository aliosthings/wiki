## 概述

- 该windows makefile可以提供linkkit sdk在windows上编译的能力，主要是针对嵌入式平台
- 目前linkkit在windows上只支持编译出两类.a，一类提供给linkitapp单品类应用的链接，一类提供给linkkit_gateway网关类应用链接
- 可以支持keil/iar工具链的编译
- 目前配网awss代码暂不支持用iar编译，keil和gcc可以
- 目前ota依赖具体aos或者linux平台，对一般嵌入式平台暂不支持ota

## 文件结构

- 修改 win_boar_conf.mk 文件，用户自己加入要添加的board选项，以及相应的工具链位置
- win.makefile是主makfile，其中指定了一些特定的编译选项，若要修改也可以在其中修改

## 命令

    make -f win.makefile COMPILER=[armcc|iar] APP=[linkkit_gateway]
1. 若不加选项或者值非法,默认使用gcc，APP=linkkitapp

2. 添加 Q= 选项可以看到详细打印过程

3. 两次构建之间需要使用 make -f win.makefile clean
