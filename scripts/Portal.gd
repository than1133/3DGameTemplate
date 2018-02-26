extends KinematicBody

export(String, FILE, "*.tscn") var WarpTo
var ui

func _ready():
	ui = get_node("UI")
	pass

func _on_Area_body_enter( body ):
	if body.is_in_group("player"):
		if WarpTo != null:
			ui.show()
			get_node("UI/No").grab_focus()
			get_tree().set_pause(true)
		pass
	pass # replace with function body


func _on_Yes_pressed():
	get_tree().change_scene(WarpTo)
	get_tree().set_pause(false)
	pass # replace with function body


func _on_No_pressed():
	ui.hide()
	get_tree().set_pause(false)
	pass # replace with function body
