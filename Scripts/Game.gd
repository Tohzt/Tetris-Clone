extends Node2D

@onready var Scores = get_node("ScoreDisplay")
var background: Control
var lines = 0
var score = 0
var level = 0

func _ready():
	background = get_node("Backgrounds")
	background.get_node("Game").visible  = false
	background.get_node("Menu").visible  = false
	background.get_node("Intro").visible = true
	background.get_node("Pause").visible = false

func _process(_delta):
	update_score()

	if Input.is_action_just_pressed("Enter"):
		match Global.background:
			"Intro":
				background.get_node("Intro").visible = false
				background.get_node("Menu").visible = true
				Global.background = "Menu"
			"Menu":
				background.get_node("Menu").visible = false
				background.get_node("Game").visible = true
				Global.background = "Game"
				Global.spawn_shape()
			"Game":
				background.get_node("Game").visible = false
				background.get_node("Pause").visible = true
				Global.background = "Pause"
			"Pause":
				background.get_node("Pause").visible = false
				background.get_node("Game").visible = true
				Global.background = "Game"

func level_up():
	lines += 1
	if !(lines % 10):
		print("Level UP: ")
		level += 1

func update_score():
	get_node("ScoreDisplay").visible = Global.background == "Game"
	Scores.get_node("Level").text = ("%02d" % level)
	Scores.get_node("Lines").text = ("%03d" % lines)
	Scores.get_node("Statistics").get_node("T").text = ("%03d" % Global.stats.T)
	Scores.get_node("Statistics").get_node("J").text = ("%03d" % Global.stats.J)
	Scores.get_node("Statistics").get_node("Z").text = ("%03d" % Global.stats.Z)
	Scores.get_node("Statistics").get_node("B").text = ("%03d" % Global.stats.B)
	Scores.get_node("Statistics").get_node("S").text = ("%03d" % Global.stats.S)
	Scores.get_node("Statistics").get_node("L").text = ("%03d" % Global.stats.L)
	Scores.get_node("Statistics").get_node("I").text = ("%03d" % Global.stats.I)
