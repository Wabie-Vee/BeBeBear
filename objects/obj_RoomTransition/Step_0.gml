// par_RoomTransition Step Event
if (place_meeting(x, y, obj_Player) && !transition_active) {
    // Initiate the transition
    transition_active = true;
    transition_complete = false;
    if (useFadeTransition) {
        fade_alpha = 0;
    }
}

if (transition_active) {
    if (useFadeTransition) {
        if (fade_alpha < 1) {
            fade_alpha += 0.05; // Increase fade_alpha to create fade out effect
        } else if (!transition_complete) {
            transition_complete = true;
            with (obj_Player) {
                global.targetX = other.targetX;
                global.targetY = other.targetY;
                global.playerState = PlayerStateLocked; // Lock player state during transition
            }
            room_goto(targetRoom);
        } else {
            if (fade_alpha > 0) {
                fade_alpha -= 0.05; // Decrease fade_alpha to create fade in effect
            } else {
                transition_active = false;
                with (obj_Player) {
                    global.playerState = PlayerStateFree; // Unlock player state after transition
                }
            }
        }
    } else {
        if (!transition_complete) {
            transition_complete = true;
            with (obj_Player) {
                global.targetX = targetX;
                global.targetY = targetY;
                global.playerState = PlayerStateLocked; // Lock player state during transition
            }
            room_goto(targetRoom);
        } else {
            transition_active = false;
            with (obj_Player) {
                global.playerState = PlayerStateFree; // Unlock player state after transition
            }
        }
    }
}
