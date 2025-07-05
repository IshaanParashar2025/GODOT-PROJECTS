extends CharacterBody3D

var picked := false


func _ready() -> void:
	get_tree().get_first_node_in_group("Player").Object_thrown.connect(_thrown)


func _physics_process(delta: float) -> void:
	
	if not picked:
		var collision = move_and_collide(velocity * delta)
		if collision:
			
			velocity = velocity.bounce(collision.get_normal()).normalized() * 100 * delta
		if not is_on_floor():
			velocity.y -= 5 * delta 
	


func _thrown(throw_dir:Vector3):
	velocity = throw_dir * 5
