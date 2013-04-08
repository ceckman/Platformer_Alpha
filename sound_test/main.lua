require "TEsound"

--https://love2d.org/wiki/TEsound for more info
function love.load()
play_effect = false
end

function love.update(dt)
   --The background music, set to .3 its normal volume
   TEsound.playLooping("whatislove.mid", 0.3)
   --Plays one of three sound effects when escape is pressed
   if (play_effect == true) then
	TEsound.play({"smb_coin.wav", "smb_stomp.wav", "smb_jumpsmall.wav"})
	play_effect = false
   end
   --needed at the end of every update
   TEsound.cleanup()
end

function love.draw()
   love.graphics.print('Hit space to play sound effect', 400, 300)
end

function love.keypressed(key, u)
	if key == "escape" then
	  play_effect = true
    end
end