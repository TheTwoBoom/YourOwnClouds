extends CustomerRequirements
class_name WebRequirements
var cpu_compute: int
var ram_type: String
var ram_capacity: int
var storage_type: String
var storage_capacity: int
var network_speed: int
var network_quality_index: int

func _init(d):
	cpu_compute = d.cpuComputeUnits
	ram_type = d.ramType
	ram_capacity = d.ramCapacity
	storage_type = d.storageType
	storage_capacity = d.storageCapacity
	network_speed = d.networkSpeed
	network_quality_index = d.networkQualityIndex
