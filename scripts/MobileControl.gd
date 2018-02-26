extends Node2D


var jump = false
var run = false

var hv = Vector2()
var _nd_analog_core
var _nd_bg_analog

func _ready():
	_check_os()
	_nd_analog_core = get_node("bg_analog/analog_core")
	_nd_bg_analog = get_node("bg_analog")
	set_process(true)
	
func _input(ev):
	
	if ev.type==InputEvent.MOUSE_MOTION:
		var n_pos = _nd_analog_core.get_pos()
		n_pos.x += ev.relative_x
		n_pos.y += ev.relative_y
		n_pos = n_pos.clamped(96)
		_nd_analog_core.set_pos(n_pos)
		hv = _set_hv(_nd_analog_core.get_pos())
		
func get_hv():
	return hv
		
func _set_hv(pos):
	var n_hv
	n_hv = (pos*1)/95
	return n_hv
	
func _check_os():
	var os_pc = ["Windows", "X11", "OSX"]
	for o in os_pc:
		if OS.get_name() == o:
			hide()
	
func _process(delta):
	get_node("Label").set_text(str(get_node("action/jump").is_pressed()))
	
	jump = get_node("action/jump").is_pressed()
	run = get_node("action/run").is_pressed()
	
	var screen_pos = get_viewport().get_rect()

func _on_analog_core_button_up():
	set_process_input(false)
	_nd_analog_core.set_pos(Vector2(0, 0))
	hv = Vector2(0, 0)

func _on_analog_core_button_down():
	set_process_input(true)
