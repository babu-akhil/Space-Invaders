EnemyShip = Ship:extend()

function EnemyShip:new(x, y, width, height, x_speed, y_speed, tile, explode_tile, animations, cooldown)
    EnemyShip.super.new(self, x, y, width, height, x_speed, y_speed, tile, animations, 'enemy', explode_tile, cooldown)
    self.x_max = self.x + 100
    self.x_min = math.max(0, self.x - 100)
    self.y_max = love.graphics.getHeight()/2
    self.direction = 1
    self.quick_fire = 3
end

function EnemyShip:fire()
    print(self.cooldown)
    if self.cooldown <= 0 then
        print('firing')
        love.audio.play(self.fire_sound)
        bullet = Bullet(self.x + self.width/2 - bullet_width/2, self.y + self.height + bullet_height/2, bullet_width, bullet_height, -600, self.bullet_img)
        table.insert(self.bullets, bullet)
        if self.quick_fire > 0 then
            self.cooldown = 10
            self.quick_fire = self.quick_fire - 1
        else
            self.cooldown = 40
            self.quick_fire = 3
        end
    end
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
    self:fire()
end

function EnemyShip:draw()
    EnemyShip.super.draw(self)
    if self.explode then
        self.animations.explode:draw(self.explode_tile, self.x, self.y, 0, 4, 4)
    else
        self.animations.idle:draw(self.tile, self.x, self.y, 0, 4, 4)
    end
end