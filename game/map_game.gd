extends Node2D

@onready var dialog_ui = $story_telling  
@onready var start = $start 
@onready var forest = $forest
@onready var landcape = $landscape
@onready var memories = $memories
@onready var seller = $npc_seller
@onready var shop_menu = seller.get_node("shopMenu")
@onready var totem = $totem
@onready var totem2 = $totem2
@onready var totem3 = $totem3
@onready var totem4 = $totem4
@onready var pause_menu = $pause_menu

@export var end_screen_scene: PackedScene
@onready var player = %player


func _ready():
	var save_path = "user://save_data.json"
	
	var file = FileAccess.open(save_path, FileAccess.READ)
	var data = file.get_as_text()
	file.close()
	var str_data = JSON.parse_string(data)
	
	if str_data and str_data.has("player_position_x") and str_data.has("player_position_y") and str_data.has("current_apples") and str_data.has("current_money") and str_data.has("played_start_dialog"):
		var apple_label = get_node("CanvasLayer/CanvasLayer2/apples")
		var start_dialogue = get_node("start")
		var coins_label = get_node("CanvasLayer/CanvasLayer/coins")
		var player = get_node("player")
		var seller = get_node("npc_seller")
	
		seller.acquaintancePlayer = str_data["acquaintancePlayer"]
		start_dialogue.played = str_data["played_start_dialog"]
		apple_label.current_apples = str_data["current_apples"]
		coins_label.current_money = str_data["current_money"]
		player.global_position = Vector2(str_data["player_position_x"], str_data["player_position_y"])
	player.health_component.died.connect(on_died)
	
	start.dialogue_node = dialog_ui
	forest.dialogue_node = dialog_ui
	landcape.dialogue_node = dialog_ui
	memories.dialogue_node = dialog_ui
	seller.dialogue_node = dialog_ui
	shop_menu.dialogue_node = dialog_ui
	totem.dialogue_node = dialog_ui
	totem2.dialogue_node = dialog_ui
	totem3.dialogue_node = dialog_ui
	totem4.dialogue_node = dialog_ui

func _process(delta):
	if (Input.is_action_just_pressed("pause")):
		pause_menu.visible = not pause_menu.visible 
		Global.paused = pause_menu.visible
		if Global.paused:
			get_tree().paused = true
			return
		get_tree().paused = false

func on_died():
	var end_screen_instance = end_screen_scene.instantiate() as EndScreen
	add_child(end_screen_instance)
