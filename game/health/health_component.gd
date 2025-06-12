extends Node
class_name HealthComponent
signal enemyHealthChanges

signal died

var max_health = 0
var current_health
var heal_sum = 0
var type = ""

func _ready():
	current_health = max_health
	
func take_damage(damage, defence, type):
	Global.ket_hit.stop()
	Global.hammer_hit.stop()
	print("Захист = ", defence)
	var effective_damage = damage * (1.0 - defence / 100.0)
	current_health = max(current_health - effective_damage, 0)
	print("Здоров'я залишилося: ", current_health)
	print("Приймає урон:", type)
	if type == "enemy":
		Global.hammer_hit.play()
		enemyHealthChanges.emit()
	if type == "player":
		Global.ket_hit.play()
	check_death()
	
func healing(heal_sum):
	if(heal_sum > max_health):
		current_health = max_health
		print(current_health)
		return
	current_health = heal_sum
	print(current_health)

func check_death():
	if current_health == 0 :
		died.emit()
