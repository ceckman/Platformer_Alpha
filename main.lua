-- Tutorial 1: Hamster Ball
-- Add an image to the game and move it around using 
-- the arrow keys.
-- compatible with löve 0.6.0 and up


function love.load()
   square = love.graphics.newImage("square.png")
   hamster = love.graphics.newImage("hamster.png")
   x = 50
   y = 50
   speed = 100
   r=0
l=0
d=0
u=0
end

function love.update(dt)

   if love.keyboard.isDown("right") then
      x = x + (speed * dt)*r
	  if r<4 then
	       r=r+.1
	       
	  end
	  l=0
   elseif love.keyboard.isDown("left") then
      x = x - (speed * dt)*l
	  if l<4 then
	       l=l+.1
	       
	  end
	  r=0
   end

   if love.keyboard.isDown("down") then
      
      y = y + (speed * dt)*d
	  if d<4 then
	       d=d+.1
	      
	  end
	   u=0
   elseif love.keyboard.isDown("up") then
      y = y - (speed * dt)*u
	  if u<4 then
	       u=u+.1
	       
	  end
	
	  d=0
   end
end

function love.draw()
   love.graphics.draw(hamster, x, y)
   love.graphics.draw(square, 100, 100)
end