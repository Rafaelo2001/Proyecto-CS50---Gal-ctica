love.window.setTitle("Project Galáctica")

local tick = require "librerias.tick"
local anchoPantalla = love.graphics.getWidth()
local altoPatalla = love.graphics.getHeight()
-- 720 x 600

function love.load()
    -- 0 - Start Screen
    -- 1 - Game Screen
    -- 2 - Game Over Screen
    GameState = 0
    Class = require "librerias.classic"

    require "librerias.estrellas"
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

    StarLoad()

    MaxMeteo = 3
    MeteoroList = {}

    SizeTypes = {"m", "mg", "b", "t", "s"}
    MoveTypes = {"r", "r", "r", "r", "r", "r", "d", "di"}



    local maxCoin = 20
    CoinList = {}

    -- Meteoros por esquivar
    MetoeGroup = tick.group()

        MetoeGroup:delay(function () OrdenM:Panel1() end,0)
        MetoeGroup:delay(
            function ()
                OrdenM:Panel2()
            end,
            4
        )
        MetoeGroup:delay(
            function ()
                OrdenM:Panel3()
            end,
            8
        )
        MetoeGroup:delay(
            function ()
                OrdenM:Panel6()
            end,
            10
        )
        MetoeGroup:delay(
            function ()
                OrdenM:Panel4()
            end,
            18
        )

        MetoeGroup:delay(
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
            , 26
        )

        MetoeGroup:delay(
            function ()
                tick.recur(
                    function ()
                        table.insert(MeteoroList, Meteoro(anchoPantalla + love.math.random(250,700), love.math.random(-250,altoPatalla+250), love.math.random(250,700), SizeTypes[love.math.random(1,5)], "r"))
                        table.insert(MeteoroList, Meteoro(anchoPantalla + love.math.random(250,700), love.math.random(-250,altoPatalla+250), love.math.random(250,700), SizeTypes[love.math.random(1,5)], "r"))
                        table.insert(MeteoroList, Meteoro(anchoPantalla + love.math.random(250,700), love.math.random(-250,altoPatalla+250), love.math.random(250,700), SizeTypes[love.math.random(1,5)], "r"))
                        table.insert(MeteoroList, Meteoro(anchoPantalla + love.math.random(250,700), love.math.random(-250,altoPatalla+250), love.math.random(250,700), SizeTypes[love.math.random(1,5)], "r"))
                        table.insert(MeteoroList, Meteoro(anchoPantalla + love.math.random(250,700), love.math.random(-250,altoPatalla+250), love.math.random(250,700), SizeTypes[love.math.random(1,5)], "r"))
                        table.insert(MeteoroList, Meteoro(anchoPantalla + love.math.random(250,700), love.math.random(-250,altoPatalla+250), love.math.random(250,700), SizeTypes[love.math.random(1,5)], "r"))
                    end
                    ,
                    love.math.random(0.4,1.2)
                )
            end
            , 50
        )

    -- Fuentes
    Fuente   = love.graphics.newFont("assets/font/kenvector_future.ttf")
    GOFont   = love.graphics.newFont("assets/font/kenvector_future.ttf", 35)
    LiveFont = love.graphics.newFont("assets/font/kenvector_future.ttf", 20)

    -- Imagenes
    Logo      = love.graphics.newImage("assets/main_logo.png")
    Arrow_key = love.graphics.newImage("assets/arrow_key.png")
    Space_key = love.graphics.newImage("assets/space_key.png")
    Z_key     = love.graphics.newImage("assets/z_key.png")

    -- Sonidos
    S_shoot1 = love.audio.newSource("assets/sfx/sfx_laser1.ogg", "static")
    S_shoot2 = love.audio.newSource("assets/sfx/sfx_laser2.ogg", "static")
end

function love.keypressed(key)
    if GameState == 0 and key == "space" then
        GameState = 1
    elseif GameState == 1 then
        if Score < 1500 then
            if #Balas < 7 then
                if key == "z" or key == "return" then
                    love.audio.stop(S_shoot1)
                    table.insert(Balas, Bullet(Player.x, Player.y, "l1"))
                    love.audio.play(S_shoot1)
                end
            end
        elseif Score >= 1500 and Score < 3000 then
            if #Balas < 11 then
                if key == "z" or key == "return" then
                    love.audio.stop(S_shoot1)
                    table.insert(Balas, Bullet(Player.x, Player.y, "l2"))
                    love.audio.play(S_shoot1)
                end
            end
        elseif Score >= 3000  then
            if #Balas < 15 then
                if key == "z" or key == "return" then
                    love.audio.stop(S_shoot2)
                    table.insert(Balas, Bullet(Player.x, Player.y, "l3"))
                    love.audio.play(S_shoot2)
                end
            end
        end
    elseif GameState == 2 and key == "space" then
        love.event.quit( "restart" )
    end
end

function love.update(dt)
    tick.update(dt)
    StarUpdate(dt)

    if GameState == 0 then
        -- Incluir pantalla de inicio
    elseif GameState == 1 then
        MetoeGroup:update(dt)

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
                GameState = 2
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

    elseif GameState == 2 then
    end
end

function love.draw()
    StarDraw()
    if GameState == 0 then
        love.graphics.printf("Made by Ramón R. Bastardo M. for CS50x 2023", Fuente, 0,5, anchoPantalla, "center")

        love.graphics.draw(Logo, anchoPantalla/2, 200, 0, 0.5,0.5, Logo:getWidth()/2, Logo:getHeight()/2)
        love.graphics.printf('Press "SPACE" to start', LiveFont, 0, (3.4*altoPatalla)/6, anchoPantalla, "center")

        love.graphics.draw(Arrow_key, 250, 440, 0, 3,3)
        love.graphics.printf("Move ship", LiveFont, 255, 540, anchoPantalla, "left")

        love.graphics.draw(Z_key, 470, 490, 0, 3,3)
        love.graphics.printf("Shoot", LiveFont, 452, 540, anchoPantalla, "left")

    elseif GameState == 1 then
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
        if Score < 1500 then
            love.graphics.setColor(0, 0.5, 1)
            love.graphics.printf("Lv. 1", LiveFont, anchoPantalla - 95, 11, anchoPantalla, "left")
            love.graphics.setColor(1, 1, 1)
        elseif Score >= 1500 and Score < 3000 then
            love.graphics.setColor(0, 1, 0)
            love.graphics.printf("Lv. 2", LiveFont, anchoPantalla - 95, 11, anchoPantalla, "left")
            love.graphics.setColor(1, 1, 1)
        elseif Score >= 3000  then
            love.graphics.setColor(1, 0, 0)
            love.graphics.printf("Lv. 3", LiveFont, anchoPantalla - 95, 11, anchoPantalla, "left")
            love.graphics.setColor(1, 1, 1)
        end
        love.graphics.printf("Score: " .. Score, Fuente, anchoPantalla - 110, 40, anchoPantalla, "left")
    elseif GameState == 2 then
        love.graphics.printf("GAME OVER",             GOFont, 0, altoPatalla/2 - 45, anchoPantalla, "center")
        love.graphics.printf("Your Score: " .. Score, Fuente, 0,      altoPatalla/2, anchoPantalla, "center")

        love.graphics.printf('Press "SPACE" to restart', LiveFont, 0, altoPatalla/2 + 50, anchoPantalla, "center")
    end
end