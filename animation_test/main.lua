require "AnAL"

--code found at https://love2d.org/wiki/AnAL
function love.load()
   local img  = love.graphics.newImage("robin.png")
   --image, frame width, frame height, fps
   anim = newAnimation(img, 240, 314, 0.001, 0)
   --choose either loop, bounce, or once for setMode
   anim:setMode("loop")
end

function love.update(dt)
   -- Updates the animation. (Enables frame changes)
   anim:update(dt)   
end

function love.draw()
   -- Draw the animation at (100, 100).
   anim:draw(100, 100) 
end