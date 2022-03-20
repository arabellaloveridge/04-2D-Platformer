extends KinematicBody2D

const GRAVITY = 300.0
const WALK_SPEED = 200
const JUMP_SPEED = 250
const JUMP_HEIGHT = 10

onready var animatedSprite = $Sprite

onready var Explosion = load("res://Player/Player_Death.tscn")
var Effects = null

var velocity = Vector2()

func _physics_process(delta):
	velocity.y += delta * GRAVITY

	if Input.is_action_pressed("left"):
		velocity.x = -WALK_SPEED
		$Sprite.flip_h = true
		if is_on_floor():
			animatedSprite.play("Run")
	elif Input.is_action_pressed("right"):
		velocity.x =  WALK_SPEED
		if is_on_floor():
			animatedSprite.play("Run")
		$Sprite.flip_h = false
	else:
		velocity.x = 0
		if is_on_floor():
			animatedSprite.play("Idle")
		
	velocity.y += GRAVITY * delta
	
	# Move based on the velocity and snap to the ground.
	velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)
	
	# Check for jumping. is_on_floor() must be called after movement code.
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			jump()
	#if not is_on_floor():
		#animatedSprite.play("Jump")
			
func jump():
	velocity.y = -JUMP_SPEED
	
	if velocity.y < 0:
		animatedSprite.play("Jump")
	move_and_slide_with_snap(velocity, Vector2(0, -1))

func bounce():
	velocity.y = -JUMP_SPEED * 0.7
	
func hurt():
	
	Effects = get_node_or_null("/root/Game/Effects")
	if Effects != null:
		var explosion = Explosion.instance()
		Effects.add_child(explosion)
		explosion.global_position = global_position
		Global.lives -= 1
	animatedSprite.hide()
	
	Input.action_release("left")
	Input.action_release("right")
	$Reset_Timer.start()
	
func _on_Reset_Timer_timeout():
	get_tree().change_scene("res://Levels/Level1.tscn")
