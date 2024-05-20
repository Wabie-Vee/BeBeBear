// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function NewTextBox(_message, _voice, _portrait, _name){
	var _obj;
	if instance_exists(obj_Text) _obj = obj_TextQueued ; else _obj = obj_Text
	with (instance_create_layer(0,0,"Instances", _obj))
	{
		message = _message;
		if _voice != undefined
		{
			voice = _voice
			if _portrait != undefined {
				
				portrait = _portrait;
				portraitSpeed = 10;
				portraitlength = sprite_get_number(portrait);
				portraitFrame = 0;
				x1 = 95;
				x2 = RESOLUTION_W*GUI_MULTIPLIER;
				y1 = 224;
				y2 = 352;
				px1 = 0;
				px2 = 95;
				py1 = 224;
				py2 = 319;
				nx1 = 0;
				nx2 = 95;
				ny1 = 319;
				ny2 = 352;
				
				//if there is no named specified
				if _name == undefined{
					py2 = 352;	
					nameTag = undefined;
				} else {
					nameTag = _name;
				}

			} else {
				portrait = undefined;	
				x1 = 0;
				x2 = RESOLUTION_W*GUI_MULTIPLIER;
				y1 = 224;
				y2 = 352;
			}
		} else {
			voice = global.voice
			portrait = undefined;	
			x1 = 0;
			x2 = RESOLUTION_W*GUI_MULTIPLIER;
			y1 = 224;
			y2 = 352;
		}
		
		if instance_exists(obj_TextQueued){
			y1Target = 0	
		} else {
			y1Target = 352-224;
}
		
	}
	
	with (obj_Player)
	{
		if (global.playerState != PlayerStateLocked)
		{
			lastState = global.playerState;
			global.playerState = PlayerStateLocked
		}
	}
}