Enemy = Class{}

function Enemy:init(pos, dir)
    self.type = 'enemy'
    self.img = love.graphics.newImage('graphics/enemy.png')
    self.pos = pos
    self.vel = vector(0, 0)
    self.dir = dir
    self.speed = 200
    self.live = 4
    self.cannons = { Cannon(vector(0, 1):normalized(), 0.3, self, 0, 60, love.graphics.newImage('graphics/bulletEnemy.png'), 'bulletEnemy', 1) }
    self.shoot = false
    self.shootProb = 0
    self.c = CircleCollider(40, self, 0, 0)
    self.destroy = false
    self.ampl = love.math.random() * 200 + 1
end

function Enemy:update(dt)
    self.vel = self.dir * self.speed

    self.pos = self.pos + self.vel*dt

    self.pos.x = self.pos.x + (self.ampl*math.cos(self.pos.y/80))*dt

    if self.live <= 0 and self.destroy == false then 
        self.destroy = true
        self:createExpParticle()
        game_shakeCam(30, 30, 10)
    end

    if player then 
        if self.pos.x >= player.pos.x - 50 and self.pos.x <= player.pos.x + 50 then 
            self.shootProb = 0.8 
        else 
            self.shootProb = 0.1
        end 
    end 

    if love.math.random() * 1.0 + 0.1 <= self.shootProb then
        self.shoot = true 
    else 
        self.shoot = false 
    end

    if self.shoot then
        for i, cannon in ipairs(self.cannons) do 
            cannon:shoot()
        end
    end

    for i, cannon in ipairs(self.cannons) do 
        cannon:update(dt)
    end
end

function Enemy:draw()
    love.graphics.draw(self.img, self.pos.x, self.pos.y, 0, 1, 1, self.img:getWidth()/2, self.img:getHeight()/2)
end

function Enemy:hit(obj)
    if obj.type == 'bullet' then
        self.live = self.live -1
        game_shakeCam(5, 5, 5)
    elseif obj.type == 'player' then 
        self.live = 0
    end 
end

function Enemy:createExpParticle()
    local particle = Particle(love.graphics.newParticleSystem(love.graphics.newImage('graphics/smoke.png'), 5), self.pos, 1, self)
    particle.system:setParticleLifetime(0.9, 0.9)
    particle.system:setEmissionRate(100)
    particle.system:setEmitterLifetime(0.1)
    particle.system:setSizes(0.2, 0.4)
    particle.system:setSpeed(10, 15)
    particle.system:setSpread(2 * math.pi)
    particle.system:setColors(255, 255, 255, 255, 255, 255, 255, 0)
    table.insert(particles, particle)

    particle = Particle(love.graphics.newParticleSystem(love.graphics.newImage('graphics/explosion.png'), 5), self.pos, 1, self)
    particle.system:setParticleLifetime(1, 1)
    particle.system:setEmissionRate(100)
    particle.system:setEmitterLifetime(0.1)
    particle.system:setSizes(0.1, 0.3)
    particle.system:setSpeed(5, 10)
    particle.system:setSpread(2 * math.pi)
    particle.system:setColors(255, 255, 255, 255, 255, 255, 255, 0)
    table.insert(particles, particle)
end