extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	global_run.in_map = false
	get_node("btn_goto_title").grab_focus()
	pass


func _on_btn_goto_title_button_up():
	get_tree().change_scene("res://scenes/title.tscn")
	pass # replace with function body
