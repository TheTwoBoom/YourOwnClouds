class_name ShopItem
var display_name: String
var id: String
var description: String
var price: int
var specs: Dictionary

func _init(d):
	display_name = d.displayName
	id = d.internalID
	description = d.description
	price = d.price
	specs = d.specs
