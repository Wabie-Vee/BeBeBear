if instance_exists(global.follow){
	if global.targetX != -1{
		x = global.targetX;
	} else {
		x = global.follow.x	
	}
	
	if global.targetY != -1{
	y = global.targetY - global.follow.sprite_height/2;
	} else {
		y = global.follow.y - global.follow.sprite_height/2;	
	}
	
}