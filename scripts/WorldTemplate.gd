tool
extends Spatial

export(int, "Night", "Day") var day_night = 1 setget set_day_night

func _ready():
	set_process(true)
	
func _process(delta):
	get_node("Sun").set_parameter(3, day_night)
		
func set_day_night(v):
	day_night = v
	