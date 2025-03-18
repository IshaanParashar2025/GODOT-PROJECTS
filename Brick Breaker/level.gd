extends Node2D

@onready var brick_num = get_tree().get_nodes_in_group("Brick").size()

@onready var brick_num_copy = brick_num

func _ready():
	Events.brick_break.connect(brick_broken)
	print(brick_num_copy)

func _physics_process(delta):
	if brick_num_copy == 0:
		get_tree().change_scene_to_file("res://victory_screen.tscn")

func _on_area_2d_body_entered(body):
	
	Events.ball_hit.emit()
	get_tree().reload_current_scene()

func brick_broken():
	brick_num_copy -= 1
	print(brick_num_copy)
