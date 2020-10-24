extends Node

var DEBUG = false

var clicked_tile = null
var player = null
var car = null
var debug_board = null
var stored_car = {}

var turn_counter = 0

var OUTSIDE_DX = 100
var OUTSIDE_DY = 100
var OUTSIDE_DZ = 100

var RESTART_TIME = 1.5

var train_car = preload("res://Train/TrainCar.tscn")
var set_bools = {
	"" : false,
	"blue" : false,
	"green" : false,
	"red": false
}
var environmental = []
func remove_environmental(obj):
	if environmental.has(obj):
		environmental.erase(obj)
func add_environmental(obj):
	if not environmental.has(obj):
		environmental.append(obj)
	# TODO sort?

var obj_map = {
	" ": preload("res://Train/Obstacles/Empty.tscn"),
	"x": preload("res://Train/Obstacles/Basic/Table/Table.tscn"),
	"g": preload("res://Train/Obstacles/Gate/Gate.tscn"),
	"G": preload("res://Train/Obstacles/Gate/GreenGate/GreenGate.tscn"),
	"o": preload("res://Train/Obstacles/Obilisk/ToggleObilisk/ToggleObilisk.tscn"),
	"p": preload("res://Train/Obstacles/Basic/Pillar/Pillar.tscn"),
	"f": preload("res://Train/Obstacles/Guns/FastGun/FastGunObstacle.tscn"),
	"b": preload("res://Train/Obstacles/Guns/BasicGun/BasicGunObstacle.tscn"),
	"r": preload("res://Train/Obstacles/Rescue/RescueWisp/RescueWisp.tscn"),
	"L": preload("res://Train/Obstacles/LockAndKey/Lock.tscn"),
	"K": preload("res://Train/Obstacles/LockAndKey/Key.tscn"),
}
var floor_map = {
	" ": preload("res://Train/Decoration/Floor/WoodBlock/WoodBlock.tscn"),
	"w": preload("res://Train/Decoration/Floor/WoodBlock/WoodBlock.tscn"),
}
var wall_map = {
	" ": preload("res://Train/Decoration/Wall/DebugWall/DebugWall.tscn"),
	"b": preload("res://Train/Decoration/Wall/BetaWall/BetaWall.tscn"),
	"d": preload("res://Train/Decoration/Wall/DoorWall/DoorWall.tscn"),
}
var lights = {
	"default": preload("res://Train/Lighting/DefaultLighting/DefaultLighting.tscn")
}
var bullets = {
	"fast": preload("res://Train/Weapons/Bullets/FastBullet.tscn")
}
var gun_bullets = {
	"fast": preload("res://Train/Weapons/Bullets/FastBulletGun.tscn")
}
var weapon_loop = {
	"fast": preload("res://Train/Visuals/WeaponLoops/FastGunLoop.tscn")
}
var bullet_loop = {
	"fast": preload("res://Train/Visuals/WeaponLoops/FastBulletLoop.tscn")
}
var car_floor = preload("res://Train/Decoration/Floor/Floor.tscn")
var game_camera = preload("res://Train/Cameras/GameCamera/GameCamera.tscn")
var pplayer = preload("res://Train/Player/Player.tscn")
var arrow = preload("res://Train/Visuals/Arrow.tscn")
var arrow_loop = preload("res://Train/Visuals/ArrowLoop.tscn")
var small_explosion = preload("res://Train/Visuals/Particle/GreenFlame/SmallExplosion.tscn")
var small_front_explosion = preload("res://Train/Visuals/Particle/GreenFlame/SmallFrontExplosion.tscn")

const TILE_SIZE = 2
const WALL_HEIGHT = 4
const CLICK_DELAY = .2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_object(obj):
	if obj in obj_map:
		return obj_map[obj]
	return null
