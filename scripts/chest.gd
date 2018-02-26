extends Spatial

export(String, FILE, "*.png") var picture
export(String, MULTILINE) var text
var opened = false

func _ready():
	pass

func _on_Area_body_enter( body ):
	if opened==false:
		get_node("AnimationPlayer").play("open-chest")
		if text:
			GUICenter.add_text_to_message_dialog(text)
		if picture:
			var pic = load(picture)
			GUICenter.show_picture(pic)
		opened = true
