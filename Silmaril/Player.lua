function player_info()
    player = windower.ffxi.get_player() -- Update the player information
    local jp_spent = tostring(player.job_points[player.main_job:lower()].jp_spent)
    local target_locked = player.target_locked
    local target_index = player.target_index
    local intIndex = 1
    local formattedString = "buffs_"..player.name.."_"..player.name.."_"

    if target_locked == nil then
        target_locked = "false"
    else
        target_locked = "true"
    end

    -- Update the buffs
    for index, value in pairs(player.buffs) do
        formattedString = formattedString..tostring(value)
        if intIndex ~= tablelength(player.buffs) then
            formattedString = formattedString ..","
        end
        intIndex = intIndex + 1
    end

    party_buffs[player.name] = formattedString

    --name
    --main_job_id
    --main_job_level
    --sub_job_id
    --sub_job_level
    --superior_level
    --jp_spent
    --target_locked

    -- Update character status
    player_status = "player_"..tostring(player.name)..'_'..tostring(player.main_job_id)..','..tostring(player.main_job_level)..','..tostring(player.sub_job_id)..','
    ..tostring(player.sub_job_level)..','..tostring(jp_spent)..','..target_locked..','..tostring(moving)
    --log('Player Data: ['..formattedString..']')
end