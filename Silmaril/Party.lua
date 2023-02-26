function party_status()
    party = windower.ffxi.get_party() -- Update the table of the party
    local party_position = {p0='0',p1='1',p2='2',p3='3',p4='4',p5='5',a10='6',a11='7',a12='8',a13='9',a14='10',a15='11',a20='12',a21='13',a22='14',a23='15',a24='16',a25='17'}

    --name
    --hp
    --hpp
    --mp
    --mpp
    --tp
    --zone
    --id
    --index
    --target_index
    --status
    --heading
    --x
    --y
    --z

    -- Clear the party structure (party reforms etc)
    party_data = {}
    for position, member in pairs(party) do
        if type(member) == "table" then
            local formattedString = "party_"..tostring(player.name)..'_'..party_position[position]..'_'..tostring(member.name)..','
            ..tostring(member.hp)..','..tostring(member.hpp)..','..tostring(member.mp)..','
            ..tostring(member.mpp)..','..tostring(member.tp)..','..tostring(member.zone)
            if member.mob then
                local mob = {}
                for index, value in pairs(member.mob) do
                    if index == 'id' then
                        mob[1] = tostring(value)
                    elseif index == 'index' then
                        mob[2] = tostring(value)
                    elseif index == 'target_index' then
                        mob[3] = tostring(value)
                        if player.target_index and member.name == player.name then
                            --log('change the target from ['..tostring(mob[3])..'] to ['..tostring(player.target_index)..']')
                            mob[3] = tostring(player.target_index)
                        end
                    elseif index == 'status' then
                        mob[4] = tostring(value)
                    elseif index == 'heading' then
                        mob[5] = tostring(value)
                    elseif index == 'x' then
                        mob[6] = tostring(value)
                    elseif index == 'y' then
                        mob[7] = tostring(value)
                    elseif index == 'z' then
                        mob[8] = tostring(value)
                    elseif index == 'pet_index' then
                        pet = windower.ffxi.get_mob_by_index(value)
                        if not pet then
                            pet = {}
                            pet.name = "None"
                            pet.id = 0
                            pet.index = 0
                            pet.hpp = 0
                            pet.tp = 0
                            pet.x = 0
                            pet.y = 0
                            pet.z = 0
                        end
                        if not pet.tp then
                            pet.tp = 0
                        end
                        local pet_string = pet.name..'|'..tostring(pet.id)..'|'..tostring(pet.index)..'|'..tostring(pet.hpp)..'|'..tostring(pet.tp)..'|'
                        ..tostring(pet.x)..'|'..tostring(pet.y)..'|'..tostring(pet.z)
                        mob[9] = pet_string 
                    end
                end
                if not mob[9] then -- No pet active
                    local pet_string = "0|0|0|0|0|0|0|0"
                    mob[9] = pet_string 
                end
                for index, value in ipairs(mob) do
                    formattedString = formattedString..','..value
                end
            else
                formattedString = formattedString..',0,0,0,0,0,0,0,0,0|0|0|0|0|0|0|0'
            end
            party_data[party_position[position]] = formattedString
            --log(formattedString)
        end
    end
    --Fill in remainder of first part
    if not party.party1_count then
        party.party1_count = 1
    end
    for i = party.party1_count, 5 do
        local formattedString = "party_"..tostring(player.name)..'_'..tostring(i)..'_Empty,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|0|0|0|0|0|0|0'
        party_data[i] = formattedString
    end
    --Fill in remainder of second party
    if not party.party2_count then
        party.party2_count = 0
    end
    for i = party.party2_count + 6, 11 do
        local formattedString = "party_"..tostring(player.name)..'_'..tostring(i)..'_Empty,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|0|0|0|0|0|0|0'
        party_data[i] = formattedString
    end
    --Fill in remainder of third part
    if not party.party3_count then
        party.party3_count = 0
    end
    for i = party.party3_count + 12, 17 do
        local formattedString = "party_"..tostring(player.name)..'_'..tostring(i)..'_Empty,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0|0|0|0|0|0|0|0'
        party_data[i] = formattedString
    end
end
