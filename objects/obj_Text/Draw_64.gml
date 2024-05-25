/* old text system
#region
draw_sprite_stretched(spr_Textbox,background,x1, y1 + y1Target, x2- x1, y2 - y1);
ResetText(c_black);

var _print = string_copy(message, 1, textProgress);
var _fontSize = font_get_size(global.fontMain) + 7;
var _textBorder = 16;
var _textBoxWidth = x2-x1 - 16 - _textBorder;

ResetText(c_black);
draw_text_ext(x1+ _textBorder, y1+_textBorder+y1Target, _print, _fontSize, _textBoxWidth);
ResetText(c_white);
draw_text_ext(x1+ _textBorder, y1+_textBorder+y1Target - 2, _print, _fontSize, _textBoxWidth);


if portrait != undefined{
	//animate portrait speaking
	var _messageLength = string_length(message);
	if _messageLength >= textProgress {
		portraitFrame += portraitSpeed / FRAME_RATE;
	} else {
		portraitFrame = 0;
	}	
	
	//draw portrait box

	draw_sprite_stretched(spr_Textbox, background, px1, py1 + y1Target, px2-px1, py2-py1);	
	draw_sprite(portrait, portraitFrame, 48,270 + y1Target);
	
	//draw name box
	if nameTag != undefined{
		draw_set_valign(fa_middle);
		draw_set_halign(fa_center);
		draw_sprite_stretched(spr_Textbox, background, nx1, ny1 + y1Target, nx2 - nx1, ny2 - ny1);
		draw_text_ext((nx2+nx1) /2 + nx1, ((ny2 - ny1) /2) + y1Target + ny1, nameTag, _fontSize, nx2 - nx1);

	}
}
#endregion
*/

// Drawing the text box
draw_sprite_stretched(spr_Textbox, background, x1, y1 + y1Target, x2 - x1, y2 - y1);

// Function to reset text color
function ResetText(color) {
    draw_set_color(color);
    draw_set_font(global.fontMain);
}

// Function to draw the text with effects
function DrawTextWithEffects(x, y, text, fontSize, maxWidth) {
    var color_map = ds_map_create();
    ds_map_add(color_map, "/cR", c_red);
    ds_map_add(color_map, "/cG", c_green);
    ds_map_add(color_map, "/cB", c_blue);
    ds_map_add(color_map, "/cY", c_yellow);
    ds_map_add(color_map, "/cO", c_orange);
    ds_map_add(color_map, "/cP", c_purple);
    ds_map_add(color_map, "/cW", c_white);
    ds_map_add(color_map, "/cK", c_black);

    var current_color = c_white;
    var apply_wave = false;
    var apply_shake = false;

    var draw_x = x;
    var draw_y = y;

    for (var i = 1; i <= string_length(text); i++) {
        var char = string_char_at(text, i);

        // Handle special markers
        if (char == "/" && i < string_length(text)) {
            var next_char = string_char_at(text, i + 1);
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
        if (draw_x + string_width(char) > x + maxWidth) {
            draw_x = x;
            draw_y += fontSize;
        }

        // Calculate wave and shake offsets
        var wave_offset = apply_wave ? sin(draw_x / wave_frequency) * wave_amplitude : 0;
        var shake_offset_x = apply_shake ? random_range(-shake_amplitude, shake_amplitude) : 0;
        var shake_offset_y = apply_shake ? random_range(-shake_amplitude, shake_amplitude) : 0;

        // Draw the character
        draw_set_color(current_color);
        draw_text(draw_x + shake_offset_x, draw_y + wave_offset + shake_offset_y, char);
        draw_x += string_width(char);
    }

    ds_map_destroy(color_map);
}

// Drawing the text with effects
var _print = string_copy(message, 1, textProgress);
var _fontSize = font_get_size(global.fontMain) + 7;
var _textBorder = 16;
var _textBoxWidth = x2 - x1 - 16 - _textBorder;

DrawTextWithEffects(x1 + _textBorder, y1 + _textBorder + y1Target, _print, _fontSize, _textBoxWidth);

// Drawing the portrait and name box if they exist
if (portrait != undefined) {
    var _messageLength = string_length(message);
    if (_messageLength >= textProgress) {
        portraitFrame += portraitSpeed / FRAME_RATE;
    } else {
        portraitFrame = 0;
    }

    draw_sprite_stretched(spr_Textbox, background, px1, py1 + y1Target, px2 - px1, py2 - py1);
    draw_sprite(portrait, portraitFrame, 48, 270 + y1Target);

    if (nameTag != undefined) {
        draw_set_valign(fa_middle);
        draw_set_halign(fa_center);
        draw_sprite_stretched(spr_Textbox, background, nx1, ny1 + y1Target, nx2 - nx1, ny2 - ny1);
        draw_text_ext((nx2 + nx1) / 2, (ny1 + ny2) / 2 + y1Target, nameTag, _fontSize, nx2 - nx1);
    }
}



