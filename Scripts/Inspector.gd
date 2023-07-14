extends CharacterBody2D

var origin: Vector2
var spawn_shape = false
var blocksInRow = []

func _ready():
	origin = global_position
	for i in 20:
		blocksInRow.append(0)

func inspect():
	for block in Global.Game.get_node("Blocks").get_children():
		if !block.get_collision_layer_value(2):
			block.queue_free()
	for y in 20:
		position.y = origin.y - y*8
		for x in 10:
			position.x = origin.x + 8 + x*8
			if test_move(transform, Vector2.ZERO):
				separate_shape()
	position = origin
	if spawn_shape:
		Global.spawn_shape()
		spawn_shape = false
		scan_rows()

func separate_shape():
	if(Global.shape.locked):
		spawn_shape = true
	Global.spawn_block(global_position, !spawn_shape)
	
func scan_rows():
	blocksInRow.fill(0)
	for i in Global.Game.get_node("Blocks").get_children():
		if (i.get_collision_layer_value(2)):
			var row = (i.position.y - 40) / 8
			blocksInRow[row] += 1
	while blocksInRow.has(10):
		var row = blocksInRow.find(10)
		Global.clear_row(row)
		blocksInRow[row] = 0
	
	for i in blocksInRow.size():
		if blocksInRow[i] == 0:
			Global.drop_above(40 + i*8)
