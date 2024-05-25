/// DrawTextFX(x, y, max_width, text, shake_amplitude, wave_amplitude, wave_frequency, type_speed, _keyActivate)
/// @param x The x-coordinate to start drawing the text
/// @param y The y-coordinate to start drawing the text
/// @param max_width The maximum width of the text before a line break happens
/// @param text The string of text to be displayed with inline color and effect markers
/// @param shake_amplitude The amplitude of the shake effect
/// @param wave_amplitude The amplitude of the wave effect
/// @param wave_frequency The frequency of the wave effect
/// @param type_speed The speed of the typewriter effect (characters per frame)
/// @param _keyActivate The key to press to skip the typewriter effect

function DrawTextFX(x, y, max_width, text, shake_amplitude, wave_amplitude, wave_frequency, type_speed, _keyActivate) {
    var color_map = ds_map_create();
    ds_map_add(color_map, "/cR", c_red);
    ds_map_add(color_map, "/cG", c_green);
    ds_map_add(color_map, "/cB", c_blue);
    ds_map_add(color_map, "/cY", c_yellow);
    ds_map_add(color_map, "/cO", c_orange);
    ds_map_add(color_map, "/cP", c_purple);
    ds_map_add(color_map, "/cW", c_white);
    ds_map_add(color_map, "/cK", c_black);

    // Initialize variables
    var default_color = c_white;
    var current_color = default_color;
    var apply_wave = false;
    var apply_shake = false;

    // Initialize typing variables (these should be instance variables to retain state across frames)
    if (!variable_instance_exists(id, "char_index")) {
        char_index = 0;
    }
    if (!variable_instance_exists(id, "typing_done")) {
        typing_done = false;
    }

    // Check if the key to skip the typewriter effect is pressed
    if (keyboard_check_pressed(_keyActivate)) {
        typing_done = true;
    }

    // Manually split the text into characters
    var characters = [];
    for (var i = 1; i <= string_length(text); i++) {
        array_push(characters, string_char_at(text, i));
    }
    var total_chars = array_length(characters);

    // Draw each character with effects
    var draw_x = x;
    var draw_y = y;
    for (var i = 0; i < total_chars; i++) {
        var char = characters[i];

        // Apply typewriter effect
        if (!typing_done && char_index < total_chars) {
            char_index += type_speed;
        } else {
            typing_done = true;
        }

        // Handle special markers
        if (char == "/" && i < total_chars - 1) {
            var next_char = characters[i + 1];
            var marker = "/" + next_char;
            if (ds_map_exists(color_map, marker)) {
                current_color = ds_map_find_value(color_map, marker);
                i++; // Skip the next character as it is part of the marker
                continue;
            } else if (next_char == "w") {
                apply_wave = !apply_wave;
                i++; // Skip the next character as it is part of the marker
                continue;
            } else if (next_char == "s") {
                apply_shake = !apply_shake;
                i++; // Skip the next character as it is part of the marker
                continue;
            }
        }

        // Check for line break
        if (draw_x + string_width(char) > x + max_width) {
            draw_x = x;
            draw_y += string_height(char);
        }

        // Draw current character if within the typing limit
        if (i < char_index) {
            var wave_offset = apply_wave ? sin(draw_x / wave_frequency) * wave_amplitude : 0;
            var shake_offset = apply_shake ? random_range(-shake_amplitude, shake_amplitude) : 0;

            draw_set_color(current_color);
            draw_text(draw_x, draw_y + wave_offset + shake_offset, char);
            draw_x += string_width(char);
        }
    }

    // Reset variables if typing is done
    if (typing_done) {
        char_index = total_chars;
    }

    ds_map_destroy(color_map);
}
