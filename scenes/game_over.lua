game_over = {}

function game_over:init()
    self.delay = 1  -- 1 second delay
    self.canRestart = false
    self.blinkTimer = 0
    self.blinkRate = 0.5  -- Blink every 0.5 seconds
    self.showText = true
end

function game_over:enter()
    self.delay = 1
    self.canRestart = false
    self.blinkTimer = 0
    self.showText = true
end

function game_over:update(dt)
    if not self.canRestart then
        self.delay = self.delay - dt
        if self.delay <= 0 then
            self.canRestart = true
        end
    else
        -- Handle blinking
        self.blinkTimer = self.blinkTimer + dt
        if self.blinkTimer >= self.blinkRate then
            self.blinkTimer = 0
            self.showText = not self.showText
        end
        
        if love.keyboard.isDown("space") then
            Gamestate.switch(menu)
        end
    end
end

function game_over:draw()
    local windowWidth = love.graphics.getWidth()
    local windowHeight = love.graphics.getHeight()
    
    -- Center the game over text
    local text = "Game Over"
    local textWidth = love.graphics.getFont():getWidth(text)
    love.graphics.print(text, (windowWidth - textWidth) / 2, windowHeight * 0.4)
    
    -- Only show restart text after delay and when showText is true
    if self.canRestart and self.showText then
        local restartText = "Press space to restart"
        local restartWidth = love.graphics.getFont():getWidth(restartText)
        love.graphics.print(restartText, (windowWidth - restartWidth) / 2, windowHeight * 0.5)
    end
end

return game_over