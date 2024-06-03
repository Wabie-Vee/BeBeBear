//gather inputs
keyLeft = keyboard_check(vk_left) or keyboard_check(ord("A"));
keyRight = keyboard_check(vk_right) or keyboard_check(ord("D"));
keyUp = keyboard_check(vk_up) or keyboard_check(ord("W"));
keyDown = keyboard_check(vk_down) or keyboard_check(ord("S"));
keyActivate = keyboard_check_pressed(ord("E")) || keyboard_check_pressed(vk_space);
keyRun = keyboard_check(vk_shift);

inputDirection = point_direction(0, 0, keyRight - keyLeft, keyDown - keyUp);
inputMagnitude = (keyRight - keyLeft != 0)  or (keyDown - keyUp != 0);

//Run global.playerState
if !global.gamePaused script_execute(global.playerState);

//depthsort
depth = -bbox_bottom;

//check direction debug
show_debug_message(direction);
