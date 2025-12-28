extends Control

func _can_drop_data(at_position:Vector2, data:Variant) -> bool:
	var x = int(get_parent().name.split("_")[1])
	var y = int(get_parent().get_parent().name.split("_")[1])
	if HelperFunctions.get_next_free_rackunit(1, x, y) == -1:
		return false
	return true

func _drop_data(at_position:Vector2, data:Variant) -> void:
	var device_id = int(data.name.split("_")[1])
	var device = JsonLoader.get_device_by_server_id(device_id)
	device.location.id = 1
	device.location.x = int(get_parent().name.split("_")[1])
	device.location.y = int(get_parent().get_parent().name.split("_")[1])
	device.location.rackunit = HelperFunctions.get_next_free_rackunit(device.location.id, device.location.x, device.location.y)
	JsonLoader.set_device_by_server_id(device_id, device)
	data.visible = false
	get_parent().refresh_devices()
