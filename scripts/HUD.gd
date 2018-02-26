extends Control


var nd_hp_cont


var CoinsNumberNode
var nd_coin_label
var mobileCon

func _ready():
	nd_coin_label = get_node("VBoxContainer/Coins/CoinsNumber")
	mobileCon = get_node("MobileControl")
	nd_hp_cont = get_node("VBoxContainer/Hp")
	
	heart_refresh()
	
	if OS.get_name() == "Android":
		mobileCon.show()
	else:
		mobileCon.hide()
		
	set_process(true)
		
func heart_refresh():
	for x in nd_hp_cont.get_children():
		x.queue_free()

	for x in range(global_run.hp):
		var nd_heartTex = load("res://gui/heartTex.tscn").instance()
		nd_hp_cont.add_child(nd_heartTex)
		
func _process(delta):
	nd_coin_label.set_text(str(global_run.coins))
	get_node("VBoxContainer/Score/ScoreNumber").set_text(str(global_run.score))
