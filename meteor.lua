Meteor = Class{}

function Meteor:init(pos, dir)
	self.type = 'enemy'
	self.img = love.graphics.newImage('graphics/meteorBig.png')
	self.pos = pos 
	self.vel = vector(0, 0)
	self.dir = dir
	self.speed = 300
	self.rot = 0
	self.rotSpeed = 1
	self.c = CircleCollider(50, self, 0, 0)
	self.live = 3
	self.destroy = false
end

function Meteor:update(dt)
	self.vel = self.dir * self.speed

	self.pos = self.pos + self.vel*dt

	self.rot = self.rot + self.rotSpeed *dt

	if self.live <= 0 and self.destroy == false then 
		self.destroy = true
		self:createParticle()
	end
end

function Meteor:draw()
	love.graphics.draw(self.img, self.pos.x, self.pos.y, self.rot, 1, 1, self.img:getWidth()/2, self.img:getHeight()/2)
end

function Meteor:hit(obj)
	if obj.type == 'bullet' then
		self.live = self.live -1
	else 
		self.live = 0
	end 
end

function Meteor:createParticle()
	local particle = Particle(love.graphics.newParticleSystem(love.graphics.newImage('graphics/meteorSmall.png'), 10), self.pos, 1)
	particle.system:setParticleLifetime(1, 1)
	particle.system:setEmissionRate(100)
	particle.system:setEmitterLifetime(0.1)
	particle.system:setSpeed(450, 650)
	particle.system:setLinearAcceleration(0, 0, 0, 0)
	particle.system:setSpread(2 * math.pi)
	particle.system:setColors(255, 255, 255, 255, 255, 255, 255, 0)
	table.insert(particles, particle)
end