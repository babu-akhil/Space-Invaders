EnemyShip = Ship:extend()

function EnemyShip:new(x, y, width, height, x_speed, y_speed, tile, explode_tile, animations)
    EnemyShip.super.new(self, x, y, width, height, x_speed, y_speed, tile, animations)
    self.x_max = self.x + 100
    self.x_min = math.max(0, self.x - 100)
    self.y_max = love.graphics.getHeight()/2
    self.direction = 1
    self.explode_tile = explode_tile
    self.explode_grid = anim8.newGrid(8, 8,self.explode_tile:getWidth(), self.explode_tile:getHeight())
    self.animations.explode = anim8.newAnimation(self.explode_grid('10-13', 7), 0.1)
    self.explode = false
    self.explode_timer = 10
    self.explode_sound = love.audio.newSource('sounds/Boom15.wav', 'static')
end

function EnemyShip:update(dt)
    EnemyShip.super.update(self, dt)
    if self.direction == 1 then
        if self.x < self.x_max then
            self.x = self.x + self.x_speed * dt
        else
            self.direction = -1
        end
    elseif self.direction == -1 then
        if self.x > self.x_min then
            self.x = self.x - self.x_speed * dt
        else
            self.direction = 1
        end
    end
    if self.y < self.y_max then
        self.y = self.y + self.y_speed * dt
    end
    if self.explode then
        self.explode_timer = self.explode_timer - 1
        self.animations.explode:update(dt)
    end
end

function EnemyShip:draw()
    EnemyShip.super.draw(self)
    if self.explode then
        self.animations.explode:draw(self.explode_tile, self.x, self.y, 0, 4, 4)
    else
        self.animations.idle:draw(self.tile, self.x, self.y, 0, 4, 4)
    end
    if draw_hitbox then
        love.graphics.setColor(255,0,0)
        love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
        love.graphics.setColor(255,255,255)
    end
end