extends "res://Train/GameObject.gd"


var xdir = 0
var ydir = 0

var x = 0
var y = 0
var car = null

var height = 1

var gun = null  # gun that can be picked up from thrown gun

onready var tween = $Tween

func init(x, y, xdir, ydir, car):
	self.x = x
	self.y = y
	self.xdir = xdir
	self.ydir = ydir
	self.car = car
	o_init(x, y, xdir, ydir, car)

func o_init(x, y, xdir, ydir, car):
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	o_ready()

func o_ready():
	pass

func _process(delta):
	o_process(delta)

func o_process(delta):
	pass

func die():
	advance()
	GameVariables.remove_environmental(self)

func action():
	pass

func give_gun():
	if gun != null:
		remove_child(gun)
		GameVariables.player.set_gun(gun)
	print("bullet removes gun")

func add_gun(gun):
	self.gun = gun
	add_child(gun)
	print("bullet carries gun")
