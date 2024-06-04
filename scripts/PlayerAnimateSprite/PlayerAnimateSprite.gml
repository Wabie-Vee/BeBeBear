//update sprite
function PlayerAnimateSprite(){
	
	if !playerAFK{
		var _cardinalDirection = round(direction/(90))
		var _totalFrames = sprite_get_number(sprite_index) / 4;
		image_index = localFrame + (_cardinalDirection * _totalFrames);
		if _totalFrames > 1 && !instance_exists(obj_Transition){
		localFrame += sprite_get_speed(sprite_index) / FRAME_RATE;
		}
	


	//if animation would loop on next game step
		if (localFrame >= _totalFrames)
		{
			animationEnd = true;
			localFrame = 0;
		}	else animationEnd = false;
	} else {
		sprite_index = spriteAFK
		var _totalFrames = sprite_get_number(sprite_index);
		image_index = localFrame;
		localFrame += sprite_get_speed(sprite_index)/FRAME_RATE;

		
		//loop last two frames of afk animation
		if localFrame >= _totalFrames{
			localFrame = _totalFrames - 2;	
		}
	}
}