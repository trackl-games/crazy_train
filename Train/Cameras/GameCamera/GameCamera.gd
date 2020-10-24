extends Spatial


onready var cam = $location/Camera

var clicked_time = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	clicked_time -= delta
	if clicked_time < 0: 
		if Input.is_action_pressed("left_click"):
			var clicked = Global.get_clicked_object(cam)
			if not clicked.empty():
				GameVariables.clicked_tile = clicked.collider.get_parent()
				print(GameVariables.clicked_tile)
				clicked_time = GameVariables.CLICK_DELAY
