EnemyShip = Ship:extend()

function EnemyShip:new(x, y, width, height, x_speed, y_speed, tile, animations)
    EnemyShip.super.new(self, x, y, width, height, x_speed, tile, animations)
    self.y_speed = y_speed
    self.x_max = self.x + 100
    self.x_min = math.max(0, self.x - 100)
    self.y_max = love.graphics.getHeight()/2
    self.direction = 1
end

function EnemyShip:update(dt)
    EnemyShip.super.update(self, dt)
    if self.direction == 1 then
        if self.x < self.x_max then
            self.x = self.x + self.speed * dt
        else
            self.direction = -1
        end
    elseif self.direction == -1 then
        if self.x > self.x_min then
            self.x = self.x - self.speed * dt
        else
            self.direction = 1
        end
    end
    if self.y < self.y_max then
        self.y = self.y + self.speed * dt
    end
end

function EnemyShip:draw()
    EnemyShip.super.draw(self)
    self.animations.idle:draw(self.tile, self.x, self.y, 0, 4, 4)
end