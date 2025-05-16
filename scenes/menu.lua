menu = {}

function menu:init()
    self.font = love.graphics.newFont('fonts/menu_font.ttf', 40)
    love.graphics.setFont(self.font)
    self.title = "Space Shooter"
    self.navCooldown = 0
    self.navCooldownTime = 0.2  -- 200ms cooldown
    start_game = {
        text = "Start Game",
        action = function()
            Gamestate.switch(game)
        end,
        selected = true
    }
    controls = {
        text = "Controls",
        action = function()
            Gamestate.switch(controls)
        end,
        selected = false
    }
    self.items = {start_game, controls}
end

function menu:enter()
    print("Menu")
end

function menu:update(dt)
    -- Update cooldown timer
    if self.navCooldown > 0 then
        self.navCooldown = self.navCooldown - dt
    end

    -- Find currently selected item
    local selectedIndex = 1
    for i, item in ipairs(self.items) do
        if item.selected then
            selectedIndex = i
            break
        end
    end

    -- Only process navigation if cooldown is finished
    if self.navCooldown <= 0 then
        if love.keyboard.isDown("up") then
            -- Move selection up, wrapping around to bottom
            self.items[selectedIndex].selected = false
            selectedIndex = selectedIndex - 1
            if selectedIndex < 1 then
                selectedIndex = #self.items
            end
            self.items[selectedIndex].selected = true
            self.navCooldown = self.navCooldownTime
        elseif love.keyboard.isDown("down") then
            -- Move selection down, wrapping around to top
            self.items[selectedIndex].selected = false
            selectedIndex = selectedIndex + 1
            if selectedIndex > #self.items then
                selectedIndex = 1
            end
            self.items[selectedIndex].selected = true
            self.navCooldown = self.navCooldownTime
        end
    end
    if love.keyboard.isDown("space") then
        for _, item in ipairs(self.items) do
            if item.selected then
                item.action()
                break
            end
        end
    end
end

function menu:draw()
    local windowWidth = love.graphics.getWidth()
    local windowHeight = love.graphics.getHeight()
    
    -- Center the title
    local titleWidth = self.font:getWidth(self.title)
    love.graphics.print(self.title, (windowWidth - titleWidth) / 2, windowHeight * 0.2)
    
    -- Center each menu item
    for i, item in ipairs(self.items) do
        local itemWidth = self.font:getWidth(item.text)
        local y = windowHeight * 0.4 + (i - 1) * 40
        if item.selected then
            love.graphics.print("> " .. item.text, (windowWidth - itemWidth) / 2 - 20, y)
        else
            love.graphics.print(item.text, (windowWidth - itemWidth) / 2, y)
        end
    end
end

return menu