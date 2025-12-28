class_name Device
var type: String
var name: String
var server_id: int
var case_id: String
var location
var customer: Customer
var height: int
var network: String
var max_power: int
var components: Array

func _init(d):
	type = d.type
	name = d.name
	customer = JsonLoader.get_customer_by_id(d.customer, true)
	server_id = d.serverID
	case_id = d.caseID
	location = d.location
	height = d.height
	network = d.network
	max_power = d.maxPowerConsumption
	components = d.components
