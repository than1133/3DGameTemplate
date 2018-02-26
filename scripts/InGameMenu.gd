extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var menu_on = false
var menu

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	menu = get_node("Menu")
	menu.hide()
	set_process_input(true)
	pass
	
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		menu_on = !menu_on
		menu.get_node("Resume").grab_focus()
		MenuOn()
		
	
func MenuOn():
	if menu_on:
		get_node("MenuBtn").hide()
		get_tree().set_pause(true)
		menu.show()
	else:
		menu.hide()
		get_node("MenuBtn").show()
		get_tree().set_pause(false)
	pass


func _on_MenuBtn_pressed():
	menu_on = !menu_on
	menu.get_node("Resume").grab_focus()
	MenuOn()
	pass # replace with function body


func _on_Resume_pressed():
	menu_on = false
	MenuOn()
	pass # replace with function body


func _on_GoToMainMenu_pressed():
	get_tree().set_pause(false)
	get_tree().change_scene("res://scenes/title.tscn")
		
	pass # replace with function body
