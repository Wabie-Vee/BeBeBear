function PlayerStateFree(){
	//movement
hSpeed = lengthdir_x(inputMagnitude * moveSpeed, inputDirection);
vSpeed = lengthdir_y(inputMagnitude * moveSpeed, inputDirection);

x += hSpeed;
y += vSpeed;

//update sprite index
var _oldSprite = sprite_index;
if (inputMagnitude != 0)
{
		direction = inputDirection;
		sprite_index = spriteRun;
}	else sprite_index = spriteIdle;
if (_oldSprite != sprite_index) localFrame = 0;

//run faster
if (keyRun and inputMagnitude != 0)
{
	if runStart = false
	{
		if moveSpeed <= speedWalk
		{
			moveSpeed = (moveSpeed * runMultiplier);
			runStart = true;
			sprite_set_speed(sprite_index, spriteSpeed * runMultiplier, spritespeed_framespersecond);
		}
	}
} else { runStart = false; }
if !keyRun
{ 
	sprite_set_speed(sprite_index, spriteSpeedStart, spritespeed_framespersecond);
	moveSpeed = speedWalk;
}

//play footstep sound

//if round(localFrame) = 0 or round(localFrame = 2)
//{
//	if sprite_index = spriteRun and footPlayed = false	
//	{
//		var _soundPitch = random_range(.75,1.25)
//		audio_sound_pitch(snd_FootStep, _soundPitch)
//		audio_play_sound(snd_FootStep, 1, false, 1, 0, _soundPitch);	
//		audio_sound_pitch(snd_FootStep, 1);
//		footPlayed = true;
//	}
//} else footPlayed = false;
//show_debug_message(round(localFrame));

if (round(localFrame) = 2 || round(localFrame) = 4)
{
	step = false	
}

if (round(localFrame) = 1 || round(localFrame) = 3) && step = false && inputMagnitude != 0
{
	step = true
	audio_sound_pitch(snd_FootStep,random_range(.5,.9))
	audio_play_sound(snd_FootStep, 1, false);
}

//animate sprite
PlayerAnimateSprite()
if keyboard_check_pressed(ord("C")) playerState = PlayerStateSpeak;
}
	
function PlayerStateSpeak(){
	inputMagnitude = 0
	
	sprite_index = spriteIdle;
	PlayerAnimateSprite();
	if keyboard_check_pressed(ord("C")) playerState = PlayerStateFree;
}
	
function PlayerStateLocked(){
//do nothing
}