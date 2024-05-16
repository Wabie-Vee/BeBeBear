lerpProgress += (1 - lerpProgress) / 50;

//Update Camera
if instance_exists(follow){
	xTo = follow.x
	yTo = follow.y - (follow.sprite_height/2);
}

x += (xTo - x) / 15;
y += (yTo - y) / 15;

//keep camera center inside room
x = clamp(x, viewWidthHalf, room_width - viewWidthHalf);
y = clamp(y, viewHeightHalf, room_height - viewHeightHalf);

//zoom in and out
if keyboard_check_pressed(ord("O")) and zoomTarget > .5 {
	lerpProgress = 0;
	audio_play_sound(snd_CameraZoomIn,1,false);
	zoomTarget -= zoomIncrement;
}

if keyboard_check_pressed(ord("P")) and zoomTarget < 1 {
	lerpProgress = 0;
	audio_play_sound(snd_CameraZoomOut,1,false);
	zoomTarget += zoomIncrement;
}

global.cameraZoomMultiplier = lerp(global.cameraZoomMultiplier, zoomTarget, lerpProgress);

//update camera
viewWidthHalf = (RESOLUTION_W * global.cameraZoomMultiplier) / 2;
viewHeightHalf = (RESOLUTION_H * global.cameraZoomMultiplier) / 2;
camera_set_view_size(cam, RESOLUTION_W * global.cameraZoomMultiplier, RESOLUTION_H * global.cameraZoomMultiplier);
camera_set_view_pos(cam, x - viewWidthHalf, y - viewHeightHalf);