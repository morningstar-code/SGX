local QBCore = exports['qb-core']:GetCoreObject()


isPUBGStart = false
isQUEUEStart = false
isRESTARTING = false
tosunoyunda = false
planeNet = 0
playersInStartOfTheMatch = 0
PUBGGAME = {
    SOLO = {
        name = "SOLO",
        player_list = {},
        players = 0
    }
}
AddEventHandler('playerDropped', function (reason)
	local _source = source
 --local xPlayer = ESX.GetPlayerFromId(_source)
 --print("dropped")
 if tosunoyunda then
	 PUBGGAME["SOLO"].players = (PUBGGAME["SOLO"].players - 1)
	 --playersInStartOfTheMatch = (playersInStartOfTheMatch - 1)
	-- planeNet = (planeNet - 1)

	 print(PUBGGAME["SOLO"].players)
	 removePlayerFromMatch(source)
	 Wait(2000)
	 tosunoyunda = false
 end
 if isPUBGStart or isQUEUEStart then
	 --print("match started")
	 if isPlayerInMatch(source) then
		 print(PUBGGAME["SOLO"].players)
		 --removePlayerFromMatch(source)
		 Wait(2000)
		 if isPUBGStart then
			 checkMatch()
		 end
	 end
 end
end)
RegisterServerEvent('zoyg_pubg_getbppoints')
AddEventHandler('zoyg_pubg_getbppoints', function()
	local xPlayer = QBCore.Functions.GetPlayer(source)
	print(PUBGGAME["SOLO"].players)
	local name = GetPlayerName(source)
	local datamon = xPlayer.PlayerData.money["bp"]
	local players = PUBGGAME["SOLO"].players
	print(PUBGGAME["SOLO"].players)
	local status = "ERROR"
	if not isRESTARTING then
		if not isPUBGStart and not isQUEUEStart then
			status = "INACTIVE"
		elseif not isPUBGStart and isQUEUEStart then
			status = "IN QUEUE"
		elseif isPUBGStart and not isQUEUEStart then
			status = "IN GAME ("..players.."/"..playersInStartOfTheMatch..")"
		end
	else
		status = "RESET MAP..."
	end
	TriggerClientEvent('zoyg_pubg_openmenu',source,name,datamon,players,status)
end)

RegisterServerEvent('zoyg_pubg_updatealive')
AddEventHandler('zoyg_pubg_updatealive', function()

	local players = PUBGGAME["SOLO"].players
	print(PUBGGAME["SOLO"].players)
	TriggerClientEvent('zoyg_pubg_updatealivee',source,players)
end)


RegisterServerEvent('zoygpubg:showmystats')
AddEventHandler('zoygpubg:showmystats', function()
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)
	local wins
	local kills
	local games
	MySQL.Async.fetchAll('SELECT * FROM `players` WHERE citizenid = @identifier', {['@identifier'] = xPlayer.PlayerData.citizenid}, function(result)
		for i=1, #result, 1 do
			wins = result[i].zoygpubgwins
			kills = result[i].zoygpubgkills
			games = result[i].zoygpubggames
			--print(""..wins.." "..kills.." "..games.."")

		end
	end)
	while wins == nil or games == nil or kills == nil do
		Wait(100)
		--print("den to xei")
	end

	TriggerClientEvent('zoygpubg:showmystatss',_source,wins,kills,games)
end)




RegisterServerEvent('zoygpubg:topwinners')
AddEventHandler('zoygpubg:topwinners', function()
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)
	MySQL.Async.fetchAll('SELECT `name`, `zoygpubgwins` FROM `players` ORDER BY `zoygpubgwins` DESC',{}, function(result)
		local datatop = {}
		for k,v in pairs(result) do
			local nameee = result[k].name or "No Player"
			table.insert(datatop, { name = nameee, wins = result[k].zoygpubgwins or 0})
		end
		
		while datatop == nil do
			Wait(100)
			--print("den to xei")
		end
        TriggerClientEvent('zoygpubg:showtopwinars',_source,datatop)
    end)
end)

RegisterServerEvent('zoygpubg:topkillers')
AddEventHandler('zoygpubg:topkillers', function()
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(_source)
	MySQL.Async.fetchAll('SELECT `name`, `zoygpubgkills` FROM `players` ORDER BY `zoygpubgkills` DESC',{}, function(result)
		local datatop = {}
		for k,v in pairs(result) do
			local nameee = result[k].name or "No Player"
			table.insert(datatop, { name = nameee, kills = result[k].zoygpubgkills or 0})
		end
		
		while datatop == nil do
			Wait(100)
			--print("den to xei")
		end
        TriggerClientEvent('zoygpubg:showtopkillerss',_source,datatop)
    end)
end)





