# timers说明

所有timer相关函数都是全局函数，能够在任意位置访问。

## timer 介绍

## 方法

### __1. setTimeout(callback, delay）__
设定定时器，在delay毫秒之后执行callback函数，返回类型整数（定时器句柄）
* null   : 失败
* number : 成功

输入参数:
* callback : 回调函数
* delay    : 类型为整数，单位毫秒

```
var t1 = setTimeout(function() {"
    print('timer t1 callback run');
    clearTimeout(t1);
}, 500);
```
输出
```
BoneEngine > timer t1 callback run
```

### __2. clearTimeout(timeoutObject)__
取消定时器, 返回值null

输入参数:
* timeoutObject : 调用setTimeout函数返回的整数

> <strong><span data-type="color" style="color:#FF4D4F">setTimeout设定定时器之后， 在时间未到达时可以调用clearTimeout取消定时器</span></strong><span data-type="color" style="color:#FF4D4F">
> </span><strong><span data-type="color" style="color:#FF4D4F">setTimeout设定的定时器执行完之后会自动释放资源，clearTimeout函数可以不调用</span></strong>

### __3. setInterval(callback, delay）__
设定定时器，每次间隔delay毫秒之后执行callback函数，返回类型整数（定时器句柄）
* 0： 成功

输入参数:
* callback : 回调函数
* delay    : 类型为整数，单位毫秒

### __2. clearInterval(timeoutObject)__
取消setInterval设定的定时器, 返回值null

输入参数:
* timeoutObject : 调用setInterval函数返回的整数

> __setInterval设定定时器之后， 需要调用clearInterval取消定时器__
> __setInterval函数的callback中可以调用clearInterval取消定时器__

```
var count = 0;
var t3 = setInterval(function() {
    count++;
    print('js t3 callback run count: ' + count);
    if (count == 3)
        clearInterval(t3);
}, 500);
```

运行结果：
```
BoneEngine > js t3 callback run count: 1 
BoneEngine > js t3 callback run count: 2 
BoneEngine > js t3 callback run count: 3
```

 