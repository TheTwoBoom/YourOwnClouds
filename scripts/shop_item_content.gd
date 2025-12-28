extends Control

func _on_visibility_changed() -> void:
	for n in %ShopItemContainer.get_children():
		n.queue_free()
	%ShopItemDetails.visible = false
	print(JsonLoader.viewed_shop_category.display_name)
	for i: ShopItem in JsonLoader.viewed_shop_category.items:
		var shop_item = load("res://template_shopitem.tscn").instantiate().duplicate()
		for n in shop_item.get_children():
			if n is TextureRect:
				pass
			elif n is RichTextLabel:
				n.connect("meta_clicked", set_viewed_shop_item)
				n.text = '[url=' + str(i.id) + ']' + i.display_name + ' [/url]'
		shop_item.visible = true
		%ShopItemContainer.add_child(shop_item)

func set_viewed_shop_item(id: String) -> void:
	JsonLoader.viewed_shop_item = JsonLoader.get_shop_item_by_id(id)
	%ShopItemDetails.visible = true
	%ShopItemName.text = JsonLoader.viewed_shop_item.display_name
	if JsonLoader.viewed_shop_category.id == "server":
		%ShopItemSpecs.text = HelperFunctions.generate_server_specs_str(JsonLoader.viewed_shop_item.specs)
	%ShopItemPrice.text = str(JsonLoader.viewed_shop_item.price)

func _on_shop_buy_button_pressed() -> void:
	buy_viewed_item()

func buy_viewed_item():
	var category = JsonLoader.viewed_shop_category
	var item = JsonLoader.viewed_shop_item
	if JsonLoader.money < item.price:
		%ShopItemName.text = "Not enough money"
	else:
		JsonLoader.money -= item.price
		if category.inventory_type == "device":
			var device: Device;
			if category.id == "server":
				device = HelperFunctions.generate_inv_item_server(item)
			elif category.id == "switch":
				pass
				#device = generate_inv_item_switch(item)
			JsonLoader.inventory_devices.append(device)
		elif category.inventory_type == "component":
			pass