RegisterServerEvent('zoygpubg:joingame')
AddEventHandler('zoygpubg:joingame', function()
    local _source = source
    local xPlayer = QBCore.Functions.GetPlayer(source)
	tosunoyunda = true
    if xPlayer ~= nil then
		if not isRESTARTING then
		xPlayer.Functions.AddItem("weapon_assaultrifle_mk2", 1)
		xPlayer.Functions.AddItem("weapon_heavysniper", 1)
		xPlayer.Functions.AddItem("bandage", 1)
		xPlayer.Functions.AddItem("armor", 1)
		xPlayer.Functions.AddItem("everon", 1)
		end
        if not isPUBGStart and not isRESTARTING then
			if PUBGGAME["SOLO"].players < Config.MaxPlayers then
				print(PUBGGAME["SOLO"].players)
				PUBGGAME["SOLO"].player_list[_source] = {
					isDead = false,
					name = GetPlayerName(_source),
					kill = 0
				}
				PUBGGAME["SOLO"].players = (PUBGGAME["SOLO"].players + 1)
				playersInStartOfTheMatch = PUBGGAME["SOLO"].players
				TriggerClientEvent('zoygpubg:joinedgame', _source, PUBGGAME)
				 if not isQUEUEStart then
					print(PUBGGAME["SOLO"].players)
					if PUBGGAME["SOLO"].players >= Config.MinPlayersToStartPUBGGame then
						isQUEUEStart = true
						local sectost = (Config.TimeUntilStartInTicks / 3000)
						local sectostt = math.floor(sectost)
						--TriggerClientEvent('chatMessage', -1, '', {255,255,255}, '^3[PUBG] ^1New game starts in '..sectost..' seconds !^7')
						TriggerClientEvent('chat:addMessage', -1, {
							template = '<div style="padding: 5px; margin: 0.5vw; background: linear-gradient(90deg, rgba(255,226,0,1) 0%, rgba(254,203,0,1) 0%, rgba(250,172,0,1) 24%, rgba(194,130,0,1) 100%); border-radius: 3px;"><img style="width: auto; height: 20px;" src="nui://zoyg_pubg/html/images/pubg.png"/> <span style="color: rgb(50,50,50);font-size: 18px; "><b>Queue started for '..sectostt..' seconds !</b></span></div>',
						})
						isPUBGStart = true
						Wait(Config.TimeUntilStartInTicks)
						if PUBGGAME["SOLO"].players >= Config.MinPlayersToStartPUBGGame then
							isPUBGStart = true
							isQUEUEStart = false
							TriggerClientEvent('zoygpubg:createnetplane')
							--print('starting PUBG GAME !!!')
							startPUBGGame()
						else
							isQUEUEStart = false
							--TriggerClientEvent('chatMessage', -1, '', {255,255,255}, '^3[PUBG] ^1Queue was canceled because the minimum number of players is not met!('..PUBGGAME["SOLO"].players..'/'..Config.MinPlayersToStartPUBGGame..' players)^7')
							TriggerClientEvent('chat:addMessage', -1, {
								template = '<div style="padding: 5px; margin: 0.5vw; background: linear-gradient(90deg, rgba(255,226,0,1) 0%, rgba(254,203,0,1) 0%, rgba(250,172,0,1) 24%, rgba(194,130,0,1) 100%); border-radius: 3px;"><img style="width: auto; height: 20px;" src="nui://zoyg_pubg/html/images/pubg.png"/> <span style="color: rgb(50,50,50);font-size: 18px; "><b>Queue was canceled because the minimum number of players is not met!('..PUBGGAME["SOLO"].players..'/'..Config.MinPlayersToStartPUBGGame..' players)</b></span></div>',
							})
						end
					end
				end
				--updateUI()
			else
				--TriggerClientEvent("esx:showNotification", _source, "[PUBG] The game is full of players. You cannot participate!")
				TriggerClientEvent('zoygpubg:donotjoinedgame', _source)
			end
        else
            --TriggerClientEvent("esx:showNotification", _source, "[PUBG] The game is going on. You cannot participate!")
			TriggerClientEvent('zoygpubg:donotjoinedgame', _source)
        end
    end
end)



QBCore.Functions.CreateCallback('zoygpubg:getPlayers', function(source, cb)
	local data = PUBGGAME["SOLO"].players
	cb(data)
end)


