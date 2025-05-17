extends CharacterBody2D

@export var movement_speed : float = 200
var character_direction : Vector2
@export var can_move : bool = false  

func _ready():
	$AnimatedSprite2D.sprite_frames.set_animation_loop("dirt", false)
	$AnimatedSprite2D.animation = "dead"
	
	await get_tree().create_timer(2.0).timeout
	can_move = true

func _physics_process(delta):
	# Якщо рухатися не можна, не обробляємо рух
	if not can_move:
		return
	if not Global.can_move:
		$AnimatedSprite2D.animation = "stand"
		return
	# Отримуємо напрямок руху
	character_direction.x = Input.get_axis("move_left", "move_right")
	character_direction.y = Input.get_axis("move_up", "move_down")
	if character_direction.x > 0: 
		$AnimatedSprite2D.flip_h = false
	elif character_direction.x < 0: 
		$AnimatedSprite2D.flip_h = true
	
	# Логіка вибору анімації залежно від напрямку руху
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
