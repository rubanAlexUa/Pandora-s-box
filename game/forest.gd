extends Area2D

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
	"text": "Ліс занадто густий щоб його пройти тут. Може є інший шлях щоб пройти?",
		"emotion": Emotion.NONE
	}
	
]
var dialogue_node: Node = null

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.name == "player" and dialogue_node != null:
		if dialogue_node.current_state == dialogue_node.State.READY:
			Global.can_move = false
			dialogue_node.start_dialogue(lines)
