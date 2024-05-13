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
			spriteSpeed = (spriteSpeed * runMultiplier);
			moveSpeed = (moveSpeed * runMultiplier);
			runStart = true;
		}
	}
} else { runStart = false; }
if !keyRun
{
	spriteSpeed = spriteSpeedStart;
	moveSpeed = speedWalk;
}

//animate sprite
PlayerAnimateSprite()
}
	
function PlayerStateSpeak(){
	PlayerAnimateSprite();
}