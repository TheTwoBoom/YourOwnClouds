extends Node2D



func _on_visibility_changed() -> void:
	for child in get_children():
		if visible:
			child.process_mode = Node.PROCESS_MODE_DISABLED
		else:
			child.process_mode = Node.PROCESS_MODE_INHERIT
