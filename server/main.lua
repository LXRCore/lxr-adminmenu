local frozen = false

local permissions = {
	['bring'] = 'admin',
	['goto'] = 'admin',
	['freeze'] = 'admin',
	['spectate'] = 'admin',
	['ban'] = 'admin',
	['noclip'] = 'admin',
	['kickall'] = 'admin',
	['kick'] = 'admin',
	['time'] = 'god',
	['showcoords'] = 'admin',
	['perms'] = 'god',
}

exports['lxr-core']:AddCommand('admin', 'Open the admin menu (Admin Only)', {}, false, function(source)
  	local src = source
  	TriggerClientEvent('admin:client:OpenMenu', src)
end, 'admin')

exports['lxr-core']:AddCommand('noclip', 'No Clip (Admin Only)', {}, false, function(source)
	local src = source
	TriggerClientEvent('admin:client:ToggleNoClip', src)
end, 'admin')

exports['lxr-core']:AddCommand('setammo', 'Set weapon ammo (Admin Only)', {{name='amount', help='Amount of bullets, for example: 20'}, {name='weapon', help='Name of the weapon, for example: WEAPON_REVOLVER_CATTLEMAN'}}, false, function(source, args)
  	local src = source
  	local weapon = args[2] or 'current'
  	local amount = tonumber(args[1])
	TriggerClientEvent('admin:client:SetWeaponAmmoManual', src, weapon, amount)
end, 'admin')

exports['lxr-core']:CreateCallback('admin:server:hasperms', function(source, cb, action)
	local src = source
	if exports['lxr-core']:HasPermission(src, permissions[action]) or IsPlayerAceAllowed(src, 'command') then
		cb(true)
	else
		cb(false)
	end
end)

exports['lxr-core']:CreateCallback('admin:server:getplayers', function(source, cb)
	local src = source
	local players = {}
	for k,v in pairs(exports['lxr-core']:GetPlayers()) do
		local target = GetPlayerPed(v)
		local ped = exports['lxr-core']:GetPlayer(v)
		players[#players + 1] = {
			name = ped.PlayerData.charinfo.firstname .. ' ' .. ped.PlayerData.charinfo.lastname .. ' | (' .. GetPlayerName(v) .. ')',
			id = v,
			coords = GetEntityCoords(target),
			citizenid = ped.PlayerData.citizenid,
			sources = GetPlayerPed(ped.PlayerData.source),
			sourceplayer = ped.PlayerData.source
		}
  	end
	table.sort(players, function(a, b)
    	return a.id < b.id
  	end)
  	cb(players)
end)

RegisterNetEvent('admin:server:getPlayersForBlips', function()
	local src = source
	local players = {}
	for k,v in pairs(exports['lxr-core']:GetPlayers()) do
		local target = GetPlayerPed(v)
		local ped = exports['lxr-core']:GetPlayer(v)
		players[#players + 1] = {
			name = ped.PlayerData.charinfo.firstname .. ' ' .. ped.PlayerData.charinfo.lastname .. ' | ' .. GetPlayerName(v),
			id = v,
			coords = GetEntityCoords(target),
			citizenid = ped.PlayerData.citizenid,
			sources = GetPlayerPed(ped.PlayerData.source),
			sourceplayer = ped.PlayerData.source
		}
  	end
  	TriggerClientEvent('admin:client:show', src, players)
end)

RegisterNetEvent('admin:server:cloth', function(player)
	local src = source
	if exports['lxr-core']:HasPermission(src, permissions['perms']) or IsPlayerAceAllowed(src, 'command') then
		TriggerClientEvent('lxr-clothing:client:openMenu', player.id,'all')
	end
end)

RegisterNetEvent('admin:server:kick', function(player, reason)
	local src = source
	if exports['lxr-core']:HasPermission(src, permissions['kick']) or IsPlayerAceAllowed(src, 'command') then
		TriggerEvent('lxr-log:server:CreateLog', 'bans', 'Player Kicked', 'red', string.format('%s was kicked by %s for %s', GetPlayerName(player.id), GetPlayerName(src), reason), true)
		DropPlayer(player.id, Lang:t("info.kicked_server") .. ':\n' .. reason .. '\n\n' .. Lang:t("info.check_discord") .. exports['lxr-core']:GetConfig().Discord)
	end
end)

