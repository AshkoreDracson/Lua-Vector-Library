-- This vector API has a variable size, which means that Vectors can be 1,2,3,4 even 10 dimensional vectors !
-- Made by Ashkore Dracson

local function clamp( num, min, max )
	if num < min then
		num = min
	elseif num > max then
		num = max 
	end
	return num
end

local function lerp( a, b, t )
	return a+(b-a)*t
end

Vector = {}

function Vector:New( ... )
    local vec = arg
    if vec == nil then

    end
    vec.n = nil
    self.__index = self
    return setmetatable( vec, self )
end

function Vector:Length()
	local len = 0
	for i,v in ipairs(self) do
		len = len + (self[i] ^ 2)
	end
	len = math.abs(math.sqrt(len))
	return len
end

function Vector:SqrLength()
	local len = 0
	for i,v in ipairs(self) do
		len = len + (self[i] ^ 2)
	end
	len = math.abs(len)
	return len
end

function Vector:Normalized()
	local len = self:Length()
	local copy = Vector:New( unpack(self) )
	for i,v in ipairs(copy) do
		copy[i] = copy[i] / len
	end
	return copy
end

function Vector:Normalize()
	local len = self:Length()
	for i,v in ipairs(self) do
		self[i] = self[i] / len
	end
end

function Vector:Add( vec, override )
	for i,v in ipairs(self) do
		override = override or false
		if override then
			vec[i] = vec[i] or vec[#vec]
		else
			vec[i] = vec[i] or 0
		end
		self[i] = self[i] + vec[i]
	end
end

function Vector:Substract( vec, override )
	for i,v in ipairs(self) do
		override = override or false
		if override then
			vec[i] = vec[i] or vec[#vec]
		else
			vec[i] = vec[i] or 0
		end
		self[i] = self[i] - vec[i]
	end
end

function Vector:Multiply( vec, override )
	for i,v in ipairs(vec) do
		override = override or false
		if override then
			vec[i] = vec[i] or vec[#vec]
		else
			vec[i] = vec[i] or 0
		end
		self[i] = self[i] * vec[i]
	end
end

function Vector:Divide( vec, override )
	for i,v in ipairs(vec) do
		override = override or false
		if override then
			vec[i] = vec[i] or vec[#vec]
		else
			vec[i] = vec[i] or 0
		end
		self[i] = self[i] / vec[i]
	end
end

function Vector:Left( dim )
	dim = dim or 3
	dim = clamp( math.floor(dim), 2, 3 )
	if dim == 3 then
		return Vector:New( 1, 0, 0 )
	else
		return Vector:New( 1, 0 )
	end
end

function Vector:Up( dim )
	dim = dim or 3
	dim = clamp( math.floor(dim), 2, 3 )
	if dim == 3 then
		return Vector:New( 0, 1, 0 )
	else
		return Vector:New( 0, 1 )
	end
end

function Vector:Forward()
	return Vector:New( 0, 0, 1 )
end

function Vector.Lerp( vec1, vec2, amount )
	amount = amount or 0.5
	for i,v in ipairs(vec1) do
		vec2[i] = vec2[i] or 0
		vec1[i] = lerp( vec1[i], vec2[i], amount )
	end
	return vec1
end

function Vector.Dot( vec1, vec2 )
	local dot = 0
	local tbl = {}
	for i,v in ipairs(vec1) do
		vec2[i] = vec2[i] or 0
		tbl[i] = vec1[i] * vec2[i]
	end
	for i,v in ipairs(tbl) do
		dot = dot + tbl[i]
	end
	return dot
end

function Vector.Cross( vec1, vec2 )
	if (#vec1 and #vec2) == 3 then
		local cross = Vector:New(0, 0, 0)
		cross[1] = (vec1[1] * vec2[3]) - (vec1[3] * vec2[2])
		cross[2] = (vec1[3] * vec2[1]) - (vec1[1] * vec2[3])
		cross[3] = (vec1[1] * vec2[2]) - (vec1[2] * vec2[1])
		return cross
	else
		error("The two vectors must be 3D !")
		return
	end
end

function Vector.Distance( vec1, vec2 )
	for i,v in ipairs(vec1) do
		vec2[i] = vec2[i] or 0
		vec1[i] = vec1[i] - vec2[i]
	end
	return vec1:Length()
end

function Vector:Print()
	local str = "{ "
	for i,v in ipairs(self) do
		str = str .. tostring(i) .. "=" .. v
		if i < #self then
			str = str .. ", "
		end
	end
	str = str .. " }"
	print( str )
end

Vector.Zero = Vector:New(0)
Vector.One = Vector:New(1)