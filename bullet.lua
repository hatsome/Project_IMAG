Bullet = Class{}

function Bullet:init(type, pos, dir, img, scale)
	self.type = type
	self.img = img
	self.pos = pos 
	self.vel = vector(0, 0)
	self.dir = dir
	self.speed = 800
	self.c = CircleCollider((self.img:getWidth()*scale)/2, self, 0, 0)
	self.scale = scale
	self.destroy = false
end

function Bullet:update(dt)
	self.vel = self.dir * self.speed

	self.pos = self.pos + self.vel*dt
end 

function Bullet:draw()
	love.graphics.draw(self.img, self.pos.x, self.pos.y, 0, self.scale, self.scale, self.img:getWidth()/2, self.img:getHeight()/2)
end

function Bullet:hit(obj)
	if (self.type == 'bullet' and obj.type == 'enemy') or (self.type == 'bulletEnemy' and obj.type == 'player') or obj.type == 'bullet' then
		self.destroy = true
    	self:createParticle()
	end 
end

function Bullet:createParticle()
	local particle = Particle(love.graphics.newParticleSystem(self.img, 100), self.pos, 1)
	particle.system:setSizes(0.2)
	particle.system:setParticleLifetime(0.1, 0.2)
	particle.system:setEmissionRate(100)
	particle.system:setEmitterLifetime(0.3)
	particle.system:setSpeed(450, 650)
	particle.system:setLinearAcceleration(0, 0, 0, 0)
	particle.system:setDirection(vector(1, 0):angleTo(self.dir))
	particle.system:setSpread(math.pi/2)
	particle.system:setColors(255, 255, 255, 255, 255, 255, 255, 0)
	table.insert(particles, particle)
end