extends Node2D

signal score

onready var point = $Point
onready var Pipe    = $Wall/Pipe
onready var Pipe_2  = $Wall/Pipe_2
onready var Pipe_3  = $Wall/Pipe_3
onready var Pipe_4  = $Wall/Pipe_4
onready var Pipe_5  = $Wall/Pipe_5
onready var Pipe_6  = $Wall/Pipe_6
onready var Pipe_7  = $Wall/Pipe_7

const SPEED = 215

func _physics_process(delta):
	position.x += -SPEED * delta
	if global_position.x <= -200:
		queue_free()

func _on_Wall_body_entered(body):
	if body is Player:
		if body.has_method("die"):
			body.die()

func _on_ScoreArea_body_exited(body):
	if body is Player:
		point.play()
		emit_signal("score")


func set_pipe(points):
	hidePipe()
	
	if(points<=5):
		Pipe.show()
	elif(points<=10):
		Pipe_2.show()
	elif(points<=15):
		Pipe_3.show()
	elif(points<=20):
		Pipe_4.show()
	elif(points<=25):
		Pipe_5.show()
	elif(points<=30):
		Pipe_6.show()
	else:
		Pipe_7.show()
		
func hidePipe():

	Pipe.hide()
	Pipe_2.hide()
	Pipe_3.hide()
	Pipe_4.hide()
	Pipe_5.hide()
	Pipe_6.hide()
	Pipe_7.hide()
