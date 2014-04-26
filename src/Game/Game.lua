rkstlib.scene = require "RakastettuLibs.Scene"
rkstlib.layer = require "RakastettuLibs.Layer"
rkstlib.node = require "RakastettuLibs.Node"
rkstlib.texturedNode = require "RakastettuLibs.TexturedNode"

local Game = {} --game with one scene
Game.Player = require "Game.Player"
Game.RoadLayer = require "Game.RoadLayer"

function Game:resizeWindow(width, height)
	local cam = self.scene._camera
	cam._sizes.width = width
	cam._sizes.height = height
end

function Game:init(width, height)
	print("Game:init() called")

	self.scene = rkstlib.scene:new()

	self.textures = {
		player = love.graphics.newImage("res/img/player.png"),
		road = love.graphics.newImage("res/img/road.png")
	}

	self:resizeWindow(width, height)
	self:_initScene()
end

--[[
Тестовая сцена
Один слой с двумя нодами
Вращение и зум камеры
]]--
function Game:_initScene()
	local roadLayer = Game.RoadLayer:new(self.textures.road)

	self.scene:addLayer( roadLayer )

	local mainLayer = rkstlib.layer:new()

	Game.player = Game.Player:new(
			{x = 0.001, y = 0},
			nil,
			0,
			self.textures.player
	)

	mainLayer:addNode(Game.player)

	self.scene:addLayer(mainLayer)

	local overlayLayer = rkstlib.layer:new()

	overlayLayer._is_screen_overlay = true

	-- local overnode1 = rkstlib.node:new()
	-- overnode1:setRect(20, 20, 50, 50)
	-- overnode1:moveTo(70, 50)
	-- overlayLayer:addNode(overnode1)

	self.scene:addLayer(overlayLayer)

	function Game.scene:update(dt)
		local player_dv = {x = 0, y = 0}
		if love.keyboard.isDown('w') then
			print('lol')
			player_dv.x = dt
		elseif love.keyboard.isDown('s') then
			player_dv.x = -dt
		end
		if love.keyboard.isDown('a') then
			player_dv.y = -dt
		elseif love.keyboard.isDown('d') then
			player_dv.y = dt
		end
		Game.player:move(player_dv.x*100, player_dv.y)
	end
	----------------------
end

return Game
