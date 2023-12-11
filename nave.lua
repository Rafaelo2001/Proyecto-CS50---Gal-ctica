Nave = Class:extend()

function Nave:new(x, y, vidas, damage, speed)
    self.x = x
    self.y = y
    self.vidas = vidas
    self.damage = damage
    self.speed = speed

    self.skin = love.graphics.newImage("assets/nave/nave1.png")
    self.ancho = self.skin:getWidth()
    self.alto = self.skin:getHeight()
    self.rotacion = - math.pi / 2
    self.desgarroX = 0
    self.desgarroY = 0

    self.radioHitbox = self.ancho/2 - 10

    LiveFont = love.graphics.newFont("assets/font/kenvector_future.ttf", 20)
end

function Nave:checkColision(e)
    local distancia = math.sqrt(
        (self.x - e.x)^2 + (self.y - e.y)^2
    )

    if self.radioHitbox + e.radioHitbox > distancia then
        return true
    end

    return false
end

function Nave:reciveDano(e, dt)
    if self:checkColision(e) then
        self.vidas = self.vidas - 1
    end
end

function Nave:update(dt)
    -- Movimiento de la nave
        if love.keyboard.isDown("d", "right") then
            self.x = self.x + self.speed * dt
        elseif love.keyboard.isDown("a", "left") then
            self.x = self.x - self.speed * dt
        end

    -- Movimiento vertical mas pequeño efecto visual
        if love.keyboard.isDown("s", "down") then
            self.y = self.y + 600 * dt
            self.desgarroX = -0.1
        elseif love.keyboard.isDown("w", "up") then
            self.y = self.y - 600 * dt
            self.desgarroX =  0.1
        else
            self.desgarroX = 0
        end


    -- Desplazamiento automatico a la posicion base
        if self.x > 151 then
            self.x = self.x - 30 * dt
        elseif self.x < 149 then
            self.x = self.x + 30 * dt
        end

        if self.y < 69 then
            self.y = self.y + 30 * dt
        elseif self.y > love.graphics.getHeight() - 69 then
            self.y = self.y - 30 * dt
        end

    -- Limitacion de movimiento al alrea de la pantalla visible
        if self.x <= 20 then
            self.x = 20
        elseif self.x >= 600 then
            self.x = 600
        end

        if self.y <=  40 then
            self.y = 40
        elseif self.y >= love.graphics.getHeight() - 40 then -- Cambiar esa funcion si se llega a notar lento
            self.y = love.graphics.getHeight() - 40
        end
end

function Nave:drawLife()
    local inicio_bar = love.graphics.newImage("assets/nave/LB-s-Full.png")
    local middle_bar = love.graphics.newImage("assets/nave/LB-m-Full.png")
    local end_bar    = love.graphics.newImage("assets/nave/LB-e-Full.png")

    if self.vidas > 100 and self.vidas < 200 then
        inicio_bar = love.graphics.newImage("assets/nave/LB-s-Medium.png")
        middle_bar = love.graphics.newImage("assets/nave/LB-m-Medium.png")
        end_bar    = love.graphics.newImage("assets/nave/LB-e-Medium.png")
    elseif self.vidas <= 100 then
        inicio_bar = love.graphics.newImage("assets/nave/LB-s-Low.png")
        middle_bar = love.graphics.newImage("assets/nave/LB-m-Low.png")
        end_bar    = love.graphics.newImage("assets/nave/LB-e-Low.png")
    end

    -- Calculos para la barra de vida
    local anchoI = inicio_bar:getWidth()
    local anchoM = middle_bar:getWidth()

    -- Barra de Vida
    love.graphics.printf("Energy", LiveFont, 10,11, 500)

    love.graphics.draw( inicio_bar,                                  120, 10, 0,            1,1, 0,0, 0,0)
    love.graphics.draw( middle_bar,                         120 + anchoI, 10, 0, self.vidas/9,1, 0,0, 0,0)
    love.graphics.draw(    end_bar, anchoM * self.vidas/9 + 120 + anchoI, 10, 0,            1,1, 0,0, 0,0)
end

function Nave:draw()
    love.graphics.print("x " .. self.x, self.x+50,self.y+50)
    love.graphics.print("y " .. self.y, self.x+50,self.y+70)
    love.graphics.draw(
        self.skin,
        self.x,
        self.y,
        self.rotacion,
        1,1,
        self.ancho/2,
        self.alto/2,
        self.desgarroX,self.desgarroY
    )

    -- Prototipo Hitbox (28 se resta de lado y lado, 14 para volverlo a centrar)
    love.graphics.rectangle("line", self.x - self.alto / 2, self.y - self.ancho/2 + 14, self.alto,self.ancho-28)
    love.graphics.circle("line", self.x,self.y, self.radioHitbox)
end