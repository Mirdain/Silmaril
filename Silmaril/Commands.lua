function commands(cmd, args)
    if cmd ~= nil then
        if cmd == "settings" then
            if args[1] and args[2] then
                ip = args[1]
                port = args[2]
                windower.add_to_chat(1, ('\31\200[\31\05Silmaril Addon\31\200]\31\207 '.. "Connection:  IP address: " .. ip .. " / Port number: " .. port))
            end
        elseif cmd == "check" then
            windower.add_to_chat(1, ('\31\200[\31\05Silmaril Addon\31\200]\31\207 '.. "Connection:  IP address: " .. ip .. " / Port number: " .. port))
        elseif cmd == "verify" then
            windower.add_to_chat(8,'Silmaril Addon Loaded')
            send_packet("confirmed")
        elseif cmd == "stop" then
            log('Silmaril Addon Stopped')
             enabled = false
        elseif cmd == "start" then
             log('Silmaril Addon Started')
             enabled = true
        elseif cmd == "follow" then
            if args[1] then
                send_packet("follow_"..player.name.."_"..args[1]:lower())
                log("follow_"..player.name.."_"..args[1]:lower(), ip, port)
            end
        elseif cmd == "cmd" then
            if args[3] then
                send_packet("command_"..player.name.."_"..args[1]:lower().."_"..args[2]:lower().." "..args[3]:lower())
                log("command_"..player.name.."_"..args[1]:lower().."_"..args[2]:lower().." "..args[3]:lower(), ip, port)
            elseif args[2] then
                send_packet("command_"..player.name.."_"..args[1]:lower().."_"..args[2]:lower())
                log("command_"..player.name.."_"..args[1]:lower().."_"..args[2]:lower(), ip, port)
            else
                send_packet("command_"..player.name.."_"..args[1]:lower())
                log("command_"..player.name.."_"..args[1]:lower(), ip, port)
            end
        elseif cmd == "send" then
            send_packet('echo_Test')
            log('echo_Test')
        elseif cmd == 'debug' then
        	if settings.debug == true then
                settings.debug = false
                sm_debug:hide()
			    windower.add_to_chat(80,'------- Debugging [OFF] -------')
		    else
			    settings.debug = true
                sm_debug:show()
			    windower.add_to_chat(80,'------- Debugging [ON]  -------')
		    end
        elseif cmd == 'display' then
        	if settings.display == true then
                settings.display = false
                sm_display:hide()
			    windower.add_to_chat(80,'------- Display [OFF] -------')
		    else
			    settings.display = true
                sm_display:show()
			    windower.add_to_chat(80,'------- Display [ON]  -------')
		    end
        elseif cmd == 'save' then
		    config.save(settings, player.name:lower())
		    windower.add_to_chat(8,'Silmaril Settings Saved')
        end
    end
end