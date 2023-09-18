local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('zm_bossjobcase:checkbosscase', function(meslek_ismi)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local kasadaki_para= 0
    local para_cash = Player.PlayerData.money.cash

    if (Player.PlayerData.job.isboss) then
        local result = MySQL.query.await('SELECT * FROM meeth_isletmelerin_kasasi WHERE isletme_adi = ? ', {meslek_ismi})
        if result[1] then
            for _,v in pairs(result) do
                kasadaki_para = v.isletme_kasa_para
            end  
        else
            MySQL.insert('INSERT INTO meeth_isletmelerin_kasasi (`isletme_adi`, `isletme_kasa_para`) VALUES (?, ?)', {meslek_ismi, 0})
            kasadaki_para = 0
        end
        TriggerClientEvent("zm_bossjobcase:opencashcase",src,kasadaki_para,para_cash,meslek_ismi)
    else
        TriggerClientEvent("zm_notify:shownotify",src,"Patron Değilsin Hayırdır Bilader ???? ",3500,"error")
    end
end)



RegisterNetEvent('zm_bossjobcase:addmoneybosscase', function(eklenecek_para,meslek)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

    local result = MySQL.query.await('SELECT * FROM meeth_isletmelerin_kasasi WHERE isletme_adi = ? ', {meslek})
    if result[1] then
        MySQL.update('UPDATE meeth_isletmelerin_kasasi SET isletme_kasa_para = isletme_kasa_para + ? WHERE isletme_adi = ?', {tonumber(eklenecek_para), meslek})
    else
        MySQL.insert('INSERT INTO meeth_isletmelerin_kasasi (`isletme_adi`, `isletme_kasa_para`) VALUES (?, ?)', {meslek, tonumber(eklenecek_para)})
    end
    
    TriggerClientEvent("zm_notify:shownotify",src,"Kasaya Başarıyla "..eklenecek_para.."$ Eklendi!",2500,"success")
end)

RegisterNetEvent('zm_bossjobcase:server:addmoneybosscase', function(eklenecek_para,meslek)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

    local result = MySQL.query.await('SELECT * FROM meeth_isletmelerin_kasasi WHERE isletme_adi = ? ', {meslek})
    if result[1] then
        MySQL.update('UPDATE meeth_isletmelerin_kasasi SET isletme_kasa_para = isletme_kasa_para + ? WHERE isletme_adi = ?', {tonumber(eklenecek_para), meslek})
    else
        MySQL.insert('INSERT INTO meeth_isletmelerin_kasasi (`isletme_adi`, `isletme_kasa_para`) VALUES (?, ?)', {meslek, tonumber(eklenecek_para)})
    end
    
    TriggerClientEvent("zm_notify:shownotify",src,"Kasaya Başarıyla "..eklenecek_para.."$ Eklendi!",2500,"success")
end)


RegisterNetEvent('zm_bossjobcase:addmoneybosscase_removemoney', function(eklenecek_para,meslek)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local eklenecek_para = tonumber(eklenecek_para)
    local oyuncuparasi = Player.PlayerData.money['cash']

    if tonumber(oyuncuparasi) >= eklenecek_para then
        local result = MySQL.query.await('SELECT * FROM meeth_isletmelerin_kasasi WHERE isletme_adi = ? ', {meslek})
        if result[1] then
            MySQL.update('UPDATE meeth_isletmelerin_kasasi SET isletme_kasa_para = isletme_kasa_para + ? WHERE isletme_adi = ?', {tonumber(eklenecek_para), meslek})
            
            Player.Functions.RemoveMoney('cash', tonumber(eklenecek_para))
        else
            Player.Functions.RemoveMoney('cash', tonumber(eklenecek_para))
            MySQL.insert('INSERT INTO meeth_isletmelerin_kasasi (`isletme_adi`, `isletme_kasa_para`) VALUES (?, ?)', {meslek, tonumber(eklenecek_para)})
        end
        
        TriggerClientEvent("zm_notify:shownotify",src,"Kasaya Başarıyla "..eklenecek_para.."$ Eklendi!",2500,"success")
    else
        TriggerClientEvent("zm_notify:shownotify",src,"Üzerinde yeterli miktarda nakit para yok!",2500,"error")
    end


end)


RegisterNetEvent('zm_bossjobcase:server:addmoneybosscase_removemoney', function(source,eklenecek_para,meslek)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local eklenecek_para = tonumber(eklenecek_para)
    local oyuncuparasi = Player.PlayerData.money['cash']

    if tonumber(oyuncuparasi) >= eklenecek_para then
        local result = MySQL.query.await('SELECT * FROM meeth_isletmelerin_kasasi WHERE isletme_adi = ? ', {meslek})
        if result[1] then
            MySQL.update('UPDATE meeth_isletmelerin_kasasi SET isletme_kasa_para = isletme_kasa_para + ? WHERE isletme_adi = ?', {tonumber(eklenecek_para), meslek})
            
            Player.Functions.RemoveMoney('cash', tonumber(eklenecek_para))
        else
            Player.Functions.RemoveMoney('cash', tonumber(eklenecek_para))
            MySQL.insert('INSERT INTO meeth_isletmelerin_kasasi (`isletme_adi`, `isletme_kasa_para`) VALUES (?, ?)', {meslek, tonumber(eklenecek_para)})
        end
        
        TriggerClientEvent("zm_notify:shownotify",src,"Kasaya Başarıyla "..eklenecek_para.."$ Eklendi!",2500,"success")
    else
        TriggerClientEvent("zm_notify:shownotify",src,"Üzerinde yeterli miktarda nakit para yok!",2500,"error")
    end


end)