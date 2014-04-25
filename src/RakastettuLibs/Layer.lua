local class = require "bartbes.SECS.basic"
rkstlib.list = require "RakastettuLibs.List"

local Layer = class:new()

function Layer:init()
	self._nodes = rkstlib.list:new()
end


function Layer:addNode(node)
	print("Layer:addNode(node) called")
	self._nodes:insert(node)
end

function Layer:draw(camera)
	if self._nodes:isEmpty() then
		return
	end

	love.graphics.push()
	love.graphics.translate(camera._sizes.width/2, camera._sizes.height/2)
	love.graphics.rotate(camera._angle)
	love.graphics.scale(camera._zoom/camera._zoom_aspect, camera._zoom*camera._zoom_aspect)
	love.graphics.translate(-camera._originPt.x, -camera._originPt.y)

	self._nodes:toBegin()
	while true do
		local node = self._nodes:getCurrent()

		node:draw()

		if camera._debug == true then
			node:_debugDraw()
		end
		
		if self._nodes:isEnd() then
			break
		end
		self._nodes:toNext()
	end

	love.graphics.pop()
end

function Layer:update(dt)
end

return Layer
