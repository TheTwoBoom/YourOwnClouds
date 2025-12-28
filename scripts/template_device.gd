extends VBoxContainer


func _on_label_meta_clicked(meta: Variant) -> void:
	JsonLoader.viewed_inv_type = "device"
	JsonLoader.viewed_inv_device = JsonLoader.get_device_by_server_id(int(meta))
	HelperFunctions.ui_manager.change_sub_menu("InventoryDevice")
