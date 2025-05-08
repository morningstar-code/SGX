AddEventHandler('qb-playerDied', function(weaponLabel, time)
    TriggerClientEvent('sgx-deathscreen:openUI', source, time)
end)

-- Inside your server-side script

-- Function to open the death screen
function OpenDeathScreen(time)
    TriggerClientEvent('sgx-deathscreen:openUI', -1, time) -- -1 sends the event to all clients
end

-- Function to revive a player
function RevivePlayer()
    TriggerClientEvent('sgx-deathscreen:revive', -1)
end

-- Function to update the respawn timer
function UpdateRespawnTimer(time)
    TriggerClientEvent('sgx-deathscreen:updateRes', -1, time)
end

-- Exporting the functions
exports('OpenDeathScreen', OpenDeathScreen)
exports('RevivePlayer', RevivePlayer)
exports('UpdateRespawnTimer', UpdateRespawnTimer)
