function love.load()
	text = " "
	love.physics.setMeter(100) --the height of a meter our worlds will be 64px
	world = love.physics.newWorld(0, 9.81*64, true) --create a world for the bodies to exist in with horizontal gravity of 0 and vertical gravity of 9.81
	
	world:setCallbacks(beginContact, endContact, preSolve, postSolve)

	objects = {} -- table to hold all our physical objects

	--let's create the ground
	objects.ground = {}
	objects.ground.body = love.physics.newBody(world, 1024/2, 768-50/2) --remember, the shape (the rectangle we create next) anchors to the body from its center, so we have to move it to (1024/2, 768-50/2)
	objects.ground.shape = love.physics.newRectangleShape(1024, 50) --make a rectangle with a width of 1024 and a height of 50
	objects.ground.fixture = love.physics.newFixture(objects.ground.body, objects.ground.shape); --attach shape to body

	--let's create a ball
	--[[
	objects.ball = {}
	objects.ball.body = love.physics.newBody(world, 1024/2, 768/2, "dynamic") --place the body in the center of the world and make it dynamic, so it can move around
	objects.ball.shape = love.physics.newCircleShape(20) --the ball's shape has a radius of 20
	objects.ball.fixture = love.physics.newFixture(objects.ball.body, objects.ball.shape, 1) -- Attach fixture to body and give it a density of 1.
	objects.ball.fixture:setRestitution(0.9) --let the ball bounce
	--]]

	---[=[
	imagePig = love.graphics.newImage("queen_pig.png")
	--let's create the pig
	objects.pig = {}
	objects.pig.body = love.physics.newBody(world, 1024/2, 768-100, "dynamic")
	objects.pig.image = imagePig
	objects.pig.shapes = {
			--[=[
			--[[ 
				In L?VE's coordinate system, positive Y goes down. 
				If you use an application that targets Box2D, 
				it will expect the system of Box2D and the shapes appear upside down if you draw them directly in L?VE.
				If you're lucky, you can just multiply all the Y coordinates of the polygon shapes with -1.
			--]]
			love.physics.newPolygonShape(9, 46, 8, 44, 8, 38,  14, 36, 11, 46),
			love.physics.newPolygonShape(-33, 14,  -31, 13,  -21, 22,  -33, 17),
			love.physics.newPolygonShape(23, 22,  23, 26,  21, 34,  5, 27,  20, 20),
			love.physics.newPolygonShape(-32, 29,  -36, 24,  -36, 19,  -33, 17,  -21, 22,  -26, 29),
			love.physics.newPolygonShape(28, 17,  20, 20,  28, 12),
			love.physics.newPolygonShape(-17, 37,  -17, 28,  -14, 25,  -3, 27,  -3, 37,  -6, 40,  -12, 40),
			love.physics.newPolygonShape( 8, 38,  7, 33,   14, 36),
			love.physics.newPolygonShape(26, 28,  26, 30,  21, 34,  23, 26),
			love.physics.newPolygonShape(5, 31,  5, 27,  21, 34,  14, 36  ,  7, 33),
			love.physics.newPolygonShape( 21, 41,  19, 41,  14, 36,  21, 34),
			love.physics.newPolygonShape(-17, 25,  -21, 22,  -37, -19,  31, 10,  28, 12,  -14, 25),
			love.physics.newPolygonShape(-29, -29,  -12, -35,  10, -35,  21, -32,  31, 10,  -37, -19 ),
			love.physics.newPolygonShape(32, 34,  32, 36,  21, 34,  26, 30),
			love.physics.newPolygonShape( -36, 8,  -39, 0,  -39, -11  ,  -37, -19,  -21, 22,  -31, 13),
			love.physics.newPolygonShape(34, -21,  37, -12,  36, 1,  31, 10,  21, -32,  28, -28),
			love.physics.newPolygonShape(20, 20,  5, 27,  -3, 27,  -14, 25,  28, 12)
			--]=]
			love.physics.newPolygonShape(  12.00, -40.50  ,  15.00, -30.50  ,  9.00, -32.50  ,  9.00, -38.50  ,  10.00, -40.50 ),
			love.physics.newPolygonShape(  -32.00, -11.50  ,  -20.00, -16.50  ,  -30.00, -7.50  ,  -32.00, -8.50 ),
			love.physics.newPolygonShape(  21.00, -14.50  ,  6.00, -21.50  ,  22.00, -28.50  ,  24.00, -20.50  ,  24.00, -16.50 ),
			love.physics.newPolygonShape(  -25.00, -23.50  ,  -20.00, -16.50  ,  -32.00, -11.50  ,  -35.00, -13.50  ,  -35.00, -18.50  ,  -31.00, -23.50 ),
			love.physics.newPolygonShape(  29.00, -6.50  ,  21.00, -14.50  ,  29.00, -11.50 ),
			love.physics.newPolygonShape(  -11.00, -34.50  ,  -5.00, -34.50  ,  -2.00, -31.50  ,  -2.00, -21.50  ,  -13.00, -19.50  ,  -16.00, -22.50  ,  -16.00, -31.50 ),
			love.physics.newPolygonShape(  15.00, -30.50  ,  8.00, -27.50  ,  9.00, -32.50 ),
			love.physics.newPolygonShape(  24.00, -20.50  ,  22.00, -28.50  ,  27.00, -24.50  ,  27.00, -22.50 ),
			love.physics.newPolygonShape(  8.00, -27.50  ,  15.00, -30.50  ,  22.00, -28.50  ,  6.00, -21.50  ,  6.00, -25.50 ),
			love.physics.newPolygonShape(  22.00, -28.50  ,  15.00, -30.50  ,  20.00, -35.50  ,  22.00, -35.50 ),
			love.physics.newPolygonShape(  -13.00, -19.50  ,  29.00, -6.50  ,  32.00, -4.50  ,  -36.00, 24.50  ,  -20.00, -16.50  ,  -16.00, -19.50 ),
			love.physics.newPolygonShape(  -36.00, 24.50  ,  32.00, -4.50  ,  22.00, 37.50  ,  11.00, 40.50  ,  -11.00, 40.50  ,  -28.00, 34.50 ),
			love.physics.newPolygonShape(  27.00, -24.50  ,  22.00, -28.50  ,  33.00, -30.50  ,  33.00, -28.50 ),
			love.physics.newPolygonShape(  -30.00, -7.50  ,  -20.00, -16.50  ,  -36.00, 24.50  ,  -38.00, 16.50  ,  -38.00, 5.50  ,  -35.00, -2.50 ),
			love.physics.newPolygonShape(  29.00, 33.50  ,  22.00, 37.50  ,  32.00, -4.50  ,  37.00, 4.50  ,  38.00, 17.50  ,  35.00, 26.50 ),
			love.physics.newPolygonShape(  29.00, -6.50  ,  -13.00, -19.50  ,  -2.00, -21.50  ,  6.00, -21.50  ,  21.00, -14.50 )
			
			
		}
	objects.pig.fixtures ={}
	for i=1, #objects.pig.shapes do
      objects.pig.fixtures[i] = love.physics.newFixture(objects.pig.body, objects.pig.shapes[i],2)
	  --objects.pig.fixtures[i]:setRestitution(0.9) --let the ball bounce
    end
		
	--]]
	
	objects.pig.body:setFixedRotation(true)
	
	--let's create a couple blocks to play around with
	objects.block1 = {}
	objects.block1.body = love.physics.newBody(world, 400, 568, "kinematic")
	objects.block1.shape = love.physics.newRectangleShape(0, 0, 100, 100)
	objects.block1.fixture = love.physics.newFixture(objects.block1.body, objects.block1.shape, 5) -- A higher density gives it more mass.

	objects.block2 = {}
	objects.block2.body = love.physics.newBody(world, 200, 618, "kinematic")
	objects.block2.shape = love.physics.newRectangleShape(0, 0, 100, 50)
	objects.block2.fixture = love.physics.newFixture(objects.block2.body, objects.block2.shape, 2)
	
	objects.block3 = {}
	objects.block3.body = love.physics.newBody(world, 600, 468, "kinematic")
	objects.block3.shape = love.physics.newRectangleShape(0, 0, 400, 100)
	objects.block3.fixture = love.physics.newFixture(objects.block3.body, objects.block3.shape, 5) -- A higher density gives it more mass.

	--initial graphics setup
	love.graphics.setBackgroundColor(104, 0, 248) --set the background color to a nice blue
	love.graphics.setMode(1024, 768, false, true, 0) --set the window dimensions to 1024 by 768
