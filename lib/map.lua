
function mapgen(width, height)
	local highClamp = height - math.floor(height/3)
	local lowClamp = math.floor(height/3)
	local p = math.floor(height/2)
	local v = 2
	local a = -1

	local container = initTable(width, height)

	for x = 0, width - 1 do
		--for y = 0, height -1 do
		container[x][height-p] = 3
		for y = height-p+1, height -1 do
			if y < height-p+5 then
				container[x][y] = 2
			else
				container[x][y] = getType()
			end
		end
		p = p+v
--		local temp = modPosition(height, p, v, a)
--		p = temp[0]
--		v = temp[1]
--		a = temp[2]

		if p > highClamp then 
			p = highClamp 
			v = 0
			a = -math.abs(a)
		end
		if p < lowClamp then 
			p = lowClamp 
			v=0 
			a = math.abs(a)
		end
		v = v+a
		a = math.random(-2, 2)
	end


	--print(tostring(container))
	return container

end

function initTable(width, height)

	local container = {}
	for x = 0, width - 1 do
		container[x] = {}
		for y = 0, height -1 do
			container[x][y] = 0
		end
	end	
	return container

end	

function modPosition(height, p, v, a)
	local out = {}
	p = p+v
	if p > height - 4 then
		p = height -4
		v = 0
		a = -math.abs(a)
	end
	if p < 4 then
		p = 4
		v = 0
		a = math.abs(a)
	end
	out[0] = p
	out[1] = v
	out[2] = a
	return out
end

function mapdraw(ox,oy)

	for x = 0, mapWidth-1 do
		for y = 0, mapHeight-1 do
			love.graphics.draw(tile[grid[x][y]],(x*textureSize) + ox, (y*textureSize) +  oy)
		end
	end

end

function getType()
	local ttype = 1
		local rand = math.random(1, 1000)
		if rand == 5 then ttype =  7
		elseif rand > 5 and rand <= 20 then ttype = 7
		elseif rand > 20 and rand <=65 then ttype = 6
		elseif rand > 65 and rand <=95 then ttype = 5
		elseif rand > 95 and rand <= 150 then ttype = 4
	end

	return ttype
end
