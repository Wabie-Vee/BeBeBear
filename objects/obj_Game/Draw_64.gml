if global.gamePaused
{
	draw_set_alpha(.5);
	draw_rectangle_color(0,0,RESOLUTION_W,RESOLUTION_H,c_black,c_black,c_black,c_black, false);
	draw_set_alpha(1);
}
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_font(fn_Font2);
draw_text(10,5,"BEBEBEAR PRE-PRE-ALPHA");