local class = require "bartbes.SECS.full"

libs = {}
rkstlib = {}
rkstlib.scene = require "RakastettuLibs.Scene"
rkstlib.layer = require "RakastettuLibs.Layer"
rkstlib.node = require "RakastettuLibs.Node"
rkstlib.texturedNode = require "RakastettuLibs.TexturedNode"
rkstlib.scene = require "RakastettuLibs.Scene"

game = require "Game.Game"
mainmenu = {}

-- 		love.graphics.newImage("res/img/main_menu.png"));

function love.load()
	local width = 640
	local height = 480

	if love.window then -- v.0.9.0
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

	mainmenu.bg = love.graphics.newImage("res/img/main_menu.png")
	_STARTMENU = true
end

function love.draw()
	if _STARTMENU then
		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.draw(mainmenu.bg, 0, 0, 0, 640/1024, 480/768)
	else
		game.scene:draw()
	end

	local pt = Game.Score
	love.graphics.print(pt, 13, 13)
end

function love.update(dt)
	if _STARTMENU then
		if love.keyboard.isDown('kpenter') then
			_STARTMENU = nil
		end
	else
		game.scene:update(dt)
	end
end
