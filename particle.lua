Particle = Class{}

function Particle:init(system, pos, lifeTime, parent)
	self.system = system 
	self.pos = pos
	self.lifeTime = lifeTime
	self.parent = parent
	self.destroy = false
end

function Particle:update(dt)
	if self.lifeTime ~= -1 then 
		self.lifeTime = self.lifeTime - (1 * dt)
		if self.lifeTime <= 0 then 
			self.destroy = true 
		end
	end

	if self.parent ~= nil then 
		self.pos = self.parent.pos 
	end

	self.system:update(dt)
end

function Particle:draw()
	love.graphics.draw(self.system, self.pos.x, self.pos.y)
end