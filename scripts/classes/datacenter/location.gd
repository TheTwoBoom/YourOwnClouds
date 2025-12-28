class_name Location
var id: int
var display_name: String
var size: String
var uplinks: Array[Uplink] = []
var racks: Array[Rack] = []
var crossConnections: Array[CrossConnection] = []
var power_cost: float
var rent: int

func _init(d):
	id = d.id
	display_name = d.displayName
	size = d.size
	power_cost = d.powerCost
	rent = d.rent

	for u in d.uplinks:
		uplinks.append(Uplink.new(u))

	for r in d.racks:
		racks.append(Rack.new(r))

	for cc in d.crossConnections:
		crossConnections.append(CrossConnection.new(cc))
