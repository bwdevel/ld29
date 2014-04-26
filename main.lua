require "assets/assets";
require "states/states";
require "states/menu";
require "lib/map";
require "player";

function love.load()
	scrollLeft = false
	scrollRight = false
	scrollDown = false
	scrollUp = false
	scrollSpeed = 5
	skyAlpha = 255
	timeofday = 43200
	timescale = 10000
	statesLoad()
	textureSize = 32
	mapScaleX = 4
	mapScaleY = 3
	mapWidth = (love.window.getWidth() / textureSize) * mapScaleX
	mapHeight = (love.window.getHeight() / textureSize) * mapScaleY
	mapOffsetX = 0
	mapOffsetY = 0
	mapX1 = 0
	mapX2 = love.window.getWidth()/textureSize
	mapY1 = 0
	mapY2 = love.window.getHeight()/textureSize

	grid = mapgen(mapWidth, mapHeight)
	love.graphics.setBackgroundColor( 0, 0, 0, 255 ) -- sky color
	print("mapWidth: " .. mapWidth .. "    mapHeight:  " .. mapHeight .. "    mapOffsetX (cap): " .. (mapWidth * textureSize) - love.window.getWidth())
end

function love.update(dt)
	require("lib/lovebird").update()
	statesUpdate(dt)

	timeofday = timeofday + (timescale * dt)
	if timeofday > 86399 then timeofday = timeofday - 86399 end
	local temp = math.abs(timeofday - 43200)
	skyAlpha = (temp/43200)*255

	if scrollLeft then mapOffsetX = mapOffsetX + scrollSpeed end
	if scrollRight then mapOffsetX = mapOffsetX - scrollSpeed end
	if scrollUp then mapOffsetY = mapOffsetY + scrollSpeed end
	if scrollDown then mapOffsetY = mapOffsetY - scrollSpeed end

	if mapOffsetX > 0 then mapOffsetX = 0 end
  if mapOffsetX <  love.window.getWidth()- (mapWidth * textureSize) then mapOffsetX = love.window.getWidth()- (mapWidth * textureSize) end
	if mapOffsetY > 0 then mapOffsetY = 0 end
  if mapOffsetY <  love.window.getHeight()- (mapHeight * textureSize) then mapOffsetY = love.window.getHeight()- (mapHeight * textureSize) end

	mapX1 = -math.floor(mapOffsetX/textureSize)-1
	mapX2 = mapX1 + love.window.getWidth()/textureSize
	mapY1 = -math.floor(mapOffsetY/textureSize)-1
	mapY2 = mapY1 + love.window.getHeight()/textureSize

	playerUpdate()
end

function love.draw()
	--sky
	love.graphics.setColor(135 , 206, 250, skyAlpha)
	love.graphics.rectangle( "fill", 0, 0, love.window.getWidth(), love.window.getHeight() ) -- sky color

	love.graphics.setColor(255, 255, 255, 255)
	statesDraw()

	mapdraw(mapOffsetX, mapOffsetY)
	drawPlayer()

	
	-- debug
	love.graphics.print(timeofday, 10, 22)
	local text = "mapX1: " .. mapX1 .. "   mapX2: " .. mapX2 .. "   mapY1: " .. mapY1 .. "  mapY2: " .. mapY2 .. "   mapOffsetX: " .. mapOffsetX
	love.graphics.print(text, 10, 34)
	love.graphics.print("Current FPS: "..tostring(love.timer.getFPS( )), 10, 58)


end

function love.mousepressed(x, y, button)

	statesMousePressed(x, y, button)

end

function love.mousereleased(x, y, button)

	statesMouseReleased(x, y, button)

end

function love.keypressed(key)

	statesKeyPressed(key)

	if key == 'a' or key == 'left' then scrollRight = true end
	if key == 'd' or key == 'right' then scrollLeft = true end
	if key == 'w' or key == 'up' then scrollDown = true end
	if key == 's' or key == 'down' then scrollUp = true end

end

function love.keyreleased(key)

	statesKeyReleased(key)
	if key == 'q' then love.event.quit() end
	if key == ' ' then 
		grid = mapgen(mapWidth, mapHeight) 
		findGround() 
	end

	if key == 'a' or key == 'left' then scrollRight = false end
	if key == 'd' or key == 'right' then scrollLeft = false end
	if key == 'w' or key == 'up' then scrollDown = false end
	if key == 's' or key == 'down' then scrollUp = false end
	if key == 'l' then lightMap() end


end

function love.focus(f)

	if not f then
		print("LOST FOCUS")
	else
		print("GAINED FOCUS")
	end

end

function love.quit()

	print("Bye!")

end
