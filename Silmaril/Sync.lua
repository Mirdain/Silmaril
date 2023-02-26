function sync_data() -- uses resource files to send to Silmaril
    get_all_spells()
    get_all_abilities()
    get_all_buffs()
    get_all_weaponskills()
    get_all_jobs()
    get_all_traits()
    get_all_status()
    formattedString = "global_sync_"..tostring(player.name)..'_true'
end

function get_all_spells() -- used via sync request and the function call "sync_data"
    local formattedString = nil
    formattedString = "spelldata_"..tostring(player.name)..'_'
    for id, spell in pairs(all_spells) do
        if spell.type ~= 'Trust' then
            formattedString = formattedString..spell.id..'|'..spell.en..'|'..spell.cast_time..'|'..spell.mp_cost..'|'..spell.range..'|'..spell.type..'|'..targets_table(spell.targets)..','
        end
    end
    formattedString = formattedString:sub(1, #formattedString - 1) -- remove last character
    --log(formattedString)
    send_packet(formattedString)
end

function get_all_abilities() -- used via sync request and the function call "sync_data"
    local formattedString = nil
    formattedString = "abilitydata_"..tostring(player.name)..'_'
    for id, ability in pairs(all_abilities) do
        formattedString = formattedString..ability.id..'|'..ability.en..'|'..ability.mp_cost..'|'..ability.tp_cost..'|'..ability.range..'|'..targets_table(ability.targets)..','
    end
    formattedString = formattedString:sub(1, #formattedString - 1) -- remove last character
    --log(formattedString)
    send_packet(formattedString)
end

function get_all_buffs()
    local formattedString = nil
    formattedString = "buffdata_"..tostring(player.name)..'_'
    for id, buff in pairs(all_buffs) do
        formattedString = formattedString..buff.id..'|'..buff.en..','
    end
    formattedString = formattedString:sub(1, #formattedString - 1) -- remove last character
    --log(formattedString)
    send_packet(formattedString)
end

function get_all_weaponskills()
    local formattedString = nil
    formattedString = "weaponskilldata_"..tostring(player.name)..'_'
    for id, ws in pairs(all_weaponskills) do
        if ws.skill then
            formattedString = formattedString..ws.id..'|'..ws.en..'|'..ws.range..'|'..res.skills[ws.skill].en..','
        end
    end
    formattedString = formattedString:sub(1, #formattedString - 1) -- remove last character
    --log(formattedString)
    send_packet(formattedString)
end

function get_all_jobs()
    local formattedString = nil
    formattedString = "jobdata_"..tostring(player.name)..'_'
    for id, job in pairs(all_jobs) do
        formattedString = formattedString..job.id..'|'..job.en..'|'..job.ens..','
    end
    formattedString = formattedString:sub(1, #formattedString - 1) -- remove last character
    --log(formattedString)
    send_packet(formattedString)
end

function get_all_traits()
    local formattedString = nil
    formattedString = "traitdata_"..tostring(player.name)..'_'
    for id, trait in pairs(all_traits) do
        formattedString = formattedString..trait.id..'|'..trait.en..','
    end
    formattedString = formattedString:sub(1, #formattedString - 1) -- remove last character
    --log(formattedString)
    send_packet(formattedString)
end

function get_all_status()
    local formattedString = nil
    formattedString = "statusdata_"..tostring(player.name)..'_'
    for id, status in pairs(all_status) do
        formattedString = formattedString..status.id..'|'..status.en..','
    end
    formattedString = formattedString:sub(1, #formattedString - 1) -- remove last character
    --log(formattedString)
    send_packet(formattedString)
end

function targets_table(targets)
    local formattedString = ''
    for type, target in pairs(targets) do
        formattedString = formattedString..type..'$'
    end    
    formattedString = formattedString:sub(1, #formattedString - 1) -- remove last character
    return formattedString
end