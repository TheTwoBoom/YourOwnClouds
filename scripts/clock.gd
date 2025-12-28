extends Timer
var hours: int = 6
var minutes: int = 45
var freeze = false
var timetext = ""

func _on_timeout() -> void:
	if freeze:
		return
	
	minutes += 15
	
	if minutes >= 60:
		minutes = 0
		hours += 1
	if hours < 13:
		%ClockLabel.text = str(hours) + ":" + ("%02d" % minutes) + " AM"
	else:
		%ClockLabel.text = str(hours-12) + ":" + ("%02d" % minutes) + " PM"
	
	if hours > 20:
		hours = 6
		%ClockLabel.text = str(hours) + ":" + ("%02d" % minutes) + " AM"
		BlackTransition.fade_to_black()
