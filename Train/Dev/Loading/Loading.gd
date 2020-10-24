extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var new_scene = load("res://Train/TrainCar.tscn").instance()
	new_scene.current_car = GameVariables.stored_car
	get_tree().get_root().add_child(new_scene)
	#get_tree().change_scene_to(new_scene)
	#get_tree().get_root().current_car = y.duplicate(true)
	queue_free()
