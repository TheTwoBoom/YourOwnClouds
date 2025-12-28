extends Control

func _on_visibility_changed() -> void:
	%ComponentTitleLabel.text = JsonLoader.viewed_inv_item.display_name
	%ComponentDescriptionLabel.text = JsonLoader.viewed_inv_item.description
