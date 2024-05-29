// Step event in obj_Transition

// Define the functions
function HandleFadeOut(_transitionTime) {
    fade_alpha += _transitionTime;
    if (fade_alpha >= 1) {
        fade_alpha = 1;
        transition_complete = true;
        room_goto(targetRoom);
    }
}

function HandleFadeIn(_transitionTime) {
    fade_alpha -= _transitionTime;
    if (fade_alpha <= 0) {
        fade_alpha = 0;
        transition_active = false;
        with (obj_Player) {
            global.playerState = PlayerStateFree;
        }
        instance_destroy(); // Destroy the object after the transition is complete
    }
}

// Step event logic
if (transition_active) {
    if (transition_complete) {
        HandleFadeIn(_transitionTime);
    } else {
        HandleFadeOut(_transitionTime);
    }
}
