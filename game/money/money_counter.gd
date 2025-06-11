extends Label


var current_money = 0


func _ready():
	Global.coin_collected.connect(on_coin_amount_collected)
	
func _process(delta: float) -> void:
	text = str(current_money)

func on_coin_amount_collected(coin):
	current_money += coin
	text = str(current_money)
	print(current_money)
	
