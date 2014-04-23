local Layer = {}

function Layer.new()
	print("Layer.new() called")

	local layer = {}

	layer._nodes = dofile("List.lua").new()

	function layer:debugDraw( )
		self._nodes.toBegin()
		local nod

		while (nod = self._nodes.getCurrent()) ~= nil do -- FIXME if syntax is wrong.
			nod.debugDraw( )
			self._nodes.toNext( )
		end

		love.graphics.setColor( 255, 255, 255, 255 ) -- Reset color state.
	end

	function layer:draw(camera)
		self._nodes.toBegin()
		local nod

		while (nod = self._nodes.getCurrent()) ~= nil do
			nod.draw( )
			self._nodes.toNext( )
		end

		if camera._debug then
			self.debugDraw( )
		end
	end

	function layer:update(dt)

	end

	return layer
end

return Layer