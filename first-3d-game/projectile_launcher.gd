extends Node3D

@export var projectile : PackedScene
@onready var timer: Timer = $Timer


func _physics_process(delta: float) -> void:
	if timer.is_stopped():
		if Input.is_action_pressed("shoot"):
			timer.start()
			var attack = projectile.instantiate()
			add_child(attack)
			attack.global_transform = global_transform
