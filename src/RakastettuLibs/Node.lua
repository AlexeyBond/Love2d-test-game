local Node = {}

function Node.new()
	print("Node.new() called")

	local node = {}

	node._rect = {
		top = 0,
		bottom = 0,
		left = 0,
		right = 0
	}

	node._originPt = {x = 0, y = 0}

	function node:draw()

	end

	function node:move(dx, dy)
		self._originPt.x = self._originPt.x + dx
		self._originPt.y = self._originPt.y + dy
	end


	function node:moveTo(x, y)
		self._originPt.x = x
		self._originPt.y = y
	end

	return node
end

return Node