
# API如下：

## MQTT.VERSION
* <strong>返回</strong><strong><code>string</code></strong><strong>对象， 表示MQTT模块的版本信息</strong>


## MQTT.start(config, callback)
* <strong>config : </strong><strong><code>object</code></strong><strong> 对象，MQTT配置参数，上云三要素</strong>
    * __productKey__
    * __deviceName__
    * __deviceSecret__
* __callback： 回调函数__
    * `callback = function(error)`,   `error`为空表示启动成功
* <strong>返回 </strong><strong><code>number</code></strong><strong> ,  0表示正常</strong>
__启动MQTT功能__

## MQTT.subscribe(topic)
* <strong>topic :  </strong><strong><code>string</code></strong><strong>对象</strong>
* <strong>返回 </strong><strong><code>number</code></strong><strong>， 0表示成功</strong>
__订阅主题__

## MQTT.unsubscribe(topic)
* <strong>topic :  </strong><strong><code>string</code></strong><strong>对象</strong>
* <strong>返回 </strong><strong><code>number</code></strong><strong>， 0表示成功</strong>
__取消订阅主题__

## MQTT.publish(topic, msg)
* <strong>topic :  </strong><strong><code>string</code></strong><strong>对象</strong>
* <strong>msg : </strong><strong><code>string</code></strong><strong> 对象</strong>
* <strong>返回 </strong><strong><code>number</code></strong><strong>， 0表示成功</strong>
__推送消息__

 