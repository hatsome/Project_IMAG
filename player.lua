Player = Class{}

function Player:init(pos)
    self.type = 'player'
    self.img = {  love.graphics.newImage('graphics/player.png'), 
                  love.graphics.newImage('graphics/playerLeft.png'), 
                  love.graphics.newImage('graphics/playerRight.png')}
    self.imgIndex = 1
    self.pos = pos
    self.vel = vector(0, 0)
    self.acc = vector(0, 0)
    self.maxVel = 400
    self.minVel = 0.5
    self.friction = 0.9
    self.speed = 1200
    self.cannons = { Cannon(vector(0, -1):normalized(), 0.1, self, 0, -60, love.graphics.newImage('graphics/bullet.png'), 'bullet', 1)}
    self.c = CircleCollider(30, self, 0, 0)
    self.destroy = false
    self:createEngineParticle()
end

function Player:update(dt)
    if love.keyboard.isDown('a') then
        self.acc.x = -self.speed 
        self.imgIndex = 2
    elseif love.keyboard.isDown('d') then
        self.acc.x = self.speed
        self.imgIndex = 3
    else 
        self.acc.x = 0
        self.imgIndex = 1
    end
    
    self.vel = self.vel + self.acc * dt
    
    self.vel = self.vel * (1 - math.min(self.friction*dt, 1))

    if self.vel:len() > self.maxVel then 
        self.vel = self.vel:normalized() * self.maxVel
    end

    if self.vel:len() < self.minVel then
        self.vel = self.vel:normalized() * 0
    end 

    self.pos = self.pos + self.vel * dt

    if self.pos.x <= self.img[self.imgIndex]:getWidth()/2 then
        self.vel = self.vel:normalized() * 0
        self.pos.x = self.img[self.imgIndex]:getWidth()/2
    elseif self.pos.x >= love.graphics.getWidth() - self.img[self.imgIndex]:getWidth()/2 then 
        self.vel = self.vel:normalized() * 0
        self.pos.x = love.graphics.getWidth() - self.img[self.imgIndex]:getWidth()/2
    end

    if love.keyboard.isDown('w') then
        for i, cannon in ipairs(self.cannons) do 
            cannon:shoot()
        end
    end

    for i, cannon in ipairs(self.cannons) do 
        cannon:update(dt)
    end
end

function Player:draw()
    love.graphics.draw(self.img[self.imgIndex], self.pos.x, self.pos.y, 0, 1, 1, self.img[self.imgIndex]:getWidth()/2, self.img[self.imgIndex]:getHeight()/2)
end

function Player:hit(obj)
    gameOver = true
    self.destroy = true
    self.particle.destroy = true
    self:createExpParticle()
    game_shakeCam(60, 60, 20)
end

function Player:createEngineParticle()
    self.particle = Particle(love.graphics.newParticleSystem(love.graphics.newImage('graphics/fire.png'), 200), self.pos, -1, self)
    self.particle.system:setParticleLifetime(0.5, 0.3)
    self.particle.system:setEmissionRate(100)
    self.particle.system:setSpeed(250)
    self.particle.system:setLinearAcceleration(0, 0, 0, 0)
    self.particle.system:setDirection(math.pi /2)
    self.particle.system:setSizes(0.4, 0.05)
    self.particle.system:setColors(255, 255, 255, 255, 255, 255, 255, 0)
    table.insert(particles, self.particle)
end

function Player:createExpParticle()
    local particle = Particle(love.graphics.newParticleSystem(love.graphics.newImage('graphics/smoke.png'), 5), self.pos, 1, self)
    particle.system:setParticleLifetime(0.9, 0.9)
    particle.system:setEmissionRate(100)
    particle.system:setEmitterLifetime(0.1)
    particle.system:setSizes(0.5, 0.7)
    particle.system:setSpeed(10, 15)
    particle.system:setSpread(2 * math.pi)
    particle.system:setColors(255, 255, 255, 255, 255, 255, 255, 0)
    table.insert(particles, particle)

    particle = Particle(love.graphics.newParticleSystem(love.graphics.newImage('graphics/explosion.png'), 5), self.pos, 1, self)
    particle.system:setParticleLifetime(1, 1)
    particle.system:setEmissionRate(100)
    particle.system:setEmitterLifetime(0.1)
    particle.system:setSizes(0.3, 0.5)
    particle.system:setSpeed(5, 10)
    particle.system:setSpread(2 * math.pi)
    particle.system:setColors(255, 255, 255, 255, 255, 255, 255, 0)
    table.insert(particles, particle)
end