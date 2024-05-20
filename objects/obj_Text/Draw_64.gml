draw_sprite_stretched(spr_Textbox,background,x1, y1 + y1Target, x2- x1, y2 - y1);
ResetText(c_black);

var _print = string_copy(message, 1, textProgress);
var _fontSize = font_get_size(global.fontMain) + 3;
var _textBoxWidth = x2-x1;
ResetText(c_black);
draw_text_ext(x1+ 8, y1+8+y1Target, _print, _fontSize, _RESOLUTION_W - 16);
ResetText(c_white);
draw_text_ext(x1+ 8, y1+7+y1Target, _print, _fontSize, _RESOLUTION_W - 16);

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

