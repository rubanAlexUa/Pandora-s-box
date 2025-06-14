extends CharacterBody2D

const speed = 30
var current_state = IDLE

var dir = Vector2.RIGHT

var is_roaming = true


enum {
	IDLE,
	NEW_DIR,
	MOVE
}

func _process(delta):
	if current_state == 0 or current_state == 1:
		$AnimatedSprite2D.play("idle")
	elif current_state == 2 :
		$AnimatedSprite2D.play("move")
		if dir.x == -1:
			$AnimatedSprite2D.flip_h = false
		elif dir.x == 1:
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
	velocity = dir * speed
	move_and_slide()

func _on_timer_timeout() :
	$Timer.wait_time = choose([0.5, 1, 1.5])
	current_state = choose([IDLE, NEW_DIR, MOVE])
