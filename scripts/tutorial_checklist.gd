extends MarginContainer
var index = 0
var check_array = [null, false, false]

func _process(_delta: float) -> void:
	match index:
		0:
			check_array = gen_checkboxes_tutorial0()
		1:
			return
	apply_checkboxes()
	for check in check_array:
		if check == false:
			return
	%UiManager.open_tutorial()
	index += 1
	JsonLoader.tutorial = true
	check_array = [null, false, false]
	self.visible = false

func apply_checkboxes() -> void:
	for i in range(check_array.size()):
		if check_array[i] != null:
			var checkbox = %TutorialCheckContainer.find_child("CheckboxRect" + str(i))
			if checkbox != null:
				if check_array[i]:
					checkbox.texture = load("res://assets/checkboxes/checked.tres")
				elif !check_array[i]:
					checkbox.texture = load("res://assets/checkboxes/non-checked.tres")

func gen_checkboxes_tutorial0() -> Array:
	var checkboxes = [null, false, false]
	if %TutorialContent.index >= 3:
		checkboxes[1] = true
	if JsonLoader.active_customers.size() != 0:
		checkboxes[2] = true
	return checkboxes

func refresh_goals() -> void:
	pass
