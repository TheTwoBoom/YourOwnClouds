extends VBoxContainer

func _on_visibility_changed() -> void:
	var email = JsonLoader.viewed_email
	if email is InquiryEmail:
		%ServerSelector.clear()
		%ServerSelector.add_item("Select a item", -1)
		for i in JsonLoader.inventory_devices:
			if i.location.id != -1:
				%ServerSelector.add_item(i.name, i.server_id)
		if email.specs is DediRequirements:
			%CPUGenLabel.text = "CPU-Gen " + str(email.specs.cpu_gen)
			%CPUCoresLabel.text = str(email.specs.cpu_cores) + " Cores at " + str(email.specs.cpu_clock) + "GHz+"
			%RAMLabel.text = str(email.specs.ram_capacity) + "GB " + str(email.specs.ram_type)
			%StorageLabel.text = str(email.specs.storage_capacity) + "GB " + str(email.specs.storage_type).to_upper()
			%ConnectionLabel.text = str(email.specs.network_speed) + "GBit Connection"
			if typeof(email.specs.sla_requirements) == TYPE_NIL:
				%SLALabel.text = "SLA: none"
			else:
				%SLALabel.text = str(email.specs.sla_requirements)


func _on_accept_button_pressed() -> void:
	if !JsonLoader.server_compatible:
		return
	var server_id = %ServerSelector.get_selected_id()
	var server = JsonLoader.get_device_by_server_id(server_id)
	var sender = JsonLoader.viewed_email.sender
	server.customer = sender
	JsonLoader.set_device_by_server_id(server_id, server)
	var payment_per_month = JsonLoader.viewed_email.payment_per_month
	var active_customer = JsonLoader.get_customer_by_id(sender.id, true)
	if active_customer == null:
		JsonLoader.active_customers.append(sender)
		active_customer = JsonLoader.get_customer_by_id(sender.id, true)
	var new_product = Product.new({
		"name": "customRequest",
		"type": JsonLoader.viewed_email.requested_category,
		"serverID": server_id,
		"paymentPerMonth": payment_per_month
	})
	active_customer.products.append(new_product)
	%EmailContent._on_trash_button_pressed()


func _on_server_selector_item_selected(index: int) -> void:
	var server_id = %ServerSelector.get_item_id(index)
	%ServerSelector.set_item_disabled(0, true)
	JsonLoader.server_compatible = false
	if typeof(JsonLoader.get_device_by_server_id(server_id)) != TYPE_NIL:
		%FeedbackContainer.visible = true
		if typeof(JsonLoader.get_device_by_server_id(server_id).customer) == TYPE_NIL:
			%AssignFeedbackIcon.texture = load("res://assets/feedback_icons/true.tres")
			%AssignFeedback.text = "Server Compatible"
			JsonLoader.server_compatible = true
		else:
			%AssignFeedbackIcon.texture = load("res://assets/feedback_icons/false.tres")
			%AssignFeedback.text = "Already assigned!"
	else:
		%FeedbackContainer.visible = false
