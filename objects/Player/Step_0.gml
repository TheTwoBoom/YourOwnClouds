if (collision_rectangle(x, y + 24, x + sprite_width, y + sprite_height, tilemap, true, true)) {
    move_and_collide(-hspeed, -vspeed, Player, 16);
    running = false;
}

if (position_meeting(mouse_x, mouse_y, gui_tilemap) && mouse_check_button_pressed(mb_left)) {
    if (layer_get_visible(desktop_symbollayer)) {
        var data = tilemap_get_at_pixel(gui_tilemap[1], mouse_x, mouse_y);
        if (data == 1675) {
            anim_index = 0;
            anim_running = true;
            tile_x = tilemap_get_cell_x_at_pixel(gui_tilemap[1], mouse_x, mouse_y);
            tile_y = tilemap_get_cell_y_at_pixel(gui_tilemap[1], mouse_x, mouse_y);
            alarm[0] = 5; // Starte die Animation mit einer Verzögerung
            tile_frames = [1675, 1676, 1677, 1676, 1675];
        } else if (data = 330) {
            show_debug_message("Das ist ein Fragezeichen Button")
        } else if (data = 271) {
            layer_set_visible(desktop_textlayer, false);
            layer_set_visible(desktop_symbollayer, false);
            layer_set_visible(email_textlayer, true);
            layer_set_visible(email_symbollayer, true);
            layer_set_visible(email_contentlayer, true);
        } else if (data = 150) {
            show_debug_message("Das ist ein Customers Button")
        } else if (data = 395) {
            show_debug_message("Das ist ein Shop Button")
        }
    } else if (layer_get_visible(email_symbollayer)) {
        var data = tilemap_get_at_pixel(gui_tilemap[0], mouse_x, mouse_y);
        if (data == 152) {
            layer_set_visible(desktop_textlayer, true);
            layer_set_visible(desktop_symbollayer, true);
            layer_set_visible(email_textlayer, false);
            layer_set_visible(email_symbollayer, false);
            layer_set_visible(email_contentlayer, false);
        } else if (data == 214 && global.y_offset > 0) {
            global.y_offset -= 1;
        } else if (data == 213 && global.y_offset <= variable_struct_names_count(global.emails) - 10) {
            global.y_offset += 1;
        }
    }
} else if (mouse_check_button_pressed(mb_left) && layer_get_visible(email_symbollayer)) {
    for (i=global.y_offset+1;i<(10 + global.y_offset);i++) {
        email = global.emails[$ i];
        title_x = 416;
        title_y = 240 + i * 20 - global.y_offset * 20;
        if (mouse_x >= title_x && mouse_x <= title_x + 128 && mouse_y >= title_y && mouse_y <= title_y + 32) {
            global.viewed_email = email;
        }
    }
}

if (running) {
    speed = 6;
} else {
    speed = 0;
}

if (x <=400 && room == Office) {
    room_goto(BuildRoom);
}