extends Camera2D

@onready var player: CharacterBody2D = %player

func _process(delta):
	if is_instance_valid(player):
		global_position = player.global_position
