extends Spatial


var start = Vector3()
var started = false

onready var origin = $origin

var magnitude = .15
var rate = 2
var offset = 0
onready var parent = get_parent()


func _ready():
	var ot = self.get_transform().origin


func _process(delta):
	offset = fmod(offset + rate*delta, 2 * PI)
	var ot = self.get_transform().origin
	Global.set_local_location(origin, ot.x + magnitude*sin(offset), ot.y, ot.z + magnitude*cos(offset))
