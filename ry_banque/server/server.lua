ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("gBank:deposer")
AddEventHandler("gBank:deposer", function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local total = money
    local xMoney = xPlayer.getMoney()
    
    if xMoney >= total then

    xPlayer.addAccountMoney('bank', total)
    xPlayer.removeMoney(total)
 
         TriggerClientEvent('esx:showAdvancedNotification', source, 'Banque', 'Banque', "Vous avez deposé ~g~"..total.."$~s~ à la banque !", 'CHAR_BANK_FLEECA', 6)
    else
         TriggerClientEvent('esx:showNotification', source, "Vous n'avez pas assez ~r~d\'argent~s~ !")
    end    
end) 

RegisterServerEvent("gBank:retirer")
AddEventHandler("gBank:retirer", function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local total = money
    local xMoney = xPlayer.getAccount('bank').money
    
    if xMoney >= total then

    xPlayer.removeAccountMoney('bank', total)
    xPlayer.addMoney(total)
 
         TriggerClientEvent('esx:showAdvancedNotification', source, 'Banque', 'Banque', "Vous avez retiré ~g~"..total.."$~s~ de la banque !", 'CHAR_BANK_FLEECA', 6)
    else
         TriggerClientEvent('esx:showNotification', source, "Vous n'avez pas assez ~r~d\'argent~s~ !")
    end    
end)


RegisterServerEvent("bank:solde") 
AddEventHandler("bank:solde", function(action, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerMoney = xPlayer.getAccount('bank').money
    TriggerClientEvent("solde:argent", source, playerMoney)
end)

ESX.RegisterServerCallback('yamsoo:getItemAmountbank', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local quantity = xPlayer.getInventoryItem(item).count

	cb(quantity)
end)


RegisterNetEvent('yamsoo:achatcb')
AddEventHandler('yamsoo:achatcb', function(v, quantite)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerMoney = xPlayer.getMoney()

    if playerMoney >= 500 then
        xPlayer.addInventoryItem('carteb', 1)
        xPlayer.removeMoney(500)
        TriggerClientEvent('esx:showNotification', source, "Vous avez recu votre ~b~Carte Bancaire.")
    else
        TriggerClientEvent('esx:showNotification', source, "Alors, t'a pas ~r~d\'argent")    
    end    
end)