extends Node


var turn_count = 1

var phases = ["player", "enemy", "boss", "environment"]
var phase = phases[0]
var phase_index = 0
var action_completed = false

var restart_timer = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func advance():
	phase_index += 1
	action_completed = false
	if phase_index >= len(phases):
		phase_index = 0
		turn_count += 1
		Global.print("Turn %d" % [turn_count])
	phase = phases[phase_index]
	Global.print("%s phase" % [phase])
	if len(get_tree().get_nodes_in_group(phase)) == 0:
		advance()
	elif phase != "player":
		for obj in get_tree().get_nodes_in_group(phase):
			obj.action()
			yield(obj, "advance_sig")
		advance()

func is_player_phase():
	if action_completed:
		return false
	return phase == "player"

func is_enemy_phase():
	if action_completed:
		return false
	return phase == "enemy"

func is_boss_phase():
	if action_completed:
		return false
	return phase == "boss"

func is_environment_phase():
	if action_completed:
		return false
	return phase == "environment"

func completed():
	action_completed = true

func restart():
	phase = "restart"
	
	# TODO
	restart_timer = Timer.new()
	restart_timer.connect("timeout",self,"restart_room") 
	add_child(restart_timer) #to process
	restart_timer.start(GameVariables.RESTART_TIME) #to start

func restart_room():
	for key in GameVariables.set_bools:
		GameVariables.set_bools[key] = false
	turn_count = 0
	phase = "player"
	action_completed = false
	restart_timer.queue_free()
	GameVariables.stored_car = GameVariables.car.current_car
	GameVariables.car.queue_free()
	get_tree().change_scene("res://Train/TrainCar.tscn")

func is_restart_phase():
	return phase == "restart"






