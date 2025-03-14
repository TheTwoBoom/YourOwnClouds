var collisions = collision_rectangle(x - 10, y - 10, x + sprite_width + 32, y + sprite_height + 10, tilemap[1], true, true);
if (collisions != -4 && gui_open == false) {
    gui_open = true;
    layer_set_visible(desktop_textlayer, gui_open);
    layer_set_visible(desktop_buttonlayer, gui_open);
    
    layer_set_visible(windowlayer, gui_open);
} else {
    gui_open = false;
    
    toggleDesktop("desktop", false);
    toggleDesktop("email", false);
    toggleDesktop("shop", false);
    
    layer_set_visible(windowlayer, false);
}