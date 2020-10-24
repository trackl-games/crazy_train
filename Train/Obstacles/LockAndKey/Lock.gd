extends "res://Train/Obstacles/Obstacle.gd"




# Called when the node enters the scene tree for the first time.
func o_ready():
	height = 3


func o_process(delta):
	if GameVariables.player.has_item("key"):
		open = true
		if GameVariables.player.x == x and GameVariables.player.y == y:
			make_empty()
			queue_free()
	else:
		open = false
