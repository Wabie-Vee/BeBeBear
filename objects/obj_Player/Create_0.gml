collisionMap = layer_tilemap_get_id(layer_get_id("Col"));

image_speed = 0;
hSpeed = 0;
vSpeed = 0;
input_direction = 0;
spriteIdle = spr_BebeIdle;
spriteRun = spr_BebeWalk;
localFrame = 0;
footStepSound = snd_FootStep2;
footPlayed = false;
step = false;
direction = 240;
drawPointer = false;

 
//Sprinting
spriteSpeedStart = 6;
spriteSpeed = spriteSpeedStart;
runStart = false;

speedWalk = 1.5;
moveSpeed = speedWalk;
runMultiplier = 1.5;
speedRun = speedWalk * runMultiplier
global.playerState = PlayerStateFree;

lastState = global.playerState;

//place to put player when room is started
if global.targetX != -1 {
		x = global.targetX;
		y = global.targetY;
}

