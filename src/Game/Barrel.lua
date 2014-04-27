local class = require "bartbes.SECS.full"
rkstlib.texturedNode = require "RakastettuLibs.TexturedNode"

local Barrel = class:new()
Barrel:addparent(rkstlib.texturedNode)

function Barrel:init( texture, minx, maxx )
	rkstlib.texturedNode.init(
		self,
		{x=math.random(minx,maxx), y=math.random(-100,100)},
		null, 0, texture)
	self._radius = (texture:getHeight()+texture:getWidth())*0.25
	self._alive = true
	self._hitted = false
	self._velocity = {x=0,y=0}
	self._countdown = 10000.0
	--self._angle = math.random( 0, 2*math.pi)
end

function Barrel:draw( )
	if self._alive then
		rkstlib.texturedNode.draw( self )
	end
end

function Barrel:_debugDraw()
	love.graphics.push( )
	love.graphics.translate( self._originPt.x, self._originPt.y )
	love.graphics.rotate( self._angle )
	love.graphics.setColor(200, 80, 80, 20)
	love.graphics.rectangle("fill", -self._rect.left, -self._rect.top,
		self._rect.left+self._rect.right, self._rect.top+self._rect.bottom)
	love.graphics.setColor(200, 80, 80, 200)
	love.graphics.rectangle("line", -self._rect.left, -self._rect.top,
		self._rect.left+self._rect.right, self._rect.top+self._rect.bottom)
	love.graphics.circle("line", 0,0, self._radius, 100)
	love.graphics.setColor(255, 120, 120, 255)
	love.graphics.setLineWidth(0.2)
	local cross_size = 2
	love.graphics.line(cross_size, cross_size, -cross_size, -cross_size)
	love.graphics.line(cross_size, -cross_size, -cross_size, cross_size)
	love.graphics.pop( );
end

function Barrel:update( dt )
	if not self._alive then
		return
	end

	if self._velocity.x ~= 0 or self._velocity.y ~= 0 then
		local dx = self._velocity.x * dt
		local dy = self._velocity.y * dt
		local da = self._angle_velocity * dt

		self._angle = self._angle + da
		self._originPt.x = self._originPt.x + dx
		self._originPt.y = self._originPt.y + dy

		self._countdown = self._countdown - math.sqrt(dx*dx+dy*dy)

		if self._countdown <= 0 then
			self._alive = false
		end
	end
end

function Barrel:hit( player )
	if self._hitted then
		return
	end
	self._velocity.x = self._originPt.x - player._originPt.x
	self._velocity.y = self._originPt.y - player._originPt.y

	local k = 1000/math.sqrt(self._velocity.x^2+self._velocity.y^2)

	self._velocity.x = self._velocity.x * k
	self._velocity.y = self._velocity.y * k

	self._angle_velocity = math.random( -math.pi, math.pi )

	player._v = 0.4 * player._v

	self._hitted = true
end

return Barrel
