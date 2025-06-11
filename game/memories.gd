extends Area2D

var played_f_t = false
enum Emotion {
	NEUTRAL,
	FINE,
	ANGRY,
	SHY,
	INTERESTED,
	GNARPY,
	SHOCKED,
	POKER_FACE,
	DISMAY,
	NONE
}

var lines1 = [
	{
		"text": "Дивно, але появилося якесь дежавю?",
		"emotion": Emotion.POKER_FACE,
	},
	{
		"text": "Хмм, виглядає як запчастини до якогось механізму чи то пристрою",
		"emotion": Emotion.INTERESTED,
	},
	{
		"text": "Я наче починаю згадувати",
		"emotion": Emotion.NEUTRAL,
	},
	{
		"text": "...",
		"emotion": Emotion.SHOCKED,
	},
	{
		"text": "*До вас повернулася частина спогадів, з минулого покритого темрявою",
		"emotion": Emotion.NONE,
	},
	{
		"text": "Нажміть \"F\" щоб відкрити інвентар та дізнатися більше",
		"emotion": Emotion.NONE,
	}
]
var lines2 = [
	{
		"text": "Виглядає як купка мотлоху, та покриті мохом спогади",
		"emotion": Emotion.NONE,
	},
	{
		"text": "*Пахне мастилом для машин, металом ташоколадним печивом",
		"emotion": Emotion.NONE,
	},
]
var dialogue_node: Node = null

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.name == "player" and dialogue_node != null:
		print("друкую")
		if dialogue_node.current_state == dialogue_node.State.READY:
			Global.can_move = false
			if played_f_t == false:
				dialogue_node.start_dialogue(lines1)
				played_f_t = true
			elif played_f_t == true:
				dialogue_node.start_dialogue(lines2)
			
