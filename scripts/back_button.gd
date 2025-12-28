extends RichTextLabel

func _ready():
	pass

func _on_meta_clicked(meta: Variant) -> void:
	if get_node_or_null("%RackContent") != null:
		%UiManager.toggle_computer()
	elif %ShopItemContent.visible:
		%UiManager.change_sub_menu("Shop")
	elif %InventoryComponentContent.visible or %InventoryDeviceContent.visible:
		%UiManager.change_sub_menu("Inventory")
	else:
		%UiManager.back_to_desktop()