end



function love.update(dt)
	world:update(dt) --this puts the world into motion

	--here we are going to create some keyboard events
	if love.keyboard.isDown("right") then --press the right arrow key to push the ball to the right
		-- objects.ball.body:applyForce(400, 0)
		objects.pig.body:applyForce(1000, 0)
		end
	if love.keyboard.isDown("left") then --press the left arrow key to push the ball to the left
		-- objects.ball.body:applyForce(-400, 0)
		objects.pig.body:applyForce(-1000, 0)
		end
	if love.keyboard.isDown("up") then --press the up arrow key to set the ball in the air
		--[[
		objects.ball.body:setLinearVelocity(0,0)
		objects.ball.body:setAngularVelocity(0,0)
		objects.ball.body:setPosition(1024/2, 768/2)
		--]]
		
		--[[
		objects.pig.body:setLinearVelocity(0,0)
		objects.pig.body:setAngularVelocity(0,0)
		objects.pig.body:setPosition(1024/2, 768/2)
		--]]
		fx = 0
		fy = 0
		g = 0
		
		fx, fy = objects.pig.body:getLinearVelocity()
		--g = objects.pig.body:getLinearDamping()
		--if g~=9.8 then
		    if fy==0 then
				   objects.pig.body:applyForce(0, -1000)
				   objects.pig.body:applyLinearImpulse(0, -400) 
				
				
			end
		--end
		
	end
	if checker then
		text = objects.pig.body:getX() .. " " .. objects.pig.body:getY()
	end
