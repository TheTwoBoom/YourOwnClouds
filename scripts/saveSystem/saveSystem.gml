function loadSave(){
    if (file_exists(game_save_id + "/save.json")) {
        save_buffer = buffer_load(game_save_id + "/save.json");
    } else {
        save_buffer = buffer_load(working_directory + "save.json");
    }
    var save_raw = buffer_read(save_buffer, buffer_string);
    buffer_delete(save_buffer);
    global.playerdata = json_parse(save_raw);
}
function writeSave(){
    save_raw = json_stringify(global.playerdata, true);
    var save_buffer;
    buffer_write(save_buffer, buffer_string, save_raw);
    buffer_save(save_buffer, game_save_id + "/save.json");
    buffer_delete(save_buffer);
}