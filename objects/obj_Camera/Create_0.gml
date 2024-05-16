cam = view_camera[0];
follow = obj_Player;
viewWidthHalf = VIEW_WIDTH * 0.5;
viewHeightHalf = VIEW_HEIGHT * 0.5;
xTo = xstart;
yTo = ystart;
zoomTarget = 1;
lerpProgress =  0;

global.cameraZoomMultiplier = 1;
zoomIncrement = .25;
currentViewWidth = VIEW_WIDTH;
currentViewHeight = VIEW_HEIGHT;

shakeLength = 0;
shakeMagnitude = 0;
shakeRemain = 0;