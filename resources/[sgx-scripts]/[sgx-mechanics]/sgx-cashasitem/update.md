# This is for exsisted users 
- if you already have cashasitem installed you don't need to download it again.
- jusy fallow the staps below

# NEW SERVER TRIGGER
- you can change this triggers for more protection.
- be sure that these 2 triggers are the same, otherwise the script will not work.
```lua
-- to add in sgx-cashasitem/config.lua
Config.UpdateTrigger = "sgx-cashasitem:server:updateCash" 

-- to add in qb-inventory/server.lua
local CashAsItemUpdateTrigger = "sgx-cashasitem:server:updateCash"
```

if you already have cashasitem installed you can also use this but you need to replace some lines in qb-inventory/server.lua
first you need to add in `qb-inventory/server.lua` someware at the top of the file
```lua
local CashAsItemUpdateTrigger = "sgx-cashasitem:server:updateCash"
```  

Then you need to replace all the lines from `"sgx-cashasitem:server:updateCash"` to `CashAsItemUpdateTrigger` in `qb-inventory/server.lua`

with this you can now create your own trigger, so people don't know where it is using for.
this is already a server side script but just in case i want to add this to make it a bit more secure.

then open version file and add 6 as version.
