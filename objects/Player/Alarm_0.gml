if (anim_running) {
    tilemap_set(gui_tilemap[1], tile_frames[anim_index], tile_x, tile_y);
    
    anim_index += 1;
    if (anim_index < array_length(tile_frames)) {
        alarm[0] = 5; // Nächstes Frame nach 5 Steps
    } else {
        anim_running = false; // Stoppe Animation am Ende
    }
}