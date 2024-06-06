depth = 2000;

var _skyWidth = sprite_get_width(spr_NightSky);
skyX -= .2;
if skyX <= -_skyWidth skyX = 0;

//draw the first sky
draw_sprite(spr_NightSky, image_index, skyX, 0)

//draw the second sky
draw_sprite(spr_NightSky, image_index, skyX + _skyWidth, 0);
