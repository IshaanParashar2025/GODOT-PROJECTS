extends Node3D

@export var bullet : PackedScene
@export var start_position : Marker3D

@onready var timer: Timer = $Timer


func _physics_process(delta: float) -> void:
	
	if Input.is_action_pressed("shoot") and timer.is_stopped():
		timer.start()
		var attack = bullet.instantiate()
		add_child(attack)
		attack.global_position = start_position.global_position
		attack.global_rotation = global_rotation
		
