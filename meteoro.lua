Meteoro = Enemigo:extend()

function Meteoro:new(x,y, speed, imagen, movement_type)
    Meteoro.super.new(self, x,y, imagen)
    self.speed = speed
    self.rotacion = 0 + love.math.random() * 4

    self.movement_type = movement_type
end

function Meteoro:update(dt)
    self.rotacion = self.rotacion + dt / 2

    if self.movement_type == "r" or self.movement_type == "recto" then
        self.x = self.x + - self.speed * dt
    elseif self.movement_type == "d" or self.movement_type == "diagonal" then
        self.x = self.x + - self.speed * dt
        self.y = self.y - - self.speed * dt
    elseif self.movement_type == "di" or self.movement_type == "diagonal_inverso" then
        self.x = self.x + - self.speed * dt
        self.y = self.y + - self.speed * dt
    end

end

function Meteoro:draw()
    love.graphics.draw(self.imagen, self.x,self.y, self.rotacion, 1,1, self.ancho/2,self.alto/2)
    love.graphics.circle("line", self.x,self.y, self.radioHitbox)
end