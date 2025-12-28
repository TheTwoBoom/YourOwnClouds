extends Control

const PLAY_SCENE_PATH = "office.tscn"
@onready var savegame_template = %SavegameTemplate
@onready var savegame_buttons = %SavegameBTNs

func _ready():
	for file: String in SaveGameHandler.get_savegame_list():
		var button = savegame_template.duplicate()
		button.text = SaveGameHandler.to_save_name(file.split(".")[0])
		button.visible = true
		savegame_buttons.add_child(button)
		button.connect("pressed", func(): self.load_save(button.text))
		pass
	ResourceLoader.load_threaded_request(PLAY_SCENE_PATH)


func _on_play_button_pressed() -> void:
	%SavegameContainer.visible = true;

func _on_settings_button_pressed() -> void:
	get_tree().change_scene_to_file("res://settings.tscn")

func _on_credits_button_pressed() -> void:
	get_tree().change_scene_to_file("res://credits.tscn")

func _on_exit_button_pressed() -> void:
	get_tree().quit()

func _on_new_savegame_pressed() -> void:
	var save_name = SaveGameHandler.new_savegame("")
	load_save(save_name)

func load_save(save_name):
	SaveGameHandler.load_savegame(save_name)
	get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(PLAY_SCENE_PATH))
