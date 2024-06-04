lerpProgress += (1 - lerpProgress) / 50;
textProgress += global.textSpeed;
var _messageLength = string_length(message);
y1Target = lerp(y1Target, 0, lerpProgress);

//cycle through responses
keyUp = keyboard_check_pressed(vk_up) or keyboard_check_pressed(ord("W"));
keyDown = keyboard_check_pressed(vk_down) or keyboard_check_pressed(ord("S"));

if textProgress >= _messageLength{
	responseSelected += (keyDown - keyUp);
	if keyDown or keyUp audio_play_sound(snd_Select, 1, false);
}

var _max = array_length(responses) - 1;
var _min = 0;
if (responseSelected > _max) responseSelected = _min;
if (responseSelected < _min) responseSelected = _max;

// Speech sound
voiceTimer += global.textSpeed;
if (voiceTimer >= 4 && textProgress < _messageLength && voice != undefined) {
    voiceTimer = 0;
    if (audio_is_playing(voice)) {
        audio_stop_sound(voice);
    }
    audio_sound_pitch(voice, random_range(0.8, 1.2));
    audio_play_sound(voice, 1, false);
}

// Kill textbox
if (keyboard_check_pressed(vk_space)) {
    if (textProgress >= _messageLength) {
		
		if (responses[0] != -1){
			with (originInstance) DialogueResponses(other.responseScripts[other.responseSelected]);
		}
		
        if (instance_exists(obj_TextQueued)) {
            with (obj_TextQueued) ticket--;
        } else {
			global.cameraLerp = 0;
			global.cameraState = "Free"
			global.cameraZoom = global.zoomDefault;
            with obj_Player global.playerState = lastState;
        }
        instance_destroy();
    } else {
        if (textProgress > 4) {
            textProgress = _messageLength;
        }
    }
}
