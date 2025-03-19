if (collision_rectangle(x, y + 24, x + sprite_width, y + sprite_height, global.tilemap, true, true)) {
    move_and_collide(-hspeed, -vspeed, Player, 16);
    speed = 0;
    running = false;
}

if (running) {
    speed = 6;
} else {
    speed = 0;
}

if (x <= 400 && room == Office) {
    room_goto(BuildRoom);
}