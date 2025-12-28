extends Control


func _on_visibility_changed() -> void:
	for child in %CustomerContainer.get_children():
		child.queue_free()
	for customer: Customer in JsonLoader.all_customers:
		var container: PanelContainer = load("res://template_customer.tscn").instantiate().duplicate()
		if JsonLoader.get_customer_by_id(customer.id, true) == null:
			container.modulate.a = 0.5
		var monthlySpend = HelperFunctions.calc_monthly_spend_from_customer(customer)
		container.get_node("%IconTexture").texture = ImageTexture.create_from_image(Image.load_from_file("res://assets/customerHeads/" + customer.avatar + ".png"))
		container.get_node("%NameLabel").text = customer.display_name
		container.get_node("%EmailLabel").text = "Email: " + customer.address
		container.get_node("%ProductsLabel").text = "Products: " + str(customer.products)
		container.get_node("%SupportLabel").text = "supportType: " + customer.support_type
		container.get_node("%SpendingLabel").text = "Monthly spend: " + str(monthlySpend)
		%CustomerContainer.add_child(container)
