extends Node2D


var current_file = "/home/harrison/workspace/projects/crazy_train/level1.json"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	pass

func _on_Open_pressed():
	if not $FileDialog.visible:
		$FileDialog.visible = true


func _on_FileDialog_file_selected(path):
	current_file = path


func _on_Play_pressed():
	var f = File.new()
	f.open(current_file, f.READ)
	var y = parse_json(f.get_as_text())
	f.close()
	var new_scene = load("res://Train/TrainCar.tscn").instance()
	new_scene.current_car = y.duplicate(true)
	get_tree().get_root().add_child(new_scene)
	#get_tree().change_scene_to(new_scene)
	#get_tree().get_root().current_car = y.duplicate(true)
	queue_free()
