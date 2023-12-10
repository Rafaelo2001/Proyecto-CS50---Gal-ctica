local tick = require "librerias.tick"
local anchoPantalla = love.graphics.getWidth()
local altoPatalla = love.graphics.getHeight()
-- 720 x 600

function love.load()
    GameOver = false
    Class = require "librerias.classic"

    require "nave"
    require "bullet"
    require "enemigo"
        require "meteoro"
    require "coin"
    require "meteorosDisplay"

    Player = Nave(200, altoPatalla/2, 300, 500, 300)
    OrdenM = Orden()
    Score = 0
    Balas = {}

    MaxMeteo = 3
    MeteoroList = {}

    SizeTypes = {"m", "mg", "b", "t", "s"}
    MoveTypes = {"r", "r", "r", "r", "r", "r", "d", "di"}



    local maxCoin = 20
    CoinList = {}

    -- OrdenM:Panel6()

    -- todo bien
    OrdenM:Panel1()
    tick.delay(
        function ()
            OrdenM:Panel2()
        end,
        4
    )
    tick.delay(
        function ()
            OrdenM:Panel3()
        end,
        8
    )
    tick.delay(
        function ()
            OrdenM:Panel6()
        end,
        10
    )
    tick.delay(
        function ()
            OrdenM:Panel4()
        end,
        18
    )

    tick.delay(
        function ()
            tick.recur(
                function ()
                    OrdenM:uno()
                    OrdenM:dos()
                end
                ,
                love.math.random(0.4,1.2)
            )
            end
        , 23
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
        , 25
    )

    

    -- tick.recur(
    --     function ()
    --         table.insert(CoinList, Coin(anchoPantalla + love.math.random(100,200), love.math.random(0, altoPatalla), "s"))
    --     end
    --     , 0.5
    -- )

     
--    for i = 1, maxCoin do
--         table.insert(CoinList, Coin(love.math.random(100, anchoPantalla - 50), love.math.random(50, altoPatalla - 50), "s"))
--     end

--     table.insert(CoinList, Coin(800, 300, "s"))
--     table.insert(CoinList, Coin(900, 350, "s"))
--      , Coin(850, 300, "s"), Coin(900, 300, "s"), Coin(950, 300, "s")

    Fuente = love.graphics.newFont("assets/font/kenvector_future.ttf")
    GOFont = love.graphics.newFont("assets/font/kenvector_future.ttf", 35)
end

function love.keypressed(key)
    if Score < 1500 then
        if #Balas < 7 then
            if key == "z" or key == "return" then
                table.insert(Balas, Bullet(Player.x, Player.y, "l1"))
            end
        end
    elseif Score >= 1500 and Score < 3000 then
        if #Balas < 11 then
            if key == "z" or key == "return" then
                table.insert(Balas, Bullet(Player.x, Player.y, "l2"))
                print("l2")
            end
        end
    elseif Score >= 3000  then
        if #Balas < 15 then
            if key == "z" or key == "return" then
                table.insert(Balas, Bullet(Player.x, Player.y, "l3"))
                print("l3")
            end
        end
    end
end

function love.update(dt)

    if GameOver == true then
        -- Al activarse esta funcion, dejamos de actualizar la logica
    else

        tick.update(dt)
        Player:update(dt)

        -- Actualizamos la posicion de cada bala
        for i, v in ipairs(Balas) do
            v:update(dt)

            for j, m in ipairs(MeteoroList) do
                if v:checkColision(m) then
                    m.vida = m.vida - v.damage
                    table.remove(Balas, i)
                    if m.vida <= 0 then
                        Score = Score + m.value
                        table.remove(MeteoroList, j)
                        table.remove(Balas, i)
                    end
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
                GameOver = true
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
end

function love.draw()
    if GameOver == true then
        love.graphics.printf("GAME OVER",             GOFont, 0, altoPatalla/2 - 35, anchoPantalla, "center")
        love.graphics.printf("Your Score: " .. Score, Fuente, 0, altoPatalla/2,      anchoPantalla, "center")

        love.graphics.printf("This text is aligned right, and wraps when it gets too big.", 25, 25, 125, "right")
    else

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

        Player:drawLife()

    end
end