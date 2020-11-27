local switcher = require("switcher")
local ismousepressed
local upgrades = {1, 2, 3, 4}

function love.load()
	switcher.createsheetandquads("switches-sheet.png", { {0, 0}, {30, 0}, {60, 0}, {90, 0} }, 30, 30, 4)
	switcher.createswitches({ {0, 100}, {40, 100}, {80, 100}, {120, 100} })
end

function love.update(dt)
	local mx = love.mouse.getX()
	local my = love.mouse.getY()

	switcher.update(mx, my, ismousepressed, upgrades)
	ismousepressed = false
end

function love.mousereleased(x, y, button, istouch, presses)
	ismousepressed = true
end

function love.draw()
	switcher.draw()
end