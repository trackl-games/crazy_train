extends Spatial


export var time = 4
export var speed = 1
export var size = 1
var started = false
var apogee = false


# Called when the node enters the scene tree for the first time.
func _ready():
	$GreenFlame.visible = false
	$GreenFlame.scale = Vector3(0, 0, 0)


func _process(delta):
	if not $Tween.is_active():
		if not started and not apogee:
			$Tween.interpolate_property(
				$GreenFlame, "scale",
				Vector3(0, 0, 0), Vector3(size, size, size), speed,
				Tween.TRANS_EXPO, Tween.EASE_IN_OUT
			)
			$Tween.start()
			started = true
			show()
			$GreenFlame.visible = true
		elif started and not apogee:
			$Tween.interpolate_property(
				$GreenFlame, "scale",
				Vector3(size, size, size), Vector3(0, 0, 0), speed,
				Tween.TRANS_EXPO, Tween.EASE_IN_OUT
			)
			$Tween.start()
			apogee = true
		else:
			queue_free()
