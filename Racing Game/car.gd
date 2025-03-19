extends CharacterBody2D

@export var player_control: Resource
#@onready var player1_controls = preload("res://Player1_Controls.tres")
#@onready var player2_controls = preload("res://Player2_controls.tres")

var engine_power = 900
var acceleration = Vector2.ZERO
var wheel_base = 70.0
var turn_direction
var steering_angle = 15
var friction = -55
var drag = -0.06
var braking = -450
var max_speed_reverse = 250
var slip_speed = 200
var traction_dast = 0.5
var traction_slow = 10

func _ready():
	Events.check_point_cleared.connect(check_point_cleared)
	Events.lap_done_signal_car.connect(lap_complete)

func _physics_process(delta):
	acceleration = Vector2.ZERO
	get_player_input(delta)
	apply_friction(delta)
	calculate_steering(delta)
	
	velocity += acceleration * delta
	move_and_slide()

func get_player_input(delta):
	player_control.player_index_x = Input.get_axis(player_control.move_left,player_control.move_right)
	player_control.player_index_y = Input.get_axis(player_control.move_down, player_control.move_up)
	turn_direction = deg_to_rad(steering_angle) * player_control.player_index_x
	if player_control.player_index_y == 1:
		acceleration = transform.x * engine_power
	if player_control.player_index_y == -1:
		acceleration = transform.x * braking


func calculate_steering(delta):
	var rear_wheel = position - transform.x * wheel_base / 2.0
	var front_wheel = position + transform.x * wheel_base / 2.0
	rear_wheel += velocity * delta
	front_wheel += velocity.rotated(turn_direction) * delta
	var new_heading = rear_wheel.direction_to(front_wheel)
	var d = new_heading.dot(velocity.normalized())
	var traction = traction_slow
	if velocity.length() > slip_speed:
		traction = traction_dast
	if d > 0:
		velocity = lerp(velocity, new_heading * velocity.length(), traction * delta)
	if d < 0:
		velocity = -new_heading * min(velocity.length(), max_speed_reverse)
	rotation = new_heading.angle()
	


func apply_friction(delta):
	if acceleration == Vector2.ZERO and velocity.length() < 50:
		velocity = Vector2.ZERO
	var friction_force = velocity * friction * delta
	var drag_force = velocity * velocity.length() * drag * delta
	acceleration += drag_force + friction_force

func check_point_cleared(player_check):
	if player_check == "P1_passed" and player_check == player_control.player_check:
		print("p1 emitted")
		Events.check_point_cleared_p1.emit()
	if player_check == "P2_passed" and player_check == player_control.player_check:
		print("p2 emitted")
		Events.check_point_cleared_p2.emit()

func lap_complete(player_check):
	if player_check == "P1_passed" and player_check == player_control.player_check:
		Events.p1_lap_done.emit()
	if player_check == "P2_passed" and player_check == player_control.player_check:
		Events.p2_lap_done.emit()

