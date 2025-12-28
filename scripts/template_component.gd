extends HBoxContainer


func _on_label_meta_clicked(meta: Variant) -> void:
	JsonLoader.viewed_inv_type = "component"
	JsonLoader.viewed_inv_item = JsonLoader.get_shop_item_by_id(meta)
	HelperFunctions.ui_manager.change_sub_menu("InventoryComponent")
