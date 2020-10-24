extends "res://Train/Obstacles/Obstacle.gd"


var start = Vector3()
var started = false
var gun = load("res://Train/Weapons/Guns/AbstractGun.tscn")

onready var origin = $model
onready var gunmodel = $model/gun

var magnitude = .15
var rate = 2
var offset = 0
onready var parent = get_parent()


# Called when the node enters the scene tree for the first time.
func o_ready():
	height = 0

func o_process(delta):
	offset = fmod(offset + rate*delta, 2 * PI)
	var ot = self.get_transform().origin
	Global.set_local_location(gunmodel, magnitude*sin(offset), 0, magnitude*cos(offset))
	if GameVariables.player.x == x and GameVariables.player.y == y:
		GameVariables.player.set_gun(gun.instance())
		make_empty()
