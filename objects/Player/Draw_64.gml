if (layer_get_visible(email_symbollayer)) {
    for (i=global.y_offset+1;i<(10 + global.y_offset);i++) {
        draw_set_font(mediumGUI);
        email = global.emails[$ i];
        title_x = 416;
        title_y = 240 + i * 20 - global.y_offset * 20;
        draw_text(title_x, title_y, email[$ "title"]);
    }
    if (variable_global_exists("viewed_email")) {
        draw_set_font(mediumGUI);
        draw_text_ext(608, 256, global.viewed_email[$ "content"], 18, 288);
    }
}