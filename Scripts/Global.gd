extends Node

var background = "Intro"
var origin = Vector2(140,44)
@onready var Game = get_tree().get_root().get_node("Game")
@onready var Blocks = preload("res://Scenes/Block.tscn").instantiate()
@onready var Shapes = preload("res://Scenes/Shapes.tscn").instantiate()
var shape: Node2D
var deck: Array
var tick = 0
var tick_dur = 0.5
var blocksInRow = []
var stats = { "T": 0, "J": 0, "Z": 0, "B": 0, "S": 0, "L": 0, "I": 0, }

func _ready():
	fill_deck()

func _process(delta):
	if Input.is_action_pressed("DOWN"):
		tick_dur = 0.05
	else:
		tick_dur = 0.5

	if background == "Game":
		Game.get_node("Inspector").inspect()
		tick-=delta
		if tick <= 0:
			tick = tick_dur
			for block in Game.get_node("Shape").get_child_count():
				Game.get_node("Shape").get_child(block).drop = true
	
func fill_deck():
	deck = ["T", "J", "Z", "S", "B", "L", "I"]
	deck.shuffle()

func spawn_shape():
	if shape:
		stats[Global.shape.name] += 1
	if deck.size() == 0:
		fill_deck()
	if Game.get_node("Shape").get_child_count():
		Game.get_node("Shape").remove_child(Game.get_node("Shape").get_child(0))
	shape = Shapes.get_node(deck.pop_back()).duplicate()
	Game.get_node("Shape").add_child(shape)

func spawn_block(pos: Vector2, falling: bool):
	var block = Blocks.duplicate()
	block.position = pos
	var frame = (shape.get_node("Sprite2D").frame) % 3 + ((Game.level%10) * 3)
	block.get_node("Sprite2D").frame = frame
	if falling:
		block.set_collision_layer_value(2, false)
		block.set_collision_mask_value(2, false)
	Game.get_node("Blocks").add_child(block)

func clear_row(row):
	Game.level_up()
	for block in Game.get_node("Blocks").get_children():
		if block.get_collision_layer_value(2) && block.position.y == row*8 + 40:
			block.queue_free()

func drop_above(y):
	for block in Game.get_node("Blocks").get_children():
		if block.get_collision_layer_value(2) && block.position.y < y:
			block.position.y += 8

