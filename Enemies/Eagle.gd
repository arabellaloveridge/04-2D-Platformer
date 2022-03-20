extends KinematicBody2D

export var start_position = Vector2(816,17)
var player = null
var nav = null

var speed = 50

onready var sound = get_node_or_null("/root/Game/ExplosionSound")

func _ready():
	position = start_position
	
func _physics_process(delta):
	if nav == null:
		nav = get_node_or_null("/root/Game/Navigation2D")
	elif player == null:
		player = get_node_or_null("/root/Game/Player_Container/Player")
	else:
		var points = nav.get_simple_path(global_position, player.global_position, true)
		if points.size() > 1:
			var target = points[1] - global_position
			var s = speed
			if target.length() > speed:
				s = target.length()
			if abs(s) < 1:
				s = 0
			var direction = target.normalized()
			if direction.x < 0:
				$AnimatedSprite.flip_h = false
			else:
				$AnimatedSprite.flip_h = true
			var _v = move_and_slide(direction*s, Vector2.ZERO)

func _on_attack_check_body_entered(body):
	if body.name == "Player":
		player.hurt()


func _on_Timer_timeout():
	queue_free()

func _on_top_checker_body_entered(body):
	$AnimatedSprite.play("Stomped")
	sound.called()
	speed = 0
	set_collision_layer_bit(2, false)
	set_collision_mask_bit(0, false)
	$top_checker.set_collision_layer_bit(2, false)
	$top_checker.set_collision_mask_bit(0, false)
	$attack_check.set_collision_layer_bit(2, false)
	$attack_check.set_collision_mask_bit(0, false)
	Global.score += 50
	$Timer.start()
	body.bounce()
