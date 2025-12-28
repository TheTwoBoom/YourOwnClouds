extends NinePatchRect


func _on_visibility_changed() -> void:
	if !get_tree().paused and visible:
		refresh_ui()
	
func refresh_ui() -> void:
	HelperFunctions.calc_finances()
	HelperFunctions.apply_finances()
	HelperFunctions.generate_email_inbox()
	%TotalLabel.text = str(JsonLoader.money)
	for index in range(4):
		var node = get_node("%Pos" + str(index+1))
		for child in node.get_children():
			if child.name == "IncomeLabel":
				if JsonLoader.financeArray[index][0] != 0:
					child.text = str(JsonLoader.financeArray[index][0])
			elif child.name == "ExpensesLabel":
				if JsonLoader.financeArray[index][1] != 0:
					child.text = str(JsonLoader.financeArray[index][1])


func _on_quit_button_pressed() -> void:
	pass

func _on_next_button_pressed() -> void:
	BlackTransition.fade_to_screen()
