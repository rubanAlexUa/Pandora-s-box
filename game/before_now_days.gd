extends Node2D

const CHAR_READ_RATE = 0.1

@onready var textbox_container = $CanvasLayer
@onready var start_symbol = $CanvasLayer/MarginContainer/Panel/MarginContainer/Panel/HBoxContainer/Start
@onready var end_symbol = $CanvasLayer/MarginContainer/Panel/MarginContainer/Panel/HBoxContainer/End
@onready var main_text = $CanvasLayer/MarginContainer/Panel/MarginContainer/Panel/HBoxContainer/Main_text
@onready var typing_sound = $CanvasLayer/MarginContainer/Panel/MarginContainer/Panel/HBoxContainer/text_writing_sound
@onready var tween = get_tree().create_tween()
@onready var img = $MarginContainer/img_future


enum State{
	READY,
	READING,
	FINISHED
}

var current_state = State.READY
var text_queue = [
	"Колись, ще як не було розподілено даний порядок, сили добра та зла воювали між собою за владу.",
	"Відбувалося чи мало звірств у ті часи. Однак пройшло багато століть перед тим, як у сторони добра появилася свідомість, здібність мислити.",
	"В ті ж часи появилися клани, які не вважали ворогували, але й не товаришували. Серед них були й маги, мисливці, летючі воїни та навіть невелике королівство із великими амбіціями.",
	"Та й згодом, дані клани скооперувалися та утворили легіон `Avatlöp`, який за мету брав знешкодження хаосу на нівець.",
	"Але постало питання, що робити із хаосом що не зникає? Був єдиний вихід - це приборкання. Потрібно всього MTkwMzIwMjU=.",
	"Так появилася скринька Пандори. Карманний вимір, із різними таємницями. Бажаючих дізнатися про них багато, однак після, вони не сильно можуть казати що-небудь.",
	"Однак через невідомий випадок вона впала та вивільнила те, що бажало сіяти зло весь цей час...",
]

func _ready():
	print("Starting state: State.READY")
	hide_textbox()
	

func _process(delta):
	match current_state:
		State.READY:
			if text_queue.size() > 0:
				display_text()
			else:
				get_tree().change_scene_to_file("res://get_item.tscn")
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
	
	var random_color = Color(randf(), randf(), randf())
	img.modulate = Color(random_color)
	var next_text = text_queue.pop_front()
	main_text.text = next_text
	typing_sound.play()
	change_state(State.READING)
	show_textbox()
	#tween.tween_property(main_text, "visible_characters", 50, len(next_text) * CHAR_READ_RATE).from(0).finished
	#tween.connect("finished", on_tween_finished)
	tween = get_tree().create_tween()
	tween.tween_property(main_text, "visible_characters", len(next_text), len(next_text) * CHAR_READ_RATE).from(0)
	tween.finished.connect(on_tween_finished)
func on_tween_finished():
	if(typing_sound.playing):
		typing_sound.stop()
	end_symbol.text = "<-"
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
		
	
