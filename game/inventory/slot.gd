extends PanelContainer

@export var item : Item:
	set(value):
		item = value
		$Icon .texture = item.icon
func _on_mouse_entered():
	if item != null:
		var current = self
		while current != null:
			if current.has_method("set_description"):
				current.set_description(item)
				break
			current = current.get_parent()
