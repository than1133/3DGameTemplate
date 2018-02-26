extends Spatial

export(String, MULTILINE) var text
var opened = false

func _ready():
	pass

func _on_Area_body_enter( body ):
	if opened==false and body.is_in_group("player") and text:
		get_node("AnimationPlayer").play("open-chest")
		get_tree().set_pause(true)

func _on_AnimationPlayer_finished():
	get_node("MessageDialog").add_text_queue(text)
	opened = true
