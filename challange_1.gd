class_name ChallangeOne extends Control

signal result(int)

@export var question: String = "Question":
	set(new_value):
		question = new_value
		_ui_update_question()
		
@export var anwsers: Array = ["Anwser 1", "Anwser 2", "Anwser 3"]:
	set(new_value):
		anwsers = new_value
		_ui_update_anwsers()
		
@export var correct_anwser: String = "Anwser 2"
var selected_anwser: String = ""
@onready var question_label: Label = %QuestionLabel
@onready var anwsers_container: BoxContainer = %AnwsersContainer
@onready var check_button: Button = %CheckButton
@onready var result_label: Label = %ResultLabel

func _ready():
	check_button.pressed.connect(_on_check_button_pressed)
	result_label.text = ""
	_ui_update()

func _ui_update_question():
	if question_label == null:
		return
	question_label.text = question
	
func _ui_update_anwsers():
	if anwsers_container == null:
		return
	for anwser in anwsers:
		var button: Button = Button.new()
		button.text = anwser
		button.toggle_mode = true
		button.focus_mode = Control.FOCUS_NONE
		button.custom_minimum_size.y = 50
		button.pressed.connect(_on_anwser_button_pressed.bind(button))
		button.button_group = load("res://anwser_button_group.tres")
		anwsers_container.add_child(button)

func _ui_update():
	_ui_update_question()
	_ui_update_anwsers()

func _on_anwser_button_pressed(button: Button):
	if check_button.disabled:
		check_button.disabled = false
	selected_anwser = button.text

func _on_check_button_pressed():
	if check_button.text != "CHECK":
		if check_button.text == "CONTINUE":
			result.emit(1)
		else:
			result.emit(0)
		self.queue_free()
	if selected_anwser == correct_anwser:
		check_button.text = "CONTINUE"
		result_label.text = "Good anwser!"
	else:
		check_button.text = "GOT IT"
		result_label.text = "Give it another try!"
		var style: StyleBoxFlat = check_button.get("theme_override_styles/normal")
		style.bg_color = Color("EE5655")
		style.border_color = Color("C54C4E")
		check_button.set("theme_override_styles/normal", style)
