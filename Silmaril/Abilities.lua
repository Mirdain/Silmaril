function get_abilities_recast() -- Used via update to get ability timers
    local formattedString = "abilities_"..tostring(player.name)..'_'
    player_abilities = windower.ffxi.get_abilities()
    ability_recasts = windower.ffxi.get_ability_recasts()
    for index, ability in pairs(player_abilities) do
        if index == "job_abilities" then
            for index, value in pairs(ability) do
                local recast_time = ability_recasts[all_abilities[value].recast_id]
                if recast_time then
                    --log("ability ["..all_abilities[value].id.."] recast id ["..all_abilities[value].recast_id.."] Timer is ["..ability_recasts[all_abilities[value].recast_id].."]")
                    formattedString = formattedString..all_abilities[value].id..'|'..recast_time..','
                end
            end
        end
    end
    player_job_abilities_recasts = formattedString:sub(1, #formattedString - 1) -- remove last character
end

--Not used anymore
function get_player_abilities()
    local formattedString = nil
    -- Returns the players Job Traits and Weaponskills
    for index, ability in pairs(player_abilities) do
        formattedString = nil
        if index == "job_abilities" then
            formattedString = "playerabilities_"..tostring(player.name)..'_'
            for index, value in pairs(ability) do
                formattedString = formattedString..value..','
            end
            formattedString = formattedString:sub(1, #formattedString - 1) -- remove last character
            --log(formattedString)
            send_packet(formattedString)
        elseif index == "job_traits" then
            formattedString = "playertraits_"..tostring(player.name)..'_'
            for index, value in pairs(ability) do
                formattedString = formattedString..value..','
            end
            formattedString = formattedString:sub(1, #formattedString - 1) -- remove last character
            --log(formattedString)
            send_packet(formattedString)
        elseif index == "weapon_skills" then
            formattedString = "playerweaponskills_"..tostring(player.name)..'_'
            for index, value in pairs(ability) do
                formattedString = formattedString..value..','
            end
            formattedString = formattedString:sub(1, #formattedString - 1) -- remove last character
            --log(formattedString)
            send_packet(formattedString)
        elseif index == "pet_commands" then
            formattedString = "playerpetcommands_"..tostring(player.name)..'_'
            for index, value in pairs(ability) do
                formattedString = formattedString..value..','
            end
            formattedString = formattedString:sub(1, #formattedString - 1) -- remove last character
            --log(formattedString)
            send_packet(formattedString)
        else
            log(index)
        end
    end
end
