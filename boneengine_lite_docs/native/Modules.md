BoneEngine@lite 支持模块操作

# 介绍

## 支持语法

* __module.exports__
* __exports__

## 使用说明
模块内容的获取有两种途径
* __从外部注册函数中获取__
<span data-type="color" style="color:#262626"><code>JSE</code></span>中提供API函数`bone_engine_loadmodule_register`，注册一个回调函数func，当JSE语法分析到`require`时，若JSE缓存中没有该模块时，会调用该func通过模块名来获取该模块的JS内容
* __JS API模块注入__
在JS app中Modules.addCached(module\_name, code)注入

# API

## 方法

### 1. __require(module\_name)__

```javascript
var myModule = require('myModule');
var myModuleInstance = new myModule();
print(myModuleInstance.hello());
print(myModuleInstance.goodbye());

var link = require('linkModule').Link;
print(link.start());
print(require('linkModule').mac);
```

### 2. Modules.addCached(module\_name, code)
向JSE添加模块，以后调用require相关模块名时，会使用该模块内容
* __module\_name__
模块名称
* __code__
模块JS代码
```javascript
Modules.addCached("a","module.exports.foo=1;");
var ta = require("a").foo;
count += ta;
print('ta=' + ta);

Modules.addCached("b","module.exports = {foo:1};");
var tb = require("b").foo;
count += tb;
print('tb=' + tb);

Modules.addCached("c","module.exports = 1;");
var tc = require("c");
count += tc;
print('tc=' + tc);

Modules.addCached("d","exports.foo = 1;");
var td = require("d").foo;
count += td;
print('td=' + td);

Modules.addCached("e","exports.foo = function(){ return 1;};");
var te = require("e").foo();
count += te;
print('te=' + td);


var myModule = "function myModule() {" +
"  this.hello = function() {" +
"    return 'hello!'; " +
"  }; " +
"  this.goodbye = function() {" +
"    return 'goodbye!';" +
"  }; " +
"}; " +
"module.exports = myModule; " ;

//print('myModule=' + myModule);

Modules.addCached("myModule", myModule);

myModule = require('myModule');
var myModuleInstance = new myModule();
print(myModuleInstance.hello());
print(myModuleInstance.goodbye());


var linkModule = " " +
"var mac = 'abc'; " +
"function Link() { " +
"	this.uuid = '1234';" +
"};" +
"var mLink = new Link();" +
"mLink.start = function(){" +
"    return this.uuid + ' start';" +
"};" +
"module.exports.Link = mLink;" +
"module.exports.mac = mac;";

Modules.addCached("linkModule", linkModule);
linkModule = undefined;

link = require('linkModule').Link;
print(link.start());
print(require('linkModule').mac);

```

 