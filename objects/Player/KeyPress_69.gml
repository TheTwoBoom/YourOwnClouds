var collisions = collision_rectangle(x - 10, y - 10, x + sprite_width + 32, y + sprite_height + 10, global.tilemap[1], true, true);
if (collisions != -4 && gui_open == false) {
    gui_open = true;
    layer_set_visible(global.desktop_textlayer, gui_open);
    layer_set_visible(global.desktop_buttonlayer, gui_open);
    
    layer_set_visible(global.windowlayer, gui_open);
} else {
    gui_open = false;
    
    toggleDesktopElements("desktop", false);
    toggleDesktopElements("email", false);
    toggleDesktopElements("shop", false);
    toggleDesktopElements("customers", false);
    
    layer_set_visible(global.windowlayer, false);
}