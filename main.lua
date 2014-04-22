require "states/states";
require "states/menu";

function love.load()
	statesLoad()

end

function love.update(dt)
	statesUpdate(dt)

end

function love.draw()
	statesDraw()

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