extends Node
var ui_manager: Node

func _process(_delta: float) -> void:
	if ui_manager:
		return
	for child in get_tree().get_root().get_children():
		if child.name == "Office":
			ui_manager = child.get_node("%UiManager")

# -------------------------------------------------------------
# Id Generators
# -------------------------------------------------------------

func generate_new_server_id() -> int:
	var id = 1
	while (JsonLoader.get_device_by_server_id(id) != null):
		id += 1
	return id

# -------------------------------------------------------------
# Server Helpers
# -------------------------------------------------------------

func generate_server_specs_str(specs: Dictionary) -> String:
	var spec_string = ""
	for key in specs.keys():
		var temp_dict = {}
		var temp_string = ""
		for i in range(specs[key].size()):
			var display_name = JsonLoader.get_shop_item_by_id(specs[key][i]).display_name
			if temp_dict.get(display_name) == null:
				temp_dict.set(display_name, 1)
			else:
				temp_dict.set(display_name, temp_dict.get(display_name)+1)
		for d_key in temp_dict.keys():
			temp_string = str(temp_dict[d_key]) + "x " + str(d_key)
		spec_string += str(key) + ": " + temp_string + "\r"
	return spec_string

func generate_server_specs_str_inv(specs: Array) -> String:
	var spec_string = "Specs: \r"
	for spec in specs:
		var display_name = JsonLoader.get_shop_item_by_id(spec["internalID"]).display_name
		var temp_string = str(int(spec["amount"])) + "x " + display_name
		spec_string += str(spec["type"]) + ": " + temp_string + "\r"
	return spec_string

func generate_inv_item_server(item: ShopItem) -> Device:
	var device_data = {
		"type": "server",
		"name": item.display_name,
		"serverID": generate_new_server_id(),
		"caseID": item.specs.case[0],
		"customer": -1,
		"location": {"id": -1, "x": -1, "y": -1, "rackunit": -1},
		"height": JsonLoader.get_shop_item_by_id(item.specs.case[0]).specs.rackunits,
		"network": JsonLoader.get_shop_item_by_id(item.specs.mainboard[0]).specs["network-ports"][0],
		"maxPowerConsumption": calc_power_server(item.specs),
		"components": generate_components_array(item.specs)
	  }
	return Device.new(device_data);

func generate_components_array(specs: Dictionary) -> Array:
	var components: Array = []
	for v: Array in specs.values():
		if v.size() > 0:
			for id in v:
				var shop_item = JsonLoader.get_shop_item_by_id(id)
				var comp_data = {
					"type": JsonLoader.get_shop_category_by_item_id(id).id,
					"name": shop_item.display_name,
					"amount": 1,
					"internalID": id
				}
				var index = components.find(comp_data)
				if index != -1:
					components[index].amount += 1
				else:
					components.append(comp_data)
	return components

func calc_power_server(specs: Dictionary) -> int:
	var power_consumption: int = 0
	for v: Array in specs.values():
		if v.size() > 0:
			for id in v:
				var shop_item = JsonLoader.get_shop_item_by_id(id)
				power_consumption += shop_item.specs.power
	return power_consumption

# -------------------------------------------------------------
# Rack Helpers
# -------------------------------------------------------------

func get_next_free_rackunit(id: int, x: int, y: int) -> int:
	var rack = JsonLoader.get_rack_by_location(id, x, y)
	if rack == null:
		return -1
	for index in range(rack.rackunits):
		if JsonLoader.get_device_by_location(id, x, y, index) == null:
			return index
	return -1

# -------------------------------------------------------------
# Finance Helpers
# -------------------------------------------------------------

func calc_monthly_spend_from_customer(customer: Customer) -> int:
	var monthly_spend = 0
	for product: Product in customer.products:
		monthly_spend += product.payment_per_month
	return monthly_spend

func calc_finances() -> void:
	var id = 1
	JsonLoader.financeArray[0] = [0, calc_rent(id)]
	JsonLoader.financeArray[1] = [0, calc_uplink_cost(id)]
	JsonLoader.financeArray[2] = [0, calc_power_cost(id)]
	JsonLoader.financeArray[3] = [calc_customer_income(), 0]

func calc_rent(id: int) -> int:
	return JsonLoader.get_location_by_id(id).rent

func calc_power_cost(id: int) -> int:
	var total_power = 0
	for dev: Device in JsonLoader.get_all_devices_in_location(id):
		total_power += dev.max_power
	return roundi(JsonLoader.get_location_by_id(id).power_cost*total_power)

func calc_uplink_cost(id: int) -> int:
	return JsonLoader.get_location_by_id(id).uplinks[0].cost

func calc_customer_income() -> int:
	var income = 0
	for i: Customer in JsonLoader.active_customers:
		for p in i.products:
			income += p.payment_per_month
	return income

func apply_finances() -> void:
	for array in JsonLoader.financeArray:
		if array[0] != 0:
			JsonLoader.money += array[0]
		if array[1] != 0:
			JsonLoader.money += array[1]*-1

# -------------------------------------------------------------
# E-Mail Helpers
# -------------------------------------------------------------

func generate_email_inbox() -> void:
	var inbox_stats = get_inbox_stats()
	var email_multiplier = 1.0 + JsonLoader.level/50.0
	var email_amount = int(randi_range(1, 4+JsonLoader.level) * email_multiplier) - inbox_stats[1]
	var spam_amount = randi_range(2, 8) - inbox_stats[0]
	if email_amount < 0 or JsonLoader.inbox.size() >= 10: email_amount = 0
	if spam_amount < 0 or JsonLoader.inbox.size() >= 10: spam_amount = 0
	for i in range(email_amount):
		while true:
			var email = JsonLoader.all_emails.pick_random()
			if email is InquiryEmail and !is_already_in_inbox(email):
				JsonLoader.inbox.append(email)
				break
	for i in range(spam_amount):
		while true:
			var email = JsonLoader.all_emails.pick_random()
			if email is SpamEmail and !is_already_in_inbox(email):
				JsonLoader.inbox.append(email)
				break

func is_already_in_inbox(email: Email):
	for comparision in JsonLoader.inbox:
		if email.id == comparision.id:
			return true
	return false

func get_inbox_stats() -> Vector2:
	var stats: Vector2 = Vector2(0, 0)
	for i in JsonLoader.inbox:
		if i is SpamEmail:
			stats[0] += 1
		elif i is InquiryEmail:
			stats[1] += 1
	return stats
