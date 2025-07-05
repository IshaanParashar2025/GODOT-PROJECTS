extends CharacterBody3D

@onready var player := get_tree().get_first_node_in_group("Player")

@export var target_gravity :int = 100

var player_head : Vector3


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= target_gravity * delta
	
	look_at(player.position)
	
	
	move_and_slide()

func _hurt(dmg: int):
	print("hurt")
	queue_free()
