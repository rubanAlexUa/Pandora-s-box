extends Node2D

@onready var dialog_ui = $story_telling  
@onready var start = $start 
@onready var forest = $forest
@onready var landcape = $landscape
@onready var memories = $memories
@onready var seller = $npc_seller
@onready var shop_menu = seller.get_node("shopMenu")

@export var end_screen_scene: PackedScene
@onready var player = %player


func _ready():
	player.health_component.died.connect(on_died)
	
	start.dialogue_node = dialog_ui
	forest.dialogue_node = dialog_ui
	landcape.dialogue_node = dialog_ui
	memories.dialogue_node = dialog_ui
	seller.dialogue_node = dialog_ui
	shop_menu.dialogue_node = dialog_ui

func on_died():
	var end_screen_instance = end_screen_scene.instantiate() as EndScreen
	add_child(end_screen_instance)
