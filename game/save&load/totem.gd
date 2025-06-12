extends CharacterBody2D

@onready var act_with_me = $actWithMe

var save_path = "user://save_data.json"

var is_in_area = false

enum Emotion {
	NEUTRAL,
	FINE,
	ANGRY,
	SHY,
	INTERESTED,
	GNARPY,
	SHOCKED,
	POKER_FACE,
	DISMAY,
	NONE
}
var lines = [
	{
		"text": "Статуя покрита мохом та великим шаром пилу; на ній видніються написи невідомою мовою",
		"emotion": Emotion.NONE
	},
	{
		"text": "Вас хвилею накривають давно забуті спогади, та натхнення",
		"emotion": Emotion.NONE
	},
	{
		"text": "Точка збереження",
		"emotion": Emotion.NONE
	},
]

var dialogue_node: Node = null

func _ready():
	act_with_me.visible = false

func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("chatting") and is_in_area):
		act_with_me.visible = false
		dialogue_node.start_dialogue(lines)
		save_present_data()

func save_present_data():
	var game_data = {
		"acquaintancePlayer": get_parent().get_node("npc_seller").acquaintancePlayer,
		"played_start_dialog": get_parent().get_node("start").played,
		"current_apples": get_parent().get_node("CanvasLayer/CanvasLayer2/apples").current_apples,
		"current_money": get_parent().get_node("CanvasLayer/CanvasLayer/coins").current_money,
		"player_position_x": get_parent().get_node("player").global_position.x,
		"player_position_y": get_parent().get_node("player").global_position.y
	}
	var jsonstring = JSON.stringify(game_data)
	
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_line(jsonstring)

func _on_detection_area_body_entered(body) :
	if body.is_in_group("player"):
		$actWithMe/AnimationPlayer.play("button_animation")
		is_in_area = true
		act_with_me.visible = true


func _on_detection_area_body_exited(body):
	if body.is_in_group("player"):
		$actWithMe/AnimationPlayer.stop()
		is_in_area = false
		act_with_me.visible = false
