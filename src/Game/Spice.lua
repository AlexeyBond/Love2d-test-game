Game.Barrel = require "Game.Barrel"

local Spice = class:new()
Spice:addparent(Game.Barrel)

function Spice:hit( player )
	if self._alive then
		Game.Score = Game.Score+(math.random(1, 10))
	end
	self._alive = false
end

return Spice