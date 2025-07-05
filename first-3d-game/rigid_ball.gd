extends RigidBody3D



@onready var spin_timer: Timer = $"Spin Timer"
@onready var player = get_tree().get_first_node_in_group("Player")


var picked := false

var spinning := false
var init_phy_mat : PhysicsMaterial

const BOUNCY_MATERIAL = preload("res://Bouncy_Material.tres")

func _ready() -> void:
	continuous_cd = true

func _physics_process(delta: float) -> void:
	if picked:
		freeze = true
		set_collision_layer_value(1,false) 
		
	_destroy_the_ball()


func _start_spinning():
		spinning = true


func _thrown(throw_dir:Vector3):
	freeze = false
	set_collision_layer_value(1,true) 
	if spinning:
		start_spinning(throw_dir)
		apply_central_impulse(throw_dir * 20)
		apply_torque_impulse(Vector3.FORWARD * 10)
	else:
		apply_central_impulse(throw_dir * 15)


func start_spinning(throw_dir:Vector3):
	spin_timer.start()
	gravity_scale /= 2
	physics_material_override = BOUNCY_MATERIAL
	set_linear_damp_mode(DAMP_MODE_REPLACE)
	linear_damp = 0.0 
	angular_damp = 0.0
	set_angular_damp(DAMP_MODE_REPLACE)
	continuous_cd = true


func _stop_spinning() -> void:
	spinning = false
	gravity_scale = 1
	physics_material_override = init_phy_mat
	set_linear_damp_mode(DAMP_MODE_COMBINE)
	linear_damp = 1.0 
	angular_damp = 1.0
	set_angular_damp(DAMP_MODE_COMBINE)
	continuous_cd = false


func _destroy_the_ball():
	if global_position.distance_to(player.global_position) > 50:
		queue_free()
