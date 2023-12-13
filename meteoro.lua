Meteoro = Enemigo:extend()

function Meteoro:new(x,y, speed, meteoro_type, movement_type)
    local imagen, value

        if meteoro_type == 'big' or meteoro_type == 'b' then
            imagen = "assets/enemy/meteoroBig.png"
            value = 300
            self.vida = 10
        elseif meteoro_type == 'medium' or meteoro_type == 'm' then
            imagen = "assets/enemy/meteoroMedium.png"
            value = 150
            self.vida = 2
        elseif meteoro_type == 'medium_gris' or meteoro_type == 'mg' then
            imagen = "assets/enemy/meteoroMediumGris.png"
            value = 150
            self.vida = 4
        elseif meteoro_type == 'small' or meteoro_type == 's' then
            imagen = "assets/enemy/meteoroSmall.png"
            value = 50
            self.vida = 1
        elseif meteoro_type == 'tiny' or meteoro_type == 't' then
            imagen = "assets/enemy/meteoroTiny.png"
            value = 10
            self.vida = 1
        end

    Meteoro.super.new(self, x,y, value, imagen)
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
    --love.graphics.circle("line", self.x,self.y, self.radioHitbox)
end