// Draw event in obj_Transition
if (transition_active) {
    draw_set_alpha(fade_alpha);
    draw_rectangle_color(0, 0, room_width, room_height, c_black, c_black, c_black, c_black, false);
    draw_set_alpha(1);
}
