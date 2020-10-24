extends "res://Train/GameObject.gd"


var current_cara = {
	"size" : {
		"w" : 5,
		"h" : 6
	},
	"map": [
		" x x ",
		" oGx ",
		"xx xx",
		"     ",
		"G   G",
		" x x ",
	],
	"floor": [
		"wwwww",
		"wwwww",
		"wwwww",
		"wwwww",
		"wwwww",
		"wwwww",
	],
	"wall": "bbbbbbbbdbbbbbbbb",
	"lighting": ["default"],
	"start": [0, 2],
}

var current_car = {
	"size" : {
		"w" : 7,
		"h" : 6
	},
	"map": [
		" px x  ",
		"  oGx  ",
		" xp xx ",
		"p      ",
		" G   G ",
		"  x x  ",
	],
	"floor": [
		"wwwwwww",
		"wwwwwww",
		"wwwwwww",
		"wwwwwww",
		"wwwwwww",
		"wwwwwww",
	],
	"wall": "bbbbbbbbdbbbbbbbb",
	"lighting": ["default"],
	"start": [0, 3],
}

var grid = {}

var origin_x = 0
var origin_z = 0
var origin_y = 0

var camera = null
onready var debug_board = $DebugBoard

# Called when the node enters the scene tree for the first time.
func _ready():
	if not GameVariables.stored_car.empty():
		current_car = GameVariables.stored_car
	intify()
	generate_car()
	GameVariables.car = self
	for light in current_car["lighting"]:
		generate_lighting(light)
	if camera == null or true: camera = generate_camera()  # TODO
	if GameVariables.player == null or true: GameVariables.player = generate_player()
	GameVariables.debug_board = debug_board

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func width():
	return current_car["size"]["w"]

func height():
	return current_car["size"]["h"]

func start():
	return current_car["start"]
	
func speed():
	return current_car.get("speed", 0.5)

func map(x, y):
	var m = current_car["map"]
	#var a = width() - x - 1
	var a = x
	var b = height() - y - 1
	return m[b].substr(a,1)

func floor_map(x, y):
	var m = current_car["floor"]
	#var a = width() - x - 1
	var a = x
	var b = height() - y - 1
	return m[b].substr(a,1)

func is_valid():
	return true

func get_position(x, y):
#	if x < 0 or x >= width() or y < 0 or y >= height():
#		return [-1, -1]
	return [
		origin_x + (width() - x - 1) * GameVariables.TILE_SIZE + (GameVariables.TILE_SIZE/2), 
		origin_z + y * GameVariables.TILE_SIZE + (GameVariables.TILE_SIZE/2)
	]

func generate_car():
	# make objects
	generate_objects()
	generate_floor()
	generate_wall()
	generate_outside()

func generate_objects():
	for i in range(width()):
		for j in range(height()):
			var obj_char = map(i,j)
			if not (obj_char in GameVariables.obj_map):
				obj_char = " "
			var new_obj = GameVariables.obj_map[obj_char].instance()
			new_obj.init(i, j, self)
			add_child(new_obj)
			var location = get_position(i, j)
			Global.set_location(new_obj, location[0], origin_y, location[1])
			#rotate_obj(new_obj, i, j)
			if i in grid:
				grid[i][j] = new_obj
			else:
				grid[i] = {
					j : new_obj
				}

func generate_floor():
	var f = GameVariables.car_floor.instance()
	add_child(f)
	f.generate(
		width(), height(), 
		origin_x + width()*GameVariables.TILE_SIZE/2, 
		-.05, 
		origin_z + height()*GameVariables.TILE_SIZE/2,
		self
	)

func generate_wall():
	# sides
	for i in range(height()):
		var w = GameVariables.wall_map[current_car["wall"].substr(i, 1)]
		var w2 = GameVariables.wall_map[current_car["wall"].substr(2*height() + width() - 1 - i, 1)]
		var new_w = w.instance()
		var new_w2 = w2.instance()
		add_child(new_w)
		add_child(new_w2)
		Global.set_location(
			new_w,
			origin_z + width()*GameVariables.TILE_SIZE ,
			0,
			origin_x + i * GameVariables.TILE_SIZE + GameVariables.TILE_SIZE/2
		)
		Global.set_location(
			new_w2,
			0,
			0,
			origin_x + i * GameVariables.TILE_SIZE + GameVariables.TILE_SIZE/2
		)
		new_w.rotate(Vector3(0,1,0), -PI/2)
		new_w2.rotate(Vector3(0,1,0), PI/2)
	# top
	for i in range(width()):
		var w = GameVariables.wall_map[current_car["wall"].substr(height() + i,1)] # TODO
		var new_w = w.instance()
		add_child(new_w)
		Global.set_location(
			new_w,
			origin_z + i * GameVariables.TILE_SIZE + GameVariables.TILE_SIZE/2,
			0,
			origin_x + height() * GameVariables.TILE_SIZE
		)
		new_w.rotate(Vector3(0,1,0), PI)

