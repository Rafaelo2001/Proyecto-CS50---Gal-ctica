Coin = Class:extend()

function Coin:new(x, y, type)
    self.x = x
    self.y = y

    if type == "s" then
        self.imagen = love.graphics.newImage("assets/star_dust.png")
        self.value = 100
        -- Ancho y alto del tamano 's' son 32x32 px
    end

    self.ancho = self.imagen:getWidth()
    self.alto = self.imagen:getHeight()

    self.radioHitbox = 32/2
end

function Coin:update(dt)
    self.x = self.x - 10*dt
end

function Coin:draw()
    love.graphics.draw(self.imagen, self.x,self.y, 0, 1,1, self.ancho/2,self.alto/2, 0,0)
    love.graphics.circle("line", self.x,self.y, self.radioHitbox)
end