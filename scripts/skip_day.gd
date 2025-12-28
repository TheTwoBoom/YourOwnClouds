extends Button


func _on_pressed() -> void:
	%Clock.hours = 21
	%Clock._on_timeout()
