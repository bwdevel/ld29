player = {}

	player.image = playerSprite
	player.ox = player.image:getWidth()/2
	player.oy = player.image:getHeight()/2
	player.x = math.floor(love.window.getWidth()/2)
	player.y = 32 + player.oy
	player.vy = 0
	player.falling = false
	player.jumping = false

function drawPlayer()
	love.graphics.setColor(0, 255, 0, 128)
	love.graphics.rectangle("fill", player.x - (player.ox), player.y - (player.oy), player.ox*2, player.oy*2)

	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.draw(player.image, player.x, player.y, 0, 1, 1, player.ox, player.oy)

	love.graphics.setColor(255, 0, 0, 255)
	love.graphics.rectangle("fill", player.x, player.y, 1, 1)

	love.graphics.setColor(255, 255, 255, 255)

	love.graphics.print("f :" .. tostring(player.falling), player.x - player.ox, player.y - player.oy - 20)
	love.graphics.print("j :" .. tostring(player.jumping), player.x - player.ox, player.y - player.oy - 10)
	love.graphics.print("vy:" .. tostring(player.vy), player.x - player.ox, player.y - player.oy )

end

function playerUpdate(dt)
	--if player.jumping == true then print("jump detected") end  -- debug; delete
	if getTile(player.x, player.y, "tile") == 0 then 
		player.falling = true
		--findGround()
	elseif player.vy > 0 then  --- only apply if falling?
		player.falling = false
		player.jumping = false
	end
	if player.falling == true then
		player.vy = player.vy + (gravity*dt)
		if player.vy >= gravity then 
			player.vy = gravity 
		end
	elseif player.jumping == false then
		player.vy = 0
	end

	--ADD: check collission and if colliding; change the delta
	player.y = player.y + player.vy

end

function playerJump()
	--print("Player jump!")  --- debug; delete
	if player.falling == false then
		player.jumping = true
		player.vy = -5
	end
end


function findGround()
	playerReset() --- remove
	local falling = true
	local y = player.y
	while (falling == true) do
		local left = getTile(player.x-player.ox, y, "tile")
		local right = getTile(player.x+player.ox, y, "tile")
		if left > 0 or right > 0 then
			falling = false
			player.y = y
		end
		y = y + 1
		if y > love.window.getHeight() then falling = false end
	end
end

function playerReset()
	player.x = love.window.getWidth()/2
	player.y = 32 + player.oy
end

function getTile(x, y, key)
	local out = nil

	if key == nil then
		out = grid[math.floor((x-mapOffsetX)/textureSize)][math.floor((y+player.oy)/textureSize)]
	else
		out = grid[math.floor((x-mapOffsetX)/textureSize)][math.floor((y+player.oy)/textureSize)][key]
	end

	return out
end

