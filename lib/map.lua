
function mapgen(width, height)
	mapOffsetX = 0
	mapOffsetY = 0
	vheight = math.floor(love.window.getHeight()/textureSize)

	local xScale = (height*textureSize)/love.window.getHeight()
	local p = math.floor(vheight/2) --- make this dynamic

	print("height: " .. height .. "  vheight: " .. vheight .. "   p init: " .. p)

	local v = 2
	local a = -1

	local highClamp = math.floor(p + (p/2))
	local lowClamp = math.ceil(p - (p/2))

	local container = initTable(width, height)

	for x = 0, width - 1 do
		--mostly grass but some random dirt
		if math.random(1,100) <= 5 then 		
			container[x][p]["tile"] = 2 -- dirt
		else
			container[x][p]["tile"] = 3 -- grass
		end
		for y = p+1, height -1 do
			if y < p+5 then
				-- mostly dirt, but some random stone
				if math.random(1,100) <= 5 then 		
					container[x][y]["tile"] = 1 -- stone
				else
					container[x][y]["tile"] = 2 -- dirt
				end
			elseif y > height - 4 then
				container[x][y]["tile"] = 12
			else
				container[x][y]["tile"] = getType( math.floor( (y / mapHeight) * 100) )
			end
		end

		-- flatten terrain a bit
		if math.random(1,2) == 2 then
			p = p+v
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
	end

	print("highClamp: " .. highClamp .. "   lowClamp: " .. lowClamp .. "   xScale: " .. xScale)


	--print(tostring(container))
	return container

end

function initTable(width, height)

	local container = {}
	for x = 0, width - 1 do
		container[x] = {}
		for y = 0, height -1 do
			container[x][y] = {}
			container[x][y]["tile"] = 0
			container[x][y]["light"] = 0
			container[x][y]["highlight"] = false
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
	local tempX = math.floor(ox/textureSize)
	local tempY = math.floor(oy/textureSize)


	for x = 0 , mapWidth-1 do
		for y = 0, mapHeight-1 do
			if (x >= mapX1 and x <= mapX2) and (y >= mapY1 and y <= mapY2) then
				love.graphics.draw(tile[grid[x][y]["tile"]],(x*textureSize) + ox, (y*textureSize) +  oy)

				if lights == true then
					local light = grid[x][y]["light"]
					if light ~= 0 then
						love.graphics.setColor( 0, 0, 0, light)
						love.graphics.rectangle("fill", (x*textureSize) + ox, (y*textureSize) +  oy, textureSize, textureSize)
						love.graphics.setColor( 255, 255, 255, 255)
					end
				end
			end
		end
	end

	local text = "tempX: " .. tempX .. "    tempY: " .. tempY
	love.graphics.print(text, 10, 46)
end

function getType(depth)
	local rand = math.random(1, 100)
	local ttype = 1  -- stone

	if depth <= 40 then
		if rand <= 4 then 
			ttype = 5				-- iron
		elseif rand <= 12 
			then ttype = 4  -- coal
		elseif rand <= 14
			then ttype = 6 	-- iron
		end
	elseif 	depth <= 70 then
		if rand <= 2 then 
			ttype = 7 			-- emeralds
		elseif rand <= 9 
			then ttype = 5 	-- iron
		elseif rand <= 16
			then ttype = 4 	-- coal
		end
	else 
		if rand <= 2 then 
			ttype = 8 			-- diamonds
		elseif rand <= 8 
			then ttype = 6 	-- gold
		elseif rand <= 12
			then ttype = 5	-- iron
		elseif rand <= 14
			then ttype = 7 	-- emerald
		elseif rand <= 16
			then ttype = 4  -- coal
		end

	end

	return ttype
end

function lightMap()
	for x = 0, mapWidth-1 do
		for y = 0, mapHeight-1 do
			local airClose = false
			local airFar = false
			if grid[x][y]["tile"] ~= 0 then 
				for xx = -2, 2 do
					for yy = -2, 2 do
						if (x+xx >= 0 and x+xx <= mapWidth-1) and (y+yy >= 0 and y+yy <= mapHeight -1) then
							if grid[x+xx][y+yy]["tile"] == 0 then
								if (xx == -2 or xx == 2) or (yy == -2 or yy == 2) then
									airFar = true
								else
									airClose = true
								end
							end 
						end
					end
				end
				if airClose then 
					grid[x][y]["light"] = 0 
				elseif airFar then 
					grid[x][y]["light"] = 128  -- 128
				else 
					grid[x][y]["light"] = 255 -- 212
				end
			end
		end
	end
end
