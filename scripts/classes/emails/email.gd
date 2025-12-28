class_name Email
var id: int
var sender: Customer
var date: String
var title: String
var content: String
var type: String

func _init(d):
	id = d.id
	date = Time.get_date_string_from_unix_time(d.unix_timestamp)
	sender = JsonLoader.get_customer_by_id(d.sender_id, false)
	title = d.title
	content = d.content
	type = d.type
