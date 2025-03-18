extends CharacterBody2D

var speed = 300

func get_input():
	var input_axis = Input.get_axis("ui_left","ui_right")
	velocity = speed * input_axis * transform.x

func _physics_process(delta):
	get_input()
	move_and_slide()
