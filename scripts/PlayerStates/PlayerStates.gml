function PlayerStateFree() {
	//movement
	hSpeed = lengthdir_x(inputMagnitude * moveSpeed, inputDirection);
	vSpeed = lengthdir_y(inputMagnitude * moveSpeed, inputDirection);

	PlayerCollision();

	//update sprite index
	var _oldSprite = sprite_index;
	if (inputMagnitude != 0) {
		direction = inputDirection;
		sprite_index = spriteRun;
	} else sprite_index = spriteIdle;
	if (_oldSprite != sprite_index) localFrame = 0;

	//run faster
	if (keyRun and inputMagnitude != 0) {
		if runStart = false {
			if moveSpeed <= speedWalk {
				moveSpeed = (moveSpeed * runMultiplier);
				runStart = true;
				sprite_set_speed(sprite_index, spriteSpeed * runMultiplier, spritespeed_framespersecond);
			}
		}
	} else {
		runStart = false;
	}
	if !keyRun {
		sprite_set_speed(sprite_index, spriteSpeedStart, spritespeed_framespersecond);
		moveSpeed = speedWalk;
	}

	//play footstep sound
	if (round(localFrame) = 2 || round(localFrame) = 4) {
		step = false
	}

	if (round(localFrame) = 1 || round(localFrame) = 3) && step = false && inputMagnitude != 0 {
		step = true
		audio_sound_pitch(snd_FootStep, random_range(.5, .9))
		audio_play_sound(snd_FootStep, 1, false);
	}

	//animate sprite
	PlayerAnimateSprite()

	//draw interact icon
	var _activateX = lengthdir_x(10, direction);
	var _activateY = lengthdir_y(10, direction);
	activate = instance_position(x + _activateX, y + _activateY, par_Entity);
	
	if (activate = noone || activate.entityActivateScript == -1){
		drawPointer = false;
	} else {
		drawPointer = true;	
	}
	//activate key logic
	if (keyActivate) {
		//1. check for entity to activate
		//2. if there is nothing, or there is something, but it has no script
		//3. otherwise, if there is something and it has a script, Activate!
		//4. if the thing we activate is an NPC, make it face towards us

		var _activateX = lengthdir_x(10, direction);
		var _activateY = lengthdir_y(10, direction);
		activate = instance_position(x + _activateX, y + _activateY, par_Entity);
		
		if (activate = noone || activate.entityActivateScript == -1) {
			//Roll goes here maybe?	
		} else {
			//activate entity
			ScriptExecuteArray(activate.entityActivateScript, activate.entityActivateArgs)

			//Make an NPC face the Player
			if (activate.entityNPC) {
				with activate {
					direction = point_direction(x, y, other.x, other.y);
				}
			}
		}


	}
}



function PlayerStateSpeak() {
	inputMagnitude = 0

	sprite_index = spriteIdle;
	PlayerAnimateSprite();
	if keyboard_check_pressed(ord("C")) playerState = PlayerStateFree;
}

function PlayerStateLocked() {
	//do nothing
}