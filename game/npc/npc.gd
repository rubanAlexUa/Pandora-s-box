extends CharacterBody2D

const speed = 30
var current_state = SIDE_LEFT

var dir = Vector2.RIGHT
var start_pos

var is_roaming = true
var is_chatting = false

var player
var player_in_chat_zone = false

enum {
	IDLE,
	NEW_DIR,
	MOVE
}

func _ready():
	randomize()
	start_pos = position
func _process(delta):
	if current_state == 0 or current_state == 1:
		$AnimatedSprite2D.play("idle")
	elif current_state == 2 and !is_chatting:
		if dir.x == -1:
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("move")
		if dir.x == 1:
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("move")
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

func _on_chat_detection_area_body_entered(body) :
	if body.has_method("player"):
		player = body 
		player_in_chat_zone = true
	
func _on_chat_detection_area_body_exited(body) :
	if body.has_method("player"):
		player_in_chat_zone = false

func _on_timer_timeout() :
	$Timer.wait_time = choose([0.5, 1, 1.5])
	current_state = choose([IDLE, NEW_DIR, MOVE])
