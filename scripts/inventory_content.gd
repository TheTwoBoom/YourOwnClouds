extends Control

func _on_visibility_changed() -> void:
	for child in %DevicesContainer.get_children():
		child.queue_free()
	for child in %ComponentsContainer.get_children():
		child.queue_free()
	for device in JsonLoader.inventory_devices:
		var dev_container: VBoxContainer = load("res://template_device.tscn").instantiate().duplicate()
		# dev_container.get_node("%TextureRect")
		dev_container.get_node("%Label").text = "[url=" + str(device.server_id) + "]" + device.name + "[/url]"
		%DevicesContainer.add_child(dev_container)
	for component in JsonLoader.inventory_components:
		var comp_container: HBoxContainer = load("res://template_component.tscn").instantiate().duplicate()
		var text = str(component.amount) + "x " + component.name
		comp_container.get_node("%Label").text = "[url=" + component.internal_id + "]" + text + "[/url]"
		%ComponentsContainer.add_child(comp_container)
