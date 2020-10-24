extends "res://Train/Visuals/GenericLoop.gd"

var spin_rate = -6


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func o_process(delta):
	$origin/s1/Sprite3D.rotate_object_local(Vector3(0, 0, 1), spin_rate*delta)
	$origin/s2/Sprite3D2.rotate_object_local(Vector3(0, 0, 1), spin_rate*delta)
	$origin/s3/Sprite3D3.rotate_object_local(Vector3(0, 0, 1), spin_rate*delta)
	$origin/s4/Sprite3D4.rotate_object_local(Vector3(0, 0, 1), spin_rate*delta)
