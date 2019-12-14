local util = require('shared/util')

local joyCon = {}
function ReplaceCharacter(position, s, replace)
    return s:sub(1, position-1) .. replace .. s:sub(position+1)
end

function joyCon.getJoyStickState(love)

	local joysticks = love.joystick.getJoysticks()
	local joystick = joysticks[1]

	function TruncatedAxis(axisName)
		return string.sub(joystick:getGamepadAxis(axisName),1,7)
	end

	local state = {}

	state.dpleft = util.boolToString(joystick:isGamepadDown("dpleft"))
	state.dpdown = util.boolToString(joystick:isGamepadDown("dpdown"))
	state.dpup = util.boolToString(joystick:isGamepadDown("dpup"))
	state.dpright = util.boolToString(joystick:isGamepadDown("dpright"))
	state.x = util.boolToString(joystick:isGamepadDown("x"))
	state.a = util.boolToString(joystick:isGamepadDown("a"))
	state.b = util.boolToString(joystick:isGamepadDown("b"))
	state.y = util.boolToString(joystick:isGamepadDown("y"))
	state.rightshoulder = util.boolToString(joystick:isGamepadDown("rightshoulder"))
	state.leftshoulder = util.boolToString(joystick:isGamepadDown("leftshoulder"))
	state.start = util.boolToString(joystick:isGamepadDown("start"))
	state.back = util.boolToString(joystick:isGamepadDown("back"))

    state.leftx = TruncatedAxis("leftx")
    state.lefty = TruncatedAxis("lefty")
    state.rightx = TruncatedAxis("rightx")
    state.righty = TruncatedAxis("righty")
    state.triggerleft = TruncatedAxis("triggerleft")
    state.triggerright = TruncatedAxis("triggerright")

    return state
end

function joyCon.controllerStateToString(state)
	local result = "000000000000 lstickx lsticky rstickx rsticky ltrigger rtrigger"

	result = ReplaceCharacter(1,result,state.dpleft)
	result = ReplaceCharacter(2,result,state.dpdown)
	result = ReplaceCharacter(3,result,state.dpup)
	result = ReplaceCharacter(4,result,state.dpright)
	result = ReplaceCharacter(5,result,state.x)
	result = ReplaceCharacter(6,result,state.a)
	result = ReplaceCharacter(7,result,state.b)
	result = ReplaceCharacter(8,result,state.y)
	result = ReplaceCharacter(9,result,state.rightshoulder)
	result = ReplaceCharacter(10,result,state.leftshoulder)
	result = ReplaceCharacter(11,result,state.start)
	result = ReplaceCharacter(12,result,state.back)

	result = string.gsub(result, "lstickx", state.leftx, 1)
    result = string.gsub(result, "lsticky", state.lefty, 1)
    result = string.gsub(result, "rstickx", state.rightx, 1)
    result = string.gsub(result, "rsticky", state.righty, 1)
    result = string.gsub(result, "ltrigger", state.triggerleft, 1)
    result = string.gsub(result, "rtrigger", state.triggerright, 1)

    return result
end

function joyCon.stringToControllerState(str)

	local parts = util.splitStringOnSpaces(str)

	local state = {}

	state.dpleft = string.sub(str, 1, 1)
	state.dpdown = string.sub(str, 2, 2)
	state.dpup = string.sub(str, 3, 3)
	state.dpright = string.sub(str, 4, 4)
	state.x = string.sub(str, 5, 5)
	state.a = string.sub(str, 6, 6)
	state.b = string.sub(str, 7, 7)
	state.y = string.sub(str, 8, 8)
	state.rightshoulder = string.sub(str, 9, 9)
	state.leftshoulder = string.sub(str, 10, 10)
	state.start = string.sub(str, 11, 11)
	state.back = string.sub(str, 12, 12)

	state.leftx = parts[2]
	state.lefty = parts[3]
	state.rightx = parts[4]
	state.righty = parts[5]
	state.triggerleft = parts[6]
	state.triggerright = parts[7]

	return state
end

return joyCon