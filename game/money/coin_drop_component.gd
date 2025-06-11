extends Node

@export var coin_scene:PackedScene
@export var health_component:Node

func _ready():
	(health_component as HealthComponent).died.connect(on_died)
	
func on_died():
	if coin_scene == null:
		return
	if not owner is Node2D:
		return
	
	var spawn_pos = (owner as Node2D).global_position
	var coin_instance = coin_scene.instantiate() as Node2D
	owner.get_parent().add_child(coin_instance)
	coin_instance.global_position = spawn_pos
