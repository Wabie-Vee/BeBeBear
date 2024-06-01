// Drawing the text box
draw_sprite_stretched(spr_Textbox, background, x1, y1 + y1Target, x2 - x1, y2 - y1);
var _print = string_copy(message, 1, textProgress);
var _responsePrint = "";
// Function to reset text color
function ResetText(color) {
    draw_set_color(color);
    draw_set_font(global.fontMain);
}

// Function to draw the text with effects
function DrawTextWithEffects(x, y, text, fontSize, maxWidth) {
    var color_map = ds_map_create();
    ds_map_add(color_map, "cR", c_red);
    ds_map_add(color_map, "cG", c_green);
    ds_map_add(color_map, "cB", c_blue);
    ds_map_add(color_map, "cY", c_yellow);
    ds_map_add(color_map, "cO", c_orange);
    ds_map_add(color_map, "cP", c_purple);
    ds_map_add(color_map, "cW", c_white);
    ds_map_add(color_map, "cK", c_black);
    ds_map_add(color_map, "cL", c_olive);

    var default_color = c_white;
    var current_color = default_color;
    var apply_wave = false;
    var apply_shake = false;

    var draw_x = x;
    var draw_y = y;

    var words = string_split(text, " ");
    for (var i = 0; i < array_length(words); i++) {
        var word = words[i];
        var word_width = string_width(word);

        // Check for line break before drawing the word
        if (draw_x + word_width > x + maxWidth) {
            draw_x = x;
            draw_y += fontSize;
        }

        for (var j = 1; j <= string_length(word); j++) {
            var char = string_char_at(word, j);

            // Handle special markers
            if (char == "/" && j < string_length(word)) {
                var next_char = string_char_at(word, j + 1);
                var marker = string_copy(word, j + 1, 2);
                if (ds_map_exists(color_map, marker)) {
                    current_color = ds_map_find_value(color_map, marker);
                    j += 2; // Skip the next characters as they are part of the marker
                    continue;
                } else if (next_char == "w") {
                    apply_wave = !apply_wave;
                    j++; // Skip the next character as it is part of the marker
                    continue;
                } else if (next_char == "s") {
                    apply_shake = !apply_shake;
                    j++; // Skip the next character as it is part of the marker
                    continue;
                }
            }

            // Only draw the character if it's not part of a marker
            if (char != "/") {
                // Calculate wave and shake offsets
                var wave_offset = apply_wave ? sin(current_time / 500 + draw_x / wave_frequency) * wave_amplitude : 0;
                var shake_offset_x = apply_shake ? random_range(-shake_amplitude, shake_amplitude) : 0;
                var shake_offset_y = apply_shake ? random_range(-shake_amplitude, shake_amplitude) : 0;

                // Draw the character
                draw_set_color(current_color);
                draw_text(draw_x + shake_offset_x, draw_y + wave_offset + shake_offset_y, char);
                draw_x += string_width(char);

                // Reset color to white after each character
                draw_set_color(default_color);
            }
        }

        // Add space between words except the last one
        if (i < array_length(words) - 1) {
            draw_x += string_width(" ");
        }
    }

    ds_map_destroy(color_map);
}

// Drawing the text with effects
var _fontSize = font_get_size(global.fontMain) + 7;
var _textBorder = 16;
var _textBoxWidth = x2 - x1 - 16 - _textBorder;

DrawTextWithEffects(x1 + _textBorder, y1 + _textBorder + y1Target, _print, _fontSize, _textBoxWidth);

// Function to draw response options with effects
function DrawResponsesWithEffects(x, y, responses, selectedIndex, fontSize) {
    var response_y = y;
    var color_map = ds_map_create();
    ds_map_add(color_map, "cR", c_red);
    ds_map_add(color_map, "cG", c_green);
    ds_map_add(color_map, "cB", c_blue);
    ds_map_add(color_map, "cY", c_yellow);
    ds_map_add(color_map, "cO", c_orange);
    ds_map_add(color_map, "cP", c_purple);
    ds_map_add(color_map, "cW", c_white);
    ds_map_add(color_map, "cK", c_black);
    ds_map_add(color_map, "cL", c_olive);

    var default_color = c_white;
    var current_color = default_color;
    var apply_wave = false;
    var apply_shake = false;

    for (var i = 0; i < array_length(responses); i++) {
        var response = responses[i];
        var draw_x = x;

        if (i == selectedIndex) {
            current_color = c_yellow;
        } else {
            current_color = default_color;
        }

        for (var j = 1; j <= string_length(response); j++) {
            var char = string_char_at(response, j);

            // Handle special markers
            if (char == "/" && j < string_length(response)) {
                var next_char = string_char_at(response, j + 1);
                var marker = string_copy(response, j + 1, 2);
                if (ds_map_exists(color_map, marker)) {
                    current_color = ds_map_find_value(color_map, marker);
                    j += 2; // Skip the next characters as they are part of the marker
                    continue;
                } else if (next_char == "w") {
                    apply_wave = !apply_wave;
                    j++; // Skip the next character as it is part of the marker
                    continue;
                } else if (next_char == "s") {
                    apply_shake = !apply_shake;
                    j++; // Skip the next character as it is part of the marker
                    continue;
                }
            }

            // Only draw the character if it's not part of a marker
            if (char != "/") {
                // Calculate wave and shake offsets
                var wave_offset = apply_wave ? sin(current_time / 500 + draw_x / wave_frequency) * wave_amplitude : 0;
                var shake_offset_x = apply_shake ? random_range(-shake_amplitude, shake_amplitude) : 0;
                var shake_offset_y = apply_shake ? random_range(-shake_amplitude, shake_amplitude) : 0;

                // Draw the character
                draw_set_color(current_color);
                draw_text(draw_x + shake_offset_x, response_y + wave_offset + shake_offset_y, char);
                draw_x += string_width(char);

                // Reset color to white after each character
                draw_set_color(default_color);
            }
        }

        response_y += fontSize; // Move to the next line
    }

    ds_map_destroy(color_map);
}

// Draw responses underneath the main text
if (responses[0] != -1 && textProgress >= string_length(message)) {
    var response_y = y1 + _textBorder + 8 + y1Target + _fontSize * 2; // Adjust vertical position as needed
	draw_set_halign(fa_right);
    DrawResponsesWithEffects(x1 + _textBorder + 6, response_y, responses, responseSelected, _fontSize);
}

// Drawing the portrait and name box if they exist
if (portrait != undefined) {
    var _messageLength = string_length(message);
    if (_messageLength >= textProgress) {
        portraitFrame += portraitSpeed / FRAME_RATE;
    } else {
        portraitFrame = 0;
    }

    draw_sprite_stretched(spr_Textbox, background, px1, py1 + y1Target, px2 - px1, py2 - py1);
    var _portraitScale = 1.25;
    draw_sprite_ext(portrait, portraitFrame, 48, 270 + y1Target, 1.25, 1.25, 0, c_white, 1);

    if (nameTag != undefined) {
        draw_set_valign(fa_middle);
        draw_set_halign(fa_center);
        draw_sprite_stretched(spr_Textbox, background, nx1, ny1 + y1Target, nx2 - nx1, ny2 - ny1);
        draw_text_ext((nx2 + nx1) / 2, (ny1 + ny2) / 2 + y1Target, nameTag, _fontSize, nx2 - nx1);
    }
}
