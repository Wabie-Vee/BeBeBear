if !playerAFK{
	var _image_index = round(image_index);
} else {
	var _image_index = 0;	
}
draw_sprite_ext(spr_PlayerShadow, _image_index, x,y, 1, 1, 0, c_white, .5);
draw_self();
