# sgx-lockpick

A lockpick minigame for use with other scripts

## Installation

> Drag *sgx-lockpick* into your server's resources folder and add `ensure sgx-lockpick` to your *server.cfg*.

> Configure the options to your liking in *config.lua*.

> In your scripts that use lockpicking add the export `exports["sgx-lockpick"]:startLockpick([item or strength], difficulty, pins)`. This export returns true if successful, or false if unsuccessful.

> Restart your server.

## Example

```lua
---@param item string|float?
---@param difficulty number?
---@param pins number?
local success = exports["sgx-lockpick"]:startLockpick(item, difficulty, pins)
if success then
    -- Unlock vehicle
else
    -- Remove lockpick
end
```

## Support

Support and updates are offered through our Discord: https://discord.gg/t3dev