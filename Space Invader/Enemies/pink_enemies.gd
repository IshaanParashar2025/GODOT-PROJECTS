extends Enemy

@onready var states: Node = $States

@onready var move_down_state: TimedStateComponent = $States/MoveDownState
@onready var move_side_state: TimedStateComponent = $States/MoveSideState
@onready var pause_state: TimedStateComponent = $States/PauseState
@onready var move_side_component: MoveComponent = $States/MoveSideState/MoveSideComponent
@onready var fire_state: StateComponent = %FireState
@onready var projectile_spawner_component: SpawnerComponent = %ProjectileSpawnerComponent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()
	for state in states.get_children():
		state = state as StateComponent
		state.disable()
	move_side_component.velocity.x = [-20,20].pick_random()
	
	move_down_state.state_finished.connect(move_side_state.enable)
	move_side_state.state_finished.connect(func():
		fire_state.enable()
		scale_component.tween_scale()
		projectile_spawner_component.spawn(global_position)
		fire_state.disable()
		fire_state.state_finished.emit()
		
	)
	fire_state.state_finished.connect(pause_state.enable)
	pause_state.state_finished.connect(move_down_state.enable)
	
	move_down_state.enable()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
