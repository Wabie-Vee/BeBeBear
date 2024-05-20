
draw_set_font(global.fontMain);

//dynamically get width and height of menu
height = opSpace * 2 + string_height(option[0,0]) + (opLength -1) * opSpace;
var _newWidth = 0;

for (var i = 0; i < opLength; i++){
	var _optionWidth = string_width(option[menuLevel, i]);
	_newWidth = max(_newWidth, _optionWidth);
}
width = _newWidth + opBorder
draw_sprite_ext(sprite_index, image_index, xTo, yTo, width/sprite_width, height/sprite_height, 0, c_white, 1)

draw_set_valign(fa_top);
draw_set_halign(fa_center);
for (var i = 0; i < opLength; i++) {
	var _c = c_white
	if pos == i _c = c_yellow;
	draw_text_color(xTo, yTo - height/2 + opSpace + opSpace * i, option[menuLevel, i], _c, _c, _c, _c, 1);	
}
