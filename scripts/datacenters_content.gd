extends Control


func _on_visibility_changed() -> void:
	for child in %DragDropContainer.get_children():
		child.queue_free()
	for device: Device in JsonLoader.inventory_devices:
		if device.location.id != 1:
			var device_container = load("res://drag_drop_device.tscn").instantiate().duplicate()
			%DragDropContainer.add_child(device_container)
			device_container.name = "Device_" + str(device.server_id)
			for child in device_container.get_children(true):
				if child is Label:
					child.text = device.name
