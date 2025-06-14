extends Node

var hammer_damage = 25

@export var atack_ability: PackedScene
const ATTACK_DISTANCE = 100.0

func _process(delta):
	if Input.is_action_just_pressed("attack") and Global.can_attack:
		perform_attack()

func perform_attack():
	Global.can_attack = false

	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		print("немає((")
		return

	var mouse_world_pos = player.get_global_mouse_position()
	var direction = (mouse_world_pos - player.global_position).normalized()
	var offset = direction * ATTACK_DISTANCE

	var attack_instance = atack_ability.instantiate() as AttackAbility
	player.get_parent().add_child(attack_instance)
	attack_instance.global_position = player.global_position + offset
	attack_instance.hit_box_component.damage = hammer_damage
	await get_tree().create_timer(2.0).timeout
	Global.can_attack = true


func hit_sound_play():
	var attack_instance = atack_ability.instantiate() as AttackAbility
	attack_instance.play_hit_sound()
