extends Node2D
var CHAR_READ_RATE = 0.1
var CHAR_READ_RATE_SECOND = 1

@onready var shrimp = $CanvasLayer/MarginContainer/VBoxContainer/shrimp_texture
@onready var textbox_container =$CanvasLayer
@onready var item_name = $CanvasLayer/MarginContainer/VBoxContainer/item_name
@onready var main_text = $CanvasLayer/MarginContainer/VBoxContainer/main_text
@onready var vertical_container = $CanvasLayer/MarginContainer/VBoxContainer
@onready var typing_sound = $CanvasLayer/MarginContainer/VBoxContainer/main_text/typing_text
@onready var happy_sound = $CanvasLayer/MarginContainer/VBoxContainer/main_text/happy
@onready var yipe_sound = $CanvasLayer/MarginContainer/VBoxContainer/main_text/Yippee
@onready var another_typing_sound = $CanvasLayer/MarginContainer/VBoxContainer/main_text/typing_text_item
@onready var tween = get_tree().create_tween()
@onready var new_tween = get_tree().create_tween()

const map_scene = preload("res://map_game.tscn")

enum State{
	READY,
	READING,
	FINISHED
}

var i = 0
var current_state = State.READY
var text_queue = [
	"Тобі сама доля підготувала велику місію",
	"Щасти тобі герою",
	"...",
	"*Кхм. Це все звісно добре, але перед цим, ось, тримай:",
	"*Вам видалася Креветка(звичайна)",
	"Все тобі час йти, вершити мабутнє "
]


func _ready():
	shrimp.playing = false
	shrimp.visible = false
	print("Starting state: State.READY")
	hide_textbox()


func _process(delta):
	match current_state:
		State.READY:
			if text_queue.size() > 0:
				display_text()
		State.READING:
			if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("mouse_left_click"):
				typing_sound.stop()
				tween.kill()
				main_text.visible_characters = -1
				change_state(State.FINISHED)
		State.FINISHED:
			if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("mouse_left_click"):
				if i == 6:
					get_tree().change_scene_to_file("res://map_game.tscn")
				else: 
					change_state(State.READY)
					hide_textbox()
		



func hide_textbox():
	main_text.text = ""
	item_name.text = ""
	textbox_container.hide()

func show_textbox():
	textbox_container.show()

func display_text():
	var next_text = text_queue[i]
	if next_text == text_queue[2]:
		CHAR_READ_RATE = 0.7
		typing_sound.pitch_scale = 0.16
	else:
		CHAR_READ_RATE = 0.1
		typing_sound.pitch_scale = 1
	
	if next_text == text_queue[4]:
		shrimp.playing = true
		shrimp.visible = true
		happy_sound.playing = true
		yipe_sound.playing = true 
		item_name.text = "DAS IST EINE KREVETTE"
	main_text.text = next_text
	typing_sound.play()
	change_state(State.READING)
	show_textbox()
	#tween.tween_property(main_text, "visible_characters", 50, len(next_text) * CHAR_READ_RATE).from(0).finished
	#tween.connect("finished", on_tween_finished)
	tween = get_tree().create_tween()
	tween.tween_property(main_text, "visible_characters", len(next_text), len(next_text) * CHAR_READ_RATE).from(0)
	tween.finished.connect(on_tween_finished)
	i += 1

func on_tween_finished():
	if(typing_sound.playing):
		typing_sound.stop()
	if(another_typing_sound.playing):
		another_typing_sound.stop()
	change_state(State.FINISHED)
	
func change_state(next_state):
	current_state = next_state
	match current_state:
		State.READY:
			print("Changing state to: State.READY")
		State.READING:
			print("Changing state to: State.READING")
		State.FINISHED:
			print("Changing state to: State.FINISHED")
		
	


func _on_TransitionScreen_transitioned():
	$CanvasLayer.get_child(0).queue_free()
	$CanvasLayer.add_child(map_scene.instantiate())
	print("Swapped in Scene two")
