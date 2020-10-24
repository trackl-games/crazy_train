extends "res://Train/GameObject.gd"


var bullets = -1  # -1 is infinite
var starting_turn = 0
var exploded = false
var turns = -1
var last_turn = 0
var bullet_loop = load("res://Train/Visuals/WeaponLoops/FastBulletLoop.tscn")
var gun_loop = load("res://Train/Visuals/WeaponLoops/FastGunLoop.tscn")
var bullet = load("res://Train/Weapons/Bullets/FastBullet.tscn")
var gun = load("res://Train/Weapons/Bullets/FastBulletGun.tscn")
var gun_name = "AbstractGun"


# Called when the node enters the scene tree for the first time.
func _ready():
	starting_turn = TurnHandler.turn_count
	last_turn = starting_turn
	o_ready()

func o_ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not exploded and (TurnHandler.turn_count - starting_turn > turns and turns > 0):
		explode()
		exploded = true
	if not exploded and (last_turn != TurnHandler.turn_count) and turns > 0:
		Global.print("%d turns until explosion" % [turns - (TurnHandler.turn_count - starting_turn)])
		last_turn = TurnHandler.turn_count

func shoot(x, y, height, xdir, ydir):
	if empty():
		return false
	if not bullet:
		return false
	bullets -= 1
	var b = bullet.instance()
	b.init(x,y,xdir,ydir,GameVariables.car)
	GameVariables.car.add_child(b)
	var pos = GameVariables.car.get_position(x, y)
	Global.set_location(b, pos[0], height, pos[1])
	return true

func throw(x, y, height, xdir, ydir):
	if not gun:
		return false
	var g = gun.instance()
	g.init(x,y,xdir,ydir,GameVariables.car)
	GameVariables.car.add_child(g)
	var pos = GameVariables.car.get_position(x, y)
	Global.set_location(g, pos[0], height, pos[1])
	return g

func empty():
	return bullets == 0

func explode():
	if get_parent() == GameVariables.player or (GameVariables.player.x == get_parent().x and GameVariables.player.y == get_parent().y): 
		TurnHandler.restart()
	#queue_free()
