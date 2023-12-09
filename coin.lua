Coin = Class:extend()

function Coin:new(x, y, velocidad, type)
    self.x = x
    self.y = y
    self.velocidad = velocidad

    if type == "s" then
        self.imagen = love.graphics.newImage("assets/star_dust.png")
        self.value = 100
        -- Ancho y alto del tamano 's' son 32x32 px
    end

    self.ancho = self.imagen:getWidth()
    self.alto = self.imagen:getHeight()
    self.scalax = 1
    self.scalay = 1

    self.radioHitbox = 32/2

    self.modulo = 0.3
end

function Coin:update(dt)
    self.x = self.x - self.velocidad*dt

    -- Pulsacion, solo visual
    if self.scalax >= 1.1 or self.scalax <= 0.9 then
        self.modulo = -self.modulo
    end
    self.scalax = self.scalax + self.modulo*dt
    self.scalay = self.scalay + self.modulo*dt
end

function Coin:draw()
    love.graphics.draw(self.imagen, self.x,self.y, 0, self.scalax,self.scalay, self.ancho/2,self.alto/2, 0,0)
    -- love.graphics.circle("line", self.x,self.y, self.radioHitbox)
end