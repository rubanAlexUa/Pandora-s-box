extends CanvasLayer
class_name EndScreen

func _ready() :
	get_tree().paused = true

func _on_restart_button_pressed():
	var sound = Global.ket_hit
	sound.stop()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://map_game.tscn")
	


func _on_quit_button_pressed():
	get_tree().quit()
