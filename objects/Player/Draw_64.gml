if (layer_get_visible(email_buttonlayer)) {
    for (i=global.y_offset+1;i<(10 + global.y_offset);i++) {
        draw_set_font(mediumGUI);
        email = global.emails[$ i];
        title_x = 416;
        title_y = 240 + i * 20 - global.y_offset * 20;
        draw_text(title_x, title_y, email[$ "title"]);
    }
    if (variable_global_exists("viewed_email")) {
        draw_set_font(bigGUI);
        draw_text(624, 256, global.viewed_email[$ "title"]);
        draw_set_font(mediumGUI);
        draw_text_ext(624, 288, global.viewed_email[$ "content"], 18, 272);
    }
}
if (layer_get_visible(shop_buttonlayer)) {
    for (i=global.y_offset+1;i<(7 + global.y_offset);i++) {
            draw_set_font(mediumGUI);
            product_category = struct_get_names(global.products)[i];
            product = global.products[$ product_category][$ "displayName"];
            title_x = 444;
            title_y = 256 + (i - 1) * 32 - global.y_offset * 20;
            tilemap_set_at_pixel(gui_tilemap[3], global.products[$ product_category][$ "icon"], 432, 256 + (i - 1) * 32 - global.y_offset * 20);
            draw_text(title_x, title_y + 2, product);
    }
    if (variable_global_exists("viewed_product")) {
        draw_set_font(bigGUI);
        draw_text(624, 256, global.viewed_product[$ "name"]);
        draw_set_font(mediumGUI);
        draw_text_ext(624, 288, global.viewed_product[$ "desciption"], 18, 272); 
    }
}