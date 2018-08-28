
# AliOS Things uData第三方算法移植说明文档 #

## 一、AliOS Things uData支持第三方算法介绍 ##

普通第三方应用数据算法可以在Service Manage中注册回调函数，由uData主task统一调用。如果要做Sensor Fusion，融合算法可能需要以独立task的形式存在，uData提供一套机制帮助开发者快速搭建独立task算法应用。
功能接口代码位于uData/uData_queue.c，示例代码位于uData/uData_service_task.c


    int uData_new_servicetask(const char *name, void (*fn)(void *),void *arg,int stack_size, int prio);
用于创建servicetask，栈大小和任务优先级可独立配置。
> - name：任务名
> - fn：task主循环函数，主循环函数需要开发者自己编写
> - arg：fn参数没有为NULL
> - stack_size：栈大小
> - prio：任务优先级
> - 返回值：taskid

    int uData_observe_servicetask_tag(int taskid,sensor_tag_e tag);
uData独立算法task会对Abstract Data Model层上报的传感器数据类型会做过滤，该函数用于设置需要观察的传感器类型，需要调用该函数独立算法task才能接收到该类型的传感器数据。
>    - taskid:通过uData_new_servicetask创建的taskid
>    - tag:传感器类型

    int aos_msg_recv(int task_id, unsigned int ms, void *msg,unsigned int *size);
用于接收传感器Abstract Data Model层上报的传感器数据。
>    - task_id：通过uData_new_servicetask创建的taskid
>    - ms：超时时间
>    - msg：消息体
>    - size：消息大小
>    - 返回值：成功0 失败非0


## 二、AliOS Things uData第三方独立算法task快速上手 ##
uData/uData_service_task.c中创建了`process_example` servicetask处理函数，并观察TAG_DEV_HUMI和TAG_DEV_TEMP传感器数据，在`process_example`中打印数据。

以developerkit开发板为例
输入以下命令编译uDataapp，然后烧录后运行
    `aos make uDataapp@developerkit`

串口打印显示

    [1878340]<V> algo own task tag=6
    
    [1878350]<V> algo own task tag=8
example运行成功，开发者根据自己需求观察对应传感器数据类型，在`process_example`主循环函数中做数据处理。