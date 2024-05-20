// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ResetText(_color){
	draw_set_font(global.fontMain);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_color(_color);
}