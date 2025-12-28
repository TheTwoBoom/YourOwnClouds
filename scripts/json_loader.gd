extends Node

# -------------------------------------------------------------
# DATA CLASSES
# -------------------------------------------------------------


# -------------------------------------------------------------
# SAVEGAME DATA
# -------------------------------------------------------------
var level: int
var money: int
var tutorial: bool

var inbox: Array[Email] = []

var active_customers: Array[Customer] = []
var available_locations: Array[Location] = []

var inventory_devices: Array[Device] = []
var inventory_components: Array[ComponentInstance] = []

# -------------------------------------------------------------
# GENERAL DATA
# -------------------------------------------------------------
var all_emails: Array[Email] = []
var all_customers: Array[Customer] = []
var shop_data: Array[ShopCategory] = []

# -------------------------------------------------------------
# TEMP DATA
# -------------------------------------------------------------
var viewed_email: Email
var viewed_shop_category: ShopCategory
var viewed_shop_item: ShopItem
var viewed_inv_type: String
var viewed_inv_item: ShopItem
var viewed_inv_device: Device
var viewed_server_rack: Array = []
var server_compatible: bool = false
var financeArray: Array[Array] = [[0, 0], [0, 0], [0, 0], [0, 0]]

# -------------------------------------------------------------
# LOAD JSON
# -------------------------------------------------------------
func load_game(path: String):
	var f := FileAccess.open(path, FileAccess.READ)
	if not f:
		push_error("Could not open schema JSON at: " + path)
		return

	var raw := f.get_as_text()
	var data = JSON.parse_string(raw)
	if typeof(data) != TYPE_DICTIONARY:
		push_error("Invalid JSON format")
		return

	_parse_save_root(data)

func load_all_emails():
	var f := FileAccess.open("res://data/emails.json", FileAccess.READ)
	if not f:
		push_error("Could not open schema JSON at: res://data/emails.json")
		return
	var raw := f.get_as_text()
	var data = JSON.parse_string(raw)
	if typeof(data) != TYPE_ARRAY:
		push_error("Invalid JSON format")
		return
	_parse_emails_root(data)

func load_all_customers():
	var f := FileAccess.open("res://data/customers.json", FileAccess.READ)
	if not f:
		push_error("Could not open schema JSON at: res://data/customers.json")
		return
	var raw := f.get_as_text()
	var data = JSON.parse_string(raw)
	if typeof(data) != TYPE_ARRAY:
		push_error("Invalid JSON format")
		return
	_parse_customers_root(data)

func load_shop_data():
	var f := FileAccess.open("res://data/shop.json", FileAccess.READ)
	if not f:
		push_error("Could not open schema JSON at: res://data/shop.json")
		return
	var raw := f.get_as_text()
	var data = JSON.parse_string(raw)
	if typeof(data) != TYPE_ARRAY:
		push_error("Invalid JSON format")
		return
	_parse_shop_root(data)

# -------------------------------------------------------------
# PARSE ROOT LEVEL
# -------------------------------------------------------------
func _parse_save_root(d: Dictionary):
	level = d.level
	money = d.money
	tutorial = d.tutorial
	
	inbox.clear()
	for i in d.inbox:
		inbox.append(get_email_by_email_id(i))
	
	active_customers.clear()
	for c in d.activeCustomers:
		active_customers.append(Customer.new(c))

	available_locations.clear()
	for l in d.availableLocations:
		available_locations.append(Location.new(l))

	inventory_devices.clear()
	for dev in d.inventory.devices:
		inventory_devices.append(Device.new(dev))

	inventory_components.clear()
	for comp in d.inventory.components:
		inventory_components.append(ComponentInstance.new(comp))

func _parse_emails_root(a: Array):
	all_emails.clear()
	for e in a:
		if e.type == "spam":
			all_emails.append(SpamEmail.new(e))
		elif e.type == "inquiry":
			all_emails.append(InquiryEmail.new(e))
		else:
			all_emails.append(Email.new(e))

func _parse_customers_root(a: Array):
	all_customers.clear()
	for c in a:
		all_customers.append(Customer.new(c))

func _parse_shop_root(a: Array):
	shop_data.clear()
	for s in a:
		shop_data.append(ShopCategory.new(s))

# -------------------------------------------------------------
# OPTIONAL: GETTER HELPERS
# -------------------------------------------------------------
func get_customer_by_id(id: int, active: bool) -> Customer:
	if active:
		for c in active_customers:
			if c.id == id:
				return c
	else:
		for c in all_customers:
			if c.id == id:
				return c
	return null

func get_location_by_id(id: int) -> Location:
	for l in available_locations:
		if l.id == id:
			return l
	return null

func get_device_by_server_id(id: int) -> Device:
	for d in inventory_devices:
		if d.server_id == id:
			return d
	return null

func get_device_by_location(id: int, x: int, y: int, rackunit: int) -> Device:
	for d in inventory_devices:
		var loc = d.location
		if (loc.id == id && loc.x == x && loc.y == y && loc.rackunit == rackunit):
			return d
	return null

func get_all_devices_in_location(id: int) -> Array[Device]:
	var array: Array[Device] = []
	for d in inventory_devices:
		var loc = d.location
		if (loc.id == id):
			array.append(d)
	return array

func get_rack_by_location(id: int, x: int, y: int) -> Rack:
	var racks
	for l in available_locations:
		if l.id == id:
			racks = l.racks
			break
	for rack in racks:
		if rack.x == x && rack.y == y:
			return rack
	return null

func get_rack_contents_by_location(id: int, x: int, y: int) -> Array[Device]:
	var array: Array[Device] = []
	if get_rack_by_location(id, x, y) == null:
		return array
	array.resize(get_rack_by_location(id, x, y).rackunits)
	for d in inventory_devices:
		var loc = d.location
		if (loc.id == id && loc.x == x && loc.y == y):
			array.set(loc.rackunit, d)
	return array

func get_email_by_email_id(id: int) -> Email:
	for e in all_emails:
		if e.id == id:
			return e
	return null

func get_shop_category_by_id(id: String) -> ShopCategory:
	for c in shop_data:
		if c.id == id:
			return c
	return null

func get_shop_category_by_item_id(id: String) -> ShopCategory:
	for c in shop_data:
		for i in c.items:
			if i.id == id:
				return c
	return null

func get_shop_item_by_id(id: String) -> ShopItem:
	for c in shop_data:
		for i in c.items:
			if i.id == id:
				return i
	return null

# -------------------------------------------------------------
# OPTIONAL: SETTER HELPERS
# -------------------------------------------------------------

func set_device_by_server_id(id: int, device: Device) -> void:
	for d in inventory_devices:
		if d.server_id == id:
			d = device
