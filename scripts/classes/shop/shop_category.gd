class_name ShopCategory
var id: String
var display_name: String
var inventory_type: String
var items: Array[ShopItem] = []

func _init(d):
	id = d.internalID
	display_name = d.displayName
	inventory_type = d.inventoryType
	items.clear()
	for i in d.items:
		items.append(ShopItem.new(i))
