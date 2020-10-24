extends "res://Train/Obstacles/Obstacle.gd"

var color = ""
var move_speed = 1
var pos = 1
var starting_pos = Vector3()
var down_pos = Vector3()
var start_height = 5


onready var gate = $gate
onready var debug_gate = $gate/debug_gate
onready var current_tween = $gate/Tween
onready var model = $model

func o_ready():
	open = false
	starting_pos = get_global_transform().origin
	down_pos = starting_pos - Vector3(0,2,0)

func o_process(delta):
	if not GameVariables.DEBUG and gate:
		debug_gate.visible = false
	if pos and GameVariables.set_bools[color]:
		move_down()
		pos = 0
	if not pos and not GameVariables.set_bools[color]:
		move_up()
		pos = 1

func move_up():
	current_tween.interpolate_property(
		gate, "translation",
		down_pos, starting_pos, 1,
		Tween.TRANS_CUBIC, Tween.EASE_IN_OUT
	)
	current_tween.interpolate_property(
		model, "translation",
		down_pos, starting_pos, 1,
		Tween.TRANS_CUBIC, Tween.EASE_IN_OUT
	)
	current_tween.start()
	open = false
	height = start_height

func move_down():
	current_tween.interpolate_property(
		gate, "translation",
		starting_pos, down_pos, 1,
		Tween.TRANS_CUBIC, Tween.EASE_IN_OUT
	)
	current_tween.interpolate_property(
		model, "translation",
		starting_pos, down_pos, 1,
		Tween.TRANS_CUBIC, Tween.EASE_IN_OUT
	)
	current_tween.start()
	open = true
	height = 0
