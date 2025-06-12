extends CharacterBody2D

@onready var act_with_me: Sprite2D = $actWithMe
@onready var animation_player: AnimationPlayer = $actWithMe/AnimationPlayer

const speed = 30
var current_state = SIDE_LEFT

var dir = Vector2.RIGHT
var start_pos

var is_chatting = false

var player
var player_in_chat_zone = false
var acquaintancePlayer = 0

enum {
	IDLE,
	NEW_DIR,
	MOVE
}

enum EmotionSeller {
	NEUTRAL = 100,
	FINE,
	ANGRY,
	SHY,
	INTERESTED,
	SHOCKED,
	POKER_FACE,
	NONE
}

var ignor = [
	{
		"text": "....",
		"emotion": EmotionSeller.POKER_FACE
	}
]

var acquaintance = [
	{
		"text": "Oh, Hallo mein Freund!",
		"emotion": EmotionSeller.FINE
	},
	{
		"text": "Entschuldigung, ich habe da geschlaft, aber du bist da!",
		"emotion": EmotionSeller.FINE
	},
	{
		"text": "Aber wie heißt du zuerst?",
		"emotion": EmotionSeller.INTERESTED
	},
	{
		"text": "А, ти не розумів мене...",
		"emotion": EmotionSeller.SHOCKED
	},
	{
		"text": "Я питаю хто ти?",
		"emotion": EmotionSeller.NEUTRAL
	},
	{
		"text": "Забув? Ай, буває, у мене те саме зпросоння.",
		"emotion": EmotionSeller.SHOCKED
	},
	{
		"text": "Доречі я Гінк Шульц! Приємно! Сам я продаю дрібнички, якщо їочеш щось купити то навідуйся",
		"emotion": EmotionSeller.FINE
	}
]

var lines = [
	{
		"text":"О, вітаю тебе знов! Хочеш щось ще придбати?",
		"emotion": EmotionSeller.FINE
	}
]

var dialogue_node: Node = null

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	act_with_me.visible = false
	animation_player.stop()
	randomize()
func _process(delta):
	if(Global.is_dialogue_open == true):
		act_with_me.visible = false
	if get_parent().get_node("CanvasLayer/CanvasLayer/coins").current_money > 0 and acquaintancePlayer == 0:
		acquaintancePlayer += 1
	
	if player_in_chat_zone and Input.is_action_just_pressed("chatting"):
		print("chatting with npc")
		is_chatting = true
		act_with_me.visible = false
		animation_player.stop()
		if(acquaintancePlayer == 0):
			dialogue_node.start_dialogue(ignor)
		elif(acquaintancePlayer == 1):
			dialogue_node.start_dialogue(acquaintance)
			acquaintancePlayer +=1
		else:
			if(Global.can_open_shop == true):
				$shopMenu.visible = true
			dialogue_node.start_dialogue(lines)
			Global.can_attack = false
		act_with_me.visible = true

func _on_chat_detection_area_body_entered(body):
	if body.is_in_group("player"):
		player = body 
		player_in_chat_zone = true
		act_with_me.visible = true
		animation_player.play("button_animation")


func _on_chat_detection_area_body_exited(body):
	if body.is_in_group("player"):
		player_in_chat_zone = false
		act_with_me.visible = false
		animation_player.stop()
