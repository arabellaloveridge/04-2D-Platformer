extends Node2D

export var spawn_location = Vector2(24, 35)
onready var Player = get_node_or_null("/root/Game/Player_Container/Player")
		
func spawn(pos):
	if not has_node("Player"):
		var player = Player.instance()
		player.global_position = pos
		add_child(player)
		player.get_node("Camera2D").current = true
		
func _physics_process(delta):
	spawn(spawn_location)
