PlayerShip = Ship:extend()

function PlayerShip:new(x, y, width, height, speed, tile,animations)
    PlayerShip.super.new(self, x, y, width, height, speed)
    self.animations = animations
    self.tile = tile
end

function PlayerShip:update(dt)
    PlayerShip.super.update(self, dt)
    if love.keyboard.isDown("right") then
        self.x = self.x + self.speed * dt
        self.x_velocity = self.speed
    elseif love.keyboard.isDown("left") then
        self.x = self.x - self.speed * dt
        self.x_velocity = -self.speed
    else
        self.x_velocity = 0
    end

    if love.keyboard.isDown("up") then
        self.y_velocity = -self.speed
        self.y= self.y - self.speed * dt
    elseif love.keyboard.isDown("down") then
        self.y_velocity = self.speed
        self.y= self.y + self.speed * dt
    end
end

function PlayerShip:draw()
    PlayerShip.super.draw(self)
    if self.x_velocity > 0 then
        self.animations.right:draw(self.tile, self.x, self.y, 0, 4, 4)
    elseif self.x_velocity < 0 then
        self.animations.left:draw(self.tile, self.x, self.y, 0, 4, 4)
    else
        self.animations.idle:draw(self.tile, self.x, self.y, 0, 4, 4)
    end
end