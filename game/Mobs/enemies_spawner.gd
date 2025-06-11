extends Node2D

enum mobs {
	HEAVY,
	SINNY,
	BIG_SHINE,
	LIL_SHINE
}

var mobs_scenes = {
	mobs.HEAVY: preload("res://Mobs/Heavy_Mob.tscn"),
	mobs.SINNY: preload("res://Mobs/Sinny_Mob.tscn"),
	mobs.BIG_SHINE: preload("res://Mobs/Big_Shine.tscn"),
	mobs.LIL_SHINE: preload("res://Mobs/Lil_Shine.tscn"),
}

var base_x
var base_y
var offset
func _ready():
	randomize()  

	for i in 7:
		print("Початок групи:", i)
		base_x = randi_range(1000, 4000)
		base_y = randi_range(800, 2200)

		for j in 4:
			offset = randi_range(200, 400)
			var enemy = _random_mob()
			enemy.position = Vector2(base_x + offset, base_y + offset)
			add_child(enemy)
		print("Кінець групи:", i)


func _random_mob() -> Node2D:
	var keys = mobs_scenes.keys()
	var random_key = keys[randi() % keys.size()]
	return mobs_scenes[random_key].instantiate()


func _on_timer_timeout() :
	randomize()
	base_x = randi_range(1000, 4000)
	base_y = randi_range(800, 2200)
	print("Заспавнилися моби:")
	for i in 2:
		offset = randi_range(100, 250)
		var enemy = _random_mob()
		enemy.position = Vector2(base_x + offset, base_y + offset)
		add_child(enemy)
		print("Моб №",i ," x: ",base_x+offset, ", y: ",base_y+offset)
