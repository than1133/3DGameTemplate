extends KinematicBody

export(String) var question
export(String) var choice1
export(String) var choice2
export(String) var choice3
export(String) var choice4
export(int) var choice_answer
export(int) var increase_score_if_true = 0
export(int) var decrease_score_if_false = 0 

func _ready():
	pass


func _on_Area_body_enter( body ):
	if body.is_in_group("player"):
		get_node("QuestionHUD").set_question(
		question, 
		choice1, 
		choice2, 
		choice3, 
		choice4, 
		choice_answer,
		increase_score_if_true,
		decrease_score_if_false)
		pass
	pass # replace with function body


func _on_QuestionHUD_question_finish():
	queue_free()
	pass # replace with function body
