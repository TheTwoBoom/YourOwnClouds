class_name Customer
var id: int
var display_name: String
var avatar: String
var support_type: String
var products: Array
var address: String

func _init(d):
	id = d.id
	address = d.address
	display_name = d.displayName
	avatar = d.avatar
	support_type = d.supportType
	products = d.products
