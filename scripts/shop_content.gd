extends Control


func _on_systems_button_pressed() -> void:
	button_handler("server")


func _on_barebones_button_pressed() -> void:
	button_handler("server")


func _on_cases_button_pressed() -> void:
	button_handler("case")


func _on_mainboard_button_pressed() -> void:
	button_handler("mainboard")


func _on_cpus_button_pressed() -> void:
	button_handler("cpu")


func _on_ram_button_pressed() -> void:
	button_handler("ram")


func _on_ssds_button_pressed() -> void:
	button_handler("ssd")


func _on_hdds_button_pressed() -> void:
	button_handler("hdd")


func _on_psu_button_pressed() -> void:
	button_handler("psu")


func _on_fans_button_pressed() -> void:
	button_handler("fan")

func button_handler(category: String):
	JsonLoader.viewed_shop_category = JsonLoader.get_shop_category_by_id(category)
	%UiManager.change_sub_menu("ShopItem")
