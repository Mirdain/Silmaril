function run_buffs(id, data)
    for k = 0, 5 do
        -- FOR EACH MEMBER REMOVE PREVIOUS CHARACTERS DATA
        local Buffs = {}
        local Character = nil
        local formattedString = nil
        local intIndex = 1
        local userIndex = nil
        local Uid = data:unpack('I', k * 48 + 5)
        local current_buff = nil

        if Uid then
            userIndex = Uid
        else
            userIndex = nil
        end

        -- GRAB THE MEMBERS NAME
        if userIndex then
            Character = windower.ffxi.get_mob_by_id(userIndex)
        end
        -- Limit packets being sent
        if Character and Character.name then
            for i = 1, 32 do
                current_buff = data:byte(k * 48 + 5 + 16 + i - 1) + 256 * (math.floor(data:byte(k * 48 + 5 + 8 + math.floor((i - 1) / 4)) / 4 ^ ((i - 1) % 4)) % 4)
                if current_buff ~= 255 and current_buff ~= 0 then
                    table.insert(Buffs, current_buff)
                end
            end
            -- COUNT TOTAL NUMBER OFF BUFFS LOCATED AND BUILD THE BUFF STRING
            formattedString = "buffs_"..player.name..'_'..Character.name.."_"
            for index, value in pairs(Buffs) do
                formattedString = formattedString .. value
                if intIndex ~= tablelength(Buffs) then
                    formattedString = formattedString ..","
                end
                intIndex = intIndex + 1
            end
            party_buffs[Character.name] = formattedString
            --log(formattedString)
        end
    end
end