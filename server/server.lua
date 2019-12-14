package.path = package.path .. ";../?.lua"

local socket = require "socket"
local udp = socket.udp()
local joyCon = require 'shared/joyCon'
local util = require 'shared/util'
local bump = require 'bump/bump'
local world = require 'levels/level1'

udp:settimeout(0)
udp:setsockname('*', 12345)

local data, msg_or_ip, port_or_nil
local entity, cmd, parms

local running = true
 
function parseData(data)
	local packet = {}
	local packetParts = util.splitStringOnSpaces(data)
	packet.clientId = packetParts[1]
	packet.buttons = packetParts[2]
	packet.leftStickX = packetParts[3]
	packet.leftStickY = packetParts[4]
	packet.rightStickX = packetParts[5]
	packet.rightStickY = packetParts[6]
	packet.leftTrigger = packetParts[7]
	packet.rightTrigger = packetParts[8]

	return packet
end

print "Beginning server loop."
while running do
	data, msg_or_ip, port_or_nil = udp:receivefrom()
	if data then
			
			local controllerState = joyCon.stringToControllerState(data)
			print("input: " .. util.dump(controllerState))
	elseif msg_or_ip ~= 'timeout' then
		error("Unknown network error: "..tostring(msg))
	end
 
	socket.sleep(0.01)
end
