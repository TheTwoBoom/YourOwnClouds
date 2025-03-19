function mouseLeftHandlerDesktop(){
    if (position_meeting(mouse_x, mouse_y, global.gui_tilemap)) {
        if (layer_get_visible(global.desktop_buttonlayer)) {
            var data = tilemap_get_at_pixel(global.gui_tilemap[1], mouse_x, mouse_y);
            if (data = 330) {
                show_debug_message("Das ist ein Fragezeichen Button")
            } else if (data = 271) {
                toggleDesktopElements("desktop", false);
                toggleDesktopElements("email", true);
            } else if (data = 150) {
                toggleDesktopElements("desktop", false);
                toggleDesktopElements("customers", true);
            } else if (data = 395) {
                toggleDesktopElements("desktop", false);
                toggleDesktopElements("shop", true);
            } else if (data = 940) {
                toggleDesktopElements("desktop", false);
                layer_set_visible(global.windowlayer, false);
            }
        } else if (layer_get_visible(global.email_buttonlayer)) {
            var data = tilemap_get_at_pixel(global.gui_tilemap[0], mouse_x, mouse_y);
            if (data == 152) {
                toggleDesktopElements("email", false);
                toggleDesktopElements("desktop", true);
            } else if (data == 214 && global.y_offset > 0) {
                global.y_offset -= 1;
            } else if (data == 213 && global.y_offset <= variable_struct_names_count(global.emails) - 12) {
                global.y_offset += 1;
            }
        } else if (layer_get_visible(global.customers_buttonlayer)) {
            var data = tilemap_get_at_pixel(global.gui_tilemap[4], mouse_x, mouse_y);
            if (data == 152) { 
                toggleDesktopElements("customers", false);
                toggleDesktopElements("desktop", true);
            } else if (data == 214 && global.y_offset > 0) {
                global.y_offset -= 1;
            } else if (data == 213 && global.y_offset <= variable_struct_names_count(global.emails) - 10) {
                global.y_offset += 1;
            }
        } else if (layer_get_visible(global.shop_buttonlayer)) {
            var data = tilemap_get_at_pixel(global.gui_tilemap[2], mouse_x, mouse_y);
            if (data == 152) {
                toggleDesktopElements("shop", false);
                toggleDesktopElements("desktop", true);
                global.viewed_category = undefined;
                global.viewed_product = undefined;
            } else if (data == 212) {
                global.viewed_category = undefined;
                global.viewed_product = undefined;
            } else if (data == 214 && global.y_offset > 0) {
                global.y_offset -= 1;
            } else if (data == 213 && global.y_offset <= variable_struct_names_count(global.emails) - 10) {
                global.y_offset += 1;
            }
        } 
    } else {
        if (layer_get_visible(global.email_buttonlayer)) {
            for (i=global.y_offset+1;i<(12 + global.y_offset);i++) {
                email = global.emails[$ i];
                title_x = 640;
                title_y = 240 + (i - 1) * 48 - global.y_offset * 48; 
                if (mouse_x >= title_x && mouse_x <= title_x + 240 && mouse_y >= title_y && mouse_y <= title_y + 48) {
                    global.viewed_email = email;
                }
            } 
        } else if (layer_get_visible(global.shop_buttonlayer)) {
            if (!variable_global_exists("viewed_category") || global.viewed_category == undefined) {
                shop_x = 640;
                for (i=global.y_offset+1;i<(7 + global.y_offset);i++) {
                    category = global.shopdata[$ (struct_get_names(global.shopdata)[i])]
                    shop_y = 336 + (i - 1) * 48 - global.y_offset * 48; 
                    if (mouse_x >= shop_x && mouse_x <= shop_x + 240 && mouse_y >= shop_y && mouse_y <= shop_y + 48) {
                        global.viewed_category = category;
                    }
                }
            } else if (global.viewed_category != undefined) {
                tilemap_set_at_pixel(global.gui_tilemap[3], 0, 580, title_y);
                shop_x = 592;
                for (i=global.y_offset+1;i<(7 + global.y_offset);i++) {
                    product = global.viewed_category[$ "items"][$ i];
                    shop_y = 384 + (i - 1) * 48 - global.y_offset * 48; 
                    if (mouse_x >= shop_x && mouse_x <= shop_x + 240 && mouse_y >= shop_y && mouse_y <= shop_y + 48) {
                        global.viewed_product = product;
                    }
                }
            }
        }
    }
}