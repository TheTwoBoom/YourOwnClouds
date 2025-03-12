direction = 0;
running = false;
gui_open = false;
desktop_textlayer = layer_get_id("GUIDesktopText");
desktop_symbollayer = layer_get_id("GUIDesktopButtons");
email_textlayer = layer_get_id("GUIEmailText")
email_contentlayer = layer_get_id("GUIEmailContentField")
email_symbollayer = layer_get_id("GUIEmailButtons")
windowlayer = layer_get_id("GUIWindow");

global.y_offset = 0;

// Tilemaps to check
if layer_exists("OfficeBorder") {
    tilemap[0] = layer_tilemap_get_id("OfficeInteriorFurniture");
    tilemap[1] = layer_tilemap_get_id("OfficeInteriorChairs");
    tilemap[2] = layer_tilemap_get_id("OfficeInteriorStuff");
    tilemap[3] = layer_tilemap_get_id("OfficeBorder");
    gui_tilemap[0] = layer_tilemap_get_id("GUIEmailButtons");
    gui_tilemap[1] = layer_tilemap_get_id("GUIDesktopButtons");
} else {
    tilemap[0] = layer_tilemap_get_id("DCInteriorFurniture");
}