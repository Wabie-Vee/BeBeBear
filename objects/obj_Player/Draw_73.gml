if (drawPointer == true) && (global.playerState == PlayerStateFree) {
    var _activateX = lengthdir_x(10, direction);
    var _activateY = lengthdir_y(10, direction);
    var _nearestEntity = instance_nearest(x + _activateX, y + _activateY, par_Entity);

    if (_nearestEntity != noone) {
        draw_sprite(spr_Exclaim, 0, _nearestEntity.x, _nearestEntity.bbox_top - Wave(0, 4, 1, 0));
    }
}
