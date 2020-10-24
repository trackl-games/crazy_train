extends Spatial


var left_bound = -30
var right_bound = 30
var upper_bound = 5
var lower_bound = 0

var edge_dx = 1

var cam_dx = 2

var cam_angle = 0  # TODO

var start_x = 0
var start_y = 0
var start_z = 0

func init(sx, sy, sz):
	start_x = sx
	start_y = sy
	start_z = sz

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_positions(num_cams):
	var poss = []
	var total_width = abs(right_bound - left_bound) - edge_dx * 2
#	for i in range(num_cams):
#		poss.append(
#			Vector3(
#				start_x + left_bound + i * (float(total_width)/float(num_cams)), 
#				start_y + (upper_bound + lower_bound) / 2, 
#				start_z
#			)
#		)
	for i in range(num_cams):
		poss.append(
			Vector3(
				start_x + float(i) * float(cam_dx),
				start_y + (float(upper_bound) + float(lower_bound)) / 2,
				start_z
			)
		)
	return poss
