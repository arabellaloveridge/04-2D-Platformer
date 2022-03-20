extends Node2D

var level = 1
var reached_end = false

func ready():
	check_level()

func check_level():
	pass

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene("res://Levels/End_Game")
		reached_end = true
