extends CharacterBody2D

const ship_speed:float = 100.0
const ship_decelaration:float = 500.0

var input_axis_x:int = 0
var input_axis_y:int = 0
var ship_rotation = 0


@onready var viewport = get_viewport_rect().size

signal ship(rotation)

func _ready():
	Events.destroy_ship.connect(destroy_ship)


func _physics_process(delta):
	get_ship_rotation()
	
	get_input()
	
	player_move()
	
	handle_drift(delta)
	
	wrap_ship()
	
	
	move_and_slide()


func get_input():
	input_axis_x = Input.get_axis("ui_left", "ui_right")
	input_axis_y = Input.get_axis("ui_up", "ui_down")
	if Input.is_action_just_pressed("ui_accept"):
		Events.fire_bullet.emit()
		Events.signal_bullet_rotation.emit(ship_rotation)

func player_move():
	look_at(get_global_mouse_position())
	if input_axis_x != 0:
		velocity.x = input_axis_x * ship_speed 
	if input_axis_y != 0:
		velocity.y = input_axis_y * ship_speed


func handle_drift(delta):
	if input_axis_x == 0 and input_axis_y == 0:
		velocity.x = move_toward(velocity.x, 0, ship_decelaration * delta)
		velocity.y = move_toward(velocity.y, 0, ship_decelaration * delta)
	if input_axis_y == 0:
		pass


func wrap_ship():
	position.x = wrapf(position.x, 0, viewport.x)
	position.y = wrapf(position.y, 0, viewport.y)

func get_ship_rotation():
	ship_rotation = rotation

func destroy_ship():
	queue_free()



func _on_hurt_box_area_entered(area):
	get_tree().reload_current_scene()