func generate_outside():
	var w = load("res://Train/Visuals/Window/Window.tscn")
	var outside = load("res://Train/Visuals/Window/PortalLocations/Greens.tscn")
	var g = outside.instance()
	g.init(GameVariables.OUTSIDE_DX, GameVariables.OUTSIDE_DY, GameVariables.OUTSIDE_DZ)
	add_child(g)
	Global.set_location(g, GameVariables.OUTSIDE_DX, GameVariables.OUTSIDE_DY, GameVariables.OUTSIDE_DZ)
	print("outside: ", g.get_global_transform().origin)
	var W_DIS = 0.001
	var cam_pos_s = g.get_positions(height())
	print("cams", cam_pos_s)
	for i in range(height()):
		var new_w = w.instance()
		var new_w2 = w.instance()
		add_child(new_w)
		add_child(new_w2)
		Global.set_location(
			new_w,
			origin_z + width()*GameVariables.TILE_SIZE + W_DIS,
			0,
			origin_x + i * GameVariables.TILE_SIZE + GameVariables.TILE_SIZE/2
		)
		Global.set_location(
			new_w2,
			0 - W_DIS,
			0,#-GameVariables.WALL_HEIGHT/2,
			origin_x + i * GameVariables.TILE_SIZE + GameVariables.TILE_SIZE/2
		)
		new_w.rotate(Vector3(0,1,0), -PI/2)
		new_w2.rotate(Vector3(0,1,0), PI/2)
		var j = height() - i - 1
		Global.set_location(new_w.camera, cam_pos_s[j].x, cam_pos_s[j].y, cam_pos_s[j].z)
		Global.set_location(new_w2.camera, cam_pos_s[j].x, cam_pos_s[j].y, cam_pos_s[j].z)
		new_w.camera.init(
			-4, 0, 0, 
			g.start_x + g.left_bound, g.start_x + g.right_bound, 
			g.start_y + g.lower_bound, g.start_y + g.upper_bound, 
			g.start_z-1, g.start_z + 1
		)
		new_w2.camera.init(
			-4, 0, 0, 
			g.start_x + g.left_bound, g.start_x + g.right_bound, 
			g.start_y + g.lower_bound, g.start_y + g.upper_bound, 
			g.start_z-1, g.start_z + 1
		)
		new_w.camera.rotate_object_local(Vector3(0,1,0), g.cam_angle)
		new_w2.camera.rotate_object_local(Vector3(0,1,0), g.cam_angle)
		new_w2.get_node("MeshInstance").scale.x = -1
		#new_w.camera.rotate(Vector3(0,1,0), PI/2)

func generate_camera():
	var cam = GameVariables.game_camera.instance()
	add_child(cam)
	Global.set_location(
		cam,
		origin_z + width()*GameVariables.TILE_SIZE/2 - 0, #Global.if_even(width(), GameVariables.TILE_SIZE/2),
		10,
		origin_x
	)
	cam.rotation_degrees.x = -60
	cam.rotation_degrees.y = 180
	return cam

func generate_lighting(light):
	if not (light in GameVariables.lights):
		return null
	var l = GameVariables.lights[light].instance()
	Global.set_location(
		l,
		origin_z + height()*GameVariables.TILE_SIZE/2 - (GameVariables.TILE_SIZE/2),
		0,
		origin_x + width()*GameVariables.TILE_SIZE/2 - (GameVariables.TILE_SIZE/2)
	)
	add_child(l)
	return l

func generate_player():
	var p = GameVariables.pplayer.instance()
	p.init(0, 0, self)
	#get_tree().get_root().add_child(Global.player)
	add_child(p) # TODO
	return p

func within_map(x, y):
	x = int(x)
	y = int(y)
	return (
		x >= 0 and x < width() and y >= 0 and y < height()
	)

func can_move(x, y):
	x = int(x)
	y = int(y)
	if within_map(x,y):
		if grid[x][y].open:
			return true
	return false

func intify():
	current_car["size"]["w"] = int(current_car["size"]["w"])
	current_car["size"]["h"] = int(current_car["size"]["h"])
	current_car["start"] = [int(current_car["start"][0]), int(current_car["start"][1])]

func rotate_obj(obj, x, y):
	var model = obj.get_node("model")
	if not model:
		return false
	var l = 0
	var r = 0
	if width() % 2 == 0:
		l = floor(width()/2)
		r = ceil(width()/2)
	else:
		l = floor(width()/2)
		r = floor(width()/2)
	
	var deg = 0
	if x < l:
		deg = asin((l-x)/(y+1)) * ((y+1) * .1 if y < 10 else 1)
		model.rotate_object_local(Vector3(0,1,0), deg)
	if x > r:
		deg = asin((x-r)/(y+1)) * .1
		model.rotate_object_local(Vector3(0,1,0), -deg)
	
	return true









