#### `public int `[`aos_register_event_filter`](#yloop_8h_1ae3324303aa3a911b01709b8e5d106aa5)`(uint16_t type,`[`aos_event_cb`](#yloop_8h_1ae6cbb49016d564e65ca5338cb69d6185)` cb,void * priv)` 

Register system event filter callback

#### Parameters
* `type` event type interested 

* `cb` system event callback 

* `priv` data to be bypassed to cb

#### Returns
the operation status, 0 is OK, others is error

#### `public int `[`aos_unregister_event_filter`](#yloop_8h_1af2001a3071743d68d2f1c6ec151ce6f5)`(uint16_t type,`[`aos_event_cb`](#yloop_8h_1ae6cbb49016d564e65ca5338cb69d6185)` cb,void * priv)` 

Unregister native event callback

#### Parameters
* `type` event type interested 

* `cb` system event callback 

* `priv` data to be bypassed to cb

#### Returns
the operation status, 0 is OK, others is error

#### `public int `[`aos_post_event`](#yloop_8h_1ad5da1aeb283d518df00e420c0a9112b7)`(uint16_t type,uint16_t code,unsigned long value)` 

Post local event

#### Parameters
* `type` event type 

* `code` event code 

* `value` event value

#### Returns
the operation status, 0 is OK,others is error

#### `public int `[`aos_poll_read_fd`](#yloop_8h_1a3f457aa0c5536e9e87da66bc606e35cc)`(int fd,`[`aos_poll_call_t`](#yloop_8h_1a7f61fff1d584f548770634ff74b9542c)` action,void * param)` 

Register a poll event in main loop

#### Parameters
* `fd` poll fd 

* `action` action to be executed 

* `param` private data past to action

#### Returns
the operation status, 0 is OK,others is error

#### `public void `[`aos_cancel_poll_read_fd`](#yloop_8h_1a2dcdc7bf91430300946e0688ae3db02e)`(int fd,`[`aos_poll_call_t`](#yloop_8h_1a7f61fff1d584f548770634ff74b9542c)` action,void * param)` 

Cancel a poll event to be executed in main loop

#### Parameters
* `fd` poll fd 

* `action` action to be executed 

* `param` private data past to action

#### `public int `[`aos_post_delayed_action`](#yloop_8h_1a8a48d02d905c2d0c7d7768af7ac0a3d6)`(int ms,`[`aos_call_t`](#yloop_8h_1ad5156dbeffd3153f16cffed15f2a26fe)` action,void * arg)` 

Post a delayed action to be executed in main loop

#### Parameters
* `ms` milliseconds to wait 

* `action` action to be executed 

* `arg` private data past to action

#### Returns
the operation status, 0 is OK,others is error

#### `public void `[`aos_cancel_delayed_action`](#yloop_8h_1a7fe6a4f879719ee04d1a24c7f8c73486)`(int ms,`[`aos_call_t`](#yloop_8h_1ad5156dbeffd3153f16cffed15f2a26fe)` action,void * arg)` 

Cancel a delayed action to be executed in main loop

#### Parameters
* `ms` milliseconds to wait, -1 means don't care 

* `action` action to be executed 

* `arg` private data past to action

#### `public int `[`aos_schedule_call`](#yloop_8h_1a7016fd75f6deb04517416399dcbbd594)`(`[`aos_call_t`](#yloop_8h_1ad5156dbeffd3153f16cffed15f2a26fe)` action,void * arg)` 

Schedule a callback in next event loop.

#### Parameters
* `action` action to be executed 

* `arg` private data past to action 

#### Parameters
* `>=0` success 

* `<0` failure 

Unlike aos_post_delayed_action, this function can be called from non-aos-main-loop context. Schedule a callback in next event loop

#### Parameters
* `action` action to be executed 

* `arg` private data past to action

#### Returns
the operation status, <0 is error,others is OK

#### `public `[`aos_loop_t`](#yloop_8h_1a654b2a49d4665eeb1d24b1b2195de6a5)` `[`aos_loop_init`](#yloop_8h_1a19622d95d4b65bff57b549e9b8c93155)`(void)` 

Init a per-task event loop

#### Returns
the handler of aos_loop_t,NULL failure,others success

#### `public `[`aos_loop_t`](#yloop_8h_1a654b2a49d4665eeb1d24b1b2195de6a5)` `[`aos_current_loop`](#yloop_8h_1a0eafe54e0bba4d333828ae02533a28ba)`(void)` 

Get current event loop

#### Returns
default event loop

#### `public void `[`aos_loop_run`](#yloop_8h_1a67c03238fac573432b77b2a957fad2b9)`(void)` 

Start event loop

#### `public void `[`aos_loop_exit`](#yloop_8h_1aad0299c429ba51bfebff02e355773ad9)`(void)` 

Exit event loop, [aos_loop_run()](#yloop_8h_1a67c03238fac573432b77b2a957fad2b9) will return

#### `public void `[`aos_loop_destroy`](#yloop_8h_1abbca6051ca7795fb409a32677513635f)`(void)` 

Free event loop resources

#### `public int `[`aos_loop_schedule_call`](#yloop_8h_1afd6d962757a7b9facf290828ab9b5014)`(`[`aos_loop_t`](#yloop_8h_1a654b2a49d4665eeb1d24b1b2195de6a5)` * loop,`[`aos_call_t`](#yloop_8h_1ad5156dbeffd3153f16cffed15f2a26fe)` action,void * arg)` 

Schedule a callback specified event loop

#### Parameters
* `loop` event loop to be scheduled, NULL for default main loop 

* `action` action to be executed 

* `arg` private data past to action

#### Returns
the operation status, <0 is error,others is OK

#### `public void * `[`aos_loop_schedule_work`](#yloop_8h_1adeabf846886d65a22e1780e1060d725b)`(int ms,`[`aos_call_t`](#yloop_8h_1ad5156dbeffd3153f16cffed15f2a26fe)` action,void * arg1,`[`aos_call_t`](#yloop_8h_1ad5156dbeffd3153f16cffed15f2a26fe)` fini_cb,void * arg2)` 

Schedule a work to be executed in workqueue

#### Parameters
* `ms` milliseconds to delay before execution, 0 means immediately 

* `action` action to be executed 

* `arg1` private data past to action 

* `fini_cb` finish callback to be executed after action is done in current event loop 

* `private` data past to fini_cb

#### Returns
work handle,NULL failure,others is OK

#### `public void `[`aos_cancel_work`](#yloop_8h_1a0eb3dd015bc0328943d482f6fab26fee)`(void * work,`[`aos_call_t`](#yloop_8h_1ad5156dbeffd3153f16cffed15f2a26fe)` action,void * arg1)` 

Cancel a work

#### Parameters
* `work` work to be cancelled 

* `action` action to be executed 

* `arg1` private data past to action