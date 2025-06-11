extends ProgressBar
@onready var health_component: HealthComponent = $"../HealthComponent"

func _ready() :
	health_component.enemyHealthChanges.connect(update)
	update()

func update():
	print("HIT!")
	$".".visible = true
	value = $".".health_component.current_health
