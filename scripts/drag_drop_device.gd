extends VBoxContainer

func _get_drag_data(_at_position:Vector2) -> Variant:
	var preview = self.duplicate()
	set_drag_preview(preview)
	return self
