class_name CrossConnection
var id: int
var from: CrossEndpoint
var to: CrossEndpoint

func _init(d):
	id = d.id
	from = CrossEndpoint.new(d.from)
	to = CrossEndpoint.new(d.to)
