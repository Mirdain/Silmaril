--First Burst
spell_type = nil
spell_tier = nil
spell_priority = nil
spell_Mode = nil

--Second Burst
spell_type_2 = nil
spell_tier_2 = nil
spell_priority_2 = nil
spell_Mode_2 = nil

local skillchains = {
	[288] = {id=288,english='Light',elements={'Light','Thunder','Wind','Fire'}},
	[289] = {id=289,english='Darkness',elements={'Dark','Ice','Water','Earth'}},
	[290] = {id=290,english='Gravitation',elements={'Dark','Earth'}},
	[291] = {id=291,english='Fragmentation',elements={'Thunder','Wind'}},
	[292] = {id=292,english='Distortion',elements={'Ice','Water'}},
	[293] = {id=293,english='Fusion',elements={'Light','Fire'}},
	[294] = {id=294,english='Compression',elements={'Dark'}},
	[295] = {id=295,english='Liquefaction',elements={'Fire'}},
	[296] = {id=296,english='Induration',elements={'Ice'}},
	[297] = {id=297,english='Reverberation',elements={'Water'}},
	[298] = {id=298,english='Transfixion', elements={'Light'}},
	[299] = {id=299,english='Scission',elements={'Earth'}},
	[300] = {id=300,english='Detonation',elements={'Wind'}},
	[301] = {id=301,english='Impaction',elements={'Thunder'}},
	[385] = {id=385,english='Light',elements={'Light','Thunder','Wind','Fire'}},
	[386] = {id=386,english='Darkness',elements={'Dark','Ice','Water','Earth'}},
	[387] = {id=387,english='Gravitation',elements={'Dark','Earth'}},
	[388] = {id=388,english='Fragmentation',elements={'Thunder','Wind'}},
	[389] = {id=389,english='Distortion',elements={'Ice','Water'}},
	[390] = {id=390,english='Fusion',elements={'Light','Fire'}},
	[391] = {id=391,english='Compression',elements={'Dark'}},
	[392] = {id=392,english='Liquefaction',elements={'Fire'}},
	[393] = {id=393,english='Induration',elements={'Ice'}},
	[394] = {id=394,english='Reverberation',elements={'Water'}},
	[395] = {id=395,english='Transfixion', elements={'Light'}},
	[396] = {id=396,english='Scission',elements={'Earth'}},
	[397] = {id=397,english='Detonation',elements={'Wind'}},
	[398] = {id=398,english='Impaction',elements={'Thunder'}},
	[767] = {id=767,english='Radiance',elements={'Light','Thunder','Wind','Fire'}},
	[768] = {id=768,english='Umbra',elements={'Dark','Ice','Water','Earth'}},
	[769] = {id=769,english='Radiance',elements={'Light','Thunder','Wind','Fire'}},
	[770] = {id=770,english='Umbra',elements={'Dark','Ice','Water','Earth'}},
}

local magic_tiers = {
	[1] = {suffix=''},
	[2] = {suffix='II'},
	[3] = {suffix='III'},
	[4] = {suffix='IV'},
	[5] = {suffix='V'},
	[6] = {suffix='VI'}
}

local spell_priorities = {
	[1] = {element='Fire'},
	[2] = {element='Ice'},
	[3] = {element='Wind'},
	[4] = {element='Earth'},
	[5] = {element='Thunder'},
	[6] = {element='Water'},
	[7] = {element='Light'},
	[8] = {element='Dark'}
}
-- SCH Buff ID's for storms
local storms = { 
	[178] = {id=178,name='Firestorm',weather=4}, 
	[179] = {id=179,name='Hailstorm',weather=12}, 
	[180] = {id=180,name='Windstorm',weather=10}, 
	[181] = {id=181,name='Sandstorm',weather=8}, 
	[182] = {id=182,name='Thunderstorm',weather=14}, 
	[183] = {id=183,name='Rainstorm',weather=6}, 
	[184] = {id=184,name='Aurorastorm',weather=16}, 
	[185] = {id=185,name='Voidstorm',weather=18},
	[589] = {id=589,name='Firestorm',weather=5}, 
	[590] = {id=590,name='Hailstorm',weather=13}, 
	[591] = {id=591,name='Windstorm',weather=11}, 
	[592] = {id=592,name='Sandstorm',weather=9}, 
	[593] = {id=593,name='Thunderstorm',weather=15}, 
	[594] = {id=594,name='Rainstorm',weather=7}, 
	[595] = {id=595,name='Aurorastorm',weather=17}, 
	[596] = {id=596,name='Voidstorm',weather=19}
}

