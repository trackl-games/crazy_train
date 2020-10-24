extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_location(obj, x=0, y=0, z=0):
	var original_transform = obj.get_global_transform()
	original_transform.origin.x = x
	original_transform.origin.y = y
	original_transform.origin.z = z
	obj.set_global_transform(original_transform)

func set_local_location(obj, x=0, y=0, z=0):
	var original_transform = obj.get_transform()
	original_transform.origin.x = x
	original_transform.origin.y = y
	original_transform.origin.z = z
	obj.set_transform(original_transform)

func get_clicked_object(cam):
	var RAY_LENGTH = 100
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_from = cam.project_ray_origin(mouse_pos)
	var ray_to = ray_from + cam.project_ray_normal(mouse_pos) * RAY_LENGTH
	var space_state = cam.get_world().direct_space_state
	var selected = space_state.intersect_ray(ray_from, ray_to, [], 0b10, false, true)
	return selected

func within_one(x1, y1, x2, y2):
	if (abs(x1 - x2) == 1 and y1 == y2) or (abs(y1 - y2) == 1 and x1 == x2):
		return true
	return false

func if_odd(v, eval):
	if v % 2 == 1:
		return eval
	return 0

func if_even(v, eval):
	if v % 2 == 0:
		return eval
	return 0

func ffmod(a, b):
	var temp = fmod(a, b)
	if a < 0 and b > 0:
		return -temp
	if a > 0 and b < 0:
		return -temp
	return temp

func mod_window(value, left, right):
	var right_norm = right - left
	var value_norm = value - left
	return (ffmod(value_norm, right_norm) + left)

func print(value):
	if GameVariables.debug_board:
		GameVariables.debug_board.print(value)
		return true
	return false






















