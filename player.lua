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
    self.cannons = { Cannon(vector(0, -1):normalized(), self, 0, -60) }
    self.destroy = false
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