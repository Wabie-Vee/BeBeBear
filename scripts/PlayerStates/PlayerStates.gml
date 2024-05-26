function PlayerStateFree() {
    #region movement and animation
    // Handle player movement
    hSpeed = lengthdir_x(inputMagnitude * moveSpeed, inputDirection);
    vSpeed = lengthdir_y(inputMagnitude * moveSpeed, inputDirection);

    // Handle player collision
    PlayerCollision();

    // Update sprite index based on movement
    var _oldSprite = sprite_index;
    if (inputMagnitude != 0) {
        direction = inputDirection;
        sprite_index = spriteRun;
    } else {
        sprite_index = spriteIdle;
    }
    if (_oldSprite != sprite_index) {
        localFrame = 0;
    }

    // Handle running logic
    if (keyRun && inputMagnitude != 0) {
        if (!runStart) {
            if (moveSpeed <= speedWalk) {
                moveSpeed = moveSpeed * runMultiplier;
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
        audio_sound_pitch(snd_FootStep, random_range(.5, .9));
        audio_play_sound(snd_FootStep, 1, false);
    }

    // Animate the sprite
    PlayerAnimateSprite();
    #endregion

    #region drawing and interactions
    // Draw interaction icon
    var _activateX = lengthdir_x(10, direction);
    var _activateY = lengthdir_y(10, direction);
    activate = instance_position(x + _activateX, y + _activateY, par_Entity);

    if (activate == noone || activate.entityActivateScript == -1) {
        drawPointer = false;
    } else {
        drawPointer = true;
    }
    #endregion
    
    #region interacting with npcs and entities
    // Handle activation key logic
    if (keyActivate) {
        // Calculate activation position
        var _activateX = lengthdir_x(10, direction);
        var _activateY = lengthdir_y(10, direction);
        var activate = instance_position(x + _activateX, y + _activateY, par_Entity);

        if (activate == noone || activate.entityActivateScript == -1) {
            // Potentially handle a roll or other fallback behavior here
        } else {
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
            }
        }
    }
    #endregion
}

function PlayerStateSpeak() {
    // Disable movement and switch to idle animation
    inputMagnitude = 0;
    sprite_index = spriteIdle;
    PlayerAnimateSprite();

    // Return to free state when the 'C' key is pressed
    if (keyboard_check_pressed(ord("C"))) {
        playerState = PlayerStateFree;
    }
}

function PlayerStateLocked() {
    // Locked state does nothing
}
