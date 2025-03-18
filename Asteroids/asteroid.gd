extends CharacterBody2D

@onready var ship = get_tree().get_first_node_in_group("Ship")
@onready var ship_direction:Vector2 
@onready var asteroid_speed = randf_range(100.0, 150.0)
@onready var viewport = get_viewport_rect().size
@onready var collision_shape_2d = $HurtBox/CollisionShape2D

var speed_up_factor = 1.2


func _ready():
	Events.added_asteroid.connect(movement)


func _physics_process(delta):
	wrap_asteroid()
	move_and_slide()


func movement():
	ship_direction = (ship.global_position - global_position).normalized()
	velocity = ship_direction.rotated(randf_range(-PI/3, PI/3)) * asteroid_speed
	
	Events.added_asteroid.disconnect(movement)
	await get_tree().create_timer(0.1).timeout
	collision_shape_2d = true
	if scale < Vector2(1,1) :
		velocity *= speed_up_factor

func wrap_asteroid():
	global_position.x = wrapf(global_position.x, 0, viewport.x)
	global_position.y = wrapf(global_position.y, 0, viewport.y)


func _on_hurt_box_area_entered(area):
	Events.asteroid_destroyed.emit(scale, global_position)
	queue_free()
