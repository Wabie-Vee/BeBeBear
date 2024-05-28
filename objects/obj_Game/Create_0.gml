randomize();
global.gamePaused = false;
global.textSpeed = 0.75;
global.BGM = snd_HereComesBebe;
global.voice = snd_Speech2;
global.fontMain = fn_Fancy;
global.fontTiny = fn_Tiny
global.fontBig = fn_Big
global.zoomDefault = .75;
global.fullScreen = false;

global.iCamera = instance_create_layer(0,0,layer,obj_Camera);
display_set_gui_size(RESOLUTION_W*GUI_MULTIPLIER,RESOLUTION_H*GUI_MULTIPLIER);
room_goto(ROOM_START)






