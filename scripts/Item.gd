extends KinematicBody

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_Area_body_enter( body ):
	if body.is_in_group("player"):
		GUICenter.increase_coin(1)
		get_node("StreamPlayer").play()
	pass # replace with function body


func _on_StreamPlayer_finished():
	call_deferred("queue_free")
	pass # replace with function body