local elements = {
	['Thunder'] = {Spell='Thunder',Helix='Ionohelix',ga='Thundaga',ja='Thundaja',ra='Thundara',jutsu='Raiton',white=nil,holy=nil},
	['Ice'] = {Spell='Blizzard',Helix='Cryohelix',ga='Blizzaga',ja='Blizzaja',ra='Blizzara',jutsu='Hyoton',white=nil,holy=nil},
	['Fire'] = {Spell='Fire',Helix='Pyrohelix',ga='Firaga',ja='Firaja',ra='Fira',jutsu='Katon',white=nil,holy=nil},
	['Wind'] = {Spell='Aero',Helix='Anemohelix',ga='Aeroga',ja='Aeroja',ra='Aerora',jutsu='Huton',white=nil,holy=nil},
	['Water'] = {Spell='Water',Helix='Hydrohelix',ga='Waterga',ja='Waterja',ra='Watera',jutsu='Suiton',white=nil,holy=nil},
	['Earth'] = {Spell='Stone',Helix='Geohelix',ga='Stonega',ja='Stoneja',ra='Stonera',jutsu='Doton',white=nil,holy=nil},
    ['Light'] = {Spell=nil,Helix='Luminohelix',ga=nil,ja=nil,ra=nil,jutsu=nil,white='Banish',holy="Holy"},
	['Dark'] = {Spell=nil,Helix='Noctohelix',ga=nil,ja=nil,ra=nil,jutsu=nil,white=nil,holy=nil},
}

function burst_message(Type, Tier, Element, Mode)
    if Type and Tier and Element and Mode then
        spell_type = Type
        spell_tier = tonumber(Tier)
        spell_priority = tonumber(Element)
        spell_Mode = Mode
        log('Burst I Enabled - Type:['..spell_type..'] Tier:['..tostring(spell_tier)..'] Element:['..tostring(spell_priority)..'] Mode:['..Mode..']')
        if spell_tier ~= "None" and spell_type ~= "None" and spell_priority ~= "None" and spell_Mode ~= "None" then
            windower.add_to_chat(8,'Burst Enabled:   Type:['..spell_type..'] Tier:['..magic_tiers[spell_tier].suffix..'] Element:['..spell_priorities[spell_priority].element..'] Mode:['..spell_Mode..']')
		end
    end
end

function burst_II_message(Type, Tier, Element, Mode)
    if Type and Tier and Element and Mode then
        spell_type_2 = Type
        spell_tier_2 = tonumber(Tier)
        spell_priority_2 = tonumber(Element)
        spell_Mode_2 = Mode
        log('Burst II Enabled - Type:['..spell_type_2..'] Tier:['..tostring(spell_tier_2)..'] Element:['..tostring(spell_priority_2)..'] Mode:['..spell_Mode_2..']')
        if spell_tier_2 ~= "None" and spell_type_2 ~= "None" and spell_priority_2 ~= "None" and spell_Mode_2 ~= "None" then
            windower.add_to_chat(8,'Burst II Enabled: Type:['..spell_type_2..'] Tier:['..magic_tiers[spell_tier_2].suffix..'] Element:['..spell_priorities[spell_priority_2].element..'] Mode:['..spell_Mode_2..']')
        end
    end
end

