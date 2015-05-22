function game_load()
    bullets = {}
    player = Player(vector(love.window.getWidth()/2, 950))
end

function game_update(dt)
    for i, bullet in ipairs(bullets) do 
        bullet:update(dt)

        if bullet.pos.y < -40 or bullet.pos.y > love.window.getHeight() + 40 then 
            table.remove(bullets, i)
        end
    end 
    player:update(dt)
end

function game_draw()
    for i, bullet in ipairs(bullets) do 
        bullet:draw()
    end 
    player:draw()
end