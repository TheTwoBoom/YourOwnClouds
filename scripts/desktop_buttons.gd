extends Control


func _on_email_button_pressed() -> void:
	%UiManager.open_sub_menu("Email")


func _on_shop_button_pressed() -> void:
	%UiManager.open_sub_menu("Shop")


func _on_customers_button_pressed() -> void:
	%UiManager.open_sub_menu("Customers")


func _on_datacenters_button_pressed() -> void:
	%UiManager.open_sub_menu("Datacenters")


func _on_devices_button_pressed() -> void:
	%UiManager.open_sub_menu("Devices")


func _on_inventory_button_pressed() -> void:
	%UiManager.open_sub_menu("Inventory")