function run_burst(id, packet)
	local actions_packet = windower.packets.parse_action(packet)
	local valid = false
	local party_ids = T{}

    -- Get ids of all current party member
	for _, member in pairs (party) do
		if (type(member) == 'table' and member.mob) then
			party_ids:append(member.mob.id)
		end
	end

    --[[ 
    Spawn type mapping:
    1 = Other players
    2 = Town NPCs, AH counters, Logging Points, etc.
    Bit 1 = 1 PC
    Bit 2 = 2 NPC (not attackable)
    Bit 3 = 4 Party Member
    Bit 4 = 8 Ally
    Bit 5 = 16 Enemy
    Bit 6 = 32 Door (Environment)
    13 = Self
    14 = Trust NPC in party
    16 = Monsters
    34 = Some doors
    ]]

    for _, target in pairs(actions_packet.targets) do
		local t = windower.ffxi.get_mob_by_id(target.id)
		-- Make sure the mob is a valid MB target
		if t and t.is_npc and t.valid_target and not t.in_party and not t.charmed and t.spawn_type == 16 and t.distance:sqrt() < 21.5 then
            -- Make sure the mob is claimed by our alliance then
		    if party_ids:contains(t.claim_id) then
				for _, action in pairs(target.actions) do
					if action.add_effect_message > 287 and action.add_effect_message < 302 -- Normal SC DMG
					or action.add_effect_message > 384 and action.add_effect_message < 399 -- SC Heals
					or action.add_effect_message > 766 and action.add_effect_message < 771 -- Umbra/Radiance
					then
						last_skillchain = skillchains[action.add_effect_message]
                        windower.send_command('timers c "Skillchain: '..last_skillchain.english..'" 5 down')
				        if last_skillchain.english == 'Light' then
                        	info('Skillchain: Light - (Light, Fire, Thunder, Wind)')
				        elseif last_skillchain.english == 'Darkness' then
                            info('Skillchain: Dark - (Dark, Earth, Water, Ice)')
						elseif last_skillchain.english == 'Radiance' then
                        	info('Skillchain: Radiance - (Light, Fire, Thunder, Wind)')
				        elseif last_skillchain.english == 'Umbra' then
                            info('Skillchain: Umbra - (Dark, Earth, Water, Ice)')
				        elseif last_skillchain.english == 'Gravitation' then
                            info('Skillchain: Gravitation - (Dark, Earth)')
				        elseif last_skillchain.english == 'Fragmentation' then
                            info('Skillchain: Fragmentation - (Thunder, Wind)')
				        elseif last_skillchain.english == 'Distortion' then
                            info('Skillchain: Distortion - (Water, Ice)')
				        elseif last_skillchain.english == 'Fusion' then
                            info('Skillchain: Fusion - (Light, Fire)')
				        elseif last_skillchain.english == 'Compression' then
                            info('Skillchain: Compression	- (Dark)')
				        elseif last_skillchain.english == 'Liquefaction' then
                            info('Skillchain: Liquefaction - (Fire)')
				        elseif last_skillchain.english == 'Induration' then
                            info('Skillchain: Induration - (Ice)')
				        elseif last_skillchain.english == 'Reverberation' then
                            info('Skillchain: Reverberation - (Water)')
				        elseif last_skillchain.english == 'Transfixion' then
                            info('Skillchain: Transfixion	- (Light)')
				        elseif last_skillchain.english == 'Scission' then
                            info('Skillchain: Scission - (Earth)')
				        elseif last_skillchain.english == 'Detonation' then
                            info('Skillchain: Detonation - (Wind)')
				        elseif last_skillchain.english == 'Impaction' then
                            info('Skillchain: Impaction - (Thunder)')
				        end
                        if spell_type and spell_tier then
                            local burst_spell = calculate_spell(last_skillchain)
                            if burst_spell then
                                log('['..last_skillchain.english..'] skillchain on ['..t.name..' - ('..t.index..')]')
                                log('Built spell is: ['..burst_spell..']')
                                casting = 'burst_'..tostring(player.name)..'_'..burst_spell..'_'..t.index
                                send_packet(casting)
                            end
                        end
                        if spell_type_2 and spell_tier_2  then
                            local burst_spell_2 = calculate_spell_2(last_skillchain)
                            if burst_spell_2 then
                                log('Built spell 2 is: ['..burst_spell_2..']')
                                casting = 'burst2_'..tostring(player.name)..'_'..burst_spell_2..'_'..t.index
                                send_packet(casting)
                            end
                        end
						last_skillchain = {}
					end
				end
			end
		end
	end
