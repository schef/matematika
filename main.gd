extends Control

func _randi_range_exclude(from, to, exclude):
	var res: int
	while true:
		res = randi_range(from, to)
		if res != exclude:
			return res

func generate_challange():
	var first: int = randi_range(1, 10)
	var second: int = randi_range(1, 10)
	var result = first * second
	var wrong_anwser_one: int
	while true:
		wrong_anwser_one = first * _randi_range_exclude(1, 10, second)
		if wrong_anwser_one != result:
			break
	var wrong_anwser_two: int
	while true:
		wrong_anwser_two = _randi_range_exclude(1, 10, first) * second
		if wrong_anwser_two != result and wrong_anwser_two != wrong_anwser_one:
			break
	return {"question": "%s x %s" % [first, second], "anwsers": [str(result), str(wrong_anwser_one), str(wrong_anwser_two)], "correct": str(result)}

func _ready():
	while true:
		var challange_one: ChallangeOne = SceneHolder.CHALLANGE_ONE_SCENE.instantiate()
		var challange = generate_challange()
		challange_one.question = challange.question
		challange.anwsers.shuffle()
		challange_one.anwsers = challange.anwsers
		challange_one.correct_anwser = challange.correct
		challange_one.result.connect(_on_result)
		self.add_child(challange_one)
		await challange_one.result

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_result(result: int):
	print(result)
