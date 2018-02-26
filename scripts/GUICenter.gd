extends Control

var HUD
var nd_msg_dial
var nd_show_pic

func _ready():
	HUD = get_node("HUD")
	set_process(true)
	
func _process(delta):
	if global_run.in_map == true:
		show()
	else:
		hide()
		
func increase_hp(n=0):
	global_run.hp+=n
	GUICenter.HUD.heart_refresh()
	
func decrease_hp(n=0):
	global_run.hp-=n
	HUD.heart_refresh()
	if global_run.hp <= 0:
		get_tree().change_scene("res://scenes/GameOver.tscn")
	
func set_hp(n=0):
	global_run.hp = n
	HUD.heart_refresh()
	
func increase_coin(n=0):
	global_run.coins += n
	
func decrease_coin(n=0):
	global_run.coins -= n
	
func set_coins(n=0):
	global_run.coins = n
	
func increase_score(n=0):
	global_run.score += n
	
func decrease_score(n=0):
	global_run.score -= n