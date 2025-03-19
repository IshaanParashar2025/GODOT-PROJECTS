extends Control

@onready var label = $ColorRect/Label
@onready var hearts_left = get_tree().get_nodes_in_group("Hearts").size()


func _ready():
	label.text = "Hearts: " + str(hearts_left)
	Events.heart_collected.connect(change_heart_count)
	Events.level_completed.connect(hide_count)

func change_heart_count():
	hearts_left -= 1
	label.text = str( "Hearts: ", hearts_left)
	
func hide_count():
	hide()
