class_name ComponentInstance
var type: String
var name: String
var amount: int
var internal_id: String

func _init(d):
	type = d.type
	name = d.name
	amount = d.amount
	internal_id = d.internalID
