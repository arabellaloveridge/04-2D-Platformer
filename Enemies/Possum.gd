extends KinematicBody2D

onready var enemy = $AnimatedSprite
onready var top_checker = $top_checker
onready var side_checker = $side_checker

onready var sound = get_node_or_null("/root/Game/ExplosionSound")

var speed = 75
var velocity = Vector2()
export var direction = -1

func _ready():
	if direction == 1:
		enemy.flip_h = true
	
func _physics_process(delta):
	if is_on_wall():
		direction *= -1
		enemy.flip_h = not enemy.flip_h
	
	velocity.y += 20
	velocity.x = speed * direction
	
	velocity = move_and_slide(velocity, Vector2.UP)

func _on_top_checker_body_entered(body):
	enemy.play("Stomped")
	sound.called()
	speed = 0
	set_collision_layer_bit(2, false)
	set_collision_mask_bit(0, false)
	top_checker.set_collision_layer_bit(2, false)
	top_checker.set_collision_mask_bit(0, false)
	side_checker.set_collision_layer_bit(2, false)
	side_checker.set_collision_mask_bit(0, false)
	Global.score += 30
	$Timer.start()
	body.bounce()

func _on_side_checker_body_entered(body):
	if body.name == "Player":
		body.hurt()


func _on_Timer_timeout():
	queue_free()
