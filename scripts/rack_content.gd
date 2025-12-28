extends Control


func _on_visibility_changed() -> void:
	if JsonLoader.viewed_server_rack.is_empty():
		return
	var x = JsonLoader.viewed_server_rack[0]
	var y = JsonLoader.viewed_server_rack[1]
	%RackTitleLabel.text = "Rack " + str(x) + "-" + str(y)
	var index = 0
	for c: TextureRect in %RackUnitsText.get_children():
		var device = JsonLoader.get_device_by_location(1, x, y, index)
		var i = c.get_children()[0]
		index += 1
		if device != null:
			i.text = "[url={'key': 'back'}]" + device.name + "[/url]"
			c.texture = PlaceholderTexture2D.new()
		else:
			i.text = ""
			c.texture = null
