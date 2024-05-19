draw_sprite_stretched(spr_Textbox,background,x1,y1,x2-x1,y2-y1);
ResetText(c_black);

var _print = string_copy(message, 1, textProgress);
var _fontSize = font_get_size(fn_Wabfont) + 3;
draw_text_ext((x1+x2)/2, y1+8, _print, _fontSize, _RESOLUTION_W - 16);
ResetText(c_white);
draw_text_ext((x1+x2)/2, y1+7, _print, _fontSize, _RESOLUTION_W - 16);

