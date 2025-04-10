extends CharacterBody2D



@export var movement_data : PlayerMovementData

var air_jump = false 
var dash_available = true
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var gravity_activated = true

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var coyote_jump_timer = $CoyoteJumpTimer
@onready var starting_position = global_position
@onready var gravity_timer = $GravityTimer
@onready var dash_timer = $DashTimer



func _physics_process(delta):
	
	
	var input_axis = Input.get_axis("move_left", "move_right")
	handle_dash(input_axis)
	apply_gravity(delta)
	handle_jump()
	handle_wall_jump()
	handle_air_acceleration(input_axis, delta)
	handle_acceleration(input_axis, delta)
	apply_friction(input_axis, delta)
	apply_air_resistance(input_axis, delta)

	
	var was_on_floor = is_on_floor()
	
	move_and_slide()
	
	var just_left_ledge = was_on_floor and not is_on_floor() and velocity.y >= 0
	if just_left_ledge:
		coyote_jump_timer.start()
	update_anims(input_axis)

func apply_gravity(delta):
	if not is_on_floor():
		if gravity_activated == true:
			velocity.y += gravity *movement_data.gravity_scale * delta 

func handle_wall_jump():
	if not is_on_wall_only(): return
	var wall_normal = get_wall_normal()
	if Input.is_action_just_pressed("ui_left") and wall_normal == Vector2.LEFT:
		velocity.x = wall_normal.x * movement_data.speed
		velocity.y = movement_data.jump_velocity
	if Input.is_action_just_pressed("ui_right") and wall_normal == Vector2.RIGHT:
			velocity.x = wall_normal.x * movement_data.speed
			velocity.y = movement_data.jump_velocity

func handle_jump():
	if is_on_floor():
		air_jump = true
	if  is_on_floor() or coyote_jump_timer.time_left > 0.0:
		if Input.is_action_pressed("jump") :
			velocity.y = movement_data.jump_velocity 
			coyote_jump_timer.stop()
	else:
		if Input.is_action_just_released("jump") and velocity.y < movement_data.jump_velocity/2:
			velocity.y = movement_data.jump_velocity / 2
		if Input.is_action_just_pressed("jump") and air_jump:
			velocity.y = movement_data.jump_velocity * 0.8
			air_jump = false

func apply_friction(input_axis, delta):
	if input_axis == 0 and is_on_floor():
		velocity.x = move_toward(velocity.x, 0, movement_data.fricion * delta)

func apply_air_resistance(input_axis, delta):
	if input_axis != 0 and not is_on_floor():
		velocity.x = move_toward(velocity.x, 0, movement_data.air_resistance * delta)

func handle_acceleration(input_axis, delta):
	if not is_on_floor(): return
	if input_axis:
		velocity.x = move_toward(velocity.x, movement_data.speed * input_axis, movement_data.acceleration * delta)

func handle_air_acceleration(input_axis, delta):
	if is_on_floor(): return
	if input_axis != 0:
		velocity.x = move_toward(velocity.x, movement_data.speed  * input_axis, movement_data.air_acceleration * delta)

func update_anims(input_axis):
	if input_axis != 0:
		animated_sprite_2d.flip_h = (input_axis < 0)
		animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("idle")
	if not is_on_floor():
		animated_sprite_2d.play("jump")

func handle_dash(input_axis):
	if is_on_floor():
		dash_available = true
	if not is_on_floor() and Input.is_action_just_pressed("dash") and input_axis != 0 and dash_available:
		gravity_activated = false
		dash_available = false
		velocity.y = 0
		velocity.x = movement_data.dash_speed * input_axis
		gravity_timer.start()
		dash_timer.start()


func _on_hazard_detector_area_entered(area):
	global_position = starting_position



func _on_gravity_timer_timeout():
	gravity_activated = true

func _on_dash_timer_timeout():
	velocity.x = 0
