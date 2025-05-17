extends Control

@export var description : NinePatchRect
@export var is_opened = false

func _ready() :
	$Inventory.position.y = -350

func _input(event):
	if Input.is_action_just_pressed("open_inventory"):
		if is_opened:
			$AnimationPlayer.play("hide_inventory")
			print("close")
			is_opened = false
		else:
			$AnimationPlayer.play("show_inventory")
			print("open")
			is_opened = true

func set_description(item : Item):
	description.find_child("Name").text = item.title
	description.find_child("Description").text = item.description
	description.find_child("Icon").texture = item.icon
	
