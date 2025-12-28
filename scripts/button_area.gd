extends Area2D
@onready var player = %PlayerBody2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "PlayerBody2D":
		if name == "DataCenterArea2D":
			call_deferred("change_scene_to_file", "res://datacenter.tscn")
		elif name == "OfficeArea2D":
			call_deferred("change_scene_to_file", "res://office.tscn")
		elif name == "MainDeskArea2D":
			%TooltipDesktop.visible = true
		player.key_area = name

func _on_body_exited(body: Node2D) -> void:
	if body.name == "PlayerBody2D" and player.key_area == name:
		if name == "MainDeskArea2D":
			%TooltipDesktop.visible = false
		player.key_area = ""

func change_scene_to_file(path: String):
	get_tree().change_scene_to_file(path)
