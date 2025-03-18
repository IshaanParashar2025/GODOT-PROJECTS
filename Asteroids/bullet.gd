extends CharacterBody2D

var bullet_dir = Vector2.RIGHT 
var bullet_speed:float = 700.0
@onready var timer = $Timer
@onready var viewport = get_viewport_rect().size

func _ready():
	Events.signal_bullet_rotation.connect(fire)
	timer.start()


func _physics_process(delta):
	wrap_asteroid()
	move_and_slide()

func fire(ship_rotation):
	rotate(ship_rotation)
	bullet_dir = bullet_dir.rotated(ship_rotation)
	velocity = bullet_dir * bullet_speed 
	Events.signal_bullet_rotation.disconnect(fire)

func wrap_asteroid():
	global_position.x = wrapf(global_position.x, 0, viewport.x)
	global_position.y = wrapf(global_position.y, 0, viewport.y)

func _on_timer_timeout():
	queue_free()



func _on_area_2d_area_entered(area):
	queue_free()
