extends ProgressBar

@onready var player: CharacterBody2D = %player

func _ready() :
	player.healthChanges.connect(update)
	update()

func update():
	value = clamp(float(player.health_component.current_health) / max(player.health_component.max_health, 1), 0.0, 1.0) * 100
