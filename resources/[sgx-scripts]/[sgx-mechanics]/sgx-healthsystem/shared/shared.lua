if not IsDuplicityVersion() then --client
    sgx.weapons = {
        [-1075685676] = "bullet",
        [126349499] = "bullet",
        [-270015777] = "bullet",
        [615608432] = "bullet",
        [2024373456] = "bullet",
        [-1810795771] = "knife",
        [-1813897027] = "bullet",
        [-598887786] = "bullet",
        [-1654528753] = "bullet",
        [-72657034] = "bullet",
        [-102323637] = "knife",
        [2144741730] = "bullet",
        [-1121678507] = "bullet",
        [-1652067232] = "bullet",
        [961495388] = "bullet",
        [-86904375] = "bullet",
        [-1786099057] = "knife",
        [177293209] = "bullet",
        [600439132] = "bullet",
        [1432025498] = "bullet",
        [-1951375401] = "knife",
        [171789620] = "bullet",
        [1593441988] = "bullet",
        [-2009644972] = "bullet",
        [2138347493] = "bullet",
        [1649403952] = "bullet",
        [-619010992] = "bullet",
        [-952879014] = "bullet",
        [317205821] = "bullet",
        [-1420407917] = "bullet",
        [-1045183535] = "bullet",
        [94989220] = "bullet",
        [-1658906650] = "bullet",
        [1198256469] = "bullet",
        [2132975508] = "bullet",
        [1627465347] = "bullet",
        [984333226] = "bullet",
        [1233104067] = "bullet",
        [-1716189206] = "knife",
        [940833800] = "knife",
        [1305664598] = "bullet",
        [727643628] = "bullet",
        [-1074790547] = "bullet",
        [-1169823560] = "bullet",
        [324215364] = "bullet",
        [-1834847097] = "knife",
        [-1466123874] = "bullet",
        [-1238556825] = "bullet",
        [-1063057011] = "bullet",
        [1470379660] = "bullet",
        [584646201] = "bullet",
        [-494615257] = "bullet",
        [-771403250] = "bullet",
        [1672152130] = "bullet",
        [338557568] = "knife",
        [1785463520] = "bullet",
        [-1355376991] = "bullet",
        [101631238] = "bullet",
        [1119849093] = "bullet",
        [883325847] = "bullet",
        [-102973651] = "knife",
        [-275439685] = "bullet",
        [-1746263880] = "bullet",
        [-879347409] = "bullet",
        [125959754] = "bullet",
        [911657153] = "bullet",
        [-2066285827] = "bullet",
        [-538741184] = "knife",
        [100416529] = "bullet",
        [-656458692] = "knife",
        [-1768145561] = "bullet",
        [1737195953] = "knife",
        [2017895192] = "bullet",
        [-2067956739] = "knife",
        [-1312131151] = "bullet",
        [-1568386805] = "bullet",
        [205991906] = "bullet",
        [1834241177] = "bullet",
        [-1716589765] = "bullet",
        [736523883] = "bullet",
        [1317494643] = "knife",
        [453432689] = "bullet",
        [1141786504] = "knife",
        [-1076751822] = "bullet",
        [-2084633992] = "bullet",
        [487013001] = "bullet",
        [-1168940174] = "bullet",
        [-38085395] = "bullet",
        [-1853920116] = "bullet",
        [-37975472] = "bullet",
        [-1600701090] = "bullet",
        [-1357824103] = "bullet",
        [-581044007] = "knife",
        [741814745] = "bullet",
        [-608341376] = "bullet",
        [137902532] = "bullet",
        [-1660422300] = "bullet",
        [1198879012] = "bullet"
    }

    function getPlayerJob()
        if framework == "qb" then
            return QBCore.Functions.GetPlayerData().job.name
        else
            return ESX.GetPlayerData().job.name
        end
    end
else                             --server
    function getInventoryItems(src)
        if framework == "qb" then
            local player = QBCore.Functions.GetPlayer(src)
            if player then
                return player.PlayerData.items
            end
        elseif framework == "esx" then
            local player = ESX.GetPlayerFromId(src)
            return player.inventory
        end
    end

    function removeItem(src, name, qty)
        if framework == 'esx' then
            local player = ESX.GetPlayerFromId(src)
            if not player then return end
            player.removeItem(name, qty)
        elseif framework == 'qb' then
            local player = QBCore.Functions.GetPlayer(src)
            if not player then return end
            player.Functions.RemoveItem(name, qty)
        end
    end
end
