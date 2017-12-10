## Yloop概要

Yloop是AliOS Things的异步时间框架。<br>
Yloop借鉴了libiuv，及嵌入式业界常见的event loop，实现了复杂性，性能，footprint的平衡。

### Yloop上下文
每个Yloop实例（aos_loop_t）与特定的任务上下文绑定，AliOS Things的程序入口application_start所在的上下文与系统的主Yloop实例绑定，该上下文也称为主任务。主任务以外的任务也可以创建自己的Yloop实例。

### Yloop调度
Yloop实现了对IO，timer，callback，event的统一调度管理：
- IO：最常见的是Socket，也可以是AliOS Things的vfs管理的设备
- timer：即常见的定时器
- callback：特定的执行函数
- event：包括系统事件，用户自定义事件

当调用aos_loop_run后，当前任务将会等待上述的各类事件发生。
