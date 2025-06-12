extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$".".visible = false

func _on_yes_pressed() -> void:
	var save_path = "user://save_data.json"
	var game_data = {
		"acquaintancePlayer": 0,
		"played_start_dialog": false,
		"current_apples": 0,
		"current_money": 0,
		"player_position_x": 0,
		"player_position_y": 0
	}
	var jsonstring = JSON.stringify(game_data)
	
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_line(jsonstring)
	get_tree().change_scene_to_file("res://before_nowDays.tscn")

func _on_no_pressed() -> void:
	$".".visible = false
