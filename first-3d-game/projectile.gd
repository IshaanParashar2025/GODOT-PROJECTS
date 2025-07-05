extends RayCast3D

var speed : float = 5.0

func _physics_process(delta: float) -> void:
	position += global_basis * Vector3.FORWARD * speed * delta
	target_position = speed * Vector3.FORWARD * delta
	force_raycast_update()
	
	var collider = get_collider()
	if collider:
		global_position = get_collision_point()
		set_physics_process(false)

func clean_up():
	queue_free()
	
