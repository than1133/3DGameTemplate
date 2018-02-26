extends Spatial

export(String, FILE, "*.png") var picture
var opened = false

func _ready():
	pass

func _on_Area_body_enter( body ):
	if opened==false and body.is_in_group("player") and picture:
		get_node("AnimationPlayer").play("open-chest")
		get_tree().set_pause(true)


func _on_AnimationPlayer_finished():
	var pic = load(picture)
	get_node("ShowPicture").display_picture(pic)
	opened = true
