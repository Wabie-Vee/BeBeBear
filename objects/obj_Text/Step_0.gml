lerpProgress += (1 - lerpProgress) / 50;
textProgress += global.textSpeed;

y1Target = lerp(y1Target, 0, lerpProgress);

// Speech sound
voiceTimer += global.textSpeed;
var _messageLength = string_length(message);
if (voiceTimer >= 4 && textProgress < _messageLength && voice != undefined) {
    voiceTimer = 0;
    if (audio_is_playing(voice)) {
        audio_stop_sound(voice);
    }
    audio_sound_pitch(voice, random_range(0.8, 1));
    audio_play_sound(voice, 1, false);
}

// Kill textbox
if (keyboard_check_pressed(vk_space)) {
    var _messageLength = string_length(message);
    if (textProgress >= _messageLength) {
        if (instance_exists(obj_TextQueued)) {
            with (obj_TextQueued) ticket--;
        } else {
            with obj_Player global.playerState = lastState;
        }
        instance_destroy();
    } else {
        if (textProgress > 4) {
            textProgress = _messageLength;
        }
    }
}
