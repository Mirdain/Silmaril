function input_message(Type, Index, Param, Option)
    --[[
	enums['action'] = {
        [0x00] = 'NPC Interaction',
        [0x02] = 'Engage monster',
        [0x03] = 'Magic cast',
        [0x04] = 'Disengage',
        [0x05] = 'Call for Help',
        [0x07] = 'Weaponskill usage',
        [0x09] = 'Job ability usage',
        [0x0C] = 'Assist',
        [0x0D] = 'Reraise dialogue',
        [0x0E] = 'Cast Fishing Rod',
        [0x0F] = 'Switch target',
        [0x10] = 'Ranged attack',
        [0x11] = 'Chocobo dig',
        [0x12] = 'Dismount Chocobo',
        [0x13] = 'Tractor Dialogue',
        [0x14] = 'Zoning/Appear', -- I think, the resource for this is ambiguous.
        [0x19] = 'Monsterskill',
        [0x1A] = 'Mount',
    }
    ]]--
    if Option then
        log('Input - Type ['..Type..'], Index ['..Index..'], Param ['..Param..'], Option ['..Option..']')
    else
        log('Input - Type ['..Type..'], Index ['..Index..'], Param ['..Param..']')
    end
    Target = windower.ffxi.get_mob_by_index(Index)
    if not Target then
        log("Target not found")
        return
    end
	if Type == "JobAbility" then
        Action_Message('0x09',Target,Param)
		log("Job Ability")
	elseif Type == "Magic" then
        if Target.valid_target and math.sqrt(Target.distance) <= 25 then
            Action_Message('0x03',Target,Param)
		    log("Magic")
        else
            log(Target)
        end
	elseif Type == "WeaponSkill" then
        if Target.valid_target and Target.spawn_type == 16 and math.sqrt(Target.distance) <= 23 then
            Action_Message('0x07',Target,Param)
		    log("Weapon Skill")
        else
            log("Distance is too far to weaponskill")
        end
	elseif Type == "Engage" then
        if Target.valid_target and Target.spawn_type == 16 and math.sqrt(Target.distance) <= 30 then
            Action_Message('0x02',Target,Param)
		    log("Engage")
        else
            log("Distance is too far to attack")
        end
    elseif Type == "Shoot" then
        if Target.valid_target and Target.spawn_type == 16 and math.sqrt(Target.distance) <= 25 then
            Action_Message('0x10',Target,Param)
		    log("Shoot")
        else
            log("Distance is too far to shoot")
        end
	elseif Type == "Disengage" then
            Action_Message('0x04',Target,Param)
		    log("Disengage")
	elseif Type == "RunAway" then
        if Target.valid_target and math.sqrt(Target.distance) <= 50 then
            -- Call the movement section
            runaway(Target,Param)
		    log("Move")
        else
            log("Distance is too far to run")
        end
    elseif Type == "RunTo" then
        if Target.valid_target and math.sqrt(Target.distance) <= 50 then
            -- Call the movement section
            runto(Target,Param)
		    log("Move")
        else
            log("Distance is too far to run")
        end
    elseif Type == "Face" then
        if Target.valid_target and math.sqrt(Target.distance) <= 50 then
            -- Call the movement section
            facemob(Target)
		    log("Face on")
        else
            log("Distance is too far to face")
        end
    elseif Type == "Script" then
        if Target.valid_target and math.sqrt(Target.distance) <= 25 then
            if Option then
                Action_Message('0x??',Target,Option)
		        log("Script")
            else
                log("Script missing Option text")
            end
        else
            log("Distance is too far to execute script")
        end
    elseif Type == "Item" then
        if Target.valid_target then
            Action_Message('0x037',Target,Param)
            if Option == "Party" then
                log("Warn Party")
                command = 'input /party Item Warning ['..res.items[tonumber(Param)].en..']!'
                windower.send_command(command)
            elseif Option ~= "" then
                log("Warn Player: "..Option)
                command = 'input /tell '..Option..' Item Warning ['..res.items[tonumber(Param)].en..']!'
                windower.send_command(command)
            end
        else
            log(Target)
        end
    elseif Type == "Message" then

	end
end

function Action_Message(Category, Target, Param)
    local command = ""
	if not Target then
        log("Target not found")
		return
	end
    -- use input commands so that gearswap can swap our gear for us - use target ID
    if Category == '0x09' then
        command = 'input /ja "'..res.job_abilities[tonumber(Param)].en..'" '..Target.id
        windower.send_command(command)
        log(command)
    elseif Category == '0x07' then
        command = 'input /ws "'..res.weapon_skills[tonumber(Param)].en..'" '..Target.id
        windower.send_command(command)
        log(command)
    elseif Category == '0x037' then
        command = 'input /item "'..res.items[tonumber(Param)].en..'" '..Target.id
        windower.send_command(command)
        log(command)
    elseif Category == '0x03' then
        command = 'input /ma "'..res.spells[tonumber(Param)].en..'" '..Target.id
        windower.send_command(command)
        log(command)
    elseif Category == '0x10' then
        command = 'input /ra '..Target.id
        windower.send_command(command)
        log(command)
    elseif Category == '0x??' then
        command = 'input '..Param..' '..Target.id
        windower.send_command(command)
        log(command)
    else
        packets.inject(packets.new('outgoing', 0x1A, {
			    ['Target'] = Target.id,
			    ['Target Index'] = Target.index,
			    ['Category'] = Category, -- Spell Cast
                ['Param'] = Param, -- Spell ID
	    }))
        log("Packet Injected")
    end
end
