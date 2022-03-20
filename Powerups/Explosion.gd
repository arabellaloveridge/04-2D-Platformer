extends AnimatedSprite

func ready():
	play("Explosion")
	
func _on_Explosion_animation_finished():
	queue_free()
