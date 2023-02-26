function get_inventory()
    local items = windower.ffxi.get_items(0)
    local formattedString = "items_"..tostring(player.name)..'_'
    for b,v in ipairs(items) do
        if v.id > 0 then
            --log('Item ID ['..tostring(v.id)..'], Count ['..tostring(v.count)..'],Item name ['..tostring(res.items[v.id].name)..']')
            formattedString = formattedString..tostring(res.items[v.id].name)..','..tostring(v.id)..','..tostring(v.count)..'|'
        end
    end
    formattedString = formattedString:sub(1, #formattedString - 1) -- remove last character
    send_packet(formattedString)
end