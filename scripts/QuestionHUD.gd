extends Control

var nd_question
var anss
var if_true = 0
var if_false = 0

signal question_finish

func _ready():
	# Set node var 
	nd_question = get_node("question")
	nd_question.hide()
	pass
	
func set_question(t, c1, c2, c3, c4, ans, itrue, ifalse):
	get_node("question/Quiz/question").set_text(str(t))
	get_node("question/Quiz/choice1").set_text(str(c1))
	get_node("question/Quiz/choice2").set_text(str(c2))
	get_node("question/Quiz/choice3").set_text(str(c3))
	get_node("question/Quiz/choice4").set_text(str(c4))
	anss = ans
	if_true = itrue
	if_false = ifalse
	nd_question.show()
	get_tree().set_pause(true)
	nd_question.get_node("Quiz/choice1").grab_focus()

func _on_choice1_button_up():
	check_answer(1)
	nd_question.hide()
	get_tree().set_pause(false)

func _on_choice2_button_up():
	check_answer(2)
	nd_question.hide()
	get_tree().set_pause(false)

func _on_choice3_button_up():
	check_answer(3)
	nd_question.hide()
	get_tree().set_pause(false)

func _on_choice4_button_up():
	check_answer(4)
	nd_question.hide()
	get_tree().set_pause(false)
	
func check_answer(choice_choose):
	if choice_choose == anss:
		GUICenter.increase_score(if_true)
	else:
		GUICenter.decrease_score(if_false)
	emit_signal("question_finish")
