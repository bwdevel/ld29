require "states/states";
require "states/menu";
require "lib/map";
require "assets/assets";

function love.load()
	skyAlpha = 255
	timeofday = 43200
	timescale = 10000
	statesLoad()
	textureSize = 16
	mapWidth = (love.window.getWidth()/16)*2
	mapHeight = love.window.getHeight()/16
	mapOffsetX = 0
	mapOffsetY = 0
	grid = mapgen(mapWidth, mapHeight)
	love.graphics.setBackgroundColor( 0, 0, 0, 255 ) -- sky color
end

function love.update(dt)
	require("lib/lovebird").update()
	statesUpdate(dt)

	timeofday = timeofday + (timescale * dt)
	if timeofday > 86399 then timeofday = timeofday - 86399 end
	local temp = math.abs(timeofday - 43200)
	skyAlpha = (temp/43200)*255

end

function love.draw()
	love.graphics.setColor(135 , 206, 250, skyAlpha)
	love.graphics.rectangle( "fill", 0, 0, love.window.getWidth(), love.window.getHeight() ) -- sky color

	love.graphics.setColor(255, 255, 255, 255)
	statesDraw()
	mapdraw(mapOffsetX, mapOffsetY)
	love.graphics.print(timeofday, 10, 20)


end

function love.mousepressed(x, y, button)
	statesMousePressed(x, y, button)
end

function love.mousereleased(x, y, button)
	statesMouseReleased(x, y, button)
end

function love.keypressed(key)
	statesKeyPressed(key)
end

function love.keyreleased(key)
	if key == 'q' then love.event.quit() end
	if key == ' ' then grid = mapgen(mapWidth, mapHeight) end
	statesKeyReleased(key)
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
