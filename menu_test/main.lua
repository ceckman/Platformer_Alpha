Gamestate = require "gamestate"
Menu = require 'menu'

fullscreen = false

local menu = {} -- previously: Gamestate.new()
local game = {}
--[[
function menu:draw()
    love.graphics.print("Press Enter to continue", 10, 10)
end

function menu:keyreleased(key, code)
    if key == 'enter' then
        Gamestate.switch(game)
    end
end

function game:enter()
    Entities.clear()
    -- setup entities here
end

function game:update(dt)
    Entities.update(dt)
end

function game:draw()
    Entities.draw()
end
]]--
function love.load()
	Gamestate.registerEvents() -- so state:update() will get called
    Gamestate.switch(menu)
end

function menu:init()
   testmenu = Menu.new()
   testmenu:addItem{
      name = 'Start Game',
      action = function()
         Gamestate.switch(game)
      end
   }
   testmenu:addItem{
      name = 'Options',
      action = function()
         -- do something
      end
   }
   testmenu:addItem{
      name = 'Quit',
      action = function()
         love.event.push('q')
      end
   }
end
function menu:update(dt)
   testmenu:update(dt)
end

function menu:draw()
   testmenu:draw(10, 10)
end

function menu:keypressed(key)
   testmenu:keypressed(key)
end

function game:draw()
    love.graphics.print('Hello World!', 400, 300)
end
