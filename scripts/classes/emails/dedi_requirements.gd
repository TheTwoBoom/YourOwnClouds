extends CustomerRequirements
class_name DediRequirements
var cpu_gen: int
var cpu_cores: int
var cpu_clock: float
var ram_type: String
var ram_capacity: int
var storage_type: String
var storage_capacity: int
var network_speed: int
var network_quality_index: int
var sla_requirements

func _init(d):
	cpu_gen = d.cpuGen
	cpu_cores = d.cpuCores
	cpu_clock = d.cpuClock
	ram_type = d.ramType
	ram_capacity = d.ramCapacity
	storage_type = d.storageType
	storage_capacity = d.storageCapacity
	network_speed = d.networkSpeed
	network_quality_index = d.networkQualityIndex
	sla_requirements = d.slaRequirements
