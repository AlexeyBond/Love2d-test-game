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

	self._roadLength = 5 * self.textures.road:getHeight()

	self:resizeWindow(width, height)
	self:_initScene()

	self.scene._camera._debug = true
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
			math.pi / 2,
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
		local player_dv = {x = 0, phi = 0}
		if love.keyboard.isDown('w') then
			player_dv.x = dt
		elseif love.keyboard.isDown('s') then
			player_dv.x = -dt
		end
		if love.keyboard.isDown('a') then
			player_dv.phi = -dt
		elseif love.keyboard.isDown('d') then
			player_dv.phi = dt
		end
		Game.player:rotate(player_dv.phi)
		Game.player:vector_move(player_dv.x*1000, 0)

		Game.player._originPt.x = Game.player._originPt.x % Game._roadLength
		if math.abs(Game.player._originPt.y)>Game.textures.road:getWidth()/2 then
			local offset = 2*(math.abs(Game.player._originPt.y) - Game.textures.road:getWidth()/2)
			if Game.player._originPt.y < 0 then offset = -offset end
			Game.player._originPt.y = -Game.player._originPt.y + offset
			Game.player._originPt.x = Game.player._originPt.x + Game._roadLength/2
		end
		Game.scene._camera._originPt.x = Game.player._originPt.x
		Game.scene._camera._originPt.y = Game.player._originPt.y
		Game.scene._camera._angle = -Game.player._angle
	end
	----------------------
	function love.mousepressed(bufx, bufy, button)
		if button == ("wu") then
			self.scene._camera._zoom = self.scene._camera._zoom + 0.1
		end
		
		if button == ("wd") then
			self.scene._camera._zoom = self.scene._camera._zoom - 0.1
		end
	end
end

return Game
