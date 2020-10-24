extends Spatial


signal advance_sig


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func advance():
	print("Emitting advance!")
	emit_signal("advance_sig")
