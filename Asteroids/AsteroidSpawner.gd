extends Marker2D

@export var spawnling_scene:PackedScene

@onready var timer = $Timer

@onready var viewport_size = get_viewport_rect().size

@export var asteroid_limit = 6

@onready var asteroids_alive = asteroid_limit

const spawning_radius:float = 600.0
var spawned_asteroids = 0



func _ready():
	Events.asteroid_destroyed.connect(spawn_new_asteroid)
	Events.destroy_ship.connect(stop_spawning)
	timer.start()

func _physics_process(delta):

	if spawned_asteroids == asteroid_limit:
		stop_spawning()

func spawn():
	var spawnling = spawnling_scene.instantiate()
	
	add_child(spawnling)
	
	var spawn_pos_x = randf_range(0,viewport_size.x)
	var spawn_pos_y = randf_range(0,viewport_size.y)
	
	var spawn_x_top = Vector2(spawn_pos_x,1)
	var spawn_x_bottom = Vector2(spawn_pos_x,viewport_size.y - 1)
	var spawn_y_left = Vector2(1,spawn_pos_y)
	var spawn_y_right = Vector2(viewport_size.x - 1,spawn_pos_y)
	
	spawnling.top_level = true
	spawnling.global_position = global_position
	
	spawnling.global_position = [spawn_x_bottom, spawn_x_top, spawn_y_left, spawn_y_right].pick_random()
	Events.added_asteroid.emit()

func stop_spawning():
	timer.stop()

func _on_timer_timeout():
	spawn()
	spawned_asteroids += 1

func spawn_new_asteroid(asteroid_scale, asteroid_position):
	asteroids_alive = get_tree().get_nodes_in_group("Asteroids").size()
	asteroids_alive -= 1
	var asteroid1 = spawnling_scene.instantiate()
	var asteroid2 = spawnling_scene.instantiate()
	
	asteroid1.top_level = true
	asteroid1.scale = asteroid_scale/2
	
	asteroid2.top_level = true
	asteroid2.scale = asteroid_scale/2
	
	if asteroid1.scale > Vector2(0.5, 0.5) or asteroid1.scale > Vector2(0.25,0.25):
		add_child(asteroid1)
		add_child(asteroid2)
		asteroids_alive = get_tree().get_nodes_in_group("Asteroids").size()
		asteroid1.global_position = asteroid_position 
		asteroid2.global_position = asteroid_position 
		Events.added_asteroid.emit()
	
	asteroids_cleared()

func asteroids_cleared():
	if asteroids_alive == 0:
		asteroid_limit += 2
		spawned_asteroids = 0
		timer.start()
		
		asteroids_alive = asteroid_limit

