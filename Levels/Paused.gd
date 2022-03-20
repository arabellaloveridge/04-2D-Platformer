extends Control



func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS

func _unhandled_input(event):
	if Input.is_action_pressed("pause"):
		var menu = get_node_or_null("/root/Game/CanvasLayer/Paused")
		if menu != null:
			var p = get_tree().paused
			if p:
				menu.hide()
				get_tree().paused = false
			else:
				menu.show()
				get_tree().paused = true


func _on_Play_pressed():
	get_tree().change_scene("res://Levels/Level1.tscn")
	var menu = get_node_or_null("/root/Game/CanvasLayer/Paused")
	get_tree().paused = false
	menu.hide()
	Global.score = 0
	Global.lives = 3


func _on_Save_pressed():
	Global.save_game()


func _on_Load_pressed():
	Global.load_game()


func _on_Quit_pressed():
	get_tree().quit()
