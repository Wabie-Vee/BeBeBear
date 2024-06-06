randomize();
InitNPCs();
global.Direction = 270;
global.gamePaused = false;
global.textSpeed = 0.75;
global.BGM = snd_HereComesBebe;
global.voice = snd_Speech2;
global.fontMain = fn_Wabfont;
global.fontTiny = fn_Tiny
global.fontBig = fn_Big
global.zoomDefault = .75;
global.fullScreen = false;
global.playerState = PlayerStateFree;
skyX = 0





//player start targets
global.targetX = -1;
global.targetY = -1;
global.oldX = -1;
global.oldY = -1;

global.iCamera = instance_create_layer(0,0,layer,obj_Camera);
display_set_gui_size(RESOLUTION_W*GUI_MULTIPLIER,RESOLUTION_H*GUI_MULTIPLIER);
room_goto(ROOM_START)








