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

speedWalk = 2.0;
moveSpeed = speedWalk;
runMultiplier = 1.7;
global.playerState = PlayerStateFree;

lastState = global.playerState;

