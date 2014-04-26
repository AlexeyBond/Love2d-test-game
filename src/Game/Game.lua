rkstlib.scene = require "RakastettuLibs.Scene"
rkstlib.layer = require "RakastettuLibs.Layer"
rkstlib.node = require "RakastettuLibs.Node"

local Game = {} --game with one scene

function Game:resizeWindow(width, height)
	local cam = self.scene._camera
	cam._sizes.width = width
	cam._sizes.height = height
end

function Game:init(width, height)
	print("Game:init() called")

	self.scene = rkstlib.scene:new()

	self:resizeWindow(width, height)
	self:_initTestScene()
end

--[[
Тестовая сцена
Один слой с двумя нодами
Вращение и зум камеры
]]--
function Game:_initTestScene()
	--test----------------
	local mainLayer = rkstlib.layer:new()


	local node1 = rkstlib.node:new(
			nil, --по умолчанию {x = 0, y = 0}
			{top = 50, bottom = 50, left = 30, right = 40},
			nil -- по умолчанию 0
	)
	mainLayer:addNode(node1)

	local node2 = rkstlib.node:new(
			{x = 100, y = -150},
			--{top = 10, bottom = 20, left = 30, right = 40},
			node1:getRect(), --копируем рект из предыдущей ноды
			nil
	)
	node2._rect.top = 10 --меняем первые два параметра ректа
	node2._rect.bottom = 20 --//--
	mainLayer:addNode(node2)

	self.scene:addLayer(mainLayer)

	local overlayLayer = rkstlib.layer:new()

	overlayLayer._is_screen_overlay = true

	local overnode1 = rkstlib.node:new()
	overnode1:setRect(20, 20, 50, 50)
	overnode1:moveTo(70, 50)
	overlayLayer:addNode(overnode1)

	self.scene:addLayer(overlayLayer)

	function game.scene:update(dt)
		local phi = 2
		local zv = 1
		self._camera._angle = (self._camera._angle + dt * phi * 0.2) % (2 * math.pi)
		self._camera._zoom = self._camera._zoom + zv * dt
		self._camera._zoom_aspect = 1 + 0.3*math.sin(self._camera._angle*20.0)
		if self._camera._zoom > 2 then
			self._camera._zoom = 0.5
			print("over")
		end
	end
	----------------------
end

return Game
