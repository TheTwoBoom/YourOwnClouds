extends StaticBody2D
@onready var player = %PlayerBody2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "PlayerBody2D" && get_tree().current_scene.name == "Datacenter":
		JsonLoader.viewed_server_rack = [int(name.split("_")[1]), int(get_parent().name.split("_")[1])]
		get_node("%TooltipServerShelf").visible = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "PlayerBody2D" && get_tree().current_scene.name == "Datacenter":
		if name.split("_")[1] == "08" && JsonLoader.viewed_server_rack[0] != 07:
			get_node("%TooltipServerShelf").visible = false

func _on_visibility_changed() -> void:
	refresh_devices()
	
func refresh_devices() -> void:
	var x = int(name.split("_")[1])
	var y = int(get_parent().name.split("_")[1])
	var rack_content = JsonLoader.get_rack_contents_by_location(1, x, y)
	var size: Vector2
	for c in get_children(true):
		if c is Sprite2D:
			size = c.texture.get_size()
	for index in range(rack_content.size()):
		if rack_content[index] != null:
			var rect = ColorRect.new()
			rect.size = Vector2(42, 10)
			rect.position.x = -floori(size.x/2) + 9
			rect.position.y = -floori(size.y/2) + 21 + index * 10
			rect.name = "Server_" + str(index)
			rect.color = Color.DIM_GRAY
			rect.z_index = 20
			add_child(rect)
