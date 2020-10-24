extends Spatial


onready var _floor = get_node("model/floor")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func generate(w, h, x, y, z, car):
	_floor.scale.x = w
	_floor.scale.z = h
	Global.set_location(self, x, y, z)
	for i in range(w):
		for j in range(h):
			var floor_char = car.floor_map(i, j)
			if not (floor_char in GameVariables.floor_map):
				floor_char = " "
			var fb = GameVariables.floor_map[floor_char].instance()
			var location = car.get_position(i, j)
			add_child(fb)
			Global.set_location(fb, location[0], y, location[1])
			#add_child(fb)
