extends Node2D


var text = ["Start"]
var MAX_LEN = 10
onready var board = $board


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func print(message):
	text.append(message)
	if len(text) > MAX_LEN:
		text.pop_front()
	text.invert()
	var new_text = ""
	for m in text:
		new_text += m + "\n"
	board.text = new_text
	text.invert()
	
