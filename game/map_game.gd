extends Node2D

@onready var dialog_ui = $story_telling  
@onready var start = $start 
@onready var forest = $forest
@onready var landcape = $landscape
func _ready():
	start.dialogue_node = dialog_ui
	forest.dialogue_node = dialog_ui
	landcape.dialogue_node = dialog_ui
