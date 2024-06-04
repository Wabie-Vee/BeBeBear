function NewTextBox(_character, _dialogueResponses, _message) {
    // Function to create a textbox
    var CreateTextBox = function(message, character, dialogueResponses, isLast) {
        var obj;
        if (instance_exists(obj_Text)) {
            obj = obj_TextQueued;
        } else {
            obj = obj_Text;
        }

        var newTextBox = instance_create_layer(0, 0, "Instances", obj);

        // Set the message immediately to ensure it is initialized
        newTextBox.message = message;

        with (newTextBox) {
            if (instance_exists(other)) {
                originInstance = other.id;
            } else {
                originInstance = noone;
            }

            // Initialize responses and responseScripts as empty arrays
            responses = [];
            responseScripts = [];

            // Ensure responses and responseScripts arrays have at least one element
            responses[0] = -1;
            responseScripts[0] = -1;

            // Check if dialogue responses are defined and copy them (only for the last textbox)
            if (isLast && dialogueResponses != undefined && array_length(dialogueResponses) > 0) {
                for (var i = 0; i < array_length(dialogueResponses); i++) {
                    responses[i] = dialogueResponses[i];
                }

                // Trim markers from responses and convert to real numbers
                for (var i = 0; i < array_length(responses); i++) {
                    var markerPosition = string_pos(":", responses[i]);
                    if (markerPosition > 0) {
                        var scriptPart = string_copy(responses[i], 1, markerPosition - 1);
                        if (scriptPart != "") {
                            responseScripts[i] = real(scriptPart);
                        } else {
                            responseScripts[i] = -1;
                        }
                        responses[i] = string_delete(responses[i], 1, markerPosition);
                    } else {
                        responseScripts[i] = -1; // Default value for invalid entries
                    }
                }
            }

            // Extract character details from the struct
            if (character != undefined) {
                voice = character.voice;
                portrait = character.portrait;
                nameTag = character.name;
            } else {
                voice = undefined;
                portrait = undefined;
                nameTag = undefined;
            }

            // Set voice and portrait properties
            if (voice != undefined) {
                voice = voice;
            } else {
                voice = global.voice;
            }

            if (portrait != undefined) {
                portrait = portrait;
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
                if (nameTag == undefined) {
                    py2 = 352;
                    nameTag = undefined;
                } else {
                    nameTag = nameTag;
                }
            } else {
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
    };

    // Create the first textbox
    CreateTextBox(_message, _character, _dialogueResponses, argument_count == 3);

    // Create additional textboxes if provided
    for (var i = 3; i < argument_count; i++) {
        var isLast = (i == argument_count - 1);
        var additionalMessage = argument[i];
        CreateTextBox(additionalMessage, _character, _dialogueResponses, isLast);
    }
}