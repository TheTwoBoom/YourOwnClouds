extends Email
class_name InquiryEmail
var required_level: int
var requested_category: String
var specs: CustomerRequirements
var payment_per_month: int

func _init(d):
	super(d)
	required_level = d.requiredLevel
	requested_category = d.requestedCategory
	if requested_category == "dedi":
		specs = DediRequirements.new(d.specs)
	else:
		specs = CustomerRequirements.new(d.specs)
	payment_per_month = d.paymentPerMonth
