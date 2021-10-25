local open = false 
local achatcarte = RageUI.CreateMenu('Banque', " ")
achatcarte.Display.Header = true 
achatcarte.Closed = function()
  open = false
end

function achattahcb()
     if open then 
         open = false
         RageUI.Visible(achatcarte, false)
         return
     else
         open = true 
         RageUI.Visible(achatcarte, true)
         CreateThread(function()
         while open do 
            RageUI.IsVisible(achatcarte,function() 


                RageUI.Separator('~b~Bienvenue '..GetPlayerName(PlayerId()))
        
                RageUI.Separator("")
                RageUI.Separator("~r~Nous avons apprecu que vous n'avez pas")
                RageUI.Separator("~r~Carte Bancaire, nous vous invitons")
                RageUI.Separator("~r~à acheter une Carte Bancaire.")
                RageUI.Separator("")
                RageUI.Button("Acheter une Carte Banciare →", nil, {RightLabel = "~g~500 $"}, true, {onSelected = function()
                    ESX.TriggerServerCallback('yamsoo:getItemAmountbank', function(quantity)
                        if quantity < 1 then
                            TriggerServerEvent('yamsoo:achatcb')
                            Wait(1)
                        else
                            ESX.ShowNotification("~r~Vous avez déja une Carte Bleu.")
                    end
                end, 'carteb')
                end
                })

            end)


          Wait(0)
         end
      end)
   end
end






-- CREER UN PED --
Citizen.CreateThread(function()
    local hash = GetHashKey("u_m_m_bankman")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
      Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVFEMALE", "u_m_m_bankman",  243.73, 226.20, 105.29, 159.87, false, true) -- remplacer x, y, z par coordonnés
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
end)











local position = {
    {x = 243.55, y = 224.55, z = 106.29}
}



Citizen.CreateThread(function()
    while true do

      local wait = 750

        for k in pairs(position) do
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)
			

        
            if dist <= 10.0 then
               wait = 0
                Visual.Subtitle("Appuyez sur ~g~[E]~s~ pour parler avec le ~g~Banquier", 1) 
                if IsControlJustPressed(1,51) then
                    ESX.TriggerServerCallback('yamsoo:getItemAmountbank', function(quantity)
                        if quantity > 0 then
                        playAnim('mp_common', 'givetake1_a', 2500)
                        Citizen.Wait(2500)
                        Config.GetPlayerMoney()
                        MenuBanque()
                    else
                        achattahcb()
                    end
                end, 'carteb')
    end
    end
    Citizen.Wait(wait)
    end
end
end)





-- Blips
Citizen.CreateThread(function()
    for i=1, #Config.position, 1 do
       local blip = AddBlipForCoord(243.55, 224.55, 106.29)
       SetBlipSprite(blip, 500)
       SetBlipColour(blip, 69)
       SetBlipAsShortRange(blip, true)
       SetBlipScale(blip, 0.8)

       BeginTextCommandSetBlipName('STRING')
       AddTextComponentString("Banque Centrale")
       EndTextCommandSetBlipName(blip)
   end
end)