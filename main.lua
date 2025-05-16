--Author: Akhil Babu (forked from Mrinal Pande's repo)
--imports

anim8 = require('libraries/anim8')
Object = require('libraries/classic')

-- objects
require('objects/Ship')
require('objects/Bullet')
require('objects/PlayerShip')
require('objects/EnemyShip')
Gamestate = require('libraries/hump/gamestate')
--min max
love.graphics.setDefaultFilter('nearest','nearest')

local game = require('scenes/game')
local menu = require('scenes/menu')
local game_over = require('scenes/game_over')

function love.load()
	Gamestate.registerEvents()
	Gamestate.switch(menu)
end

function love.update(dt)
	Gamestate.update(dt)
end

function love.draw()
	Gamestate.draw()
end