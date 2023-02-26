mobs = {} -- replace with settings.mob to grab the list saved

function get_tracking_data()
    for id, enemy in pairs(mob_array) do
        if enemy and enemy.is_npc and enemy.valid_target and not enemy.in_party and not enemy.charmed and enemy.spawn_type == 16 and enemy.distance:sqrt() < 50 then
            for index, target in pairs(mobs) do
                if target == enemy.name then
                    mob_tracking[index] = round(enemy.distance:sqrt(),1)
                end
            end
        end
    end
end