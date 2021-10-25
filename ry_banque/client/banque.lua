ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end
end)

local PlayerMoney = 0

RegisterNetEvent("solde:argent")
AddEventHandler("solde:argent", function(money, cash)
    PlayerMoney = tonumber(money)
end)



Citizen.CreateThread(function()
    while true do
        local Timer = 500
        for i=1, #Config.posatm, 1 do
        local plycrdjob = GetEntityCoords(GetPlayerPed(-1), false)
        local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, Config.posatm[i].x, Config.posatm[i].y, Config.posatm[i].z)
        if jobdist <= 10.0 and Config.jeveuxmarkeratm then
            Timer = 0
            DrawMarker(Config.Type, Config.posatm[i].x, Config.posatm[i].y, Config.posatm[i].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z, Config.Color.r, Config.Color.g, Config.Color.b, 100, false, true, 2, false, false, false, false)
            end
            if jobdist <= 1.0 then
                Timer = 0
                    Visual.Subtitle("Appuyez sur ~g~[E]~s~ pour accéder a l'ATM", 1)
                    if IsControlJustPressed(1,51) then
                        ESX.TriggerServerCallback('yamsoo:getItemAmountbank', function(quantity)
							if quantity > 0 then
                            playAnim('mp_common', 'givetake1_a', 2500)
                            Citizen.Wait(2500)
                            Config.GetPlayerMoney()
                            MenuBanque()
                        else
                            Nocartefunction()
                        end
                    end, 'carteb')
                end  
            end 
            end 
    Citizen.Wait(Timer)   
end
end)

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)


    AddTextEntry('FMMC_KEY_TIP1', TextEntry) 
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    blockinput = true

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Citizen.Wait(0)
    end
        
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult() 
        Citizen.Wait(500) 
        blockinput = false
        return result 
    else
        Citizen.Wait(500) 
        blockinput = false 
        return nil 
    end
end

local Mbank = RageUI.CreateMenu("Banque", " ")
local MbankDepo = RageUI.CreateSubMenu(Mbank, "Banque", " ")
local MbankReti = RageUI.CreateSubMenu(Mbank, "Banque", " ")

local open = false

Mbank:DisplayGlare(false)
Mbank.Closed = function()
    open = false
end

