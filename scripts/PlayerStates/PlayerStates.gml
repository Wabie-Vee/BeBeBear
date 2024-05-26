function PlayerStateFree() {
    #region Movement and Animation
    // Reset transparency
    image_alpha = 1;
    show_debug_message("PlayerStateFree: Reset transparency");

    // Handle player movement
    hSpeed = lengthdir_x(inputMagnitude * moveSpeed, inputDirection);
    vSpeed = lengthdir_y(inputMagnitude * moveSpeed, inputDirection);
    show_debug_message("PlayerStateFree: Movement calculated");

    // Handle player collision
    PlayerCollision();
    show_debug_message("PlayerStateFree: PlayerCollision executed");

    // Update sprite based on movement
    var _oldSprite = sprite_index;
    sprite_index = (inputMagnitude != 0) ? spriteRun : spriteIdle;
    if (inputMagnitude != 0) {
        direction = inputDirection;
    }
    if (_oldSprite != sprite_index) {
        localFrame = 0;
    }
    show_debug_message("PlayerStateFree: Sprite updated");

    // Handle running logic
    if (keyRun && inputMagnitude != 0) {
        if (!runStart) {
            if (moveSpeed <= speedWalk) {
                moveSpeed *= runMultiplier;
                runStart = true;
                sprite_set_speed(sprite_index, spriteSpeed * runMultiplier, spritespeed_framespersecond);
                show_debug_message("PlayerStateFree: Running started");
            }
        }
    } else {
        runStart = false;
    }
    if (!keyRun) {
        sprite_set_speed(sprite_index, spriteSpeedStart, spritespeed_framespersecond);
        moveSpeed = speedWalk;
        show_debug_message("PlayerStateFree: Running stopped");
    }

    // Play footstep sound based on frame
    if (round(localFrame) == 2 || round(localFrame) == 4) {
        step = false;
    }
    if ((round(localFrame) == 1 || round(localFrame) == 3) && !step && inputMagnitude != 0) {
        step = true;
        audio_sound_pitch(snd_FootStep, random_range(.5, .9));
        audio_play_sound(snd_FootStep, 1, false);
        show_debug_message("PlayerStateFree: Footstep sound played");
    }

    // Animate the sprite
    PlayerAnimateSprite();
    show_debug_message("PlayerStateFree: Animation updated");
    #endregion

    #region Drawing and Interactions
    // Draw interaction icon
    var _activateX = lengthdir_x(10, direction);
    var _activateY = lengthdir_y(10, direction);
    activate = instance_position(x + _activateX, y + _activateY, par_Entity);

    if (activate == noone || activate.entityActivateScript == -1) {
        drawPointer = false;
    } else {
        drawPointer = true;
    }
    show_debug_message("PlayerStateFree: Interaction icon updated");
    #endregion
    
    #region Interacting with NPCs and Entities
    // Handle activation key logic
    if (keyActivate) {
        // Calculate activation position
        var _activateX = lengthdir_x(10, direction);
        var _activateY = lengthdir_y(10, direction);
        var activate = instance_position(x + _activateX, y + _activateY, par_Entity);

        if (activate == noone || activate.entityActivateScript == -1) {
            // Potentially handle a roll or other fallback behavior here
            show_debug_message("PlayerStateFree: No valid entity to activate");
        } else {
            // Execute the activation script
            ScriptExecuteArray(activate.entityActivateScript, activate.entityActivateArgs);
            show_debug_message("PlayerStateFree: Activation script executed");

            // Make an NPC face the player if applicable
            if (activate.entityNPC) {
                with (activate) {
                    global.cameraLerp = 0;
                    global.cameraState = "Talking";
                    global.follow = id;
                    direction = point_direction(x, y, other.x, other.y);
                }
                playerState = PlayerStateSpeak; // Correct state transition
                show_debug_message("PlayerStateFree: NPC is now facing the player, state set to PlayerStateSpeak");
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
    show_debug_message("PlayerStateSpeak: Player animation updated to idle");

    // Check if player overlaps with the NPC
    var activate = instance_nearest(x, y, par_Entity); // Use instance_nearest for better accuracy
    if (activate != noone && activate.entityNPC) {
        show_debug_message("PlayerStateSpeak: Found NPC - " + string(activate));

        // Check for overlap
        if (place_meeting(x, y, activate)) {
            image_alpha = 0.5; // Set transparency
            show_debug_message("PlayerStateSpeak: Player is overlapping NPC, set transparency to 0.5");
        } else {
            image_alpha = 1; // Reset transparency
            show_debug_message("PlayerStateSpeak: Player is not overlapping NPC, reset transparency to 1");
        }
    } else {
        image_alpha = 1; // Reset transparency
        show_debug_message("PlayerStateSpeak: No NPC found, reset transparency to 1");
    }

    // Return to free state when the 'C' key is pressed
    if (keyboard_check_pressed(ord("C"))) {
        playerState = PlayerStateFree;
        show_debug_message("PlayerStateSpeak: Returned to PlayerStateFree");
    }
}

function PlayerStateLocked() {
    // Locked state does nothing
    show_debug_message("PlayerStateLocked: State is locked, no action taken");
}
