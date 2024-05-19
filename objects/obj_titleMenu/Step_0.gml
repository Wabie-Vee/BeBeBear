//gather inputs
keyUp = keyboard_check_pressed(vk_up);
keyDown = keyboard_check_pressed(vk_down);
keyActivate = keyboard_check_pressed(ord("E")) || keyboard_check_pressed(vk_space);

//store number of options in current menu
opLength = array_length(option[menuLevel]);

//move through the menu
pos += keyDown - keyUp;
if pos >= opLength pos = 0;
if pos < 0 pos = opLength - 1;

if keyUp || keyDown audio_play_sound(snd_Select,1,false);


if keyActivate{
	var _startMenuLevel = menuLevel;
	switch(menuLevel){
		case 0:
			switch(pos){
				case 0: audio_stop_all(); audio_play_sound(snd_Select, 1, false); global.BGM = snd_Nature; room_goto(rm_Start); break;
		
				case 1: menuLevel = 1; break;
			
				case 2: game_end(); break;
			}
		break;
		
		case 1:
			switch(pos){
				
				//window size
				case 0: break;
				
				//controls
				case 1: break;
				
				//back
				case 2: menuLevel = 0; break;
			}
	}
	
	if _startMenuLevel != menuLevel pos = 0;
	
	//correct option length
	opLength = array_length(option[menuLevel]);
}