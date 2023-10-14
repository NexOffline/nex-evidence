local QBCore = exports['qb-core']:GetCoreObject()

RegisterCommand("evidence", function()
    local PlayerData = QBCore.Functions.GetPlayerData()
    local PlayerJobType = PlayerData.job.type
    local canOpen = false

    if PlayerJobType == "leo" then
        canOpen = true
    end

    if canOpen then
        local input = lib.inputDialog('Evidence', {
            {type = 'input', label = 'Evidence Locker', description = 'Choose which locker you wish to open', required = true}
        })      
    
        TriggerServerEvent("inventory:server:OpenInventory", "stash", Lang:t('info.current_evidence_stash', {value = input[1]}), {
            maxweight = 4000000,
            slots = 500,
        })
        TriggerEvent("inventory:client:SetCurrentStash", Lang:t('info.current_evidence_stash', {value = input[1]}))
            TriggerServerEvent("InteractSound_SV:PlayOnSource", "StashOpen", 0.5)
        
    else
        QBCore.Functions.Notify('You are not authorized!', 'error')
    end
end) 

CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/evidence', 'Store evidence in PD Lockers!')
end) 
