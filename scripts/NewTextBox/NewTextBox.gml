function NewTextBox(_message, _dialogueResponses, _voice, _portrait, _name) {
    var _obj;
    if (instance_exists(obj_Text)) {
        _obj = obj_TextQueued;
    } else {
        _obj = obj_Text;
    }
    with (instance_create_layer(0, 0, "Instances", _obj)) {
        message = _message;
        if (instance_exists(other)) {
            originInstance = other.id;
        } else {
            originInstance = noone;
        }

        // Initialize responses and responseScripts as empty arrays
        responses = [];
        responseScripts = [];

        // Check if dialogue responses are defined and copy them
        if (_dialogueResponses != undefined && array_length(_dialogueResponses) > 0) {
            for (var i = 0; i < array_length(_dialogueResponses); i++) {
                responses[i] = _dialogueResponses[i];
            }

            // Trim markers from responses and convert to real numbers
            for (var i = 0; i < array_length(responses); i++) {
                var _markerPosition = string_pos(":", responses[i]);
                if (_markerPosition > 0) {
                    var _scriptPart = string_copy(responses[i], 1, _markerPosition - 1);
                    if (_scriptPart != "") {
                        responseScripts[i] = real(_scriptPart);
                    } else {
                        responseScripts[i] = -1;
                    }
                    responses[i] = string_delete(responses[i], 1, _markerPosition);
                } else {
                    responseScripts[i] = -1; // Default value for invalid entries
                }
            }
        } else {
            responses[0] = -1;
            responseScripts[0] = -1;
        }

        // Debug messages to check responses and responseScripts
        show_debug_message("NewTextBox - Responses: " + string(responses));
        show_debug_message("NewTextBox - Response Scripts: " + string(responseScripts));

        // Check if voice sound is defined
        if (_voice != undefined) {
            voice = _voice;
            if (_portrait != undefined) {
                portrait = _portrait;
                portraitSpeed = 10;
                portraitLength = sprite_get_number(portrait);
                portraitFrame = 0;
                x1 = 95;
                x2 = RESOLUTION_W * GUI_MULTIPLIER;
                y1 = 224;
                y2 = 352;
                px1 = 0;
                px2 = 95;
                py1 = 224;
                py2 = 319;
                nx1 = 0;
                nx2 = 95;
                ny1 = 319;
                ny2 = 352;

                // Check if a name is specified
                if (_name == undefined) {
                    py2 = 352;
                    nameTag = undefined;
                } else {
                    nameTag = _name;
                }
            } else {
                portrait = undefined;
                x1 = 0;
                x2 = RESOLUTION_W * GUI_MULTIPLIER;
                y1 = 224;
                y2 = 352;
            }
        } else {
            voice = global.voice;
            portrait = undefined;
            x1 = 0;
            x2 = RESOLUTION_W * GUI_MULTIPLIER;
            y1 = 224;
            y2 = 352;
        }

        if (instance_exists(obj_TextQueued)) {
            y1Target = 0;
        } else {
            y1Target = 352 - 224;
        }
    }

    with (obj_Player) {
        if (!instance_exists(obj_TextQueued)) {
            lastState = global.playerState;
            global.playerState = PlayerStateSpeak;
        }
    }
}
