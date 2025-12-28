extends Control

func _on_visibility_changed() -> void:
	refresh_email_list()
	
func refresh_email_list():
	for n in %EmailContainer.get_children():
		n.queue_free()
	for e: Email in JsonLoader.inbox:
		var email = load("res://template_email.tscn").instantiate().duplicate()
		for n in email.get_children():
			if n is TextureRect:
				n.texture = load("res://assets/email_icons/" + e.type + ".tres")
			elif n is RichTextLabel:
				n.connect("meta_clicked", set_viewed_email)
				n.text = '[url=' + str(e.id) + ']' + e.title + ' [/url]'
		email.visible = true
		%EmailContainer.add_child(email)

func set_viewed_email(id: String):
	JsonLoader.viewed_email = JsonLoader.get_email_by_email_id(int(id))
	var email = JsonLoader.viewed_email
	%EmailTitle.text = email.title
	%EmailDetail.text = "by " + email.sender.address + " | " + email.date
	%EmailText.text = email.content
	if email.type == "spam":
		%InfoButton.visible = false
	else:
		%InfoButton.visible = true
	%EmailDetails.visible = true


func clear_viewed_email():
	%EmailDetails.visible = false


func _on_info_button_pressed() -> void:
	%UiManager.open_popup("Offer")


func _on_trash_button_pressed() -> void:
	%UiManager.hide_popup()
	JsonLoader.inbox.erase(JsonLoader.viewed_email)
	clear_viewed_email()
	refresh_email_list()
