extends Node2D

onready var Possum = load("res://Enemies/Possum.tscn")
onready var Eagle = load("res://Enemies/Eagle.tscn")


func spawn(e_type, attributes, p):
	var enemy = null
	if e_type == "Possum":
		enemy.Possum.instance()
	if e_type == "Eagle":
		enemy.Eagle.instance()
	for a in attributes:
		enemy[a] = attributes[a]
	enemy.position = p
	add_child(enemy)
