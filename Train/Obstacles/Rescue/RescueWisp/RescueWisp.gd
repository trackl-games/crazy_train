extends "res://Train/Obstacles/Obstacle.gd"

var restarting = false
var restart_timer = null

# Called when the node enters the scene tree for the first time.
func o_ready():
	height = 0

func o_process(delta):
	if GameVariables.player.x == x and GameVariables.player.y == y and not restarting:
		restarting = true
		#make_empty()
		restart_timer = Timer.new()
		restart_timer.connect("timeout",self,"goto_end") 
		add_child(restart_timer) #to process
		restart_timer.start(GameVariables.RESTART_TIME) #to start

func goto_end():
	for key in GameVariables.set_bools:
		GameVariables.set_bools[key] = false
	TurnHandler.turn_count = 0
	TurnHandler.phase = "player"
	TurnHandler.action_completed = false
	GameVariables.car.queue_free()
	get_tree().change_scene("res://Train/Dev/Credits/Credits.tscn")
