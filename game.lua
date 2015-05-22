function game_load()
    offY = 200
    bullets = {}
    meteors = {}
    player = Player(vector(love.window.getWidth()/2, 950))
    meteorSpawner = MeteorSpawner(vector(love.window.getWidth()/2, -offY), vector(0, 1), 0, love.window.getWidth())
end

function game_update(dt)
    for i, bullet in ipairs(bullets) do 
        bullet:update(dt)

        if bullet.pos.y < -offY or bullet.pos.y > love.window.getHeight() + offY then 
            table.remove(bullets, i)
        end
    end 

    player:update(dt)

    meteorSpawner:update(dt)

    for i, meteor in ipairs(meteors) do 
        meteor:update(dt)

        if meteor.pos.y < -offY or meteor.pos.y > love.window.getHeight() + offY then 
            table.remove(meteors, i)
        end
    end
end

function game_draw()
    for i, bullet in ipairs(bullets) do 
        bullet:draw()
    end 

    player:draw()

    for i, meteor in ipairs(meteors) do 
        meteor:draw()
    end
end