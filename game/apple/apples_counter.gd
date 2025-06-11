extends Label

var current_apples = 0

func _ready():
	$".".text = str(current_apples)

func _process(delta: float) -> void:
	$".".text = str(current_apples)
