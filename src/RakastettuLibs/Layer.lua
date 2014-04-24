rkstlib.list = require "RakastettuLibs.List"

local Layer = {}

function Layer.new()
	print("Layer.new() called")

	local layer = {}

	layer._nodes = rkstlib.list.new()


	function layer:addNode(node)
		print("layer:addNode(node) called")
		self._nodes:insert(node)
	end

	function layer:draw(camera)
		if self._nodes:isEmpty() then
			return
		end

		love.graphics.push()
		love.graphics.translate(camera._sizes.width/2 - camera._originPt.x,
				camera._sizes.height/2 - camera._originPt.y)
		love.graphics.rotate(camera._angle)
		love.graphics.scale(camera._zoom/camera._zoom_aspect, camera._zoom*camera._zoom_aspect)

		self._nodes:toBegin()
		while true do
			local node = self._nodes:getCurrent()

			node:_debugDraw()
			node:draw()
			if self._nodes:isEnd() then
				break
			end
			self._nodes:toNext()
		end

		love.graphics.pop()
	end

	function layer:update(dt)

	end

	return layer
end

return Layer
