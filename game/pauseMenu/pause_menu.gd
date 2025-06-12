extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$".".visible = false
	

func _on_return_pressed() -> void:
	get_tree().paused = false
	$".".visible = false

func _on_back_menu_pressed() :
	get_tree().paused = false
	get_tree().change_scene_to_file("res://main_menu.tscn")

func _on_quit_game_pressed() -> void:
	get_tree().quit()
