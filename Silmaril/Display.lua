default = {
	debug = false,
	display = true,
	Debug_Box = {text={size=10,font='Consolas',red=255,green=255,blue=255,alpha=255},pos={x=1473,y=763},bg={visible=true,red=0,green=0,blue=0,alpha=102},},
	Update_Box = {text={size=10,font='Consolas',red=255,green=255,blue=255,alpha=255},pos={x=1635,y=782},bg={visible=true,red=0,green=0,blue=0,alpha=102},},}

settings = config.load(default) -- Loads the default settings (Display.lua)

gears = {'|','/','-','\\\\'}
gear = 1

sm_debug = {}
sm_debug = texts.new("",settings.Debug_Box)

sm_display = {}
sm_display = texts.new("",settings.Update_Box)

--Variable to monitor during debug mode
debug_value = 0

if settings.debug == true then
	sm_debug:show()
else
	sm_debug:hide()
end

if settings.display == true then
	sm_display:show()
else
	sm_display:hide()
end

-- Used to help debug issues - 20 chacaters long
function debug_box_refresh()
	local maxWidth = 20
	lines = T{}
	lines:insert('Enabled' ..string.format('[%s]',tostring(enabled)):lpad(' ',13))
	lines:insert('Connected' ..string.format('[%s]',tostring(connected)):lpad(' ',11))
	lines:insert('Update (s)' ..string.format('[%s]',tostring(update_time)):lpad(' ',10))
	lines:insert('Delay' ..string.format('[%s]',tostring(delay_time)):lpad(' ',15))
	lines:insert('Moving' ..string.format('[%s]',tostring(moving)):lpad(' ',14))
	for i,line in ipairs(lines) do lines[i] = lines[i]:rpad(' ', maxWidth) end
    sm_debug:text(lines:concat('\n'))
end

-- Used to show if Silmaril is running
function display_box_refresh()
	local maxWidth = 30
	gear_update()
	lines = T{}
	lines:insert('Silmaril...'..string.format('[%s]',tostring(gears[gear])):lpad(' ',maxWidth - 22 + string.len(gears[gear])))
	local maxWidth = math.max(1, table.reduce(lines, function(a, b) return math.max(a, #b) end, '1'))
	for i,line in ipairs(lines) do lines[i] = lines[i]:rpad(' ', maxWidth - string.len(gears[gear])) end
    sm_display:text(lines:concat('\n'))
end
 
function gear_update()
	gear = gear +1
	if gear > 4 then
		gear = 1
	end
end

