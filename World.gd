extends Node2D
onready var background = $Background
onready var background_2 = $Background_2
onready var background_3 = $Background_3
onready var background_4 = $Background_4
onready var background_5 = $Background_5
onready var background_6 = $Background_6
onready var background_7 = $Background_7

onready var ground = $Ground
onready var ground_2 = $Ground_2
onready var ground_3 = $Ground_3
onready var ground_4 = $Ground_4
onready var ground_5 = $Ground_5
onready var ground_6 = $Ground_6
onready var ground_7 = $Ground_7

onready var player = $Player


#onready var Wall = get_node_and_resource("res://environment/Wall/Pipe")
#onready var Pipe   = get_node_and_resource("res://environment/Wall/Pipe") 
#onready var Pipe_2 = get_node_and_resource("res://environment/Wall/Pipe_2")
#onready var Pipe_3 = get_node_and_resource("res://environment/Wall/Pipe_3")
#onready var Pipe_4 = get_node_and_resource("res://environment/Wall/Pipe_4")
#onready var Pipe_5 = get_node_and_resource("res://environment/Wall/Pipe_5")
#onready var Pipe_6 = get_node_and_resource("res://environment/Wall/Pipe_6")
#onready var Pipe_7 = get_node_and_resource("res://environment/Wall/Pipe_7")


onready var hud = $HUD
onready var obstacle_spawner = $ObstacleSpawner
onready var menu_layer = $MenuLayer


const SAVE_FILE_PATH = "user://savedata.save"

var score = 0 setget set_score
var highscore = 0

func _ready():
	obstacle_spawner.connect("obstacle_created", self, "_on_obstacle_created")
	load_highscore()

func new_game():
	self.score = 0
	obstacle_spawner.start()
	hideBack()
	set_background(self.score)
	hideGroud()
	set_ground(self.score)
	hideBird()
	set_bird(self.score)
	
	obstacle_spawner.connect("obstacle_created", self, "_on_obstacle_created")
#	hidePipe()
#	set_pipe(self.score)
	
	
	

func player_score():
	self.score += 1
	set_background(self.score)
	set_ground(self.score)
	set_bird(self.score)
	#set_pipe(self.score)


func set_score(new_score):
	score = new_score
	hud.update_score(score)

func _on_obstacle_created(obs):
	obs.connect("score", self, "player_score")

func _on_DeathZone_body_entered(body):
	if body is Player:
		if body.has_method("die"):
			body.die()

func _on_Player_died():
	game_over()

func game_over():
	obstacle_spawner.stop()
	ground.get_node("AnimationPlayer").stop()
	get_tree().call_group("obstacles", "set_physics_process", false)
	
	if score > highscore:
		highscore = score
		save_highscore()
	
	menu_layer.init_game_over_menu(score, highscore)

func _on_MenuLayer_start_game():
	new_game()

func save_highscore():
	var save_data = File.new()
	save_data.open(SAVE_FILE_PATH, File.WRITE)
	save_data.store_var(highscore)
	save_data.close()

func load_highscore():
	var save_data = File.new()
	if save_data.file_exists(SAVE_FILE_PATH):
		save_data.open(SAVE_FILE_PATH, File.READ)
		highscore = save_data.get_var()
		save_data.close()




func set_bird(points):
	hideBird()
	if(points<=5):
		$Player/Bird.show()
	elif(points<=10):
		$Player/Bird_2.show()
	elif(points<=15):
		$Player/Bird_3.show()
	elif(points<=20):
		$Player/Bird_4.show()
	elif(points<=25):
		$Player/Bird_5.show()
	elif(points<=30):
		$Player/Bird_6.show()
	else:
		$Player/Bird_7.show()

func set_background(points):
	hideBack()
	if(points<=5):
		background.show()
	elif(points<=10):
		background_2.show()
	elif(points<=15):
		background_3.show()
	elif(points<=20):
		background_4.show()
	elif(points<=25):
		background_5.show()
	elif(points<=30):
		background_6.show()
	else:
		background_7.show()



func set_ground(points):
	hideGroud()
	if(points<=5):
		ground.show()
	elif(points<=10):
		ground_2.show()
	elif(points<=15):
		ground_3.show()
	elif(points<=20):
		ground_4.show()
	elif(points<=25):
		ground_5.show()
	elif(points<=30):
		ground_6.show()
	else:
		ground_7.show()

#func set_pipe(points):
#	hidePipe()
#	
#	if(points<=5):
#		Pipe.show()
#	elif(points<=10):
#		Pipe_2.show()
#	elif(points<=15):
#		Pipe_3.show()
#	elif(points<=20):
#		Pipe_4.show()
#	elif(points<=25):
#		Pipe_5.show()
#	elif(points<=30):
#		Pipe_6.show()
#	else:
#		Pipe_7.show()

func hideBack():
	background.hide()
	background_2.hide()
	background_3.hide()
	background_4.hide()
	background_5.hide()
	background_6.hide()
	background_7.hide()

func hideGroud():
	ground.hide()
	ground_2.hide()
	ground_3.hide()
	ground_4.hide()
	ground_5.hide()
	ground_6.hide()
	ground_7.hide()
	
	
func hideBird():
	$Player/Bird.hide()
	$Player/Bird_2.hide()
	$Player/Bird_3.hide()
	$Player/Bird_4.hide()
	$Player/Bird_5.hide()
	$Player/Bird_6.hide()
	$Player/Bird_7.hide()

#func hidePipe():
#
#	Pipe.hide()
#	Pipe_2.hide()
#	Pipe_3.hide()
#	Pipe_4.hide()
#	Pipe_5.hide()
#	Pipe_6.hide()
#	Pipe_7.hide()