RegisterNetEvent('admin:server:bring', function(player) 
	local src = source 
	if exports['lxr-core']:HasPermission(src, permissions['bring']) or IsPlayerAceAllowed(src, 'command') then 
		local admin = GetPlayerPed(src) 
		local adminCoords = GetEntityCoords(admin) 
		local target = GetPlayerPed(player.id) 
		SetEntityCoords(target, adminCoords) 
	end
end)

RegisterNetEvent('admin:server:goto', function(player)
	local src = source
	if exports['lxr-core']:HasPermission(src, permissions['goto']) or IsPlayerAceAllowed(src, 'command') then
		local admin = GetPlayerPed(src)
		local target = GetPlayerPed(player.id)
		local targetCoords = GetEntityCoords(target)
		SetEntityCoords(admin, targetCoords)
	end
end)

RegisterNetEvent('admin:server:spectate', function(player)
	local src = source
	if exports['lxr-core']:HasPermission(src, permissions['spectate']) or IsPlayerAceAllowed(src, 'command') then
		local admin = GetPlayerPed(src)
		local target = GetPlayerPed(player.id)
		local coords = GetEntityCoords(target) 
		TriggerClientEvent('admin:client:spectate', src, player.id, coords)
	end
end)

RegisterNetEvent('admin:server:freeze', function(player)
	local src = source
	if exports['lxr-core']:HasPermission(src, permissions['freeze']) or IsPlayerAceAllowed(src, 'command') then
		TriggerClientEvent('admin:client:Freeze', player.id)
	end
end)

RegisterNetEvent('admin:server:inventory', function(player)
	local src = source
	if exports['lxr-core']:HasPermission(src, permissions['perms']) or IsPlayerAceAllowed(src, 'command') then
		TriggerClientEvent('admin:client:inventory', src, player.id)
	end
end)

RegisterNetEvent('admin:server:ban', function(player, time, reason)
	local src = source
	if exports['lxr-core']:HasPermission(src, permissions['ban']) or IsPlayerAceAllowed(src, 'command') then
		local time = tonumber(time)
		local banTime = tonumber(os.time() + time)
		if banTime > 2147483647 then
			banTime = 2147483647
		end
		local timeTable = os.date('*t', banTime)

		MySQL.insert.await('INSERT INTO bans (name, license, discord, ip, reason, expire, bannedby) VALUES (?, ?, ?, ?, ?, ?, ?)', {
			GetPlayerName(player.id),
			GetPlayerIdentifierByType(player.id, 'license'),
			GetPlayerIdentifierByType(player.id, 'discord'),
			GetPlayerIdentifierByType(player.id, 'ip'),
			reason,
			banTime,
			GetPlayerName(src)
		})

		TriggerClientEvent('chat:addMessage', -1, {
			template = "<div class=chat-message server'><strong>ANNOUNCEMENT | {0} has been banned:</strong> {1}</div>",
			args = {GetPlayerName(player.id), reason}
		})

		TriggerEvent('lxr-log:server:CreateLog', 'bans', 'Player Banned', 'red', string.format('%s was banned by %s for %s', GetPlayerName(player.id), GetPlayerName(src), reason), true)
		if banTime >= 2147483647 then
			DropPlayer(player.id, Lang:t("info.banned") .. '\n' .. reason .. Lang:t("info.ban_perm") .. exports['lxr-core']:GetConfig().Discord)
		else
			DropPlayer(player.id, Lang:t("info.banned") .. '\n' .. reason .. Lang:t("info.ban_expires") .. timeTable['day'] .. '/' .. timeTable['month'] .. '/' .. timeTable['year'] .. ' ' .. timeTable['hour'] .. ':' .. timeTable['min'] .. '\n🔸 Check our Discordformore information: ' .. exports['lxr-core']:GetConfig().Discord)
		end
	end
end)
