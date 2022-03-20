extends Node2D

onready var Explosion = load("res://Powerups/Explosion.tscn")
var Effects = null

onready var sound = get_node_or_null("/root/Game/Pickup")

func _ready():
	pass
	

func _on_Area2D_body_entered(body):
	Effects = get_node_or_null("/root/Game/Effects")
	if Effects != null:
		var explosion = Explosion.instance()
		Effects.add_child(explosion)
		explosion.global_position = global_position
		Global.score += 10
		sound.called()
	queue_free()

