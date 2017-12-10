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

## Yloop的使用
### 从hello world说起

[hello world example](https://github.com/alibaba/AliOS-Things/blob/master/example/helloworld/helloworld.c)
里面有这样一段代码：
```c
static void app_delayed_action(void *arg)
{
    LOG("%s:%d %s\r\n", __func__, __LINE__, aos_task_name());
    aos_post_delayed_action(5000, app_delayed_action, NULL);
}

int application_start(int argc, char *argv[])
{
    aos_post_delayed_action(1000, app_delayed_action, NULL);
    aos_loop_run();

    return 0;
}
```

application_start里面做了两件事情：
* 调用aos_post_delayed_action创建了一个1秒的定时器（Yloop里面只有oneshot timer）
* 调用aos_loop_run进入事件循环

1秒后，定时器触发，app_delayed_action被调用，而app_delayed_action里面
* 调用LOG打印
* 再次创建一个5秒的定时器，重而实现定期执行app_delayed_action

这里注意到，程序并不需要aos_loop_init()去创建Yloop实例，因为系统会默认自动创建主Yloop实例。