function startPUBGGame()
	
	--print(planeNet)
    for k,v in pairs(PUBGGAME["SOLO"].player_list) do
        TriggerClientEvent('zoygpubg:startgame', k)
    end
    --TriggerClientEvent('chatMessage', -1, '', {255,255,255}, '^3[PUBG] ^1The game starts in 30 seconds !^7')
	TriggerClientEvent('chat:addMessage', -1, {
		template = '<div style="padding: 5px; margin: 0.5vw; background: linear-gradient(90deg, rgba(255,226,0,1) 0%, rgba(254,203,0,1) 0%, rgba(250,172,0,1) 24%, rgba(194,130,0,1) 100%); border-radius: 3px;"><img style="width: auto; height: 20px;" src="nui://zoyg_pubg/html/images/pubg.png"/> <span style="color: rgb(50,50,50);font-size: 18px; "><b>The game starts in 30 seconds !</b></span></div>',
	})
end

RegisterNetEvent("zoygpubg:shareplane")
AddEventHandler("zoygpubg:shareplane", function(planenett,plane) sharePlane(planenett, plane) end)

function sharePlane(planenett,plane)
	print("netid:"..planenett.." / plane: "..plane.."")
	planeNet = planenett
	for k,v in pairs(PUBGGAME["SOLO"].player_list) do
        TriggerClientEvent('zoygpubg:sharePlaneToCl', k,planeNet,plane)
    end
end

RegisterServerEvent('zoygpubg:iamdead')
AddEventHandler('zoygpubg:iamdead', function(currentKiller) 
	local _source = source
    local xPlayer = QBCore.Functions.GetPlayer(_source)
	local playerName = GetPlayerName(_source)
	                                    ExecuteCommand("envanterisil")
    if xPlayer ~= nil then
		local killer
		if currentKiller == "YOURSELF" or currentKiller == "UNKNOWN" then
			killer = currentKiller
		else
			killer = GetPlayerName(currentKiller)
			if Config.anountKill then
				--TriggerClientEvent('chatMessage', -1, '', {255,255,255}, "^3[PUBG] ^8"..playerName.." ^1killed by ^8"..killer.."^1!^7")
				TriggerClientEvent('chat:addMessage', -1, {
					template = '<div style="padding: 5px; margin: 0.5vw; background: linear-gradient(90deg, rgba(255,226,0,1) 0%, rgba(254,203,0,1) 0%, rgba(250,172,0,1) 24%, rgba(194,130,0,1) 100%); border-radius: 3px;"><img style="width: auto; height: 20px;" src="nui://zoyg_pubg/html/images/pubg.png"/> <span style="color: rgb(50,50,50);font-size: 18px; "><b><span style="color:red">'..playerName..'</span> killed by <span style="color:red">'..killer..'!</span></b></span></div>',
				})
			end
		end
		local startedPlayers = playersInStartOfTheMatch
		local placement = PUBGGAME["SOLO"].players
        PUBGGAME["SOLO"].players = (PUBGGAME["SOLO"].players - 1)
		TriggerClientEvent('zoygpubg:revive', _source)
		Citizen.Wait(1000)
		
		local kills = PUBGGAME["SOLO"].player_list[_source].kill
		local bpfromkills = (kills * Config.BPPerKill)
		local bpfromplacement_notsrogkilo = (((startedPlayers + 1) - placement) * (Config.BPForWinner / Config.MaxPlayers))
		local bpfromplacement = math.floor(bpfromplacement_notsrogkilo)
		local reward = (bpfromkills + bpfromplacement)
		xPlayer.Functions.AddMoney("bp", reward)
		local reason = "BETTER LUCK NEXT TIME!"
		removePlayerFromMatch(_source)
		TriggerClientEvent('zoygpubg:setinmatfalse',_source,playerName,kills,bpfromkills,bpfromplacement,reward,placement,startedPlayers,killer,reason)
		Citizen.Wait(1000)
		checkMatch()
		
		MySQL.Async.fetchAll('SELECT * FROM players WHERE citizenid = @identifier', {
            ['@identifier'] = xPlayer.PlayerData.citizenid
        },function(results)
            if results then
                local games = results[1].zoygpubggames
				local killss = results[1].zoygpubgkills
				while games == nil or killss == nil do
					Wait(200)
				end
                local newgames = (games + 1)
				local newkills = (killss + kills)
                MySQL.Async.execute('UPDATE players SET zoygpubggames = @zoygpubggames WHERE citizenid = @identifier', {
                    ['@identifier'] = xPlayer.PlayerData.citizenid,
                    ['@zoygpubggames'] = newgames
                }, function(rowsChanged)
                end)
				MySQL.Async.execute('UPDATE players SET zoygpubgkills = @zoygpubgkills WHERE citizenid = @identifier', {
                    ['@identifier'] = xPlayer.PlayerData.citizenid,
                    ['@zoygpubgkills'] = newkills
                }, function(rowsChanged)
                end)
            end
        end)
    end
end)

