extends CharacterBody3D

signal struck

func _physics_process(delta: float) -> void:
	for index in range(get_slide_collision_count()):
		var collision = get_slide_collision(index)
		if collision:
			emit_signal("struck")
	move_and_slide()
