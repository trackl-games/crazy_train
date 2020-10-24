extends "res://Train/Weapons/Guns/AbstractGun.gd"


# Called when the node enters the scene tree for the first time.
func o_ready():
	bullets = 3
	turns = 8
	bullet_loop = load("res://Train/Visuals/WeaponLoops/BasicBulletLoop.tscn")
	gun_loop = load("res://Train/Visuals/WeaponLoops/BasicGunLoop.tscn")
	bullet = load("res://Train/Weapons/Bullets/BasicBullet.tscn")
	gun = load("res://Train/Weapons/Bullets/BasicBulletGun.tscn")
	gun_name = "BasicGun"


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
