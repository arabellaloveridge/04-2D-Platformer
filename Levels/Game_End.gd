extends Node2D


func _ready():
	pass


func _on_Level2_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene("res://Levels/End_Game.tscn")
