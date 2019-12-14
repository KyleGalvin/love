package.path = package.path .. ";../?.lua"

-- Unit testing starts
local luaUnit = require('luaunit')
local util = require('shared/util')
local joyCon = require('shared/joyCon');

TestMyStuff = {}

function TestMyStuff:TestStringSplit()
	local split = util.splitStringOnSpaces("000000000000 0.11111 0.22222 0.33333 0.44444 0.55555 0.66666")

	assertEquals("000000000000", split[1])
	assertEquals("0.11111", split[2])
	assertEquals("0.22222", split[3])
	assertEquals("0.33333", split[4])
	assertEquals("0.44444", split[5])
	assertEquals("0.55555", split[6])
	assertEquals("0.66666", split[7])
end

function TestMyStuff:TestJoyStickSerialize()
	local serialized = "000000000000 0.11111 0.22222 0.33333 0.44444 0.55555 0.66666"
	local joyConState = joyCon.stringToControllerState(serialized)
	assertEquals(serialized, joyCon.controllerStateToString(joyConState))
end

luaUnit:run()