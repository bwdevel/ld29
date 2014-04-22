function statesLoad()
	state = "Menu"

end

function statesUpdate(dt)
	if state == "Menu" then menuUpdate(dt) end

end

function statesDraw()
	if state == "Menu" then menuDraw() end

end

function statesMousePressed(x, y, button)
	if state == "Menu" then menuMousePressed(x, y, button) end

end

function statesMouseReleased(x, y, button)
	if state == "Menu" then menuMouseReleased(x, y, button) end

end

function statesKeyPressed(key)
	if state == "Menu" then menuKeyPressed(key) end

end

function statesKeyReleased(key)
	if state == "Menu" then menuKeyReleased(key) end

end