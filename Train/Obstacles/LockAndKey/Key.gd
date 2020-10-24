extends "res://Train/Obstacles/Obstacle.gd"


var key_item = {
	"name": "key"
}

var offset = 0
var rate = 2
var radius = .25

var defaultxrot = -30
var rot_offset = 0
var rot_rate = 1
var rot_radius = .5

func o_ready():
	#defaultxrot = get_rotation().x
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func o_process(delta):
	offset += delta * rate
	rot_offset += delta * rot_rate
	Global.set_local_location($model/Sprite3D, 0, radius * sin(offset) + .6, 0)
	$model/Sprite3D.set_rotation(Vector3(defaultxrot, 0, rot_radius*sin(rot_offset)))
	if GameVariables.player.x == x and GameVariables.player.y == y:
		GameVariables.player.add_item(key_item)
		Global.print("Picked up key item")
		make_empty()
		queue_free()
