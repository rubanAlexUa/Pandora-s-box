extends Area2D

var played = false
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

var lines = [
	{
		"text": "#$&!Ö°_#λΩ中Я∑v9☂⌘ä@Жπ7ß☠∆1",
		"emotion": Emotion.DISMAY,
	},
	{
		"text": "Це мене звісно занисло. А де це я?",
		"emotion": Emotion.INTERESTED,
	},
	{
		"text": "Йо, шось невідоме місце мені, може вважається чи що...",
		"emotion": Emotion.POKER_FACE,
	}
]
var dialogue_node: Node = null

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.name == "player" and dialogue_node != null and played == false:
		await get_tree().create_timer(2.0).timeout
		print("друкую")
		played = true
		if dialogue_node.current_state == dialogue_node.State.READY:
			Global.can_move = false
			dialogue_node.start_dialogue(lines)
