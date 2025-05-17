extends Node2D

const CHAR_READ_RATE = 0.1

@onready var textbox_container = $CanvasLayer
@onready var start_symbol = $CanvasLayer/Panel/MarginContainer/Panel/HBoxContainer/Start
@onready var end_symbol = $CanvasLayer/Panel/MarginContainer/Panel/HBoxContainer/End
@onready var main_text = $CanvasLayer/Panel/MarginContainer/Panel/HBoxContainer/Main_text
@onready var typing_sound = $CanvasLayer/Panel/MarginContainer/Panel/HBoxContainer/text_writing_sound
@onready var emotion_sprite = $CanvasLayer/Panel/MarginContainer/Panel/HBoxContainer/Emotion
@onready var tween = get_tree().create_tween()

enum State {
	READY,
	READING,
	FINISHED
}

enum Emotion {
	NEUTRAL,
	FINE,
	ANGRY,
	SHY,
	INTERESTED,
	GNARPY,
	SHOCKED,
	POKER_FACE,
	DISMAY
}

var emotion_textures = {
	Emotion.NEUTRAL: preload("res://Спрайти/Діалогове вікно/emotions/neutral.png"),
	Emotion.FINE: preload("res://Спрайти/Діалогове вікно/emotions/fine.png"),
	Emotion.ANGRY: preload("res://Спрайти/Діалогове вікно/emotions/angry.png"),
	Emotion.SHY: preload("res://Спрайти/Діалогове вікно/emotions/shy.png"),
	Emotion.INTERESTED: preload("res://Спрайти/Діалогове вікно/emotions/interested.png"),
	Emotion.GNARPY: preload("res://Спрайти/Діалогове вікно/emotions/gnarpi.png"),
	Emotion.SHOCKED: preload("res://Спрайти/Діалогове вікно/emotions/shocked.png"),
	Emotion.POKER_FACE: preload("res://Спрайти/Діалогове вікно/emotions/poker face.png"),
	Emotion.DISMAY: preload("res://Спрайти/Діалогове вікно/emotions/dismay.png")
}

var current_state = State.READY
var text_queue = []

func _ready():
	print("Starting state: State.READY")
	hide_textbox()
	typing_sound.stop()

func _process(delta):
	match current_state:
		State.READY:
			if not text_queue.is_empty():
				Global.can_move = false
				display_text()
			else:
				text_queue=[]
				Global.can_move = true
		State.READING:
			if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("mouse_left_click"):
				typing_sound.stop()
				tween.kill()
				main_text.visible_characters = -1
				end_symbol.text = "<-"
				change_state(State.FINISHED)
		State.FINISHED:
			if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("mouse_left_click"):
				change_state(State.READY)
				hide_textbox()

func hide_textbox():
	start_symbol.text = ""
	end_symbol.text = ""
	main_text.text = ""
	textbox_container.hide()

func show_textbox():
	start_symbol.text = "*"
	textbox_container.show()

func display_text():
	if text_queue.is_empty():
		change_state(State.READY)
		hide_textbox()
		return

	typing_sound.play()

	var next_entry = text_queue.pop_front()
	var next_text = next_entry.get("text", "")
	var next_emotion = next_entry.get("emotion", Emotion.NEUTRAL)

	main_text.text = next_text
	main_text.visible_characters = 0

	update_emotion(next_emotion)

	change_state(State.READING)
	show_textbox()

	tween = get_tree().create_tween()
	tween.tween_property(main_text, "visible_characters", len(next_text), len(next_text) * CHAR_READ_RATE).from(0)
	tween.finished.connect(on_tween_finished)

func on_tween_finished():
	if typing_sound.playing:
		typing_sound.stop()
	end_symbol.text = "<-"
	change_state(State.FINISHED)

func change_state(next_state):
	current_state = next_state
	print("Changing state to:", next_state)

func update_emotion(next_emotion):
	if next_emotion in emotion_textures:
		emotion_sprite.texture = emotion_textures[next_emotion]
	
func start_dialogue(lines) :
	print(lines)
	if current_state == State.READY and not lines.is_empty():
		text_queue = lines.duplicate()
		change_state(State.READY)
		typing_sound.play()
