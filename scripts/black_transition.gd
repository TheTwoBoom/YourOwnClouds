extends Node

var color_rect: ColorRect
var ui_layer: CanvasLayer

func _ready():
	_init_overlay()


func _init_overlay():
	if color_rect:
		return

	ui_layer = CanvasLayer.new()
	ui_layer.name = "UILayer"
	ui_layer.layer = 4
	ui_layer.process_mode = Node.PROCESS_MODE_ALWAYS
	add_child(ui_layer)

	color_rect = ColorRect.new()
	color_rect.color = Color.BLACK
	color_rect.self_modulate = Color(1, 1, 1, 0) # Start transparent
	color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	var day_end_ui = load("res://day_end_ui.tscn").instantiate().duplicate()
	var center_ui = CenterContainer.new()
	center_ui.set_anchors_preset(Control.LayoutPreset.PRESET_FULL_RECT)
	center_ui.mouse_filter = Control.MOUSE_FILTER_IGNORE
	center_ui.name = "CenterUI"
	center_ui.visible = false
	#day_end_ui.set_anchor_preset(Control.LayoutPreset.PRESET_CENTER)
	
	center_ui.add_child(day_end_ui)
	ui_layer.add_child(color_rect)
	ui_layer.add_child(center_ui)
	
	color_rect.anchor_left = 0
	color_rect.anchor_top = 0
	color_rect.anchor_right = 1
	color_rect.anchor_bottom = 1
	color_rect.offset_left = 0
	color_rect.offset_top = 0
	color_rect.offset_right = 0
	color_rect.offset_bottom = 0

func switch_visibility_black():
	for child in ui_layer.get_children():
		if child.name == "CenterUI":
			child.visible = !child.visible
	get_tree().paused = true

func switch_visibility_screen():
	for child in ui_layer.get_children():
		if child.name == "CenterUI":
			child.visible = !child.visible
	get_tree().paused = false

func fade_to_black(duration := 5.0):
	_init_overlay()
	var tween := create_tween()
	tween.tween_property(color_rect, "self_modulate", Color(1, 1, 1, 1), duration)
	tween.tween_callback(switch_visibility_black)


func fade_to_screen(duration := 5.0):
	_init_overlay()
	var tween := create_tween()
	switch_visibility_screen()
	tween.tween_property(color_rect, "self_modulate", Color(0, 0, 0, 0), duration)
