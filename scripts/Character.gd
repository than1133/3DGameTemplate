extends KinematicBody

export(float) var player_walk_accelerate = 1
export(float) var player_max_walk_speed = 0.1
export(bool) var can_run = false
export(float) var player_run_accelerate = 1
export(float) var player_max_run_speed = 0.2
export(float) var Gravity = 5
export(bool) var can_jump = false
export(float) var jump_accelerate = 100

var ray
var velocity = Vector3()
var CharacterTemplate
var player_anim
var anim_tree
var anim_state = "idle"
var first_pos
var player

var accelerate = Vector2()
var rot_var = 0
var look_speed = 5
var player_last_dir = Vector2()

var _mobile_con

func _ready():
	global_run.in_map = true
	CharacterTemplate = get_node("player")
	anim_tree = get_node("AnimationTreePlayer")
	player = get_node("player")
	player_anim = CharacterTemplate.get_node("AnimationPlayer")
	ray = get_node("ray")
	ray.add_exception(self)
	first_pos = get_global_transform()
	first_pos.origin.y+50
	_mobile_con = get_node("MobileControl")
	set_fixed_process(true)
	pass
	
func _fixed_process(delta):
	var w = Input.is_action_pressed("ui_up")
	var a = Input.is_action_pressed("ui_left")
	var s = Input.is_action_pressed("ui_down")
	var d = Input.is_action_pressed("ui_right")
	
	var shift = Input.is_action_pressed("shift")
	var space = Input.is_action_pressed("space")
	
	if can_jump == false:
		_mobile_con.get_node("action/jump").hide()
		
	if can_run == false:
		_mobile_con.get_node("action/run").hide()
	
	if _mobile_con.is_visible():
		space = _mobile_con.jump
		shift = _mobile_con.run
		_set_accelerate_for_mobile()
	else:
		_set_accelerate(delta, w, a, s, d)
#
	velocity.x = 0
	velocity.z = 0
	
	
	_player_movement(delta, shift)
	
	if !ray.is_colliding():
		_set_gravity(delta)
	else:
		_player_jump(delta, space)
		
	_animation_state_controller()
	move(velocity)
	
func _set_accelerate(delta, w, a, s, d):
	if w:
		accelerate.y = _cal_accelerate(delta, accelerate.y, 0, 1)
	elif s:
		accelerate.y = _cal_accelerate(-delta, accelerate.y, -1, 0)
	else:
		accelerate.y = 0
	if a:
		accelerate.x = _cal_accelerate(delta, accelerate.x, 0, 1)
	elif d:
		accelerate.x = _cal_accelerate(-delta, accelerate.x , -1, 0)
	else:
		accelerate.x = 0
		
func _set_accelerate_for_mobile():
	accelerate = -(_mobile_con.get_hv())
	
func _cal_accelerate(delta, axis, c_min, c_max):
	axis += delta*5
	axis = clamp(axis, c_min, c_max)
	return axis
	
func _is_accelerate():
	if accelerate.x != 0 or accelerate.y != 0:
		return true
	else:
		return false
	
func _set_gravity(delta):
	velocity.y -= Gravity*delta
	velocity.y = clamp(velocity.y, -0.5, 1)
	
func _player_jump(delta, space):
	velocity.y = 0
	if space and can_jump:
		anim_state = "jump"
		velocity.y += jump_accelerate*delta
	
func _player_rotation(delta):
	var t = player.get_transform()
	if _is_accelerate():
		var rot_dir = t.looking_at(Vector3(accelerate.x, 0, accelerate.y), Vector3(0, 1, 0))
		var this_rot = Quat(t.basis).slerp(rot_dir.basis, rot_var)
		rot_var+=delta
		rot_var = clamp(rot_var, 0, 1)
		player.set_transform(Transform(this_rot, t.origin))
	else:
		rot_var = 0

# Character movement controller
func _player_movement(delta, run):
	if _is_accelerate():
		if run and can_run:
			velocity.x += -accelerate.x*player_run_accelerate
			velocity.x = clamp(velocity.x, -player_max_run_speed, player_max_run_speed)
			velocity.z += -accelerate.y
			velocity.z = clamp(velocity.z, -player_max_run_speed, player_max_run_speed)
			_player_rotation(delta)
			anim_state = "run"
		else:
			velocity.x += -accelerate.x*player_walk_accelerate
			velocity.x = clamp(velocity.x, -player_max_walk_speed, player_max_walk_speed)
			velocity.z += -accelerate.y
			velocity.z = clamp(velocity.z, -player_max_walk_speed, player_max_walk_speed)
			_player_rotation(delta)
			anim_state = "walk"
	else:
		anim_state = "idle"

# Animation State of character
func _animation_state_controller():
	if ray.is_colliding():
		if anim_state == "idle":
			anim_tree.transition_node_set_current("transition", 0)
		if anim_state == "walk":
			anim_tree.transition_node_set_current("transition", 1)
		if anim_state == "run":
			anim_tree.transition_node_set_current("transition", 2)
	else:
		anim_tree.transition_node_set_current("transition", 3)
		pass