extends Marker2D

signal spawned(spawn)

@export var spawnling_scene:PackedScene


func spawn():
	var spawnling = spawnling_scene.instantiate()
	add_child(spawnling)
	
	spawnling.top_level = true
	spawnling.global_position = global_position
	
	spawned.emit(spawnling)
	return spawnling
