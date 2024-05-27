// Ensure no unexpected modification to global.cameraZoom
if (global.cameraZoom != 0.5 && global.cameraZoom != 0.75 && global.cameraZoom != 1) {
    show_debug_message("Unexpected value detected in cameraZoom: " + string(global.cameraZoom));
}

// Update the cooldown timer
if (global.keyCooldown > 0) {
    global.keyCooldown--;
}

// Reset the keyHandled flag at the start of the frame
global.keyHandled = false;

// Camera state handling
switch (global.cameraState) {
    case "Free":
        global.follow = obj_Player;
        if (instance_exists(global.follow)) {
            xTo = global.follow.x;
            yTo = global.follow.y - (global.follow.sprite_height / 2);
        }
        
        // Zoom in and out
        if (!global.keyHandled && global.keyCooldown == 0) {
            if (keyboard_check_pressed(ord("O")) && global.cameraZoom > 0.5) {
                global.cameraLerp = 0;
                audio_play_sound(snd_CameraZoomIn, 1, false);
                global.cameraZoom -= zoomIncrement;
                global.keyCooldown = 10; // Set the cooldown duration (adjust as needed)
                global.keyHandled = true; // Mark the key as handled
            }

            if (keyboard_check_pressed(ord("P")) && global.cameraZoom < 1) {
                global.cameraLerp = 0;
                audio_play_sound(snd_CameraZoomOut, 1, false);
                global.cameraZoom += zoomIncrement;
                global.keyCooldown = 10; // Set the cooldown duration (adjust as needed)
                global.keyHandled = true; // Mark the key as handled
            }
        }
        break;
    
    case "Talking":
        if (instance_exists(global.follow)) {
            xTo = global.follow.x;
            yTo = global.follow.y - (global.follow.sprite_height / 2);
        }
        global.cameraZoom = 0.5;
        break;
}

// Debug message for current zoom level

// Smoothly transition camera properties
lerpProgress += (1 - lerpProgress) / 50;
global.cameraLerp += (1 - global.cameraLerp) / 100;

// Update Camera position
x += (xTo - x) / 15;
y += (yTo - y) / 15;

// Keep camera center inside room
x = clamp(x, viewWidthHalf, room_width - viewWidthHalf);
y = clamp(y, viewHeightHalf, room_height - viewHeightHalf);

// Smoothly update camera zoom multiplier
global.cameraZoomMultiplier = lerp(global.cameraZoomMultiplier, global.cameraZoom, global.cameraLerp);

// Update camera view size and position
viewWidthHalf = (RESOLUTION_W * global.cameraZoomMultiplier) / 2;
viewHeightHalf = (RESOLUTION_H * global.cameraZoomMultiplier) / 2;
camera_set_view_size(cam, RESOLUTION_W * global.cameraZoomMultiplier, RESOLUTION_H * global.cameraZoomMultiplier);
camera_set_view_pos(cam, x - viewWidthHalf, y - viewHeightHalf);
