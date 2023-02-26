--Monitors for Skillchian Partners

Skillchain_Leader_Name = ''
Skillchain_Leader_WS = ''

Skillchain_Leader_Name_2 = ''
Skillchain_Leader_WS_2 = ''

Skillchain_Leader_Name_3 = ''
Skillchain_Leader_WS_3 = ''

Skillchain_Leader_Name_4 = ''
Skillchain_Leader_WS_4 = ''

function skillchain(Leader, WS)
    log("Skillchain #1 - Leader:["..Leader.."], Weaponskill:["..WS.."]")
    if Leader ~= 'none' and WS ~= 'none' then
        Skillchain_Leader_Name = Leader
        Skillchain_Leader_WS = WS
        windower.add_to_chat(8,'Monitoring #1 ['..Skillchain_Leader_Name..'] for ['..Skillchain_Leader_WS..'] to skillchain with.')
    else
        Skillchain_Leader_Name = ''
        Skillchain_Leader_WS = ''
    end
end

function skillchain2(Leader, WS)
    log("Skillchain #2 - Leader:["..Leader.."], Weaponskill:["..WS.."]")
    if Leader ~= 'none' and WS ~= 'none' then
        Skillchain_Leader_Name_2 = Leader
        Skillchain_Leader_WS_2 = WS
        windower.add_to_chat(8,'Monitoring #2 ['..Skillchain_Leader_Name_2..'] for ['..Skillchain_Leader_WS_2..'] to skillchain with.')
    else
        Skillchain_Leader_Name_2 = ''
        Skillchain_Leader_WS_2 = ''
    end
end

function skillchain3(Leader, WS)
    log("Skillchain #3 - Leader:["..Leader.."], Weaponskill:["..WS.."]")
    if Leader ~= 'none' and WS ~= 'none' then
        Skillchain_Leader_Name_3 = Leader
        Skillchain_Leader_WS_3 = WS
        windower.add_to_chat(8,'Monitoring #3 ['..Skillchain_Leader_Name_3..'] for ['..Skillchain_Leader_WS_3..'] to skillchain with.')
    else
        Skillchain_Leader_Name_3 = ''
        Skillchain_Leader_WS_3 = ''
    end
end

function skillchain4(Leader, WS)
    log("Skillchain #4 - Leader:["..Leader.."], Weaponskill:["..WS.."]")
    if Leader ~= 'none' and WS ~= 'none' then
        Skillchain_Leader_Name_4 = Leader
        Skillchain_Leader_WS_4 = WS
        windower.add_to_chat(8,'Monitoring #4 ['..Skillchain_Leader_Name_4..'] for ['..Skillchain_Leader_WS_4..'] to skillchain with.')
    else
        Skillchain_Leader_Name_4 = ''
        Skillchain_Leader_WS_4 = ''
    end
end

function run_skillchain_check(data)
    if character.name == Skillchain_Leader_Name then
        ability = res.weapon_skills[data.param]
        if ability.en == Skillchain_Leader_WS then
            if primarytarget then
                log('['..character.name..'] Weaponskill ['..ability.en..'] on ['..primarytarget.name..' - ('..primarytarget.index..')] Follower #1')
                action = 'skillchain_'..tostring(player.name)..'_'..ability.en..'_'..character.name..'_'..primarytarget.index
                send_packet(action)
            end
        end
    end
    if character.name == Skillchain_Leader_Name_2 then
        ability = res.weapon_skills[data.param]
        if ability.en == Skillchain_Leader_WS_2 then
            if primarytarget then
                log('['..character.name..'] Weaponskill ['..ability.en..'] on ['..primarytarget.name..' - ('..primarytarget.index..')] Follower #2')
                action = 'skillchain2_'..tostring(player.name)..'_'..ability.en..'_'..character.name..'_'..primarytarget.index
                send_packet(action)
            end
        end
    end
    if character.name == Skillchain_Leader_Name_3 then
        ability = res.weapon_skills[data.param]
        if ability.en == Skillchain_Leader_WS_3 then
            if primarytarget then
                log('['..character.name..'] Weaponskill ['..ability.en..'] on ['..primarytarget.name..' - ('..primarytarget.index..')] Follower #3')
                action = 'skillchain3_'..tostring(player.name)..'_'..ability.en..'_'..character.name..'_'..primarytarget.index
                send_packet(action)
            end
        end
    end
    if character.name == Skillchain_Leader_Name_4 then
        ability = res.weapon_skills[data.param]
        if ability.en == Skillchain_Leader_WS_4 then
            if primarytarget then
                log('['..character.name..'] Weaponskill ['..ability.en..'] on ['..primarytarget.name..' - ('..primarytarget.index..')] Follower #4')
                action = 'skillchain4_'..tostring(player.name)..'_'..ability.en..'_'..character.name..'_'..primarytarget.index
                send_packet(action)
            end
        end
    end
end

function run_spell_check(data)
    if character.name == Skillchain_Leader_Name then
        if data.param ~= 0 then
            ability = res.spells[data.targets[1].actions[1].param]
            if ability.en == Skillchain_Leader_WS then
                if primarytarget then
                    log('['..character.name..'] skillchain with spell ['..ability.en..'] on ['..primarytarget.name..' - ('..primarytarget.index..')] for Follower #1')
                    action = 'skillchain_'..tostring(player.name)..'_'..ability.en..'_'..character.name..'_'..primarytarget.index
                    send_packet(action)
                end
            end
        end
    end
    if character.name == Skillchain_Leader_Name_2 then
        if data.param ~= 0 then
            ability = res.spells[data.targets[1].actions[1].param]
            if ability.en == Skillchain_Leader_WS_2 then
                if primarytarget then
                    log('['..character.name..'] skillchain with spell ['..ability.en..'] on ['..primarytarget.name..' - ('..primarytarget.index..')] for Follower #2')
                    action = 'skillchain2_'..tostring(player.name)..'_'..ability.en..'_'..character.name..'_'..primarytarget.index
                    send_packet(action)
                end
            end
        end
    end
    if character.name == Skillchain_Leader_Name_3 then
        if data.param ~= 0 then
            ability = res.spells[data.targets[1].actions[1].param]
            if ability.en == Skillchain_Leader_WS_3 then
                if primarytarget then
                    log('['..character.name..'] skillchain with spell ['..ability.en..'] on ['..primarytarget.name..' - ('..primarytarget.index..')] for Follower #3')
                    action = 'skillchain3_'..tostring(player.name)..'_'..ability.en..'_'..character.name..'_'..primarytarget.index
                    send_packet(action)
                end
            end
        end
    end
    if character.name == Skillchain_Leader_Name_4 then
        if data.param ~= 0 then
            ability = res.spells[data.targets[1].actions[1].param]
            if ability.en == Skillchain_Leader_WS_4 then
                if primarytarget then
                    log('['..character.name..'] skillchain with spell ['..ability.en..'] on ['..primarytarget.name..' - ('..primarytarget.index..')] for Follower #3')
                    action = 'skillchain3_'..tostring(player.name)..'_'..ability.en..'_'..character.name..'_'..primarytarget.index
                    send_packet(action)
                end
            end
        end
    end
end