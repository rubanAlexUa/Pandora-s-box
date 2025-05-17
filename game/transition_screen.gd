extends CanvasLayer

signal transitioned

func _ready():
	$ColorRect.color.a = 0
	
func transition():
	$AnimationPlayer.play("fade_to_black")
	print("Fading to black")
	

func _on_AnimationPlayer_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_to_black":
		print("Emitsignal transitioned")
		emit_signal("transitioned")
		$AnimationPlayer.play("fade_to_normal");
	if anim_name == "fade_to_normal":
		print("Finished fading")
