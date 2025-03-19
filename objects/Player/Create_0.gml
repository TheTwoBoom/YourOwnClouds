direction = 0;
running = false;
gui_open = false;
global.desktop_textlayer = layer_get_id("GUIDesktopText");
global.desktop_buttonlayer = layer_get_id("GUIDesktopButtons");

global.email_contentlayer = layer_get_id("GUIEmailContentField")
global.email_buttonlayer = layer_get_id("GUIEmailButtons")

global.shop_contentlayer = layer_get_id("GUIShopContentField")
global.shop_buttonlayer = layer_get_id("GUIShopButtons")
global.shop_iconlayer = layer_get_id("GUIShopIcons")
global.shop_searchlayer = layer_get_id("GUIShopSearch")

global.customers_contentlayer = layer_get_id("GUICustomersContentField")
global.customers_buttonlayer = layer_get_id("GUICustomersButtons")
global.customers_iconlayer = layer_get_id("GUICustomersIcons")
global.customers_searchlayer = layer_get_id("GUICustomersSearch")

global.windowlayer = layer_get_id("GUIDesktopWindow");

global.y_offset = 0;

// Tilemaps to check
if layer_exists("OfficeBorder") {
    global.tilemap = [layer_tilemap_get_id("OfficeInteriorFurniture"), layer_tilemap_get_id("OfficeInteriorChairs"), layer_tilemap_get_id("OfficeInteriorStuff"), layer_tilemap_get_id("OfficeBorder")];
    global.gui_tilemap = [layer_tilemap_get_id("GUIEmailButtons"), layer_tilemap_get_id("GUIDesktopButtons"), layer_tilemap_get_id("GUIShopButtons"), layer_tilemap_get_id("GUIShopIcons"), layer_tilemap_get_id("GUICustomersButtons")];
} else if layer_exists("DCSmallBorder") {
    global.tilemap[0] = layer_tilemap_get_id("DCSmallInteriorFurniture");
}

draw_set_color(make_color_rgb(56, 41, 42))