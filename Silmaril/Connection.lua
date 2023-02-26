-- socket
local socket = require("socket")
local udp = nil
local port = 2020
local ip = "127.0.0.1"

function connect()
    udp = assert(socket.udp())
    udp:settimeout(0)
    udp:setpeername(ip, port)
    log("startup")
    initialize()
end

function disconnect()
    connected = false
    enabled = false
    log("connection closed")
    udp:close()
end

function request()
    local formattedString = "request_"..player.name
    send_packet(formattedString)
end

function send_packet (msg)
    if msg ~= nil then
        assert(udp:send(msg))
        --log(msg)
    else
        log('Unable to send data')
    end
end

function receive_info()
    repeat
        data, msg = udp:receive()
        if data then
            --log(data)
            local message = data:split('_')
            if message[1] == player.name then
                if message[2] == "accepted" then
                    message = data:split('_')
                    windower.add_to_chat(1, ('\31\200[\31\05Silmaril Addon\31\200]\31\207 '..message[3]))
                    connected = true
                elseif message[2] == "on" then
                    get_player_spells()
                    enabled = true
                    log('Enabled')
                elseif message[2] == "off" then
                    enabled = false
                    log('Disabled')
                elseif message[2] == "sync" then
                    log('Sync Request')
                    sync_data() -- method called via Sync.lua
                elseif message[2] == "reset" then
                    log('Reset Request')
                    disconnect()
                    connect()
                elseif message[2] == "input" then
                    input_message(message[3],message[4],message[5],message[6])
                elseif message[2] == "burst" then
                    burst_message(message[3],message[4],message[5],message[6])
                elseif message[2] == "burst2" then
                    burst_II_message(message[3],message[4],message[5],message[6])
                elseif message[2] == "skillchain" then
                    skillchain(message[3],message[4])
                elseif message[2] == "skillchain2" then
                    skillchain2(message[3],message[4])
                elseif message[2] == "skillchain3" then
                    skillchain3(message[3],message[4])
                elseif message[2] == "skillchain4" then
                    skillchain4(message[3],message[4])
                end
            end
		elseif msg ~= 'timeout' then 
			error("Network error: "..tostring(msg))
		end
    until not data and connect
end