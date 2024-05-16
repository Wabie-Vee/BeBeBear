draw_sprite_stretched(spr_Textbox,background,x1,y1,x2-x1,y2-y1);
ResetText(c_black);

var _print = string_copy(message, 1, textProgress);
draw_text((x1+x2)/2, y1+8, _print);
ResetText(c_white);
draw_text((x1+x2)/2, y1+7, _print);

