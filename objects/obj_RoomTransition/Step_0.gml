// Define the functions at the top of the Step event
/*
function HandleFadeOut(_transitionTime) {
    fade_alpha += _transitionTime;
    if (fade_alpha >= 1) {
        fade_alpha = 1;
        transition_complete = true;
        with (obj_Player) {
            global.targetX = other.targetX;
            global.targetY = other.targetY;
            global.playerState = PlayerStateLocked;
        }
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
var _transitionTime = 0.05;

if (place_meeting(x, y, obj_Player) && !transition_active) {
    // Initiate the transition
    transition_active = true;
    transition_complete = false;
    fade_alpha = 0;
    // Lock the player immediately when the transition starts
	
    with (obj_Player) {
        if other.useFadeTransition global.playerState = PlayerStateLocked;
    }
    
    // Skip the fade transition if useFadeTransition is false
    if (!useFadeTransition) {
        with (obj_Player) {
            global.targetX = other.targetX;
            global.targetY = other.targetY;
        }
        room_goto(targetRoom);
        instance_destroy(); // Destroy the object immediately
        exit; // Exit the event to prevent further execution
    }
}

if (transition_active) {
    if (transition_complete) {
        HandleFadeIn(_transitionTime);
    } else {
        HandleFadeOut(_transitionTime);
    }
}
