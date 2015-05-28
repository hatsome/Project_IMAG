io.stdout:setvbuf('no')

function love.load()
    Class = require 'class'
    vector = require 'vector'
    camera = require 'camera'
    require 'game'
    require 'player'
    require 'enemy'
    require 'bullet'
    require 'cannon'
    require 'meteor'
    require 'meteorSpawner'
    require 'enemySpawner'
    require 'collision'
    require 'circleCollider'
    require 'particle'

    game_load()
end

function love.update(dt)
    game_update(dt)
end

function love.draw()
    game_draw()
end