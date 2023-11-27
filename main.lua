local tick = require "librerias.tick"
local anchoPantalla = love.graphics.getWidth()
local altoPatalla = love.graphics.getHeight()

function love.load()
    Class = require "librerias.classic"

    require "nave"
    require "bullet"
    require "enemigo"
        require "meteoro"
    require "coin"

    Player = Nave(200, 200, 300, 500, 300)
    Score = 0
    Balas = {}

    MaxMeteo = 3
    MeteoroList = {}

    tick.delay(
        function ()
            table.insert(MeteoroList, Meteoro(anchoPantalla + 100, altoPatalla/2, 100, "s", "r"))
            table.insert(MeteoroList, Meteoro(anchoPantalla + 250, altoPatalla/2, 100, "s", "r"))
            table.insert(MeteoroList, Meteoro(anchoPantalla + 400, altoPatalla/2, 100, "s", "r"))
        end
        , .5
    )

    local maxCoin = 20
    CoinList = {}

    for i = 1, maxCoin do
        table.insert(CoinList, Coin(love.math.random(100,love.graphics.getWidth() - 50), love.math.random(50, love.graphics.getHeight() - 50), "s"))
    end

    Fuente = love.graphics.newFont("assets/font/kenvector_future.ttf")

    Moneda_test = Coin(500, 500, "s")
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
            print("Money tocao")
            Score = Score + c.value
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