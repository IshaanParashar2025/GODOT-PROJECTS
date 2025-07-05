extends CharacterBody3D

@export var speed : int = 8
@export var target_gravity :int = 100


@export var mouse_sensitivity : float = 0.5
@export var TILT_LOWER_LIMIT := deg_to_rad(-90.0)
@export var TILT_UPPER_LIMIT := deg_to_rad(90.0)

@export var CAMERA_CONTOLLER : Camera3D 
@export var hand_marker : Marker3D
@export var ball : PackedScene



@onready var aim_cast: RayCast3D = $Node3D/Camera3D/AimCast

var rot_x = 0
var rot_y = 0
var target_velocity = Vector3.ZERO

var mouse_rotation : Vector3
var mouse_input : bool = false
var rotation_input : float
var mouse_tilt : float 

var player_rotaion : Vector3
var camera_rotation : Vector3

var object_in_hand : Node3D

signal Object_thrown

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("exit"):
		get_tree().quit()
	if event.is_action_pressed("Spin") and object_in_hand:
		object_in_hand._start_spinning()
	if event.is_action_pressed("spawn_ball"):
		spawn_ball()


func _unhandled_input(event: InputEvent) -> void:
	mouse_input = event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	if mouse_input:
		rotation_input = -event.relative.x * mouse_sensitivity
		mouse_tilt = -event.relative.y * mouse_sensitivity
	


func _physics_process(delta: float) -> void:
	
	target_velocity = Vector3.ZERO
	
	if Input.is_action_pressed("move_forward"):
		target_velocity += transform.basis.z
	if Input.is_action_pressed("move_back"):
		target_velocity += -transform.basis.z 
	if Input.is_action_pressed("move_left"):
		target_velocity += transform.basis.x 
	if Input.is_action_pressed("move_right"):
		target_velocity += -transform.basis.x
	
	
	target_velocity = target_velocity.normalized()
	target_velocity = target_velocity * speed
	
	_pick_object()
	
	if object_in_hand:
		object_in_hand.global_position = hand_marker.global_position
		object_in_hand.global_rotation = global_rotation
	
	
	_drop_object()
	_throw_object()
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		position.y =  lerp(position.y, position.y + 200, 0.5*delta)
		#target_velocity.y = 150
	
		print(target_velocity)
	
	if not is_on_floor():
		target_velocity.y = target_velocity.y - (target_gravity * delta)
	
	_update_camera(delta)
	
	velocity = target_velocity
	move_and_slide() 


func _update_camera(delta):
	mouse_rotation.x += mouse_tilt * delta
	mouse_rotation.x = clamp(mouse_rotation.x, TILT_LOWER_LIMIT, TILT_UPPER_LIMIT)
	mouse_rotation.y += rotation_input * delta
	
	player_rotaion = Vector3(0.0, mouse_rotation.y,0.0)
	camera_rotation = Vector3(mouse_rotation.x,0.0,0.0)
	
	CAMERA_CONTOLLER.transform.basis = Basis.from_euler(camera_rotation)
	CAMERA_CONTOLLER.rotation.z = 0.0
	
	global_transform.basis = Basis.from_euler(player_rotaion)
	
	rotation_input = 0.0
	mouse_tilt = 0.0


#pick object 
func _pick_object():
	
		var collision = aim_cast.get_collider()
		
		if collision:
			if collision.is_in_group("Pickable") and Input.is_action_pressed("interact"):
				print("grab")
				collision.picked = true
				object_in_hand = collision


func _drop_object():
	if object_in_hand and Input.is_action_just_pressed("drop_object"):
		if object_in_hand.is_class("RigidBody3D"):
			object_in_hand.freeze = false
		object_in_hand.apply_central_impulse(Vector3(0,2,0))
		object_in_hand = null


func _throw_object():
	if object_in_hand and Input.is_action_just_pressed("throw_object"):
		var throw_dir = (aim_cast.to_global(aim_cast.target_position) - aim_cast.to_global(Vector3.ZERO)).normalized()
		object_in_hand.picked = false
		object_in_hand._thrown(throw_dir)
		object_in_hand = null


func spawn_ball():
	if not object_in_hand:
		var new_ball = ball.instantiate()
		new_ball.picked = true
		object_in_hand = new_ball
		new_ball.top_level = true
		add_child(new_ball)
		
	
	
