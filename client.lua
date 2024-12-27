local isJarvisActive = false

-- Registering event for voice response after AI processing
RegisterNetEvent('jarvis:voiceResponse')
AddEventHandler('jarvis:voiceResponse', function(responseText)
    SendNUIMessage({
        action = 'speak',
        text = responseText
    })
end)

-- Command to toggle Jarvis and activate the assistant
RegisterCommand('toggleJarvis', function()
    isJarvisActive = not isJarvisActive
    local status = isJarvisActive and "activated" or "deactivated"
    TriggerEvent('jarvis:voiceResponse', "Jarvis has been " .. status)
end)

-- Listen for chat messages and act as Jarvis
AddEventHandler('chatMessage', function(source, name, message)
    if isJarvisActive then
        -- Call AI processing for any received message
        TriggerServerEvent('jarvis:processCommand', message)
        CancelEvent()
    end
end)