end

function love.draw()
	love.graphics.setColor(72, 160, 14) -- set the drawing color to green for the ground
	love.graphics.polygon("fill", objects.ground.body:getWorldPoints(objects.ground.shape:getPoints())) -- draw a "filled in" polygon using the ground's coordinates

	--[[
	love.graphics.setColor(193, 47, 14) --set the drawing color to red for the ball
	love.graphics.circle("fill", objects.ball.body:getX(), objects.ball.body:getY(), objects.ball.shape:getRadius())
	--]]
	
	-- objects.pig.body:getAngle()
	love.graphics.setColor(255,255,255)
	love.graphics.draw(imagePig, objects.pig.body:getX(), objects.pig.body:getY(), objects.pig.body:getAngle() , 1, 1, imagePig:getWidth()/2, imagePig:getHeight()/2)
	
	---[[
	love.graphics.setColor(193, 47, 14)
	--for i = 1, #objects.pig.shapes do
	--	love.graphics.polygon("line", objects.pig.body:getWorldPoints(objects.pig.shapes[i]:getPoints()))
	--end
	--]]
	
	love.graphics.setColor(50, 50, 50) -- set the drawing color to grey for the blocks
	love.graphics.polygon("fill", objects.block1.body:getWorldPoints(objects.block1.shape:getPoints()))
	love.graphics.polygon("fill", objects.block2.body:getWorldPoints(objects.block2.shape:getPoints()))
	love.graphics.polygon("fill", objects.block3.body:getWorldPoints(objects.block3.shape:getPoints()))
	
	love.graphics.printf(text, 0, 0, 800)
end

function love.keypressed(key, u)
   --Debug
   if key == "f12" then --set to whatever key you want to use
      if(checker==true) then checker = false 
	  else checker = true end
   end
end

function beginContact(a, b, coll)
    
end

function endContact(a, b, coll)
    
end

function preSolve(a, b, coll)
    
end

function postSolve(a, b, coll)
    
end