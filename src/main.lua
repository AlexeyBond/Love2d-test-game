rkstlib = {}
rkstlib.scene = require "RakastettuLibs.Scene"
rkstlib.layer = require "RakastettuLibs.Layer"
rkstlib.node = require "RakastettuLibs.Node"

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
	do
		local cam = game.scene._camera
		cam._sizes.width = width
		cam._sizes.height = height
	end

	initTestScene()
end

function initTestScene()
	--test----------------
	local mainLayer = rkstlib.layer.new()

	local node1 = rkstlib.node.new()
	node1:setRect(50, 50, 30, 40)
	node1:moveTo(0, 0)
	mainLayer:addNode(node1)

	local node2 = rkstlib.node.new()
	node2:setRect(10, 20, 30, 40)
	node2:moveTo(100, -150)
	mainLayer:addNode(node2)

	game.scene:addLayer(mainLayer)

	function game.scene:update(dt)
		local phi = 2
		local zv = 1
		self._camera._angle = (self._camera._angle + dt * phi) % (2 * math.pi)
		self._camera._zoom = self._camera._zoom + zv * dt
		if self._camera._zoom > 2 then
			self._camera._zoom = 0.5
			print("over")
		end
	end
	----------------------
end

function love.draw()
	game.scene:draw()
end

function love.update(dt)
	game.scene:update(dt)
end
