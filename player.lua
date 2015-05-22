Player = Class{}

function Player:init(x, y)
    self.img = {  love.graphics.newImage("graphics/player.png"), 
                  love.graphics.newImage("graphics/playerLeft.png"), 
                  love.graphics.newImage("graphics/playerRight.png")}
    self.imgIndex = 1
    self.pos = vector(x, y)
    self.vel = vector(0, 0)
    self.acc = vector(0, 0)
    self.maxVel = 400
    self.minVel = 0.5
    self.friction = 0.9
end

function Player:update(dt)
    if love.keyboard.isDown('a') then
        self.acc.x = -1200
        self.imgIndex = 2
    elseif love.keyboard.isDown('d') then
        self.acc.x = 1200
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
end

function Player:draw()
    love.graphics.draw(self.img[self.imgIndex], self.pos.x-self.img[self.imgIndex]:getWidth()/2 , self.pos.y-self.img[self.imgIndex]:getWidth()/2)
end