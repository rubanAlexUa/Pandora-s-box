extends Area2D

@export var lines: Array = [
	"Ліс занадто густий щоб його пройти тут. Може є інший шлях щоб пройти?"
]
var dialogue_node: Node = null

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.name == "player" and dialogue_node != null:
		if dialogue_node.current_state == dialogue_node.State.READY:
			Global.can_move = false
			dialogue_node.start_dialogue(lines)
