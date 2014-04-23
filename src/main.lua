rkstlib = {}
rkstlib.scene = require "RakastettuLibs.Scene"
game = {}

function love.load()
	local width = 640
	local height = 480

	if love.window ~= nil then
		love.window.setMode(width, height)
	else
		love.graphics.setMode(width, height)
	end

	game.scene = rkstlib.scene.new()
	game.scene:addLayer(nil)
end


function love.draw()
	game.scene:draw()
end


function love.update(dt)
	game.scene:update(dt)
end
