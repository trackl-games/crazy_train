extends "res://Train/Weapons/Bullets/Bullet.gd"

var rate = 12
var timer = null

func o_ready():
	height = 2

func o_process(delta):
	if timer:
		return
	$Model/Sprite3D.rotate_object_local(Vector3(0,0,1), delta*rate)
	if tween.is_active():
		return
	if car.within_map(x+xdir, y+ydir):
		var ob = car.grid[x+xdir][y+ydir]
		if ob.height >= height:
			if car.within_map(x, y + 1):
				car.grid[x][y + 1].shot()
				flame(x, y+1)
			if car.within_map(x, y - 1):
				car.grid[x][y - 1].shot()
				flame(x, y-1)
			if car.within_map(x+1, y):
				car.grid[x+1][y].shot()
				flame(x+1, y)
			if car.within_map(x-1, y):
				car.grid[x-1][y].shot()
				flame(x-1, y)
			car.grid[x][y].shot()
			flame(x, y)
			create_timer()
		else:
			jump_to(x + xdir, y + ydir)
	else:
		if car.within_map(x, y + 1):
			car.grid[x][y + 1].shot()
			flame(x, y+1)
		if car.within_map(x, y - 1):
			car.grid[x][y - 1].shot()
			flame(x, y-1)
		if car.within_map(x+1, y):
			car.grid[x+1][y].shot()
			flame(x+1, y)
		if car.within_map(x-1, y):
			car.grid[x-1][y].shot()
			flame(x-1, y)
		car.grid[x][y].shot()
		flame(x, y)
		create_timer()

func flame(x, y):
	if not car.within_map(x, y):
		return
	var flame = GameVariables.small_front_explosion.instance()
	flame.size = 2
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

func create_timer():
	timer = Timer.new()
	timer.autostart = true
	timer.wait_time = .5
	add_child(timer)
	timer.connect("timeout", self, "finish")

func finish():
	TurnHandler.advance()
	die()
	queue_free()




