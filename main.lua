local tick = require "librerias.tick"

function love.load()
    Class = require "librerias.classic"

    require "nave"
    require "bullet"
    require "enemigo"
        require "meteoro"

    Player = Nave(200, 200, 300, 500, 300)
    Balas = {}

    MaxMeteo = 3
    MeteoroList = {}

    tick.delay(
        function ()
            table.insert(MeteoroList, Meteoro(600,-150, 120, "assets/enemy/meteoro1.png", "d"))
            table.insert(MeteoroList, Meteoro(750,-150, 100, "assets/enemy/meteoro1.png", "d"))
            table.insert(MeteoroList, Meteoro(900,-150, 80, "assets/enemy/meteoro1.png", "d"))
        end
        , .5
    )

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
    end
end

function love.draw()
    love.graphics.print("Hola", Fuente, 10)

    -- Dibujamos cada bala
    for i, v in ipairs(Balas) do
        v:draw()
    end

    -- Se dibuja al player de ultima para que aparezca encima de las balas
    Player:draw()

    for i, v in ipairs(MeteoroList) do
        v:draw()
    end
end