// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function NewTextBox(){
	var _obj;
	if instance_exists(obj_Text) _obj = obj_TextQueued ; else _obj = obj_Text
	with (instance_create_layer(0,0,"Instances", _obj))
	{
		message = argument0;
		voice = argument1;
		
		if (instance_exists(other))  originInstance = other.id else originInstance = noone;
	}
}