extends Area2D

func _on_fall_zone_body_entered(body):
	if body.name == "Player":
		body.hurt()
