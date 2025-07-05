extends RayCast3D

@export var speed := 100

func _physics_process(delta: float) -> void:
	target_position = speed * Vector3.FORWARD 
	force_raycast_update()
	
	
	var collision = get_collider()
	if collision and collision.has_method("_hurt"):
		_damge(collision)
	
	


func _destroy_bullet():
	queue_free()

func _damge(body: Node3D):
	print("body entered")
	if body.has_method("_hurt"):
		body._hurt(10)
		print("body damaged")
