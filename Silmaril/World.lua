function get_world_data()
    world = windower.ffxi.get_info()
    local formattedString = "world_"..tostring(player.name)..'_'
    player_world_data = formattedString..tostring(world.menu_open)..','..world.zone..','..world.day..','..world.weather
    --log(player_world_data)
end

function get_enemy_data()
    mob_array = windower.ffxi.get_mob_array()
    local formattedString = "enemy_"..tostring(player.name)..'_'
    for id, enemy in pairs(mob_array) do
        if enemy and enemy.is_npc and enemy.valid_target and not enemy.in_party and not enemy.charmed and enemy.spawn_type == 16 and enemy.distance:sqrt() < 50 then
            formattedString = formattedString..enemy.name..'|'..enemy.distance:sqrt()..'|'..enemy.hpp..'|'..enemy.id..'|'..enemy.index..'|'..enemy.status..'|'..enemy.x..'|'..enemy.y..'|'..enemy.z..','
        end
    end
    player_enemy_data = formattedString:sub(1, #formattedString - 1) -- remove last character
    --log(player_enemy_data)
end