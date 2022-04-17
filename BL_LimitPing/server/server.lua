function bl_limitping(xPlayer, text, xTarget, source, to, amount)
    local discord_webhook = ConfigSV.WebhookPing
    if discord_webhook == '' then
      return
    end
    local headers = {
      ['Content-Type'] = 'application/json'
    }
    local data = {
      ["username"] = "BL_LIMITPING",
      ["avatar_url"] = "https://i.imgur.com/go4moGp.gif",
      ["embeds"] = {{
        ["author"] = {
        ["name"] = ConfigSV.NameServer
        },		
        ["color"] = 1942002,
        ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
      }}
    }
    data['embeds'][1]['description'] = text
    PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
	
end

RegisterServerEvent("blackverified")
AddEventHandler("blackverified", function()
	ping = GetPlayerPing(source)
	local name = GetPlayerName(source)	
	local steamID  = "Unknown"
	local license  = "Unknown"
	local discord  = "Unknown"
	local playerip = "Unknown"

	for k,v in ipairs(GetPlayerIdentifiers(source))do
		 if string.sub(v, 1, string.len("steam:")) == "steam:" then 
			steam = string.sub(v, 7) steamID = "" .. steam .. ""
			elseif string.sub(v, 1, string.len("license:")) == "license:" then
			lice = string.sub(v, 9) license = "" .. lice .. ""
			elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
			ip = string.sub(v, 4) playerip = "" .. ip .. ""
			elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
			id = string.sub(v, 9) discord = "<@" .. id .. ">" 
			end
	end
	
	if ping >= ConfigSV.PingLimite then
	bl_limitping(source,"\n**RAZON :** Se detecto que su ping subio a **"..ping.."ms**, cuando el limite es: **".. ConfigSV.PingLimite.. "ms**\n**Nombre de Steam :** ".. name .."\n**IP del jugador :** ".. playerip .."\n**SteamID :** "..steamID.."\n**Licencia :** "..license.."\n**Discord :** "..discord)
	if ConfigSV.KickEnable then
	DropPlayer(source,ConfigSV.MessageKick.. " Limite: [" .. ConfigSV.PingLimite .. "ms], Tu ping actual: [" .. ping .. "ms]")
	end
	end
end)

