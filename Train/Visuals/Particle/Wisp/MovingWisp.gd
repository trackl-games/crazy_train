extends Spatial


var offset = 0
var rate = 1
var radius = .4


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	offset += delta * rate
	Global.set_local_location($WillowWisp, radius * sin(offset), radius * cos(offset), radius * cos(offset))
