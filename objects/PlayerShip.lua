PlayerShip = Ship:extend()

function PlayerShip:new(x, y, width, height, x_speed, y_speed, tile, animations, explode_tile, cooldown)
    PlayerShip.super.new(self, x, y, width, height, x_speed, y_speed, tile, animations, 'player', explode_tile, cooldown)
end

function PlayerShip:update(dt)
    PlayerShip.super.update(self, dt)
    if love.keyboard.isDown("right") then
        self.x = self.x + self.x_speed * dt
        self.x_velocity = self.x_speed
    elseif love.keyboard.isDown("left") then
        self.x = self.x - self.x_speed * dt
        self.x_velocity = -self.x_speed
    else
        self.x_velocity = 0
    end

    if love.keyboard.isDown("up") then
        self.y_velocity = -self.y_speed
        self.y= self.y - self.y_speed * dt
    elseif love.keyboard.isDown("down") then
        self.y_velocity = self.y_speed
        self.y= self.y + self.y_speed * dt
    end

end

function PlayerShip:draw()
    PlayerShip.super.draw(self)
    if self.explode then
        self.animations.explode:draw(self.explode_tile, self.x, self.y, 0, 4, 4)
    else
        if self.x_velocity > 0 then
            self.animations.right:draw(self.tile, self.x, self.y, 0, 4, 4)
        elseif self.x_velocity < 0 then
            self.animations.left:draw(self.tile, self.x, self.y, 0, 4, 4)
        else
            self.animations.idle:draw(self.tile, self.x, self.y, 0, 4, 4)
        end
    end
    if draw_hitbox then
        love.graphics.setColor(255,0,0)
        love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
        love.graphics.setColor(255,255,255)
    end
end