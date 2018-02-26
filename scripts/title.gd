extends Control

export(String, FILE, "*.tscn") var IfStartPress
export(String, FILE, "*.tscn") var ContinueScene

func _ready():
	global_run.in_map = false
	get_node("Menu/Start").grab_focus()
	GUICenter.set_hp(3)
	global_run.coins = 0
	global_run.score = 0
	global_run.in_map = false

func _on_Exit_pressed():
	get_tree().quit()

func _on_Start_pressed():
	if IfStartPress != null:
		get_tree().change_scene(IfStartPress)
	else:
		print("No next scene to start button.")

func _on_Quit_pressed():
	get_tree().quit()
