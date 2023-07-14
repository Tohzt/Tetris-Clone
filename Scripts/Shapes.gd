extends CharacterBody2D

var locked = false
var drop = false

func _ready():
	position = Global.origin
	if name == "I" or name == "B":
		position+=Vector2(4,4)

func _physics_process(_delta):
	if !locked:
		if Input.is_action_just_pressed("LEFT"):
			if !test_move(transform, Vector2(-8,0)):
				move_and_collide(Vector2(-8,0))
		if Input.is_action_just_pressed("RIGHT"):
			if !test_move(transform, Vector2(8,0)):
				move_and_collide(Vector2(8,0))

		if Input.is_action_just_pressed("UP"):
			rotation_degrees += 90

		if drop:
			drop = false
			if !test_move(transform, Vector2(0,8)):
				move_and_collide(Vector2(0,8))
			else:
				locked = true
	
