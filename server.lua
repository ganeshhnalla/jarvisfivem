local OPENAI_API_KEY = "your_openai_api_key"  -- Replace this with your actual OpenAI API key
local OPENAI_URL = "https://api.openai.com/v1/completions"  -- OpenAI GPT API endpoint

-- Function to send requests to OpenAI API and get responses
function getAIResponse(message)
    local data = {
        model = "gpt-3.5-turbo",  -- You can use GPT-4 as well
        prompt = message,
        max_tokens = 100,
        temperature = 0.7,
    }

    local headers = {
        ["Content-Type"] = "application/json",
        ["Authorization"] = "Bearer " .. OPENAI_API_KEY
    }

    PerformHttpRequest(OPENAI_URL, function(statusCode, response, headers)
        if statusCode == 200 then
            local aiResponse = json.decode(response)
            local responseText = aiResponse.choices[1].text
            TriggerClientEvent('jarvis:voiceResponse', source, responseText)
        else
            TriggerClientEvent('jarvis:voiceResponse', source, "Sorry, I couldn't process your request.")
        end
    end, 'POST', json.encode(data), headers)
end

-- Listen for messages from the client
RegisterServerEvent('jarvis:processCommand')
AddEventHandler('jarvis:processCommand', function(message)
    -- Process the message using AI
    getAIResponse(message)
end)
