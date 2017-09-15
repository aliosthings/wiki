get the offset of a member variable

#### Parameters
* `type` the type of the struct this is embedded in. 

* `member` the name of the list_struct within the struct.

#### `define `[`aos_container_of`](#list_8h_1ab351f3482972778a52453d4cf00f273c) 

get the struct for this entry 
#### Parameters
* `ptr` the &struct list_head pointer. 

* `type` the type of the struct this is embedded in. 

* `member` the name of the list_struct within the struct.

#### `define `[`dlist_entry`](#list_8h_1aa90e0ac71281846733410d0625524d02) 

get the struct

#### Parameters
* `addr` list address 

* `type` the type of the struct this is embedded in. 

* `member` the name of the list_struct within the struct.

#### `define `[`AOS_DLIST_INIT`](#list_8h_1ad84316f170c0ed94abff6bee5ca3986d) 

init zhe list

#### Parameters
* `list` list to be inited

#### `define `[`dlist_first_entry`](#list_8h_1af1a183b22309a4a18139101e0b8dc5be) 

get the fist struct in the list

#### Parameters
* `ptr` the &struct list_head pointer. 

* `type` the type of the struct this is embedded in. 

* `member` the name of the list_struct within the struct.

#### `define `[`dlist_for_each`](#list_8h_1a85c0c0944bdf6463f332c38d02ee1b69) 

iterate over list of given type

#### Parameters
* `pos` the type * to use as a loop cursor 

* `head` he head for your list

#### `define `[`dlist_for_each_safe`](#list_8h_1a3b0134cd9d9839dbf4188a814fe19bd2) 

iterate over list of given type safety

#### Parameters
* `pos` the type * to use as a loop cursor 

* `n` the type * to use as a loop temp 

* `head` he head for your list

#### `define `[`dlist_for_each_entry`](#list_8h_1ac613bf70e3c79057a81c158113c50455) 

iterate over list of given type

#### Parameters
* `queue` he head for your list 

* `node` the type * to use as a loop cursor 

* `type` the type of the struct this is embedded in 

* `member` the name of the list_struct within the struct

#### `define `[`dlist_for_each_entry_safe`](#list_8h_1a32b2914cd25f6124306ae66c046deb1d) 

iterate over list of given type safey

#### Parameters
* `queue` he head for your list 

* `node` the type * to use as a loop cursor 

* `n` the type * to use as a temp. 

* `type` the type of the struct this is embedded in 

* `member` the name of the list_struct within the struct

#### `define `[`list_entry`](#list_8h_1a26c976b7f654e70df318c1843e5094de) 

get the struct for this entry 
#### Parameters
* `ptr` the &struct list_head pointer. 

* `type` the type of the struct this is embedded in. 

* `member` the name of the list_struct within the struct.

#### `define `[`dlist_for_each_entry_reverse`](#list_8h_1aaa882b0cf8af3cc7245e51a6b1095f4c) 

iterate backwards over list of given type

#### Parameters
* `pos` the type * to use as a loop cursor. 

* `head` he head for your list 

* `member` the name of the list_struct within the struct 

* `type` the type of the struct this is embedded in.

#### `define `[`dlist_entry_number`](#list_8h_1a3f5a888135b513cb5ee39f534842e062) 

get zhe list length

#### Parameters
* `queue` he head for your list

#### `define `[`AOS_DLIST_HEAD_INIT`](#list_8h_1ae00de76a37aadf228d5da0e6295736af) 

#### `define `[`AOS_DLIST_HEAD`](#list_8h_1a6707b3b791b349124111c7c9e5b777dd) 

#### `define `[`slist_for_each_entry`](#list_8h_1a2b49a24c73d18c6175de98419869d1ac) 

iterate over list of given type

#### Parameters
* `queue` he head for your list 

* `node` the type * to use as a loop cursor 

* `type` the type of the struct this is embedded in 

* `member` the name of the list_struct within the struct

#### `define `[`slist_for_each_entry_safe`](#list_8h_1aff7c0edb74de8e67a0c1cc15c4b06e8e) 

iterate over list of given type safey

#### Parameters
* `queue` he head for your list 

* `node` the type * to use as a loop cursor 

* `n` the type * to use as a temp. 

* `type` the type of the struct this is embedded in 

* `member` the name of the list_struct within the struct

#### `define `[`AOS_SLIST_HEAD_INIT`](#list_8h_1afc7b63732b51ec4d92227018f6d71494) 

#### `define `[`AOS_SLIST_HEAD`](#list_8h_1a350fd389591b7bf3da3e81baed9fbbee) 

#### `define `[`slist_entry`](#list_8h_1a7345be2c3717197378d0c294603a92f9) 

get the struct for this entry 
#### Parameters
* `ptr` the &struct list_head pointer. 

* `type` the type of the struct this is embedded in. 

* `member` the name of the list_struct within the struct.

#### `define `[`slist_first_entry`](#list_8h_1af97027b393b390597759c365c6820c0f) 

get the struct for this entry 
#### Parameters
* `ptr` the &struct list_head pointer. 

* `type` the type of the struct this is embedded in. 

* `member` the name of the list_struct within the struct.

#### `define `[`slist_entry_number`](#list_8h_1a6b07c04dad0d85b6e31f4a4cec20d808) 

get zhe list length

#### Parameters
* `queue` he head for your list
