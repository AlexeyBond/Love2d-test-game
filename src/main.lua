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
--пример наследования
	-- local a = class:new()
	-- function a:init(x)
	-- 	self.x = x
	-- end
	-- local b = class:new(); b:addparent(a)
	-- function b:init(x, y)
	-- 	a.init(self, x) --вызываем конструктор родителя

	-- 	self.y = y
	-- 	self.z = self.x + self.y
	-- end

	-- local obj = b:new(1, 2)
	-- print(obj.x .. ' ' .. obj.y .. ' ' .. obj.z)
----------------------------------
end

function love.draw()
	game.scene:draw()

	local pt = Game.Score
	love.graphics.print(pt, 13, 13)
end

function love.update(dt)
	game.scene:update(dt)
end
