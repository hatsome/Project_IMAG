function game_load()
    player = Player(love.window.getWidth()/2, 950)
end

function game_update(dt)
    player:update(dt)
end

function game_draw()
    player:draw()
end