RegisterServerEvent('showmekill')
AddEventHandler('showmekill', function(currentKiller) 
	local _source = source
	local srcName = GetPlayerName(_source)
	local kill = GetPlayerName(currentKiller)
	print(""..kill.." killed "..srcName.."")
end)

function removePlayerFromMatch(_source)

    for k,v in pairs(PUBGGAME["SOLO"].player_list) do
        if k == _source then
            PUBGGAME["SOLO"].player_list[_source] = nil
			for k,v in pairs(PUBGGAME["SOLO"].player_list) do
				TriggerClientEvent('zoygpubg:updatealivepl', k, PUBGGAME["SOLO"].players )
			end
            return true
        end
    end
    return false
end


function isPlayerInMatch(_source)
    for k,v in pairs(PUBGGAME["SOLO"].player_list) do
        if k == _source then
            return true
        end
    end
    return false
end


RegisterServerEvent('zoygpubg:ikilled')
AddEventHandler('zoygpubg:ikilled', function() 
    local _source = source
    local xPlayer = QBCore.Functions.GetPlayer(source)
    if xPlayer ~= nil then
		if PUBGGAME["SOLO"].player_list[_source] ~= nil then
			PUBGGAME["SOLO"].player_list[_source].kill = PUBGGAME["SOLO"].player_list[_source].kill + 1
			TriggerClientEvent('zoygpubg:updateplkills', _source, PUBGGAME["SOLO"].player_list[_source].kill )
		end
    end
end)


function checkMatch()
    if PUBGGAME["SOLO"].players == 1 then
		isRESTARTING = true
		local winnername
        for k,v in pairs(PUBGGAME["SOLO"].player_list) do
			winnername = GetPlayerName(k)
			print(""..winnername.." won the game with  kills")

			local startedPlayers = playersInStartOfTheMatch
			local kills = PUBGGAME["SOLO"].player_list[k].kill
			local bpfromkills = (kills * Config.BPPerKill)
			local bpfromplacement_notsrogkilo = (startedPlayers * (Config.BPForWinner / Config.MaxPlayers))
			local bpfromplacement = math.floor(bpfromplacement_notsrogkilo)
			local reward = (bpfromkills + bpfromplacement)
			local xPlayer = QBCore.Functions.GetPlayer(k)
			ExecuteCommand("envanterisil")
			xPlayer.Functions.AddMoney("bp", reward)
			local reason = "WINNER WINNER CHICKEN DINNER!"
			TriggerClientEvent('zoygpubg:setinmatfalse',k,winnername,kills,bpfromkills,bpfromplacement,reward,1,startedPlayers,nil,reason)
			removePlayerFromMatch(k)
            --TriggerClientEvent('zoygpubg:iamwinner', k)
			MySQL.Async.fetchAll('SELECT * FROM players WHERE citizenid = @identifier', {
				['@identifier'] = xPlayer.PlayerData.citizenid
			},function(results)
				if results then
					local games = results[1].zoygpubggames
					local killss = results[1].zoygpubgkills
					local wins = results[1].zoygpubgwins
					while games == nil or killss == nil or wins == nil do
						Wait(200)
					end
					local newgames = (games + 1)
					local newkills = (killss + kills)
					local newwins = (wins + 1)
					MySQL.Async.execute('UPDATE players SET zoygpubggames = @zoygpubggames WHERE citizenid = @identifier', {
						['@identifier'] = xPlayer.PlayerData.citizenid,
						['@zoygpubggames'] = newgames
					}, function(rowsChanged)
					end)
					MySQL.Async.execute('UPDATE players SET zoygpubgkills = @zoygpubgkills WHERE citizenid = @identifier', {
						['@identifier'] = xPlayer.PlayerData.citizenid,
						['@zoygpubgkills'] = newkills
					}, function(rowsChanged)
					end)
					MySQL.Async.execute('UPDATE players SET zoygpubgwins = @zoygpubgwins WHERE citizenid = @identifier', {
						['@identifier'] = xPlayer.PlayerData.citizenid,
						['@zoygpubgwins'] = newwins
					}, function(rowsChanged)
					end)
				end
			end)
        end
        --TriggerClientEvent('chatMessage', -1, '', {255,255,255}, '^3[PUBG] ^8'..winnername.. " won the PUBG game!")
		TriggerClientEvent('chat:addMessage', -1, {
			template = '<div style="padding: 5px; margin: 0.5vw; background: linear-gradient(90deg, rgba(255,226,0,1) 0%, rgba(254,203,0,1) 0%, rgba(250,172,0,1) 24%, rgba(194,130,0,1) 100%); border-radius: 3px;"><img style="width: auto; height: 20px;" src="nui://zoyg_pubg/html/images/pubg.png"/> <span style="color: rgb(50,50,50);font-size: 18px; "><b><span style="color:green;">'..winnername..'</span> won the PUBG game!</b></span></div>',
		})
        TriggerClientEvent('zoygpubg:startendtimer', -1)
		Wait(1000)
		TriggerClientEvent('chat:addMessage', -1, {
			template = '<div style="padding: 5px; margin: 0.5vw; background: linear-gradient(90deg, rgba(255,226,0,1) 0%, rgba(254,203,0,1) 0%, rgba(250,172,0,1) 24%, rgba(194,130,0,1) 100%); border-radius: 3px;"><img style="width: auto; height: 20px;" src="nui://zoyg_pubg/html/images/pubg.png"/> <span style="color: rgb(50,50,50);font-size: 18px; "><b>Reseting Map Please Wait...</b></span></div>',
		})
		Wait(20000)
			
        resetMatch()


		
	elseif PUBGGAME["SOLO"].players < 1 then
		isRESTARTING = true
		TriggerClientEvent('zoygpubg:startendtimer', -1)
		Wait(1000)
		TriggerClientEvent('chat:addMessage', -1, {
			template = '<div style="padding: 5px; margin: 0.5vw; background: linear-gradient(90deg, rgba(255,226,0,1) 0%, rgba(254,203,0,1) 0%, rgba(250,172,0,1) 24%, rgba(194,130,0,1) 100%); border-radius: 3px;"><img style="width: auto; height: 20px;" src="nui://zoyg_pubg/html/images/pubg.png"/> <span style="color: rgb(50,50,50);font-size: 18px; "><b>Reseting Map Please Wait...</b></span></div>',
		})
		Wait(20000)
           resetMatch()

    end
