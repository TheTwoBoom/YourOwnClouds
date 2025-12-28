extends Control

func _on_visibility_changed() -> void:
	if JsonLoader.viewed_inv_device:
		var dev = JsonLoader.viewed_inv_device
		%DeviceTitleLabel.text = dev.name
		if dev.customer:
			%DeviceCustomerLabel.text = "Assigned Customer: " + dev.customer.display_name
		else:
			%DeviceCustomerLabel.text = "Assigned Customer: None"
		%DevicePowerLabel.text = "Power Consumption: " + str(dev.max_power) + "W"
		%DeviceSpecLabel.text = HelperFunctions.generate_server_specs_str_inv(dev.components)
