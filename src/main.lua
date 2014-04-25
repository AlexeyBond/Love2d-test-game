local class = require "bartbes.SECS.full"

libs = {}
rkstlib = {}
rkstlib.scene = require "RakastettuLibs.Scene"
rkstlib.layer = require "RakastettuLibs.Layer"
rkstlib.node = require "RakastettuLibs.Node"

game = require "Game.Game"

function love.load()
	local width = 640
	local height = 480

	if love.window ~= nil then -- v.0.9.0
		love.window.setMode(width, height, {resizable = true,
				vsync = true, minwidth = 320, minheight = 240})

		--register resize callback
		function love.resize(w, h)
			game:resizeWindow(w, h)
		end

	else  -- v.0.8.0
		love.graphics.setMode(width, height, false, true)
	end

	game:init(width, height)

----------------------------------
	-- local a = class:new()
	-- function a:init(x)
	-- 	self.x = x
	-- end
	-- local b = a:new()
	-- function b:init(x, y)
	-- 	self.y = y

	-- 	print(self.x)
	-- 	print(self.y)
	-- 	self.z = self.x + self.y
	-- end

	-- local obj = b:new(1, 2)
	-- print(obj.x .. ' ' .. obj.y .. ' ')-- .. obj.z)
----------------------------------
end

function love.draw()
	game.scene:draw()
end

function love.update(dt)
	game.scene:update(dt)
end
