RegisterNetEvent('sgx-chopshop:StartMenu', function()
    exports['qb-menu']:openMenu({
        {
            header = 'Chop Parts',
            -- icon = 'fas fa-code',
            isMenuHeader = true, -- Set to true to make a nonclickable title
        },
        {
            header = 'Door',
            icon = 'fas fa-code-merge',
            txt = 'Print a message!',
            params = {
                event = "sgx-chopshop:chopdoor",
                args = {
                    number = 1,
                    id = 2
                }
            }
        },  
        {
            header = 'Wheel',
            icon = 'fas fa-code-merge',
            txt = 'Print a message!',
            params = {
                event = "sgx-chopshop:chopwheel",
                args = {
                    number = 1,
                    id = 2
                }
            }
        }, 
        {
            header = 'Hood',
            icon = 'fas fa-code-merge',
            params = {
                event = "sgx-chopshop:chophood",
                args = {
                    number = 1,
                    id = 2
                }
            }
        }, 
        {
            header = 'Trunk',
            icon = 'fas fa-code-merge',
            params = {
                event = "sgx-chopshop:choptrunk",
                args = {
                    number = 1,
                    id = 2
                }
            }
        }, 

    })
end)

RegisterNetEvent('sgx-chopshop:chopdoor')
AddEventHandler('sgx-chopshop:chopdoor', function()
    TriggerServerEvent("sgx-chopshop:server:chopdoor")
end)

RegisterNetEvent('sgx-chopshop:chopwheel')
AddEventHandler('sgx-chopshop:chopwheel', function()
    TriggerServerEvent("sgx-chopshop:server:chopwheel")
end)

RegisterNetEvent('sgx-chopshop:chophood')
AddEventHandler('sgx-chopshop:chophood', function()
    TriggerServerEvent("sgx-chopshop:server:chophood")
end)

RegisterNetEvent('sgx-chopshop:choptrunk')
AddEventHandler('sgx-chopshop:choptrunk', function()
    TriggerServerEvent("sgx-chopshop:server:choptrunk")
end)