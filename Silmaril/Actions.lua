function action_message(data)
    --[[
    Action packets
    [1] = 'Melee attack',
    [2] = 'Ranged attack finish',
    [3] = 'Weapon Skill finish',
    [4] = 'Casting finish',
    [5] = 'Item finish',
    [6] = 'Job Ability',
    [7] = 'Weapon Skill start',
    [8] = 'Casting start',
    [9] = 'Item start',
    [11] = 'NPC TP finish',
    [12] = 'Ranged attack start',
    [13] = 'Avatar TP finish',
    [14] = 'Job Ability DNC',
    [15] = 'Job Ability RUN',
    ]]--
	if data and enabled then
        action = nil
        ability = nil
        character = nil
        primarytarget = nil
        if data.actor_id then
            character = windower.ffxi.get_mob_by_id(data.actor_id)
        end
        if data.targets[1].id then
            primarytarget = windower.ffxi.get_mob_by_id(data.targets[1].id)
        end
        if character and primarytarget then
            -- Information on the player
            if character.id == player.id then
                -- Player finished shooting
                if data.category == 2 and data.param == 26739 then
                    action = 'shooting_'..tostring(player.name)..'_finished_2_Ranged Attack_'..primarytarget.index
                    send_packet(action)
                    log("PACKET: Shooting Finished")
                -- Weaponskills
                elseif data.category == 3 and data.param ~= 0 then
                    ability = res.weapon_skills[data.param]
                    if ability and ability.en then
                        action = 'weaponskill_'..tostring(player.name)..'_blocked_'..ability.id..'_'..ability.en..'_'..primarytarget.index
                        send_packet(action)
                        log('PACKET: Weaponskill ['..ability.en..'] on target ['..primarytarget.index..']')
                    end
                -- Player finished casting
                elseif data.category == 4 then
                    action = 'casting_'..tostring(player.name)..'_finished_'..data.param..'_'
                    for i, target in pairs(data.targets) do
					    for n, act in pairs(target.actions) do
						    if act.message ~= 0 and res.action_messages[act.message] ~= nil then
							    -- Action message gives the results of spell
                                action = action..target.id..'|'..act.message..','
                                --log(Target ID ['..target.id..'] with result of ['..act.message..']')
						    end
					    end
				    end
                    action = action:sub(1, #action - 1) -- remove last character
                    send_packet(action)
                    log('PACKET: Casting has finished')
                -- Player Item finished
                elseif data.category == 5 then
                    action = 'item_'..tostring(player.name)..'_finished'
                    send_packet(action)
                    log("PACKET: Item Finished")
                -- Player using JA
                elseif data.category == 6 then
			        ability = res.job_abilities[data.param]
			        if ability and ability.en and primarytarget.index then
                        action = 'jobability_'..tostring(player.name)..'_blocked_'..ability.id..'_'..ability.en..'_'..primarytarget.index
                        send_packet(action)
                        log('PACKET: Job Ability ['..ability.en..'] on target ['..primarytarget.index..']')
			        end
                elseif data.category == 8 then
                    if data.param == 28787 then -- Spell Intrupted
                        if data.targets[1].actions[1].param ~= 0 then
						    ability = res.spells[data.targets[1].actions[1].param]
                            if ability and ability.en then
                                action = 'casting_'..tostring(player.name)..'_interrupted_'..ability.id..'_'..ability.en..'_'..primarytarget.index
                                send_packet(action)
                                log("PACKET: Casting was interrupted")
                            end
                        end
                    elseif data.param == 24931 then -- Casting Spell
                        if data.targets[1].actions[1].param ~= 0 then
						    ability = res.spells[data.targets[1].actions[1].param]
						    if ability and ability.en then
                                action = 'casting_'..tostring(player.name)..'_blocked_'..ability.id..'_'..ability.en..'_'..primarytarget.index..'_'..tostring(ability.cast_time + 2.5)
                                send_packet(action)
                                log('PACKET: Casting Spell ['..ability.en..'] on target '..primarytarget.index)
						    end
					    end
                    end
                -- Player Item starts
                elseif data.category == 9 then
                    if data.param == 28787 then
                        action = 'item_'..tostring(player.name)..'_interrupted'
                        send_packet(action)
                        log("PACKET: Item use interrupted")
                    else
                        action = 'item_'..tostring(player.name)..'_blocked'
                        send_packet(action)
                        log("PACKET: Item use started")
                    end
                elseif data.category == 12 then
                -- Player is shooting or interrupted
                    if data.param == 24931 then
                        action = 'shooting_'..tostring(player.name)..'_blocked_2_Ranged Attack_'..primarytarget.index
                        send_packet(action)
                        log("PACKET: Shooting")
                    elseif data.param == 28787 then
                        action = 'shooting_'..tostring(player.name)..'_interrupted_2_Ranged Attack_'..primarytarget.index
                        send_packet(action)
                        log("PACKET: Shooting interrupted")
                    end
                end
            end
            -- Monitor others for Weaponskills
            if data.category == 3 and data.param ~= 0 then
                run_skillchain_check(data)
            end
            -- Monitor others for Immanence spells
            if data.category == 8 then
                run_spell_check(data)
            end
        end
    end
end