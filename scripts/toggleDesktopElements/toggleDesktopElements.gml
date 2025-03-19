function toggleDesktopElements(type, status){
    if (type == "desktop") {
        global.y_offset = 0;
        layer_set_visible(global.desktop_textlayer, status);
        layer_set_visible(global.desktop_buttonlayer, status);
    } else if (type == "email") {
        global.y_offset = 0;
        layer_set_visible(global.email_buttonlayer, status);
        layer_set_visible(global.email_contentlayer, status);
    } else if (type == "shop") {
        global.y_offset = 0;
        layer_set_visible(global.shop_buttonlayer, status);
        layer_set_visible(global.shop_contentlayer, status);
        layer_set_visible(global.shop_iconlayer, status);
        layer_set_visible(global.shop_searchlayer, status);
    } else if (type == "customers") {
        global.y_offset = 0;
        layer_set_visible(global.customers_buttonlayer, status);
        layer_set_visible(global.customers_contentlayer, status);
        layer_set_visible(global.customers_iconlayer, status);
        layer_set_visible(global.customers_searchlayer, status);
    }
}