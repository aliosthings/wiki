#### `public int `[`cli_register_command`](#cli_8h_1a23c3dbb78c76121d390d07b74619b68e)`(const struct `[`cli_command`](#structcli__command)` * command)` 

This function registers a command with the command-line interface.

#### Parameters
* `command` The structure to register one CLI command

#### Returns
: 0 on success, 1 on failure

#### `public int `[`cli_unregister_command`](#cli_8h_1a2a21b313d17b8810170b996151349750)`(const struct `[`cli_command`](#structcli__command)` * command)` 

This function unregisters a command from the command-line interface.

#### Parameters
* `command` The structure to unregister one CLI command

#### Returns
: 0 on success, 1 on failure

#### `public int `[`cli_register_commands`](#cli_8h_1a94651f2613336ec2981c0ec9721673cc)`(const struct `[`cli_command`](#structcli__command)` * commands,int num_commands)` 

Register a batch of CLI commands Often, a module will want to register several commands.

#### Parameters
* `commands` Pointer to an array of commands. 

* `num_commands` Number of commands in the array.

#### Returns
: 0 on successï¼ 1 on failure

#### `public int `[`cli_unregister_commands`](#cli_8h_1a0140b701cc2a99ccc96b7180844ea301)`(const struct `[`cli_command`](#structcli__command)` * commands,int num_commands)` 

Unregister a batch of CLI commands

#### Parameters
* `commands` Pointer to an array of commands. 

* `num_commands` Number of commands in the array.

#### Returns
: 0 on success,1 on failure

#### `public int `[`cli_printf`](#cli_8h_1a208041556e7760947b1d89ecb5598575)`(const char * buff,...)` 

Print CLI msg

#### Parameters
* `buff` Pointer to a char * buffer.

#### Returns
: 0 on success, error code otherwise.

#### `public int `[`aos_cli_init`](#cli_8h_1a14ab9e06d8c6409b4b5593e70769e9dc)`(void)` 

CLI initial function

#### Returns
: 0 on success, error code otherwise

#### `public int `[`aos_cli_stop`](#cli_8h_1a480bf860a9810003f30d6909d83d6457)`(void)` 

Stop the CLI thread and carry out the cleanup

#### Returns
: 0 on success, return error code otherwise.