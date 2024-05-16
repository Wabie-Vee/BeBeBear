if global.gamePaused
{
	draw_set_alpha(.5);
	draw_rectangle_color(0,0,RESOLUTION_W,RESOLUTION_H,c_black,c_black,c_black,c_black, false);
	draw_set_alpha(1);
}
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_text(10,10,"BEBEBEAR PRE-PRE-ALPHA");