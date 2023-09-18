local QBCore = exports['qb-core']:GetCoreObject()
local display = false



Citizen.CreateThread(function()

	local meslek_patron_kasalari = {
		isInside = false,
		open_zone_kasa = {
	
		}
	}
	
	for _, v in pairs(config.kasalar) do
		meslek_patron_kasalari.open_zone_kasa[#meslek_patron_kasalari.open_zone_kasa+1] = BoxZone:Create(v.kasa_erisimkoordinat, v.kasa_coord_width, v.kasa_coord_lenght, {
			name = v.kasa_job,
			heading = v.kasa_heading,
			debugPoly = v.debug,
			minZ = v.kasa_minZ,
			maxZ = v.kasa_maxZ,
		})
	end
	
	local alancombo = ComboZone:Create(meslek_patron_kasalari.open_zone_kasa, {name = "Kasalar", debugPoly = false})
	alancombo:onPlayerInOut(function(isPointInside, point, zone)
		meslek_patron_kasalari.isInside = isPointInside
		if isPointInside then
			local alan_meslegi = zone.name
			local Player = QBCore.Functions.GetPlayerData()
			local jobName = Player.job.name
			local patronmu = Player.job.isboss
			if (jobName == alan_meslegi) and patronmu then
				TriggerEvent("zm_notify:shownotify",'(E) Tuşuna basarak para kasasına erişebilirsin!',2500,"info")
			
				CreateThread(function()
					while meslek_patron_kasalari.isInside do
						if IsControlJustReleased(0,38) then
							TriggerServerEvent("zm_bossjobcase:checkbosscase",alan_meslegi)
						end
						Wait(1)
					end
				end)	
			end
		end
	end)
end)

RegisterNUICallback("kasaparaekle", function(data)
    local eklenecek_para = data.para
	local meslek = data.meslek

    TriggerServerEvent("zm_bossjobcase:addmoneybosscase_removemoney",eklenecek_para,meslek)
    TriggerScreenblurFadeOut(0)
    zm_bossjobcaseshowkasa(display)

    
end)


RegisterNUICallback("exit", function()
    TriggerScreenblurFadeOut(0)
	zm_bossjobcaseshowkasa(display)
end)



function zm_bossjobcaseshowkasa(bool,meslek_kasasi_para,para_cash,meslek_ismi)
    TriggerScreenblurFadeIn(0)
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "show_kasa_ekrani",
        meslek_kasasi_para = meslek_kasasi_para,
        para_cash = para_cash,
		meslek_ismi = meslek_ismi,
        status = bool,
    })
end



RegisterNetEvent("zm_bossjobcase:opencashcase")
AddEventHandler("zm_bossjobcase:opencashcase", function(meslek_kasasi_para,para_cash,meslek_ismi)

    zm_bossjobcaseshowkasa(not display,meslek_kasasi_para,para_cash,meslek_ismi)
end)

RegisterNUICallback("hataver", function(data)
    TriggerEvent("zm_notify:shownotify",data.mesaj,2500,"error")
end)

