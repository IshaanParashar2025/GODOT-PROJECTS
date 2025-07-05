extends CharacterBody3D

@onready var move_target = transform.basis.x 
@onready var explosion_radius: Area3D = $"Explosion Radius"

var nearby_objects = []


func _ready() -> void:
	if owner.explosive:
		explosion_radius.set_process_mode(PROCESS_MODE_INHERIT) 


func _physics_process(delta: float) -> void:
	
	for index in range(get_slide_collision_count()):
		var collision = get_slide_collision(index)
		if collision:
			if collision.get_collider().is_in_group("Pickable"):
				if owner.explosive:
					explode()
				SignalBus.destroyed.emit()
				destroy()
	
	if owner.moving:
		move_around_origin(delta)
	
	if not is_on_floor() and not owner.flying:
		velocity.y -= 100 * delta 
	
	
	move_and_slide()


func move_horizontal(delta:float):
	
	return 


func _on_explosion_radius_body_entered(body: Node3D) -> void:
	if body.has_method("destroy"):
		nearby_objects.append(body)


func _on_explosion_radius_body_exited(body: Node3D) -> void:
	var index = nearby_objects.find(body)
	nearby_objects.pop_at(index)


func explode():
	for object in nearby_objects:
		object.destroy()


func move_around_origin(delta : float):
	if position.x >= owner.target_distance:
		owner.change_horizontal_dir = -1
	elif position.x <= -owner.target_distance :
		owner.change_horizontal_dir = 1 
	position += move_target * delta * owner.move_speed * owner.change_horizontal_dir

func destroy():
	owner.queue_free()
