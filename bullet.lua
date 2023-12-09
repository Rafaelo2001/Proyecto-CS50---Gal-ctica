Bullet = Class:extend()

function Bullet:new(x,y, type)
    self.x = x
    self.y = y
    self.type = type

    if type == "l1" then
        self.image = love.graphics.newImage("assets/nave/bullet - laser1.png")
        self.ancho = self.image:getWidth()
        self.alto = self.image:getHeight()
        self.speed = 400
        self.damage = 1
        self.rango = 400
        self.radioHitbox = self.ancho/2

    elseif type == "l2" then
        self.image = love.graphics.newImage("assets/nave/bullet - laser2.png")
        self.ancho = self.image:getWidth()
        self.alto = self.image:getHeight()
        self.speed = 800
        self.damage = 3
        self.rango = 550
        self.radioHitbox = self.ancho/2 + 5

    elseif type == "l3" then
        self.image = love.graphics.newImage("assets/nave/bullet - laser3b.png")
        self.ancho = self.image:getWidth()
        self.alto = self.image:getHeight()
        self.speed = 1000
        self.damage = 7
        self.rango = 900
        self.radioHitbox = self.ancho/2
    end

    -- self.ancho = self.image:getWidth()
    -- self.alto = self.image:getHeight()

    -- self.radioHitbox = self.ancho/2
end

function Bullet:checkColision(e)
    local distancia
    if self.type == "l1" or self.type == "l2" then
        distancia = math.sqrt(
            ((self.x + 5 + self.ancho*2) - e.x)^2 + (self.y - e.y)^2
        )
    elseif self.type == "l3" then
        distancia = math.sqrt(
            (self.x - e.x)^2 + (self.y - e.y)^2
        )
    end

    if self.radioHitbox + e.radioHitbox > distancia then
        return true
    end

    return false
end

function Bullet:update(dt)
    self.x = self.x + self.speed * dt
end

function Bullet:draw()
    love.graphics.draw(self.image, self.x,self.y, math.pi/2, 1,1, self.ancho/2, self.alto/2)

    if self.type == "l1" or self.type == "l2" then
        love.graphics.circle("line", self.x + 5 + self.ancho*2, self.y, self.radioHitbox)

    elseif self.type == "l3" then
        love.graphics.circle("line", self.x, self.y, self.radioHitbox)
    end
end