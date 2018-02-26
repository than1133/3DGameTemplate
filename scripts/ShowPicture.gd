extends Control

# Node var
var nd_pic
var anim_show_pic

func _ready():
	# Set node var
	nd_pic = get_node("pic")
	anim_show_pic = get_node("show_pic")
	
	nd_pic.hide()
	set_process_input(true)
	pass
	
func _input(event):
	if event.is_action_released("ui_cancel"):
		nd_pic.hide()
	
func display_picture(pic):
	if pic != null:
		nd_pic.set_texture(pic)
	nd_pic.show()
	anim_show_pic.play("show_pic")
	get_node("pic/btn_close").grab_focus()
	get_tree().set_pause(true)

func _on_btn_close_pressed():
	nd_pic.hide()
	get_tree().set_pause(false)


func _on_show_pic_finished():
	get_node("pic/btn_close").grab_focus()
