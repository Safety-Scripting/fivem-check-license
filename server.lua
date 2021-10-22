local ScriptId = 'YOUR_SCRIPT_ID'
local ScriptVersion = 'YOUR_SCRIPT_VERSION'

function Verificate()
    local ResourceName = GetCurrentResourceName()

    PerformHttpRequest('https://api.safetyscripting.dev/auth/' .. ScriptId .. '/' .. ScriptVersion .. '/' .. AUTH_TOKEN, function(statusCode, resultData, resultHeaders)

        if statusCode == 200 then
            local data = json.decode(resultData)
            if data.valid == true then
                print('^5 [' .. ResourceName .. '] - ^7Auth Validated')
                TriggerClientEvent('StartClientCode', -1)
                Main()
            else
                print('^1 [' .. ResourceName .. '] - ^7Auth Not Validated')
            end
        elseif statusCode == 201 then
            print('^3 ['.. ResourceName ..'] - ^7We are assigning this Ip to your License, Please Wait...')
            Verificate()
        else
            print('^1 [' .. ResourceName .. '] - ^7An unknown error has occurred')
        end

    end, 'POST')
end

function Main()
    -- Add your code here
    print('Code Started')
end

AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        Verificate()
    end
end)