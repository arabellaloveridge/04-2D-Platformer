extends Node2D

var Cherry = load("res://Powerups/Cherry.tscn")

func _spawn(attr, p):
	var cherry = Cherry.instance()
	cherry.position = p
