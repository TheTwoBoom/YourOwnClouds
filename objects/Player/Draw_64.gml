if (layer_get_visible(email_buttonlayer)) {
    draw_set_font(mediumGUI);
    title_x = 596;
    for (i=global.y_offset+1;i<(10 + global.y_offset);i++) {
        email = global.emails[$ i];
        title_y = 240 + i * 48 - global.y_offset * 48;
        draw_text(title_x, title_y, email[$ "title"]);
    }
    if (variable_global_exists("viewed_email")) {
        draw_set_font(bigGUI);
        draw_text(960, 288, global.viewed_email[$ "title"]);
        draw_set_font(mediumGUI);
        draw_text_ext(972, 340, global.viewed_email[$ "content"], 32, 400);
    }
}
if (layer_get_visible(shop_buttonlayer)) {
    draw_set_font(mediumGUI);
    if (variable_global_exists("viewed_category") && global.viewed_category != undefined) {
        title_x = 580;
        tilemap_set_at_pixel(gui_tilemap[2], 212, 580, 360);
        for (i=global.y_offset+1;i<(7 + global.y_offset);i++) {
            product = global.viewed_category[$ "items"][$ i];
            title_y = 384 + (i - 1) * 48 - global.y_offset * 48; 
            tilemap_set_at_pixel(gui_tilemap[3], 0, 580, title_y);
            if (product == undefined) {continue}
            draw_text(title_x, title_y + 2, product[$ "displayName"]);
        }
    } else {
        title_x = 640;
        tilemap_set_at_pixel(gui_tilemap[2], 0, 580, 360);
        for (i=global.y_offset+1;i<(7 + global.y_offset);i++) {
            product_category = global.shopdata[$ (struct_get_names(global.shopdata)[i])]
            title_y = 336 + (i - 1) * 48 - global.y_offset * 48;
            tilemap_set_at_pixel(gui_tilemap[3], product_category[$ "icon"], 580, title_y);
            draw_text(title_x, title_y + 2, product_category[$ "displayName"]); 
        }
    }
    if (variable_global_exists("viewed_product") && global.viewed_product != undefined) {
        draw_set_font(mediumGUI);
        draw_text(1056, 384, global.viewed_product[$ "displayName"]);
        draw_text_ext(1056, 432, global.viewed_product[$ "description"], 32, 344); 
        draw_text(1104, 720, global.viewed_product[$ "price"]);
    }
}