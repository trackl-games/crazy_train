extends Spatial


var start = Vector3()
var started = false

onready var origin = $origin

var magnitude = .15
var rate = 2
var offset = 0
onready var parent = get_parent()


# Called when the node enters the scene tree for the first time.
func _ready():
	var ot = self.get_transform().origin
	#Global.set_local_location(origin, ot.x - (magnitude * .5), ot.y, ot.z - magnitude*.5) 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	offset = fmod(offset + rate*delta, 2 * PI)
	var ot = self.get_transform().origin
	Global.set_local_location(origin, ot.x + magnitude*sin(offset), ot.y, ot.z + magnitude*cos(offset))
	o_process(delta)

func o_process(delta):
	return
