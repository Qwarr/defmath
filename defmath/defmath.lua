-- This module has many useful math functions and shortcuts

local M = {}

-- Angle-Diff (gets the smallest angle between two angles, using radians)
function M.anglediff_rad(rad1, rad2)
	local a = rad1 - rad2
	a = (a + math.pi) % (math.pi * 2) - math.pi
	return a
end

-- Angle-Diff (gets the smallest angle between two angles, using degrees)
function M.anglediff_deg(deg1, deg2)
	local a = deg1 - deg2
	a = (a + 180) % (180 * 2) - 180
	return a
end

-- Round
function M.round(x)
	local a = x % 1
	x = x - a
	if a < 0.5 then a = 0
	else a = 1 end
	return x + a
end

-- Round to decimal point
function M.round_decimal(number, decimal)
	decimal = 10 ^ (decimal or 0)
	return math.floor(number*decimal+0.5)/decimal
end

-- Clamp
function M.clamp(x, min, max)
	if x > max then x = max
	elseif x < min then x = min
	end
	return x
end

-- Sign
function M.sign(x)
	if x >= 0 then return 1
	else return -1
	end
end

-- Checks if two numbers have the same sign
function M.same_sign(a,b)
	return M.sign(a) == M.sign(b)
end

-- Vect to Quat
function M.vect_to_quat(vect)
	return vmath.quat_rotation_z(math.atan2(vect.y, vect.x))
end

-- Vect to Quat + 90 degrees (perpendicular)
function M.vect_to_quat90(vect)
	return vmath.quat_rotation_z(math.atan2(vect.y, vect.x) + math.pi/2)
end

-- Random float from -1 to 1
function M.rand11()
	return((math.random() - 0.5) * 2)
end

-- Random float in range
function M.rand_range(min, max)
	return math.random() * (max - min) + min
end

-- Linear interpolation
function M.lerp(start, stop, amount)
	amount = M.clamp(amount, 0, 1)
	return((1-amount) * start + amount * stop)	
end

-- Distance between two 2d points
function M.dist2d(x1, y1, x2, y2)
	return ((x2-x1)^2+(y2-y1)^2)^0.5
end

-- Distance betwen two 3d points
function M.dist3d(x1, y1, z1, x2, y2, z2)
	return ((x2-x1)^2+(y2-y1)^2+(z2-z1)^2)^0.5
end

-- Angle in radians of vector between two points
function M.angle_of_vector_between_two_points(x1,y1, x2,y2) 
	return math.atan2(y2-y1, x2-x1) 
end

-- Clears bad RNG and sets seed to be based on OS time
function M.setup_rng()
	math.randomseed(os.time() + math.random())
	math.random(); math.random(); math.random() -- clear bad rng	
end

-- Check if number is within range
function M.is_within_range(number, min, max)
	return number >= min and number <= max
end

-- Convert radians to degrees
function M.radians_to_degrees(radian)
	return 180 / math.pi * radian
end

-- Convert degrees to radians
function M.degrees_to_radians(degrees)
	return math.pi / 180 * degrees
end

-- Wrap a number to betwen 0 and a range bound
function M.wrap(number, bound)
	if (number < 0) then
		return bound - (math.fmod(-number, bound))
	else
		return math.fmod(number, bound)
	end
end

-- Bound a number so that it is no larger than max and no smaller than min
function M.bound(number, min, max)
	if number < min then 
		number = min
	elseif number > max then
		number = max
	end
	return number
end

-- Adds an amount to a value within the value going over max or below min
function M.bound_add(number, amount, min, max)
	number = number + amount
	return M.bound(number, min, max)
end

-- Sums a set of values
function M.sum(...)
  local sum = 0
  for a = 1, select("#", ...) do
    local v = select(a, ...)
    sum = sum + v
  end
  return sum
end

-- Average of set of values
function M.average(...)
	local arg ={...}
	return (M.sum(...) / #arg)
end

-- Get difference between two values
function M.difference(a,b) 
	return math.abs(a-b)
end

-- if a number is even
function M.is_even(number)
	return math.fmod(number, 2) == 0
end

-- if a number is odd
function M.is_odd(number)
	return M.is_even(number) ~= true
end

-- Wrap an angle between -180 and +180
function M.wrap_angle(angle)
	if angle > 180 then
		angle = M.wrap_angle(angle - 360)
	elseif angle < -180 then
		angle = M.wrap_angle(angle + 360)
	end
	return angle
end

-- Angle between vmath vectors in radians
function M.angle_between_vectors(vector1, vector2)
	return math.atan2(vector2.y-vector1.y, vector2.x-vector1.x) 
end

-- Average midpoint of a set of vmath vectors
function M.average_midpoint_of_vectors(...)
	local vectors = {...}
	local x,y,c = 0,0,#vectors
	for i=1, c do
		x = x + vectors[i].x
		y = y + vectors[i].y
	end
	return x/c, y/c

end

-- Fraction of
function M.fraction_of(a,b)
	return a/b
end

-- Percent of
function M.percent_of(a,b)
	return M.fraction_of(a,b) * 100
end


return M
