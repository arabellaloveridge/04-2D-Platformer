extends AnimatedSprite

onready var sound = get_node_or_null("/root/Game/ExplosionSound")

func ready():
	play("Death")
	sound.called()

func _on_Death_animation_finished():
	queue_free()
