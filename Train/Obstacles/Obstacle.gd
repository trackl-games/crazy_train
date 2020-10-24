extends "res://Train/GameObject.gd"

onready var debug_marker = $debug/debug_marker

var open = true
var selected = false
var height = 0
var landable = false

var unselected_color = Color( .1, .1, .1, .7 )
var selected_color = Color( 1, .5, 0, .7 )

var x = -1
var y = -1
var car = null

func init(x, y, car):
	self.x = x
	self.y = y
	self.car = car
	o_init()

func o_init():
	# Override in implementation
	return false

# Called when the node enters the scene tree for the first time.
func _ready():
	debug_marker.set_surface_material(0, SpatialMaterial.new())
	debug_marker.get_surface_material(0).flags_transparent = true
	debug_marker.get_surface_material(0).albedo_color = unselected_color
	if not GameVariables.DEBUG:
		debug_marker.visible = false
	o_ready()

func o_ready():
	# Override in implementation
	return false

func _process(delta):
	#set_selected()
	o_process(delta)

func o_process(delta):
	# Override in implementation
	return false

func set_selected():
	if GameVariables.player.mode == "move":
		if not selected:
			if GameVariables.clicked_tile == self:
				selected = true
				debug_marker.get_surface_material(0).albedo_color = selected_color
				if open and Global.within_one(x, y, GameVariables.player.x, GameVariables.player.y):
					move_player()
		else:
			if GameVariables.clicked_tile != self:
				selected = false
				debug_marker.get_surface_material(0).albedo_color = unselected_color
			if (
				(GameVariables.player.x != x or GameVariables.player.y != y) and open and 
				Global.within_one(x, y, GameVariables.player.x, GameVariables.player.y)
			):
				move_player()
	if GameVariables.player.mode == "shoot":
		if not selected:
			if GameVariables.clicked_tile == self:
				shot()
				selected = true
		else:
			if GameVariables.clicked_tile != self:
				selected = false

func move_player():
	GameVariables.player.jump_to(x, y)

func shot():
	o_shot()
	if GameVariables.player.x == x and GameVariables.player.y == y:
		GameVariables.player.shot()

func o_shot():
	return

func make_empty():
	var empty = GameVariables.obj_map[" "].instance()
	empty.init(x, y, car)
	car.grid[x][y] = empty
	var location = car.get_position(x, y)
	Global.set_location(empty, location[0], car.origin_y, location[1])
	get_parent().add_child(empty)
	queue_free()
