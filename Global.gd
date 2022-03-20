extends Node

const SAVE_PATH = "user://savegame.sav"
const SECRET = "C220 Is the Best!"
var save_file = ConfigFile.new()

onready var HUD = get_node_or_null("/root/Game/CanvasLayer/Hud")
onready var Game = load("res://Levels/Level1.tscn")

export (float) var gravity = 50
export (float) var terminal_velocity = 300

var score = 0
var lives = 3

var save_data = {
	"general": {
		"score": 0,
		"lives": 3
	},
	"player": {
		"position_x": 0,
		"position_y":0
	},
	"enemies":[]
}

func _ready():
	update_score(0)
	update_lives(3)

func _physics_process(delta):
	if lives <= 0:
		get_tree().change_scene("res://Levels/Game_Over.tscn")
		
func update_score(s):
	save_data["general"]["score"] += s
	HUD.find_node("Score").text = "Score: " + str(save_data["general"]["score"])
	
func update_lives(l):
	save_data["general"]["lives"] += l
	HUD.find_node("Lives").text = "Lives: " + str(save_data["general"]["lives"])
		
func restart_level():
	HUD = get_node_or_null("/root/Game/CanvasLayer/Hud")
	update_score(0)
	update_lives(0)
	if save_data["player"]["position_x"] != 0:
		var player_container = get_node_or_null("/root/Game/Player_Container")
		if player_container != null:
			player_container.spawn(Vector2(save_data["player"]["position_x"]), save_data["player"]["position_y"])
	save_data["enemies"] = []
	var enemies = get_tree().get_nodes_in_group("enemy")
	for enemy in enemies:
		var found = false
		for s_enemy in save_data["enemies"]:
			if s_enemy["name"] == enemy.name:
				found = true
				enemy.position.x = s_enemy["position_x"]
				enemy.position.y = s_enemy["position_y"]
			if not found:
				enemy.queue_free()
	get_tree().paused = false

#--------------------------------------------------------------

func save_game():
	var player = get_node_or_null("/root/Game/Player_Container/Player")
	if player != null:
		save_data["player"]["position_x"] = player.global_position.x
		save_data["player"]["position_y"] = player.global_position.y
	var enemies = get_tree().get_nodes_in_group("enemy")
	for enemy in enemies:
		var temp = {}
		temp["position_x"] = enemy.global_position.x
		temp["position_y"] = enemy.global_position.y
		temp["name"] = enemy.name
		save_data["enemies"].append(temp)
	var save_game = File.new()
	save_game.open_encrypted_with_pass(SAVE_PATH, File.WRITE, SECRET)
	save_game.store_string(to_json(save_data))
	save_game.close()

func load_game():
	var save_game = File.new()
	if not save_game.file_exists(SAVE_PATH):
		return
	save_game.open_encrypted_with_pass(SAVE_PATH, File.WRITE, SECRET)
	var contents = save_game.get_as_text()
	save_data = parse_json(contents)
	var _scene = get_tree().change_scene_to(Game)
	call_deferred("restart_level")
