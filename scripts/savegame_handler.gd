extends Node
	
func to_file_name(save_name: String):
	return save_name.to_snake_case()
	
func to_save_name(file_name: String):
	return file_name.capitalize()
	
func get_savegame_list() -> PackedStringArray:
	var dir = DirAccess.open("user://savegame")
	if dir == null:
		DirAccess.open("user://").make_dir("user://savegame")
		return PackedStringArray([])
	dir.list_dir_begin()
	return dir.get_files()

func new_savegame(save_name: String):
	if save_name == "":
		var id = 0
		while (does_savegame_exist("Save Game " + str(id))):
			id += 1;
		save_name = "Save Game " + str(id);
	var dir = DirAccess.open("user://savegame")
	print(does_savegame_exist(save_name))
	if (dir.copy("res://data/save.json", "user://savegame/" + to_file_name(save_name) + ".json") != OK):
		push_error("Couldn't create new save");
	return save_name

func does_savegame_exist(save_name: String):
	return to_file_name(save_name) + ".json" in get_savegame_list();

func load_savegame(save_name: String):
	if does_savegame_exist(save_name):
		JsonLoader.load_all_customers()
		JsonLoader.load_all_emails()
		JsonLoader.load_shop_data()
		JsonLoader.load_game("user://savegame/" + to_file_name(save_name) + ".json")
