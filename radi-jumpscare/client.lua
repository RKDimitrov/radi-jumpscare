local headbagList = GlobalState.headbagList or {}
local attachedObject = nil

RegisterNetEvent('jumpscare:removeHeadBag', function()
    if attachedObject and DoesEntityExist(attachedObject) then
        DeleteEntity(attachedObject)
        SetEntityAsNoLongerNeeded(attachedObject)
    end
    SendNUIMessage({ action = "remove" })
end)

local isUsingHeadbag = false
RegisterNetEvent("jumpscare:toggleHeadbag", function()
    isUsingHeadbag = true
    SendNUIMessage({ action = "open" })
    SendNUIMessage({ action = "playSound", sound = "sound.mp3" }) -- Trigger NUI to play sound

    SetTimeout(Config.UseHeadbagTimeout, function()
        isUsingHeadbag = false
    end)
end)



AddStateBagChangeHandler('jumpscareList', 'global', function(_, _, value)
    headbagList = value
end)

-- Update this command to trigger the server event with the player ID
RegisterCommand('radi', function(source, args)
    local playerId = tonumber(args[1]) -- Get player ID from command arguments
    if playerId then
        TriggerServerEvent("jumpscare:triggerForPlayer", playerId)
    else
        Notify("Invalid player ID", "error")
    end
end, false)

RegisterCommand('radii', function(source, args)
    local playerId = tonumber(args[1]) -- Get player ID from command arguments
    if playerId then
        TriggerServerEvent("jumpscare:removeHeadbag", playerId)
    else
        Notify("Invalid player ID", "error")
    end
end, false)

