extends "res://Train/Obstacles/Obstacle.gd"

onready var sprite = $sprite/head
var color = "red"
var red_sprite = load("res://Train/Obstacles/Obilisk/ToggleObilisk/redobnospike.png")
var green_sprite = load("res://Train/Obstacles/Obilisk/ToggleObilisk/greenobnospike.png")

func o_init():
	open = false
	height = 5

func o_process(delta):
	GameVariables.set_bools[color] = true

func o_shot():
	if color == "red":
		sprite.set_texture(green_sprite)
		color = "green"
		GameVariables.set_bools["red"] = false
	elif color == "green":
		sprite.set_texture(red_sprite)
		color = "red"
		GameVariables.set_bools["green"] = false
