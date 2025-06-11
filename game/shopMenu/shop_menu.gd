extends CanvasLayer

@onready var amount_label = $MarginContainer/PanelContainer/MarginContainer/HBoxContainer/VBoxContainer2/amount
@onready var cost_label = $HBoxContainer/cost
@onready var less_button = $MarginContainer/PanelContainer/MarginContainer/HBoxContainer/VBoxContainer2/HBoxContainer/button_left
@onready var less_button_arrow = $MarginContainer/PanelContainer/MarginContainer/HBoxContainer/VBoxContainer2/HBoxContainer/button_left_arrow
@onready var more_button = $MarginContainer/PanelContainer/MarginContainer/HBoxContainer/VBoxContainer2/HBoxContainer/button_right
@onready var more_button_arrow = $MarginContainer/PanelContainer/MarginContainer/HBoxContainer/VBoxContainer2/HBoxContainer/button_right_arrow
@onready var buy_button = $"MarginContainer/PanelContainer/MarginContainer/HBoxContainer/VBoxContainer2/buy button"
@onready var close = $close_shop
@onready var sus = $Sus

var dialogue_open = false

var amount = 0
var per_apple = 15
var cost = 0

enum Emotion {
	NONE
}
var lines = [
	{
		"text":"Схоже, що вам не хватає грошей, а сумління у вас  ще залишилося",
		"emotion": Emotion.NONE
	}
]

var dialogue_node: Node = null
func _ready():
	$".".visible = false

func _on_button_left_pressed() :
	if(amount == 0):
		sus.play()
		less_button.disabled = true
		less_button_arrow.texture = load("res://Спрайти/shop/arrow_left_disabled.png")
		more_button.disabled = true
		more_button_arrow.texture = load("res://Спрайти/shop/arrow_right_disabled.png")
		await get_tree().create_timer(2.0).timeout
		less_button.disabled = false
		less_button_arrow.texture = load("res://Спрайти/shop/arrow_left.png")
		more_button.disabled = false
		more_button_arrow.texture = load("res://Спрайти/shop/arrow_right.png")
		return
	amount -= 1
	cost -= per_apple
	amount_label.text = str("...",amount,"...")
	cost_label.text = str(cost," coins")


func _on_button_right_pressed() :
	if(amount == 10):
		sus.play()
		less_button.disabled = true
		less_button_arrow.texture = load("res://Спрайти/shop/arrow_left_disabled.png")
		more_button.disabled = true
		more_button_arrow.texture = load("res://Спрайти/shop/arrow_right_disabled.png")
		await get_tree().create_timer(2.0).timeout
		less_button.disabled = false
		less_button_arrow.texture = load("res://Спрайти/shop/arrow_left.png")
		more_button.disabled = false
		more_button_arrow.texture = load("res://Спрайти/shop/arrow_right.png")
		return
	amount += 1
	cost += per_apple
	amount_label.text = str("...",amount,"...")
	cost_label.text = str(cost," coins")
	


func _on_buy_button_pressed():
	buy_button.release_focus()
	if get_parent().get_parent().get_node("CanvasLayer/CanvasLayer/coins").current_money < cost:
		dialogue_node.start_dialogue(lines)
		print("Nope!")
		return
	get_parent().get_parent().get_node("CanvasLayer/CanvasLayer/coins").current_money -= cost
	get_parent().get_parent().get_node("CanvasLayer/CanvasLayer2/apples").current_apples += amount

	


func _on_close_shop_pressed():
	$".".visible = false
	Global.can_attack = true
	amount = 0
	amount_label.text = str("...",amount,"...")
	cost = 0
	cost_label.text = str(cost," coins")
