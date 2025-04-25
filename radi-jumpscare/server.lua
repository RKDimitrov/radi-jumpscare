-- List of allowed licenses for jumpscare access
local allowedLicenses = {
    "license:da4c6a06a44ad016680b28d73ffb5fdcab1b8df2" -- replace with actual FiveM license IDs
}

-- Function to get the FiveM license from player identifiers
function getFiveMLicense(playerId)
    local identifiers = GetPlayerIdentifiers(playerId)
    for _, identifier in ipairs(identifiers) do
        if string.sub(identifier, 1, 8) == "license:" then
            return identifier
        end
    end
    return nil
end

-- Function to check if the player's license is in the allowed list
function isLicenseAllowed(playerId)
    local license = getFiveMLicense(playerId)
    if license then
        for _, allowedLicense in ipairs(allowedLicenses) do
            if license == allowedLicense then
                return true
            end
        end
    end
    return false
end

-- Handle the server-side trigger for targeting a specific player with the jumpscare
RegisterNetEvent("jumpscare:triggerForPlayer", function(targetPlayerId)
    local src = source -- Get the player who initiated the command

    -- Check if the initiator's license is allowed
    if isLicenseAllowed(src) then
        if targetPlayerId then
            -- Trigger the jumpscare event for the target player
            TriggerClientEvent("jumpscare:toggleHeadbag", targetPlayerId)
        else
            -- Send an error message if the target player ID is invalid
            TriggerClientEvent("chat:addMessage", src, { args = { "Error", "Invalid target player ID." } })
        end
    else
        -- Notify the player if they don't have permission
        TriggerClientEvent("chat:addMessage", src, { args = { "^1Access Denied", "Your license does not have access to this feature." } })
    end
end)

-- Server-side removal event to ensure headbag removal for a specific player
RegisterNetEvent("jumpscare:removeHeadbag", function(targetPlayerId)
    local src = source -- Get the player who initiated the command

    -- Check if the initiator's license is allowed
    if isLicenseAllowed(src) then
        if targetPlayerId then
            -- Trigger the removal event for the target player
            TriggerClientEvent("jumpscare:removeHeadBag", targetPlayerId)
        else
            -- Send an error message if the target player ID is invalid
            TriggerClientEvent("chat:addMessage", src, { args = { "Error", "Invalid target player ID." } })
        end
    else
        -- Notify the player if they don't have permission
        TriggerClientEvent("chat:addMessage", src, { args = { "^1Access Denied", "Your license does not have access to this feature." } })
    end
end)
