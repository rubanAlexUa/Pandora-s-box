extends Node2D

@onready var start: Button = $ParallaxBackground/ParallaxLayer/Sprite2D/Start
@onready var continue_btn: Button = $ParallaxBackground/ParallaxLayer/Sprite2D/Continue_btn


func _ready():
	var save_path = "user://save_data.json"
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		var data = file.get_as_text()
		file.close()
		var str_data = JSON.parse_string(data)
		print(str_data)
		if str_data and str_data.has("player_position_x") and str_data.has("player_position_y") and str_data.has("current_apples") and str_data.has("current_money"):
			continue_btn.disabled = false
			return
		continue_btn.disabled = true

func _on_start_pressed():
	var save_path = "user://save_data.json"
	var file = FileAccess.open(save_path, FileAccess.READ)
	var data = file.get_as_text()
	file.close()
	var str_data = JSON.parse_string(data)
	print(str_data)
	if str_data and str_data.has("player_position_x") and str_data.has("player_position_y") and str_data.has("current_apples") and str_data.has("current_money"):
		$warning.visible = true
		return
	get_tree().change_scene_to_file("res://before_nowDays.tscn")


func _on_continue_btn_pressed():
	get_tree().change_scene_to_file("res://map_game.tscn")
