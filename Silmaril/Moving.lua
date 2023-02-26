do
	local autorun = nil
	local autorun_target = nil
	local autorun_distance = 0
	local autorun_tofrom = 0
	local mov = {x=0, y=0, z=0}
	local runtime = .5
	local runsstart = os.clock()

	function combat_movement()
		if autorun == 1 and autorun_target and autorun_distance and autorun_tofrom and enabled then 
			local now = os.clock()
			if(now - runsstart > runtime) then
				log('Time running ['..(now - runsstart)..'] now turning off running')
				windower.ffxi.run(false)
				autorun_tofrom = 0
				autorun = 0
				runsstart = os.clock()
			end
			local t = windower.ffxi.get_mob_by_index(autorun_target.index)
			if t and t.valid_target and t.status < 2 then 
				if autorun_tofrom == 2 then -- run away from
					if t.distance:sqrt() - .1 > autorun_distance then	
						windower.ffxi.run(false)
						autorun = 0
					else
						local angle = (math.atan2((t.y - player_location.y), (t.x - player_location.x))*180/math.pi)*-1
						windower.ffxi.run((angle+180):radian())
					end
				elseif autorun_tofrom == 1 then -- run towards
					if t.distance:sqrt() + .1 < autorun_distance then	
						windower.ffxi.run(false)
						autorun = 0
					else 
						local angle = (math.atan2((t.y - player_location.y), (t.x - player_location.x))*180/math.pi)*-1
						windower.ffxi.run((angle):radian())
					end
				end
			else
				windower.ffxi.run(false)
				autorun_tofrom = 0
				autorun = 0
			end 
		end
	end

	function runaway(target, distance) 
		-- if not targeting self and has a valid targets
		if target and enabled then 
			local angle = (math.atan2((target.y - player_location.y), (target.x - player_location.x))*180/math.pi)*-1
			windower.ffxi.run((angle+180):radian())
			autorun = 1
			autorun_target = target
			autorun_distance = tonumber(distance)
			autorun_tofrom = 2
			runsstart = os.clock()
		end
	end

	function runto(target,distance)
		if target and enabled then
			local angle = (math.atan2((target.y - player_location.y), (target.x - player_location.x))*180/math.pi)*-1
			windower.ffxi.run((angle):radian())
			autorun = 1
			autorun_target = target
			autorun_distance = tonumber(distance)
			autorun_tofrom = 1	
			runsstart = os.clock()
		end
	end

	function facemob(target)
		if target and enabled then
			local angle = (math.atan2((target.y - player_location.y), (target.x - player_location.x))*180/math.pi)*-1
			windower.ffxi.turn((angle):radian())
		end
	end

	function Moving_Check() --Must read the party.lua to update the player_location values
		if player.status < 2 then
			local position = windower.ffxi.get_mob_by_id(player.id)
			if position then
				player_location.x = position.x
				player_location.y = position.y
				player_location.z = position.z
				local movement = math.sqrt( (player_location.x-mov.x)^2 + (player_location.y-mov.y)^2 + (player_location.z-mov.z)^2 ) > 0.05
				if movement and not moving then
					moving = true
					log("Moving on")
				elseif not movement and moving then
					moving = false
					log("Moving off")
				end
				mov.x = player_location.x
				mov.y = player_location.y
				mov.z = player_location.z
				combat_movement()
			end
		end
	end
end