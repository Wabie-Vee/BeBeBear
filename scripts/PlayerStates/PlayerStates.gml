function PlayerStateFree() {
    #region Movement and Animation
    // Reset transparency
    image_alpha = 1;

    // Handle player movement
    hSpeed = lengthdir_x(inputMagnitude * moveSpeed, inputDirection);
    vSpeed = lengthdir_y(inputMagnitude * moveSpeed, inputDirection);

    // Handle player collision
    PlayerCollision();

    // Update sprite based on movement
    var _oldSprite = sprite_index;
    if (!playerAFK) {
        sprite_index = (inputMagnitude != 0) ? spriteRun : spriteIdle;
    } else {
        sprite_index = spriteAFK;
    }
    if (inputMagnitude != 0) {
        direction = inputDirection;
    }
    if (_oldSprite != sprite_index) {
        localFrame = 0;
    }

    // Handle running logic
    if (keyRun && inputMagnitude != 0) {
        if (!runStart) {
            if (moveSpeed <= speedWalk) {
                moveSpeed = speedRun;
                runStart = true;
                sprite_set_speed(sprite_index, spriteSpeed * runMultiplier, spritespeed_framespersecond);
            }
        }
    } else {
        runStart = false;
    }
    if (!keyRun) {
        sprite_set_speed(sprite_index, spriteSpeedStart, spritespeed_framespersecond);
        moveSpeed = speedWalk;
    }

    // Play footstep sound based on frame
    if (round(localFrame) == 2 || round(localFrame) == 4) {
        step = false;
    }
    if ((round(localFrame) == 1 || round(localFrame) == 3) && !step && inputMagnitude != 0) {
        step = true;
        audio_sound_pitch(footStepSound, random_range(1, 0.9));
        audio_play_sound(footStepSound, 1, false);
    }

    // Force sleep
    if (keyboard_check_pressed(ord("Z"))) {
        afkCounter = afkLimit + 1;
    }

    // AFK check
    afkCounter++;
    if (afkCounter > afkLimit) {
        if (!playerAFK) {
            audio_sound_pitch(snd_Yawn, 1.7);
            audio_play_sound(snd_Yawn, 1, false);
        }

        playerAFK = true;
    } else {
        playerAFK = false;
    }

    if (inputMagnitude == 0) {
        afkCounter++;
    } else {
        afkCounter = 0;
    }

    // Animate the sprite
    PlayerAnimateSprite();
    #endregion

    #region Drawing and Interactions
    // Draw interaction icon
    var _activateX = lengthdir_x(10, direction);
    var _activateY = lengthdir_y(10, direction);
    activate = noone;

    // Check for entities within the area and at the bottom of their sprites
    var instanceList = ds_list_create();
    instance_place_list(x + _activateX, y + _activateY, par_Entity, instanceList, false);
    for (var i = 0; i < ds_list_size(instanceList); i++) {
        var inst = ds_list_find_value(instanceList, i);
        var instBottomY = inst.bbox_bottom;
        if (point_in_circle(inst.x, instBottomY, x + _activateX, y + _activateY, 16)) {
            activate = inst;
            break;
        }
    }
    ds_list_destroy(instanceList);

    if (activate != noone && activate.entityActivateScript != -1) {
        drawPointer = true;
    } else {
        drawPointer = false;
    }
    #endregion

    #region Interacting with NPCs and Entities
    // Handle activation key logic
    if (keyActivate) {
        if (activate != noone && activate.entityActivateScript != -1) {

            // Execute the activation script
            ScriptExecuteArray(activate.entityActivateScript, activate.entityActivateArgs);

            // Make an NPC face the player if applicable
            if (activate.entityNPC) {
                with (activate) {
                    global.cameraLerp = 0;
                    global.cameraState = "Talking";
                    global.follow = id;
                    direction = point_direction(x, y, other.x, other.y);
                }
                playerState = PlayerStateSpeak; // Correct state transition
            }
        } else {
        }
    }

    // Check for collision with obj_RoomTransition
    if (place_meeting(x, y, obj_RoomTransition)) {
        var transitionObj = instance_place(x, y, obj_RoomTransition);
        if (transitionObj.playSound != noone) {
            audio_play_sound(transitionObj.playSound, 1, false);
        }
        if (transitionObj.useFadeTransition) {
            // Spawn a new obj_Transition
            var newTransition = instance_create_layer(x, y, "Instances", obj_Transition);
            newTransition.targetRoom = transitionObj.targetRoom;
            newTransition.targetX = transitionObj.targetX;
            newTransition.targetY = transitionObj.targetY;
            if (transitionObj.targetX != -1) global.targetX = transitionObj.targetX else global.targetX = x;
            if (transitionObj.targetY != -1) global.targetY = transitionObj.targetY else global.targetY = y;
            newTransition.useFadeTransition = transitionObj.useFadeTransition;

            // Lock the player
            global.playerState = PlayerStateLocked;
			global.Direction = obj_Player.direction;
        } else {
            // Direct room transition without fade
            if (transitionObj.targetX != -1) global.targetX = transitionObj.targetX else global.targetX = x;
            if (transitionObj.targetY != -1) global.targetY = transitionObj.targetY else global.targetY = y;
            room_goto(transitionObj.targetRoom);
        }
    }
    #endregion
}


function PlayerStateSpeak() {
    // Disable movement and switch to idle animation
    inputMagnitude = 0;
    sprite_index = spriteIdle;
    PlayerAnimateSprite();

    // Check if player overlaps with the NPC
    var activate = instance_nearest(x, y, par_Entity); // Use instance_nearest for better accuracy
    if (activate != noone && activate.entityNPC) {

        // Check for overlap
        if (activate.bbox_bottom < bbox_bottom) {
            image_alpha = 0.5; // set transparency
        } else {
            image_alpha = 1; // reset transparency
        }
    } else {
        image_alpha = 1; // Reset transparency
    }

    // Return to free state when the 'C' key is pressed
    if (keyboard_check_pressed(ord("C"))) {
        playerState = PlayerStateFree;
    }
}

function PlayerStateLocked() {
	    PlayerAnimateSprite();
    // Locked state does nothing
}
