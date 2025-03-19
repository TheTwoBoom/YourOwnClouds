function renderOverlay(){
    draw_set_font(bigGUI);
    draw_set_halign(fa_right);
    draw_text(184, 30, global.playerdata[$ "level"]);
    draw_text(514, 30, global.playerdata[$ "money"]);
}