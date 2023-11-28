local tick = require "librerias.tick"
local anchoPantalla = love.graphics.getWidth()
local altoPatalla = love.graphics.getHeight()
-- 720 x 600

function love.load()
    Class = require "librerias.classic"

    require "nave"
    require "bullet"
    require "enemigo"
        require "meteoro"
    require "coin"

    Player = Nave(200, altoPatalla/2, 300, 500, 300)
    Score = 0
    Balas = {}

    MaxMeteo = 3
    MeteoroList = {}

    SizeTypes = {"m", "mg"}
    MoveTypes = {"r","d", "di"}

    tick.recur(
        function ()
            table.insert(MeteoroList, Meteoro(anchoPantalla + love.math.random(250,500), love.math.random(-250,altoPatalla+250), 100, "s", MoveTypes[love.math.random(1,3)]))
            table.insert(MeteoroList, Meteoro(anchoPantalla + love.math.random(250,500), love.math.random(-250,altoPatalla+250), 100, "s", MoveTypes[love.math.random(1,3)]))
            table.insert(MeteoroList, Meteoro(anchoPantalla + love.math.random(250,500), love.math.random(-250,altoPatalla+250), 100, "s", MoveTypes[love.math.random(1,3)]))
        end
        ,
        love.math.random(0.4,1.2)
    )

    tick.delay(
        function ()
            tick.recur(
                function ()
                    table.insert(MeteoroList, Meteoro(anchoPantalla + love.math.random(250,500), love.math.random(-250,altoPatalla+250), love.math.random(50,250), SizeTypes[love.math.random(1,2)], MoveTypes[love.math.random(1,3)]))
                    table.insert(MeteoroList, Meteoro(anchoPantalla + love.math.random(250,500), love.math.random(-250,altoPatalla+250), love.math.random(50,250), SizeTypes[love.math.random(1,2)], MoveTypes[love.math.random(1,3)]))
                    table.insert(MeteoroList, Meteoro(anchoPantalla + love.math.random(250,500), love.math.random(-250,altoPatalla+250), love.math.random(50,250), SizeTypes[love.math.random(1,2)], MoveTypes[love.math.random(1,3)]))
                end
                ,
                love.math.random(0.4,1.2)
            )
        end
        , 15
    )

    local maxCoin = 20
    CoinList = {}

   for i = 1, maxCoin do
        table.insert(CoinList, Coin(love.math.random(100, anchoPantalla - 50), love.math.random(50, altoPatalla - 50), "s"))
    end
--[[
    table.insert(CoinList, Coin(800, 300, "s"))
    table.insert(CoinList, Coin(900, 350, "s"))]]
     --, Coin(850, 300, "s"), Coin(900, 300, "s"), Coin(950, 300, "s")

    Fuente = love.graphics.newFont("assets/font/kenvector_future.ttf")
end

function love.keypressed(key)
    if #Balas < 7 then
        if key == "z" or key == "return" then
            table.insert(Balas, Bullet(Player.x, Player.y))
        end
    end
end

function love.update(dt)
    tick.update(dt)
    Player:update(dt)

    -- Actualizamos la posicion de cada bala
    for i, v in ipairs(Balas) do
        v:update(dt)

        for j, m in ipairs(MeteoroList) do
            if v:checkColision(m) then
                Score = Score + m.value
                table.remove(MeteoroList, j)
                table.remove(Balas, i)
            end
        end

        -- Calcula la distancia maxima antes de eliminar el disparo
        local distancia_nave = v.rango + Player.x
        if v.x > distancia_nave then
            table.remove(Balas, i)
        end
    end

    for i, v in ipairs(MeteoroList) do
        v:update(dt)
        Player:reciveDano(v, dt)

        if Player.vidas <= 0 then
            love.load() -- Reinicia el juego al acabarse la vida del jugador
        end
    end

    for i, c in ipairs(CoinList) do
        c:update(dt)

        if Player:checkColision(c) then
            Score = Score + c.value
            table.remove(CoinList, i)
        end
    end

    --  Eliminacion de objetos mas alla de la pantalla
    for i, v in ipairs(MeteoroList) do
        if v.x < -anchoPantalla or v.y < -altoPatalla or v.y > altoPatalla*2 then
            table.remove(MeteoroList, i)
        end
    end

    for i, v in ipairs(CoinList) do
        if v.x < -anchoPantalla then
            table.remove(CoinList, i)
        end
    end
end

function love.draw()
    love.graphics.print("Score: " .. Score, Fuente, 10)

    -- Dibujamos cada bala
    for i, v in ipairs(Balas) do
        v:draw()
    end

    -- Se dibuja al player de ultima para que aparezca encima de las balas
    Player:draw()

    for i, v in ipairs(MeteoroList) do
        v:draw()
    end

    for i, c in ipairs(CoinList) do
        c:draw()
    end
end