end

function resetMatch()
	playersInStartOfTheMatch = 0
	planeNet = 0
	PUBGGAME = {
		SOLO = {
			name = "SOLO",
			player_list = {},
			players = 0
		}
	}
	TriggerClientEvent('zoygpubg:removeallcars',-1)
	Wait(2000)
	isRESTARTING = false
	isPUBGStart = false
	isQUEUEStart = false
end


RegisterServerEvent('zoygpubg:buyWeapon')
AddEventHandler('zoygpubg:buyWeapon', function(weaponName)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local bppoints = xPlayer.PlayerData.money["bank"]
    local price = Config.Weapons[weaponName].cost
	if price <= bppoints then
		xPlayer.Functions.RemoveMoney('bp', price)
		xPlayer.Functions.AddItem(weaponName, 1)
		local bppointss = xPlayer.PlayerData.money["bank"]
		TriggerClientEvent('zoygpubg:updatebppoints',src,bppointss)
	else 
		--TriggerClientEvent("esx:showNotification", source, "[PUBG] You Do not Have Enough BP Points!")
	end
end)




RegisterServerEvent('zoygpubg:buyItem')
AddEventHandler('zoygpubg:buyItem', function(itemName)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local bppoints = xPlayer.PlayerData.money["bp"]
	local price = Config.Items[itemName].cost
	local sourceItem = xPlayer.Functions.GetItemByName(itemName)
	if price <= bppoints then
		if sourceItem.limit ~= -1 and (sourceItem.count + 1) > sourceItem.limit then
			--TriggerClientEvent('esx:showNotification', src, '[PUBG] You cannot hold this item!')
		else
			xPlayer.Functions.RemoveMoney('bp', price)
			xPlayer.Functions.AddItem(itemName, 1)
			local bppointss = xPlayer.PlayerData.money["bank"]
			TriggerClientEvent('zoygpubg:updatebppoints',src,bppointss)
		end
	else
		--TriggerClientEvent("esx:showNotification", src, "You Do not Have Enough BP Points")
	end
end)