extends KinematicBody

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export(int) var damage = 0
export(String, "idle", "random") var MoveType
export(float) var walkSpeed = 3
export(float) var waitWalkingTime = 3
export(float) var waitIdleTime = 3

var waitWalking
var waitIdle
var anim
var begin_walk = false
var rand = 0
var ray
var ray_check_ground

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	waitIdle = get_node("waitIdle")
	waitWalking = get_node("waitWalking")
	anim = get_node("AnimationTreePlayer")
	ray = get_node("check_edge")
	ray_check_ground = get_node("check_floor")
	
	waitIdle.set_wait_time(waitIdleTime)
	waitWalking.set_wait_time(waitWalkingTime)
	ray_check_ground.add_exception(self)
	
	waitIdle.start()
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	if !ray_check_ground.is_colliding():
		move(Vector3(0, -1*delta, 0))
		
	var rot_rang = [180, -90, 0, 90]
	if MoveType == "random":
		if waitIdle.get_time_left() <=0:
			if !begin_walk:
				randomize()
				rand = int(rand_range(0,4))
				waitWalking.start()
				anim.transition_node_set_current("transition", 1)
				begin_walk = true
				
			set_rotation_deg(Vector3(0, rot_rang[rand],0))
			if ray.is_colliding():
				translate(Vector3(0, 0, walkSpeed*delta))
				
			if waitWalking.get_time_left() <=0:
				begin_walk = false
				anim.transition_node_set_current("transition", 0)
				waitIdle.start()


func _on_Area_body_enter( body ):
	if body.is_in_group("player"):
		GUICenter.decrease_hp(damage)
	pass # replace with function body
