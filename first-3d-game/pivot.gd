extends Node3D


var struck := false

var rotation_speed = PI

func _physics_process(delta: float) -> void:
	
	if struck:
		rotate_x(-rotation_speed * delta)



func _on_target_struck() -> void:
	struck = true
	print("signal recieved")