function MenuBanque() 
    if open then 
		open = false
		RageUI.Visible(Mbank, false)
		return
	else
		open = true 
		RageUI.Visible(Mbank, true)
		CreateThread(function()
		while open do 
        RageUI.IsVisible(Mbank, function()
        RageUI.Separator('~b~Bienvenue '..GetPlayerName(PlayerId()))

        RageUI.Button("Déposer de l'argent", nil, {RightLabel = "→"}, true, {onSelected = function()
        end
        },MbankDepo)

        RageUI.Button("Retirer de l'argent", nil, {RightLabel = "→"}, true, {onSelected = function()
        end
        },MbankReti)  
        
        RageUI.Separator("~g~↓ Informations du Compte ↓")

        RageUI.Button("Solde du compte : ", nil, {RightLabel = "~g~"..PlayerMoney.." $"}, true, {onSelected = function()
            end
            })
        end)

        RageUI.IsVisible(MbankDepo, function()

            RageUI.Separator("~y~↓ Dépôt Disponible ↓")

            RageUI.Button("Déposer ~g~100 $", nil, {RightLabel = "→"}, true, {onSelected = function()
                TriggerServerEvent('gBank:deposer', 100)
                Config.GetPlayerMoney()
            end
            })

            RageUI.Button("Déposer ~g~500 $", nil, {RightLabel = "→"}, true, {onSelected = function()
                TriggerServerEvent('gBank:deposer', 500)
                Config.GetPlayerMoney()
            end
            })

            RageUI.Button("Déposer ~g~2 500 $", nil, {RightLabel = "→"}, true, {onSelected = function()
                TriggerServerEvent('gBank:deposer', 2500)
                Config.GetPlayerMoney()
            end
            })

            RageUI.Separator("~y~↓ Autre montant ↓")

            RageUI.Button("Montant Personnalisé", nil, {RightLabel = "→"}, true, {onSelected = function()
                saisiedepot()
                Config.GetPlayerMoney()
            end
            })
        end)

        RageUI.IsVisible(MbankReti, function()

            RageUI.Separator("~y~↓ Retrait Disponible ↓")

            RageUI.Button("Retirer ~g~100 $", nil, {RightLabel = "→"}, true, {onSelected = function()
                TriggerServerEvent('gBank:retirer', 100)
                Config.GetPlayerMoney()
            end
            })

            RageUI.Button("Retirer ~g~500 $", nil, {RightLabel = "→"}, true, {onSelected = function()
                TriggerServerEvent('gBank:retirer', 500)
                Config.GetPlayerMoney()
            end
            })

            RageUI.Button("Retirer ~g~2 500 $", nil, {RightLabel = "→"}, true, {onSelected = function()
                TriggerServerEvent('gBank:retirer', 2500)
                Config.GetPlayerMoney()
            end
            })   

            RageUI.Separator("~y~↓ Autre montant ↓")

            RageUI.Button("Montant Personnalisé", nil, {RightLabel = "→"}, true, {onSelected = function()
                saisieretrait()
                Config.GetPlayerMoney()
            end
            })

        end)





        Wait(0)
    end
end)
end
end


 Citizen.CreateThread(function()
    while true do
        local Timer = 500
        for i=1, #Config.position, 1 do
        local plycrdjob = GetEntityCoords(GetPlayerPed(-1), false)
        local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, Config.position[i].x, Config.position[i].y, Config.position[i].z)
        if jobdist <= 10.0 and Config.jeveuxmarkerbanque then
            Timer = 0
            DrawMarker(Config.Type, Config.position[i].x, Config.position[i].y, Config.position[i].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z, Config.Color.r, Config.Color.g, Config.Color.b, 100, false, true, 2, false, false, false, false)
            end
            if jobdist <= 1.0 then
                Timer = 0
                    Visual.Subtitle("Appuyez sur ~g~[E]~s~ pour parler avec le ~g~Banquier", 1)
                    if IsControlJustPressed(1,51) then
                        ESX.TriggerServerCallback('yamsoo:getItemAmountbank', function(quantity)
							if quantity > 0 then
                            playAnim('mp_common', 'givetake1_a', 2500)
                            Citizen.Wait(2500)
                            Config.GetPlayerMoney()
                            MenuBanque()
                        else
                            Nocartefunction()
                        end
                    end, 'carteb')
    
                end  
            end 
            end 
    Citizen.Wait(Timer)   
end
end)





local Nocarte = RageUI.CreateMenu("Banque", " ")

local open = false

Nocarte:DisplayGlare(false)
Nocarte.Closed = function()
    open = false
end

function Nocartefunction() 
    if open then 
		open = false
		RageUI.Visible(Nocarte, false)
		return
	else
		open = true 
		RageUI.Visible(Nocarte, true)
		CreateThread(function()
		while open do 
        RageUI.IsVisible(Nocarte, function()
            
        RageUI.Separator('~b~Bienvenue '..GetPlayerName(PlayerId()))
        
        RageUI.Separator("")
        RageUI.Separator("~r~Nous avons apprecu que vous n'avez pas")
        RageUI.Separator("~r~Carte Bancaire, nous vous invitons")
        RageUI.Separator("~r~à acheter une Carte à la banque Centrale.")

        end)

        Wait(0)
    end
end)
end
end



Citizen.CreateThread(function()
    for i=1, #Config.position, 1 do
       local blip = AddBlipForCoord(Config.position[i].x, Config.position[i].y, Config.position[i].z)
       SetBlipSprite(blip, 207)
       SetBlipColour(blip, 69)
       SetBlipAsShortRange(blip, true)
       SetBlipScale(blip, 0.65)

       BeginTextCommandSetBlipName('STRING')
       AddTextComponentString("Banque")
       EndTextCommandSetBlipName(blip)
   end
end)

function saisieretrait()
    local amount = KeyboardInput("Retrait banque", "", 15)

    if amount ~= nil then
        amount = tonumber(amount)

        if type(amount) == 'number' then
            TriggerServerEvent('gBank:retirer', amount)
        else
            ESX.ShowNotification("Vous n'avez pas saisi un montant")
        end
    end
end

function saisiedepot()
    local amount = KeyboardInput("Dépot banque", "", 15)

    if amount ~= nil then
        amount = tonumber(amount)

        if type(amount) == 'number' then
            TriggerServerEvent('gBank:deposer', amount)
        else
            ESX.ShowNotification("Vous n'avez pas saisi un montant")
        end
    end
end

function playAnim(animDict, animName, duration)
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do Citizen.Wait(0) end
	TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
	RemoveAnimDict(animDict)
end