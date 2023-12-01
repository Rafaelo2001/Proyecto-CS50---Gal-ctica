Orden = Class:extend()
local anchoPantalla = love.graphics.getWidth()
local altoPatalla = love.graphics.getHeight()

    require "enemigo"
        require "meteoro"
    require "coin"

    function Orden:uno()
        print("aa")
        table.insert(MeteoroList, Meteoro(anchoPantalla + love.math.random(250,500), love.math.random(-250,altoPatalla+250), 100, "s", MoveTypes[love.math.random(1,3)]))
        table.insert(MeteoroList, Meteoro(anchoPantalla + love.math.random(250,500), love.math.random(-250,altoPatalla+250), 100, "s", MoveTypes[love.math.random(1,3)]))
        table.insert(MeteoroList, Meteoro(anchoPantalla + love.math.random(250,500), love.math.random(-250,altoPatalla+250), 100, "s", MoveTypes[love.math.random(1,3)]))
    end