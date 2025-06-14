extends Node2D

var coin_amount = 10

func _on_area_2d_area_entered(area) :
	Global.coin_collected.emit(coin_amount)
	queue_free()
