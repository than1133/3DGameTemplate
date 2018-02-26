extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export(int) var apply_damage = 0

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	get_node("Quad").hide()
	pass


func _on_Area_body_enter( body ):
	if body.is_in_group("player"):
		print("player touch dead zone")
		GUICenter.decrease_hp(apply_damage)
		body.set_transform(body.first_pos)
