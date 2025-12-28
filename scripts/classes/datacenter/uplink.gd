class_name Uplink
var id: int
var type: String
var sla: float
var speed: int
var speed_unit: String
var cost: int

func _init(d):
	id = d.id
	type = d.type
	sla = d.sla
	speed = d.speed
	speed_unit = d.speedUnit
	cost = d.cost
