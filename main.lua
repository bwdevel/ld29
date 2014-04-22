function love.load()

end

function love.update(dt)

end

function love.draw()

end

function love.mousepressed(x, y, button)

end

function love.mousereleased(x, y, button)

end

function love.keypressed(key)

end

function love.keyreleased(key)
	if key == 'q' then love.event.quit() end

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