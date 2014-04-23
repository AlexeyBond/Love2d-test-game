local Node = {}

function Node.new()
	print("Node.new() called")

	local node = {}

	node._rect = {
		x = 0,
		y = 0,
		width = 0,
		height = 0
	}

	node._originPt = {x = 0, y = 0}

	function node:debugDraw()
		love.graphics.setColor( 128, 200, 200, 100 )
		love.graphics.rectangle( "fill", self._rect.x, self._rect.y, self._rect.width, self._rect.height )
		love.graphics.setColor( 128, 200, 200, 200 )
		love.graphics.rectangle( "line", self._rect.x, self._rect.y, self._rect.width, self._rect.height )
	end

	function node:draw()

	end

	function node:move(dx, dy)
		self._originPt.x = self._originPt.x + dx
		self._originPt.y = self._originPt.y + dy
		self._rect.x = self._rect.x + dx
		self._rect.y = self._rect.y + dy
	end


	function node:moveTo(x, y)
		self._originPt.x = x
		self._originPt.y = y
		self._rect.x = x
		self._rect.y = y
	end

	return node
end

return Node