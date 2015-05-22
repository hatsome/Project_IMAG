function game_load()
    offY = 200
    bullets = {}
    meteors = {}
    particles = {}

    collision_load()
    player = Player(vector(love.window.getWidth()/2, 950))
    meteorSpawner = MeteorSpawner(vector(love.window.getWidth()/2, -offY), vector(0, 1), 0, love.window.getWidth())
end

function game_update(dt)
    for i, bullet in pairs(bullets) do 
        bullet:update(dt)

        if bullet.destroy or bullet.pos.y < -offY or bullet.pos.y > love.window.getHeight() + offY then 
            bullets[i] = nil
        end
    end

    if player then 
        player:update(dt)

        if player.destroy then
            player = nil 
        end
    end 

    meteorSpawner:update(dt)

    for i, meteor in pairs(meteors) do 
        meteor:update(dt)

        if meteor.destroy or meteor.pos.y < -offY or meteor.pos.y > love.window.getHeight() + offY then 
            meteors[i] = nil
        end
    end

    collision_update(dt)

    for i, particle in pairs(particles) do
        particle:update(dt)

        if particle.destroy or particle.pos.y < -offY or particle.pos.y > love.window.getHeight() + offY then 
            particles[i] = nil
        end
    end
end

function game_draw()
    for i, particle in pairs(particles) do
        particle:draw()
    end

    for i, bullet in pairs(bullets) do 
        bullet:draw()
    end 

    if player then 
        player:draw()
    end

    for i, meteor in pairs(meteors) do 
        meteor:draw()
    end

    --collision_draw()
end