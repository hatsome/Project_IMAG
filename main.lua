io.stdout:setvbuf('no')

function love.load()
    Class = require 'class'
    vector = require 'vector'
    require 'game'
    require 'player'
    require 'bullet'
    require 'cannon'

    time = 0

    game_load()
end

function love.update(dt)
    game_update(dt)
end

function love.draw()
    game_draw()
end