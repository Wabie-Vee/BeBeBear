//pause game
if keyboard_check_pressed(vk_escape)
{
	global.gamePaused = !global.gamePaused
	
	if global.gamePaused
	{
		with (all)
		{
			gamePausedImageSpeed = image_speed;
			image_speed = 0;
		}	
	}
	else
	{
		image_speed = gamePausedImageSpeed;	
	}
}

//play BGM
if global.BGM != undefined
{
	if !audio_is_playing(global.BGM)
	{
		audio_play_sound(global.BGM, 1, false);	
	}
}

if instance_number(obj_Game) > 1 instance_destroy();