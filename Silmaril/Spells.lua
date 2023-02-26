function get_spell_recast() 
    local formattedString = nil
    spell_recasts = windower.ffxi.get_spell_recasts()
    -- Returns the recast timers
    formattedString = "spells_"..tostring(player.name)..'_'
    for index, recast in pairs(player_spell_usable) do
        formattedString = formattedString..recast..'|'..spell_recasts[recast]..','
    end
    player_spell_recasts = formattedString:sub(1, #formattedString - 1) -- remove last character
    --log(player_spell_recasts)
end

function get_player_spells() -- Call this on initial load, job change, and start of Silmaril
    local formattedString = nil
    player_spell_usable = {}
    for id, spell in pairs (all_spells) do
        if spells_have[id] == true and spell.type ~= 'Trust' then
            for job, level in pairs (spell.levels) do
                if(job == player.main_job_id and level > 99) then -- Merit spell.  You have learned since it appears from the windower.ffxi.get_spells() in silmaril.lua
                    level = 99
                end
                if (job == player.main_job_id and level <= player.main_job_level) or (job == player.sub_job_id and level <= player.sub_job_level) then
                    table.insert(player_spell_usable, id)
                    --log('Spell ['..id..'] learned ['..spell.en..']')
                    break
                end
            end
        end
    end
end