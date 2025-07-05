extends Node

@onready var levels : Array = ["res://main.tscn","res://level_1.tscn","res://level_2.tscn"]
var level_no := 0
var remaining_targets : int = 0

func _ready() -> void:
	change_level()
	find_targets()
	SignalBus.destroyed.connect(find_targets)


#func _physics_process(delta: float) -> void:
	


func find_targets():
	var children = get_tree().get_nodes_in_group("Target")
	remaining_targets = len(children) - 1
	if remaining_targets == 0:
		change_level()


func change_level():
	if get_children():
		get_child(0).queue_free()
	var level_resource = load(levels[level_no])
	var level = level_resource.instantiate()
	add_child(level)
	level_no += 1
