extends CharacterBody3D

@export var moving := false
@export var flying := false
@export var explosive := false
@export var target_distance : float = 2
@export var move_speed := 5

@onready var move_target = global_transform.basis.x 
@onready var explosion_radius: Area3D = $"Explosion Radius"

var nearby_objects = []

var change_horizontal_dir := -1


func _ready() -> void:
	if explosive:
		explosion_radius.set_process_mode(PROCESS_MODE_INHERIT) 


func _physics_process(delta: float) -> void:
	
	for index in range(get_slide_collision_count()):
		var collision = get_slide_collision(index)
		if collision:
			if collision.get_collider().is_in_group("Pickable"):
				if explosive:
					explode()
				queue_free()
	
	if moving:
		move_around_origin(delta)
		print(position)
		print(global_position)
	
	if not is_on_floor() and not flying:
		velocity.y -= 100 * delta 
	
	
	move_and_slide()


func move_horizontal(delta:float):
	
	return 


func _on_explosion_radius_body_entered(body: Node3D) -> void:
	nearby_objects.append(body)
	print(nearby_objects)


func _on_explosion_radius_body_exited(body: Node3D) -> void:
	var index = nearby_objects.find(body)
	nearby_objects.pop_at(index)
	print(nearby_objects)


func explode():
	for object in nearby_objects:
		object.queue_free()


func move_around_origin(delta : float):
	if position.x >= target_distance:
		change_horizontal_dir = -1
	elif position.x <= -target_distance :
		change_horizontal_dir = 1 
	position += move_target * delta * move_speed * change_horizontal_dir
