# 构建要素

一般而言，一个工程的构建包含如下几个要素：

![](https://img.alicdn.com/tfs/TB1cdUAjx6I8KJjy0FgXXXXzVXa-377-257.png)

## 组件化思想

组件化思想是指是功能模块可以随意地剪裁，拼接。实际上此思想的实现就主要依附于构建体系，一个组件存在的**标志**就是它有一个对应的 .mk 文件。

由于采用组件化管理思想，为了让每个组件相互隔离，独立配置，每一个组件的目录下放置一个.mk来存放每个组件各异的操作配置。并且组件间通过**依赖**来指定关联。而构建系统所有组件统一的操作机制放在build目录下的.mk中。这样可以达到组件间变化隔离，修改灵活的效果

# 总体流程

总体上构建的过程分为如下三个步骤：

![](https://img.alicdn.com/tfs/TB1He6PjC_I8KJjy0FoXXaFnVXa-1295-445.png)

简言之，第二步中如 config.mk，xx.c_opts，link.opts 就包含了上面所说的要素中除工具链链外所有所需的信息。所以构建的核心其实就是这些文件的生成和使用。

更详细的图示如下：

![](https://img.alicdn.com/tfs/TB1W1Eejv6H8KJjy0FjXXaXepXa-1816-820.png)

# mk文件内容说明

一个模块的mk文件中基本上描述了这个组件要如何构建，所以非常关键，下面部分举例来说明其主要内容：

![](https://img.alicdn.com/tfs/TB1E5PxjwvD8KJjSsplXXaIEFXa-1073-552.png)

其中全局是指编译所有组件时都要用到的设置，局部是指仅在编译本组件时用到。一个mk文件就是描述了一个组件的配置信息。其实配置的设定都可以在 _CFLAGS 和 _LDFLAGS中指定，包括链接使用的链接脚本。

# 具体实现说明

下面按照上面所说的要素来展开说明构建体系的具体实现，相关关键代码等：

## 工具链选择

![](https://img.alicdn.com/tfs/TB1X8gvjvDH8KJjy1XcXXcpdXXa-937-348.png)

宿主平台在aos.py中设置。辅助命令工具在 aos_host_cmd.mk 中设置，目前主要支持 windows 和 linux64 上两种编译宿主机平台。

![](https://img.alicdn.com/tfs/TB1mGgdjxrI8KJjy0FpXXb5hVXa-386-132.png)

编译工具链的设置，在 aos_target_xx.mk 和 aos_library_xx.mk中会设置。

## 找到源文件

![](https://img.alicdn.com/tfs/TB19o12hiqAXuNjy1XdXXaYcVXa-1044-181.png)

编译命令通常是 app名@board名，app和board即为查找所有依赖的两个入口组件。

依赖查找过程**递归**实现：

![](https://img.alicdn.com/tfs/TB1l2BIjLDH8KJjy1XcXXcpdXXa-1098-246.png)

事实上上面的查找除了找到源文件之外还会解析出mk中定义编译选项等信息，实际上是在递归解析组件的mk文件。为后面的编译链接步骤做好准备。

### config.mk生成

将上面递归解析出的mk中的信息存储在config.mk中：

![](https://img.alicdn.com/tfs/TB1tWO7hiqAXuNjy1XdXXaYcVXa-903-59.png)

config.mk 其实就是把所有组件 mk 中的信息汇总到一起。而后面产生的opts文件则是针对每个组件把config.mk中信息重新组合到一起产生的一个独立的文件。

## 编译

## 链接

## 二进制及其他处理

# 关键宏调用关系梳理

# 