end

function calculate_spell(last_skillchain)
    local spell = nil

	-- Default to weather element.
	local weather_element = get_weather_element()
	local skillchain_element = nil

    -- Give priority to manual selection
    if T(last_skillchain.elements):contains(spell_priorities[spell_priority].element) then
		if spell_Mode == "Priority Element" or spell_Mode == "Exclusive Element" then
			skillchain_element = spell_priorities[spell_priority].element
			log('Set element to priority: ['..spell_priorities[spell_priority].element..']')
		end
	else
		if spell_Mode == "Exclusive Element" then
			log('Exit due to Mode: ['..spell_priorities[spell_priority].element..']')
			return spell
		end
	end

   	-- Check if skillchain contains weather element.				
	if skillchain_element == nil and T(last_skillchain.elements):contains(weather_element) then
		skillchain_element = weather_element
        log('Set element to weather: ['..weather_element..']')
	end

  	-- If nothing was found for the current weather element, try the day element.
	if skillchain_element == nil then
		day_element = get_day_element()
		if T(last_skillchain.elements):contains(day_element) then
			skillchain_element = day_element
            log('Set element to day: ['..day_element..']')
		end
	end

   	-- If no element was found based weather or day, or no spell exists for computed element, go by priority list.
	if skillchain_element == nil or elements[skillchain_element][spell_type] == nil then		
		for i=1,#spell_priorities do
			if skillchain_element == nil and T(last_skillchain.elements):contains(spell_priorities[i].element) then
				skillchain_element = spell_priorities[i].element
                log('Set element to priority level: ['..spell_priorities[i].element..']')
			end
		end
	end

  	-- If we get here and no element was found (shouldn't happen), fail out now.
	if skillchain_element == nil then
		log('Unable to find a valid element.')
		return spell
	end

    -- Check if spell type was set
   	if spell_type == nil or spell_type == "None" then
		log('No spell type defined.')
		return spell
	elseif not T{'Spell', 'Helix', 'ga', 'ja', 'ra'}:contains(spell_type) then
		-- Invalid type
		log('Invalid spell type specified.')
		return spell
	end	

    -- Check if spell tier was set
   	if spell_tier == nil or spell_tier == "None" then
		log('No spell tier defined.')
	    return spell
	end

    if not elements[skillchain_element][spell_type] or not magic_tiers[spell_tier].suffix then
        spell = nil
        log('Could not parse spell.')
        return spell
    end

    -- Build spell name if there is one for the element type
	local spellName = string.trim(elements[skillchain_element][spell_type].." "..magic_tiers[spell_tier].suffix)
	if not spellName then
	    log('Could not find spell.')
        return spell
	end
	local spell_time = spell_recasts[res.spells:with('name', spellName).recast_id]/100

	if spell_time > 0 then
    	windower.add_to_chat(8,''..spellName..' ['..spell_time..'] - Down Grade the tier')
        if spell_type ~= 'ja' then
            spell = string.trim(elements[skillchain_element][spell_type].." "..magic_tiers[spell_tier-1].suffix)
        else
            spell = string.trim(elements[skillchain_element]['ga'].." "..magic_tiers[3].suffix)
        end
	else
		-- Cast the spell!
        spell = spellName
	end

    return spell
end

function calculate_spell_2 (last_skillchain)
    local spell = nil

	-- Default to weather element.
	local weather_element = get_weather_element()
	local skillchain_element = nil

    -- Give priority to manual selection
    if T(last_skillchain.elements):contains(spell_priorities[spell_priority_2].element) then
		if spell_Mode_2 == "Priority Element" or spell_Mode_2 == "Exclusive Element" then
			skillchain_element = spell_priorities[spell_priority_2].element
			log('Set element to priority: ['..spell_priorities[spell_priority_2].element..']')
		end
	else
		if spell_Mode_2 == "Exclusive Element" then
			log('Exit due to Mode: ['..spell_priorities[spell_priority_2].element..']')
			return spell
		end
	end

   	-- Check if skillchain contains weather element.				
	if skillchain_element == nil and T(last_skillchain.elements):contains(weather_element) then
		skillchain_element = weather_element
        log('Set element to weather: ['..weather_element..']')
	end

  	-- If nothing was found for the current weather element, try the day element.
	if skillchain_element == nil then
		day_element = get_day_element()
		if T(last_skillchain.elements):contains(day_element) then
			skillchain_element = day_element
            log('Set element to day: ['..day_element..']')
		end
	end

   	-- If no element was found based weather or day, or no spell exists for computed element, go by priority list.
	if skillchain_element == nil or elements[skillchain_element][spell_type_2] == nil then		
		for i=1,#spell_priorities do
			if skillchain_element == nil and T(last_skillchain.elements):contains(spell_priorities[i].element) then
				skillchain_element = spell_priorities[i].element
                log('Set element to priority level: ['..spell_priorities[i].element..']')
			end
		end
	end

  	-- If we get here and no element was found (shouldn't happen), fail out now.
	if skillchain_element == nil then
		log('Unable to find a valid element.')
		return spell
	end

    -- Check if spell type was set
   	if spell_type_2 == nil or spell_type_2 == "None" then
		log('No spell type defined.')
		return spell
	elseif not T{'Spell', 'Helix', 'ga', 'ja', 'ra'}:contains(spell_type_2) then
		-- Invalid type
		log('Invalid spell type specified.')
		return spell
	end	

    -- Check if spell tier was set
   	if spell_tier_2 == nil or spell_tier_2 == "None" then
		log('No spell tier defined.')
	    return spell
	end

    if not elements[skillchain_element][spell_type_2] or not magic_tiers[spell_tier_2].suffix then
        spell = nil
        log('Could not parse spell.')
        return spell
    end

    -- Build spell name if there is one for the element type
	local spellName = string.trim(elements[skillchain_element][spell_type_2].." "..magic_tiers[spell_tier_2].suffix)
	if not spellName then
	    log('Could not find spell.')
        return spell
	end
	local spell_time = spell_recasts[res.spells:with('name', spellName).recast_id]/100

	if spell_time > 0 then
    	windower.add_to_chat(8,''..spellName..' ['..spell_time..'] - Down Grade the tier')
        if spell_type_2 ~= 'ja' then
            spell = string.trim(elements[skillchain_element][spell_type_2].." "..magic_tiers[spell_tier_2-1].suffix)
        else
            spell = string.trim(elements[skillchain_element]['ga'].." "..magic_tiers[3].suffix)
        end
	else
		-- Cast the spell!
        spell = spellName
	end

    return spell
end

function get_day_element()
	-- Return the name of the element.
	return res.elements[res.days[world.day].element].en
end

function get_weather_element()
	-- Check if any storm is active.		
	if #player.buffs > 0 then		
		for i=1,#player.buffs do
			local buff = player.buffs[i]
			for _, storm in pairs(storms) do
				if storm.id == buff then
					-- A storm is active, override weather with storm element.					
					world.weather = storm.weather	
				end
			end			
		end
	end
	-- Return the name of the element.
	return res.elements[res.weather[world.weather].element].en
end