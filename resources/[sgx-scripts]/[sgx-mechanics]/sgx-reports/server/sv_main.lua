RegisterServerEvent('submit:bug:report')
AddEventHandler('submit:bug:report', function(data)
    local src = source
    local pName = GetPlayerName(source)
    local embedColor = "3289855"
    local discordWebhook = "https://discord.com/api/webhooks/1236040475841003590/2TxgIAo1e1s562yWSAdzttQhbfAepS_GfsYtXxWAX_HRJ58rvt-LZkNAThR23U0YA36N" 
    local connect = {
        {
            ["color"] = embedColor,
            ["author"] = {
                ["name"] = "🐞 New Bug Report from " .. pName,
            },
            ["title"] = "🔍 Report Overview",
            ["description"] = "Below are the details of the bug report submitted. Please review and take the necessary actions.",
            ["fields"] = {
                {
                    ["name"] = "📝 Report Title",
                    ["value"] = data.title,
                    ["inline"] = false
                },
                {
                    ["name"] = "🔧 Type",
                    ["value"] = data.type,
                    ["inline"] = true
                },
                {
                    ["name"] = "📖 Description",
                    ["value"] = data.description,
                    ["inline"] = false
                },
                {
                    ["name"] = "🔗 Links (VODs/Clips/Screenshots)",
                    ["value"] = data.url ~= "" and data.url or "No links provided.",
                    ["inline"] = false
                }
            },
            ["footer"] = {
                ["text"] = "SGX Core Bug Report • " .. os.date("%Y-%m-%d %H:%M:%S", os.time()),
                ["icon_url"] = "https://i.ibb.co/yQfyDKw/SGX-logo.png" -- Footer icon URL.
            },
            ["thumbnail"] = {
                ["url"] = "https://i.ibb.co/yQfyDKw/SGX-logo.png" -- Replace with an appropriate thumbnail URL.
            },
        }
    }
    PerformHttpRequest(discordWebhook, function(err, text, headers) end, 'POST', json.encode({username = "SGX Bug Report", embeds = connect}), { ['Content-Type'] = 'application/json' })
end)
AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
      Citizen.Wait(1000) -- Optional delay to ensure it's the last message
      print('^2Script made by SGX Team^0')
    end
  end)
  