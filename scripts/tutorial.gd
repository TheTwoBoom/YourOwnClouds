extends Control
var index: int = -1
var content_dict: Dictionary = {
	"Background Story": "In this game you're a young entrepreneur.
	You run a server hosting business.
	Enough story for now! Let's get you started!",
	"Economics": "As a business, there are typical running costs.
	In your case, you've got power, rent and uplink costs.
	Currently they are totaling around 300 per month
	Try to offset the costs by successfully renting out your equipment.",
	"Workflow": "You are being provided with a starter pack
	It contains the following things and items:
	2000$, some mid-tier servers, a uplink and
	a prepaid lease for your own datacenter cage.
	Now go into your email client and accept your first offer!
	PS: You may buy additional equipment in the shop later",
	"DesktopContent": "DesktopContent",
	"End of tutorial!": "The rest of the content isn't really polished.
	Feel free to go into the datacenter!
	Also try out the other things on the desktop",
	"EndDesktopContent": "EndDesktopContent",
	"": ""
}

func change_page() -> void:
	if content_dict.keys()[index] == content_dict.values()[index]:
		HelperFunctions.ui_manager.back_to_desktop()
		self.visible = false
		index += 1
	%TextLabel.text = content_dict.values()[index]
	%TitleLabel.text = content_dict.keys()[index]
	print(index)
	return


func _on_next_button_pressed() -> void:
	index += 1
	change_page()
	return


func _on_back_button_pressed() -> void:
	index -= 1
	change_page()
	return
