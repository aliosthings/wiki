# 1 新增模块
具体通过如下两个示例说明
## 1.1	目标一
增加一个新模块 newcomp，在example下的 nano工程中调用新模块接口，运行查看结果。
### 1.1.1	选择新模块放置位置
组件可以放置在以下任一目录中：
```
COMPONENT_DIRECTORIES := . \
                         example   \
                         board     \
                         kernel    \
                         platform  \
                         utility   \
                         framework \
                         tools     \
                         test      \
                         device    \
                         security
```
例如在framework下创建一个 newcomp 目录。
### 1.1.2	增加新模块源文件
如在newcomp 目录中创建newcomp.c :
```
//newcomp.c
#include <stdio.h>
#include <aos/aos.h>

void newcomp_fun()
{
	printf("this is in newcomp_fun\n");
}

```

### 1.1.3	增加新模块的.mk文件
.mk文件是模块存在的标志。每一个模块都会有一个对应的mk文件，makefile通过搜索mk后缀的文件来查找模块。其中声明了一些针对该模块的定制化的东西。最基本的两个就是该模块所包含的源文件和该模块依赖的其他模块。如：
```
// newBcomp.mk
NAME := newcomp
$(NAME)_SOURCES := newcomp.c
```
### 1.1.4	增加新模块的对外头文件

```	
// newcomp.h
#ifndef NEW_COMP_H
#define NEW_COMP_H

void newcomp_fun();

#endif
```
模块的对外头文件，一般都需包含在 aos.h中，以方便用户使用。在aos.h中添加一行：
``
#include <aos/newcomp.h>
``
### 1.1.5	修改 nano 源文件调用新接口
如：
```
//nano.c
#include <stdio.h>
#include <aos/aos.h>

static void app_delayed_action(void *arg)
{
    printf("%s:%d %s\r\n", __func__, __LINE__, aos_task_name());
	newcomp_fun();	
}

int application_start(int argc, char *argv[])
{
    do
    {
        app_delayed_action(NULL);
        aos_msleep(100);
    }while(1);
}
```
### 1.1.6	修改 nano的 .mk 文件依赖新模块
在nano.mk中新增一行：
```
$(NAME)_COMPONENTS += newcomp
```
### 1.1.7	运行结果
打印如下：
```
$ ./nano@linuxhost.elf
cpu num is 1
trace should have cli to control!!!
app_delayed_action:9 app
this is in newcomp_fun
app_delayed_action:9 app
this is in newcomp_fun
```

## 1.2	目标二
增加一个新模块 newBcomp， 被另一个模块 newcomp所依赖。

前4步和目标一中的一样，可以修改 newcomp.c调用newBcomp的接口，再在 newcomp.mk 加上下面这句即可：
```
$(NAME)_COMPONENTS += newBcomp
```
运行可见newcomp和newBcomp中的接口均被调用。
