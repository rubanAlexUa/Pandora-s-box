extends CharacterBody2D

var speed = 70
var defence = 25 
var damage = 50
var type = "enemy"

var player_chase = false
var player = null

var dir = Vector2.RIGHT
var start_pos
var is_roaming = true
var is_chatting = false
var player_in_chat_zone = false

@onready var health_component: HealthComponent = $HealthComponent
@onready var progress_bar: ProgressBar = $ProgressBar

enum {
	IDLE,
	NEW_DIR,
	MOVE
}

var current_state = IDLE 

func _ready():
	health_component.died.connect(on_died)
	randomize()
	start_pos = position
	health_component.max_health = 100
	health_component.type = type
	health_component.current_health = health_component.max_health
	progress_bar.visible = false

func _physics_process(delta):
	if player_chase and player:
		position += (player.position - position) / speed

		if (player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = false
		else:
			$AnimatedSprite2D.flip_h = true 

func _process(delta):
	if current_state == MOVE and !is_chatting:
		if dir.x == -1:
			$AnimatedSprite2D.flip_h = false
		if dir.x == 1:
			$AnimatedSprite2D.flip_h = true
	if is_roaming:
		match current_state:
			IDLE:
				pass
			NEW_DIR:
				dir = choose([Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN])
			MOVE:
				move(delta)

func choose(array):
	array.shuffle()
	return array[0]

func move(delta):
	position += dir * speed * delta

func _on_timer_timeout():
	$Timer.wait_time = choose([0.2, 0.3, 0.4])
	current_state = choose([IDLE, NEW_DIR, MOVE, MOVE, MOVE])

func _on_detection_area_body_entered(body):
	if body.is_in_group("player"):
		player = body
		player_in_chat_zone = true
		player_chase = true

func _on_detection_area_body_exited(body):
	if body.is_in_group("player"):
		player = null
		player_chase = false
		player_in_chat_zone = false

func on_died():
	queue_free()
