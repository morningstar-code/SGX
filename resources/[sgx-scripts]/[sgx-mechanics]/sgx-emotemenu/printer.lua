print("SGX Core V1.5 EMOTES | Discord: https://discord.gg/sgx")

SetTimeout( 1000, function ()
    if GetResourceState('dpemotes') == 'started' then
        for i = 1, 10 do
            print("RpEmotes: Warning! dpemotes is on the server, this WILL cause issues.")
        end
    end
end)
