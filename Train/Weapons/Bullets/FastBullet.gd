extends "res://Train/Weapons/Bullets/Bullet.gd"

var spin_rate = 5
var timer = null

func o_ready():
	height = 2
	if xdir < 0 and not ydir:
		$Model/bullet.rotate_object_local(Vector3(0, 0, 1), PI)
	elif xdir > 0 and not ydir:
		pass
	elif ydir < 0 and not xdir:
		$Model/bullet.rotate_object_local(Vector3(0, 0, 1), PI/2)
	elif ydir > 0 and not xdir:
		$Model/bullet.rotate_object_local(Vector3(0, 0, 1), -PI/2)

func o_process(delta):
	if timer:
		return
	$Model/bullet.rotate_object_local(Vector3(1, 0, 0), spin_rate*delta)
	if tween.is_active():
		return
	if car.within_map(x, y):
		if car.grid[x][y].is_in_group("Obstacle"):
			var ob = car.grid[x][y]
			if ob.height >= height:
				ob.shot()
				timer = Timer.new()
				timer.autostart = true
				timer.wait_time = .5
				flame(x, y)
				add_child(timer)
				timer.connect("timeout", self, "finish")
			else:
				jump_to(x + xdir, y + ydir)
		else:
			jump_to(x + xdir, y + ydir)
	else:
		finish()

func flame(x, y):
	if not car.within_map(x, y):
		return
	var flame = GameVariables.small_front_explosion.instance()
	flame.size = 2
	flame.hide()
	car.grid[x][y].add_child(flame)
	var pos = car.get_position(x, y)
	Global.set_location(flame, pos[0], car.origin_y, pos[1])

func jump_to(i, j):
	var old_position = get_global_transform().origin
	var new_position = old_position
	var old_locations = self.car.get_position(x, y)
	var new_locations = self.car.get_position(i, j)
	old_position.x = old_locations[0]
	old_position.z = old_locations[1]
	old_position.y = get_global_transform().origin.y
	new_position.x = new_locations[0]
	new_position.z = new_locations[1]
	new_position.y = get_global_transform().origin.y
	self.x = i
	self.y = j
	tween.interpolate_property(
		self, "translation",
		get_global_transform().origin, new_position, .2,
		Tween.TRANS_LINEAR, Tween.EASE_OUT_IN
	)
	tween.start()
	return

func finish():
	TurnHandler.advance()
	die()
	queue_free()
