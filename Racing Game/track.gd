extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.end_game.connect(game_over)


func game_over():
	get_tree().paused = true
