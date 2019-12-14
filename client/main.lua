package.path = package.path .. ";../?.lua"

-- to start with, we need to require the 'socket' lib (which is compiled
-- into love). socket provides low-level networking features.
local socket = require "socket"
local joyCon = require "shared/joyCon"
local util = require "shared/util"
-- the address and port of the server
local address, port = "192.168.1.68", 12345
 
local entity -- entity is what we'll be controlling
local updaterate = 0.1 -- how long to wait, in seconds, before requesting an update
 
local world = {} -- the empty world-state
local t
 
-- love.load, hopefully you are familiar with it from the callbacks tutorial
function love.load()
 
	udp = socket.udp()
	udp:settimeout(0)
	udp:setpeername(address, port)
 
	math.randomseed(os.time()) 
	entity = tostring(math.random(99999))
 
	local dg = string.format("%s %s %d %d", entity, 'at', 320, 240)
	udp:send(dg)
 
	t = 0
end

-- love.update, hopefully you are familiar with it from the callbacks tutorial
function love.update(deltatime)
 
	t = t + deltatime
 
	if t > updaterate then
		local joystickState = joyCon.getJoyStickState(love)
		udp:send(entity .. " " .. joyCon.controllerStateToString(joystickState))
		t=t-updaterate
	end
 
	repeat
		data, msg = udp:receive()
 
		if data then

			ent, cmd, parms = data:match("^(%S*) (%S*) (.*)")
			if cmd == 'at' then

				local x, y = parms:match("^(%-?[%d.e]*) (%-?[%d.e]*)$")
				assert(x and y)
 
				x, y = tonumber(x), tonumber(y)

				world[ent] = {x=x, y=y}
			else
				print("unrecognised command:", cmd)
			end
 
		elseif msg ~= 'timeout' then 
			error("Network error: "..tostring(msg))
		end
	until not data 
  
end

function love.draw()
	for k, v in pairs(world) do
		love.graphics.print(k, v.x, v.y)
	end
end
