
local util = {}

function util.dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. util.dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

function util.boolToString(value)
   if value == true then
      return "1"
   else
      return "0"
   end
end

function util.splitStringOnSpaces(inputstr)
	local t = {}
	for v in string.gmatch(inputstr, "[%d/.]+") do
	   t[#t+1] = v
	end
	return t
end


return util