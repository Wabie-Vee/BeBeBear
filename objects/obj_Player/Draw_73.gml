if drawPointer = true && global.playerState = PlayerStateFree{
	var _activateX = lengthdir_x(10, direction);
	var _activateY = lengthdir_y(10, direction);
	var _activate = instance_position(x + _activateX, y + _activateY, par_Entity);
	if _activate != noone{
		if _activate.sprite_index != noone{
		var _drawX = _activate.sprite_width/2;
		var _drawY = _activate.sprite_height;
		} else {
		var _drawX = 0;
		var _drawY = 0;
		}
		draw_sprite(spr_Exclaim, 0, _activate.x, _activate.bbox_top - Wave(0,4,1,0))
	}
	
}