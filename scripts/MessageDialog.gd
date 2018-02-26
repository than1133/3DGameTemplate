extends Control

# Member variable
var text_queue = []
var time_visible_char = 0
var state_process_text = 0
var text_speed = 20

# Node variable
var text_node
var dialog_node
var anim_open_dialog
var anim_notic_next
var node_notic_next

func _ready():
	# Set node variable
	dialog_node = get_node("Dialog")
	text_node = get_node("Dialog/text")
	anim_open_dialog = get_node("open_dialog")
	anim_notic_next = get_node("notic_next")
	node_notic_next = get_node("Dialog/notic_next")
	
	dialog_node.hide()
	node_notic_next.hide()
	set_process(true)
	set_process_input(true)
	pass
	
func _input(event):
	if event.is_action_released("ui_accept"):
		if state_process_text == 1:
			if time_visible_char < text_node.get_bbcode().length():
				time_visible_char = text_node.get_bbcode().length()
			else:
				get_tree().set_pause(false)
				dialog_node.hide()
				text_queue.remove(0)
				state_process_text = 0
	pass
	
func _process(delta):
	if text_queue.size() > 0:
		get_tree().set_pause(true)
		if state_process_text == 0:
			node_notic_next.hide()
			text_node.clear()
			time_visible_char = 0
			text_node.set_bbcode(text_queue[0])
			dialog_node.show()
			anim_open_dialog.play("open_dialog")
			state_process_text = 1
		else:
			if !anim_open_dialog.is_playing():
				if time_visible_char < text_node.get_bbcode().length():
					time_visible_char+=text_speed*delta
				else:
					node_notic_next.show()
		
		text_node.set_visible_characters(time_visible_char)

# Add text to text_queue variable 
func add_text_queue(text):
	text_queue.append(text)
