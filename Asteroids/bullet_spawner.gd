extends Node2D



@export var spawnling_scene:PackedScene

func _ready():
	Events.fire_bullet.connect(spawn)


func spawn():
	var spawnling = spawnling_scene.instantiate()
	
	add_child(spawnling)
	
	spawnling.top_level = true
	spawnling.global_position = global_position
	
	return spawnling
