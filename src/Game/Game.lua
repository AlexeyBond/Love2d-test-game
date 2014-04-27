rkstlib.scene = require "RakastettuLibs.Scene"
rkstlib.layer = require "RakastettuLibs.Layer"
rkstlib.node = require "RakastettuLibs.Node"
rkstlib.list = require "RakastettuLibs.List"
rkstlib.texturedNode = require "RakastettuLibs.TexturedNode"

Game = {} --game with one scene
Game.Player = require "Game.Player"
Game.RoadLayer = require "Game.RoadLayer"
Game.SpaceBGLayer = require "Game.SpaceBGLayer"
Game.Monster = require "Game.Monster"
Game.Barrel = require "Game.Barrel"

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
		road = love.graphics.newImage("res/img/road.png"),
		space = love.graphics.newImage("res/img/space.jpg"),
		monster = love.graphics.newImage("res/img/monster.png"),
		barrel = love.graphics.newImage("res/img/barrel.png")
	}

	self._num_road_sectors = 5
	self._roadLength = self._num_road_sectors * self.textures.road:getHeight()

	self:resizeWindow(width, height)
	self:_initScene()

	self.scene._camera._debug = true
end

function Game:_makeBarrels(mainLayer)
	local max_barrels_per_sector = 3
	local i

	self._barrels = rkstlib.list:new( )

	for i = 1, self._num_road_sectors do
		local barrels_in_sector = math.random(1,max_barrels_per_sector)
		for j = 1, barrels_in_sector do
			local barrel = Game.Barrel:new(
				self.textures.barrel,
				self.textures.road:getHeight()*(i-1),
				self.textures.road:getHeight()*i )
			mainLayer:addNode( barrel )
			self._barrels:insert( barrel )
		end
	end
end

function Game:_initScene()

	local spaceLayer = Game.SpaceBGLayer:new(self.textures.space, self.textures.road:getHeight())

		self.scene:addLayer( spaceLayer )

		local mainLayer = rkstlib.layer:new()

		--Game.player = Game.Player:new(
		--		{x = 0.001, y = 0},
		--		nil,
		--		math.pi / 2,
		--		self.textures.player
		--)

	--mainLayer:addNode(Game.player)
	

	local mainLayer = rkstlib.layer:new()
	self:_makeBarrels(mainLayer)

	Game.player = Game.Player:new(
			{x = 0.001, y = 0},
			nil,
			math.pi / 2,
			self.textures.player
	)
	
	Game.monster = Game.Monster:new(
			nil,
			nil,
			nil,
			self.textures.monster,
			self.textures.road,
			5
	)
	mainLayer:addNode(Game.monster)
	
	mainLayer:addNode(Game.player)

	self.scene:addLayer(mainLayer)
	
	
	local roadLayer = Game.RoadLayer:new(self.textures.road)

	self.scene:addLayer( roadLayer )
	
	
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
			Game.player._v = Game.player._v+(Game.player._maxv-Game.player._v)*(dt/5.0)
			player_dv.x = Game.player._v
		elseif love.keyboard.isDown('s') then
			Game.player._v = Game.player._v-(Game.player._maxv-Game.player._v)*(dt/6)
			player_dv.x = Game.player._v
			elseif (Game.player._v-0.001>0) then
				Game.player._v = Game.player._v - (Game.player._maxv-Game.player._v)*(dt/1.5)
				player_dv.x = Game.player._v
				elseif (Game.player._v+0.001<0) then
					Game.player._v = Game.player._v + (Game.player._maxv-Game.player._v)*(dt/1.5)
					player_dv.x = Game.player._v
					else
					Game.player._v = 0
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

		--[[ Check barrel collisions ]]
		Game._barrels:toBegin( )
		while true do
			local barrel = Game._barrels:getCurrent()
			if barrel ~= nil and not barrel._hitted then
				if ((math.pow(Game.player._originPt.x-barrel._originPt.x,2))+
					(math.pow(Game.player._originPt.y-barrel._originPt.y,2)))
						< math.pow(Game.player._radius+barrel._radius,2) then
					barrel:hit( Game.player )
				end
			end
			if Game._barrels:isEnd() then
				break
			end
			if not deleted then Game._barrels:toNext() end
		end

		rkstlib.scene.update(self,dt)
	end
	----------------------
	function love.mousepressed(bufx, bufy, button)
		if button == ("wd") then
			self.scene._camera._zoom = self.scene._camera._zoom *0.9
		end
		
		if button == ("wu") then
			self.scene._camera._zoom = self.scene._camera._zoom /0.9
		end
	end
end

return Game
