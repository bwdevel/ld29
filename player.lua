player = {}

	player.image = playerSprite
	player.ox = player.image:getWidth()/2
	player.oy = player.image:getHeight()/2
	player.x = math.floor(love.window.getWidth()/2)
	player.y = 32 + player.oy

function drawPlayer()
	love.graphics.setColor(0, 255, 0, 128)
	love.graphics.rectangle("fill", player.x - (player.ox), player.y - (player.oy), player.ox*2, player.oy*2)

	love.graphics.setColor(255, 255, 255, 255)
	love.graphics.draw(player.image, player.x, player.y, 0, 1, 1, player.ox, player.oy)

	love.graphics.setColor(255, 0, 0, 255)
	love.graphics.rectangle("fill", player.x, player.y, 1, 1)

	love.graphics.setColor(255, 255, 255, 255)

end

function playerUpdate()
	if getTile(player.x, player.y) == 0 then 
		falling = true
		findGround()
	end

end


function findGround()
	player.x = love.window.getWidth()/2
	player.y = 32 + player.oy
	local falling = true
	local y = player.y
	while (falling == true) do
		local left = getTile(player.x-player.ox, y)
		local right = getTile(player.x+player.ox, y)
		if left > 0 or right > 0 then
			falling = false
			player.y = y
		end
		y = y + 1
		if y > love.window.getHeight() then falling = false end
	end

	
end

function getTile(x, y)
	local out = grid[math.floor((x-mapOffsetX)/textureSize)][math.floor((y+player.oy)/textureSize)]["tile"]
	return out
end

