extends CharacterBody2D

signal healthChanges

@onready var health_component: HealthComponent = $HealthComponent
@onready var grace_period: Timer = $GracePeriod
@onready var sad_sound = $uomp
@onready var nomnom = $nomnom

var defence = 25
var enemies_colliding = 0
var heal_sum = 0
var last_damage = null
var type = "player"

@export var movement_speed : float = 200
var character_direction : Vector2
@export var can_move : bool = false  

func _ready():
	health_component.died.connect(on_died)
	health_component.max_health = 100
	health_component.current_health = health_component.max_health
	add_to_group("player")
	$AnimatedSprite2D.sprite_frames.set_animation_loop("dirt", false)
	$AnimatedSprite2D.animation = "dead"
	
	await get_tree().create_timer(2.0).timeout
	can_move = true
	Global.can_attack = true

func _physics_process(delta):
	if Input.is_action_just_pressed("healling"):
		heal_player()
	if not can_move:
		return
	if not Global.can_move:
		$AnimatedSprite2D.animation = "stand"
		return
		
	character_direction.x = Input.get_axis("move_left", "move_right")
	character_direction.y = Input.get_axis("move_up", "move_down")
	if character_direction.x > 0: 
		$AnimatedSprite2D.flip_h = false
	elif character_direction.x < 0: 
		$AnimatedSprite2D.flip_h = true
	
	
	if character_direction:
		velocity = character_direction * movement_speed
		
		if character_direction.y < 0: 
			if $AnimatedSprite2D.animation != "go_back": 
				$AnimatedSprite2D.animation = "go_back"
		elif character_direction.y > 0: 
			if $AnimatedSprite2D.animation != "go_front": 
				$AnimatedSprite2D.animation = "go_front"
		elif character_direction.x != 0:  
			if $AnimatedSprite2D.animation != "left_right": 
				$AnimatedSprite2D.animation = "left_right"
	else:
		velocity = velocity.move_toward(Vector2.ZERO, movement_speed)
		if $AnimatedSprite2D.animation != "stand": 
			$AnimatedSprite2D.animation = "stand"
		
	move_and_slide()

func check_if_damage():
	if enemies_colliding == 0 || !grace_period.is_stopped():
		return
	
	health_component.take_damage(last_damage, defence, type)
	healthChanges.emit()
	grace_period.start()

func heal_player():
	if get_parent().get_node("CanvasLayer/CanvasLayer2/apples").current_apples == 0:
		sad_sound.play()
		return
	get_parent().get_node("CanvasLayer/CanvasLayer2/apples").current_apples -= 1
	heal_sum = 20 + health_component.current_health
	health_component.healing(heal_sum)
	nomnom.play()
	healthChanges.emit()

func _on_hurt_box_area_entered(area) :
	print(owner)
	enemies_colliding +=1
	last_damage = area.owner.damage
	check_if_damage()
	print(health_component.current_health)

func _on_player_hurt_box_area_exited(area: Area2D) -> void:
	enemies_colliding -= 1

func on_died():
	queue_free()
