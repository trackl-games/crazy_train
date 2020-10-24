extends "res://Train/GameObject.gd"


var x = -1
var y = -1
var car = null

var moving = false
var mode = "move"  # move, shoot, pause
onready var current_tween = $Tween

var arrows = null
var WAIST_HEIGHT = 0.2
var NECK_HEIGHT = 0.5

var gun = null

var items = []

func init(x, y, car):
	self.x = x
	self.y = y
	self.car = car

# Called when the node enters the scene tree for the first time.
func _ready():
	var location = self.car.get_position(x, y)
	jump_to(self.car.start()[0], self.car.start()[1])

func _process(delta):
	if moving:
		if not current_tween.is_active():
			moving = false
	process_buttons(delta)

func process_buttons(delta):
	if not TurnHandler.is_player_phase():
		return
	if Input.is_action_just_pressed("key_space"):
		if mode == "shoot":
			change_mode("move")
			free_arrows()
		elif (mode == "move" or mode == "throw") and gun:
			change_mode("shoot")
			make_arrows()
	if Input.is_action_just_pressed("key_w"):
		if mode == "move" and not moving:
			if car.can_move(x, y+1):
				jump_to(x,y+1)
				TurnHandler.advance()
		elif mode == "shoot":
			if shoot(0, 1):
				TurnHandler.completed()
		elif mode == "throw":
			if throw(0, 1):
				TurnHandler.completed()
	if Input.is_action_just_pressed("key_s"):
		if mode == "move" and not moving:
			if car.can_move(x, y-1):
				jump_to(x,y-1)
				TurnHandler.advance()
		elif mode == "shoot":
			if shoot(0, -1):
				TurnHandler.completed()
		elif mode == "throw":
			if throw(0, -1):
				TurnHandler.completed()
	if Input.is_action_just_pressed("key_a"):
		if mode == "move" and not moving:
			if car.can_move(x-1, y):
				jump_to(x-1,y)
				TurnHandler.advance()
		elif mode == "shoot":
			if shoot(-1, 0):
				TurnHandler.completed()
		elif mode == "throw":
			if throw(-1, 0):
				TurnHandler.completed()
	if Input.is_action_just_pressed("key_d"):
		if mode == "move" and not moving:
			if car.can_move(x+1, y):
				jump_to(x+1,y)
				TurnHandler.advance()
		elif mode == "shoot":
			if shoot(1, 0):
				TurnHandler.completed()
		elif mode == "throw":
			if throw(1, 0):
				TurnHandler.completed()
	if Input.is_action_just_pressed("key_t"):
		if ((mode == "move" and not moving) or (mode == "shoot")) and gun:
			change_mode("throw")
			make_arrows(false)
		elif mode == "throw":
			change_mode("move")
			free_arrows()
	if Input.is_action_just_pressed("key_r"):
		TurnHandler.restart()

func jump_to(x, y):
	if moving or mode != "move":
		return false
	if x > self.x:
		$model/player_sprite.flip_h = false
	if x < self.x:
		$model/player_sprite.flip_h = true
	moving = true
	var new_position = get_global_transform().origin
	var locations = self.car.get_position(x,y)
	new_position.x = locations[0]
	new_position.z = locations[1]
	self.x = x
	self.y = y
	current_tween.interpolate_property(
		self, "translation",
		get_global_transform().origin, new_position, .5,
		Tween.TRANS_CUBIC, Tween.EASE_IN_OUT
	)
	current_tween.start()
	return

func change_mode(new_mode):
	mode = new_mode
	free_arrows()
	GameVariables.debug_board.print("%s mode" % mode)


## Guns
func shot():
	TurnHandler.restart()

func shoot(xdir, ydir):
	if not gun:
		free_arrows()
		mode = "move"
		return false
	var worked = gun.shoot(x, y, get_global_transform().origin.y + WAIST_HEIGHT + 1, xdir, ydir)
	mode = "move"
	free_arrows()
	return worked

func throw(xdir, ydir):
	if not gun:
		free_arrows()
		mode = "move"
		return false
	var thrown_gun = gun.throw(x, y, get_global_transform().origin.y + WAIST_HEIGHT + 1, xdir, ydir)
	var temp_gun = gun
	remove_gun(false)
	thrown_gun.add_gun(temp_gun)
	mode = "move"
	free_arrows()
	return true

func set_gun(gun):
	remove_gun()
	self.gun = gun
	add_child(gun)

func remove_gun(delete=true):
	if self.gun:
		remove_child(self.gun)
		if delete:
			self.gun.queue_free()
	self.gun = null

func make_arrows(bullet=true):
	if not gun:
		return
	if bullet and gun.empty():
		return
	free_arrows()
	if bullet:
		arrows = gun.bullet_loop.instance()
	else:
		arrows = gun.gun_loop.instance()
	add_child(arrows)
	Global.set_local_location(arrows, 0, NECK_HEIGHT, 0)

func free_arrows():
	if arrows:
		arrows.queue_free()
		arrows = null

## Items
func add_item(item):
	items.append(item)

func has_item(item_name):
	for item in items:
		if item["name"] == item_name:
			return true
	return false

func item_index(item_name):
	var i = 0
	for item in items:
		if item["name"] == item_name:
			return i
		i += 1
	return -1

func get_item(item_name):
	if has_item(item_name):
		return items[item_index(item_name)]
	return null

func remove_item(item_name):
	if has_item(item_name):
		items.remove(item_index(item_name))


























