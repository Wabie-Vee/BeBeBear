// Initialize camera properties
cam = view_camera[0];
global.follow = obj_Player;
viewWidthHalf = VIEW_WIDTH * 0.5;
viewHeightHalf = VIEW_HEIGHT * 0.5;

xTo = xstart;
yTo = ystart;

zoomTarget = .75;
lerpProgress =  0;

global.cameraZoomMultiplier = 0.75;
global.cameraZoom = 0.75;
global.cameraLerp = 0;
zoomIncrement = 0.25;
currentViewWidth = VIEW_WIDTH;
currentViewHeight = VIEW_HEIGHT;

shakeLength = 0;
shakeMagnitude = 0;
shakeRemain = 0;

global.cameraState = "Free";

// Initialize key handling properties
global.keyCooldown = 0;
global.keyHandled = false;

show_debug_message("Initialized cameraZoom in obj_Camera Create: " + string(global.cameraZoom));
