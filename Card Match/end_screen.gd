extends Node2D

@onready var high_score_label: Label = %HighScoreLabel
@onready var score_label: Label = %ScoreLabel

func _ready() -> void:
	score_label.text = 'Score : ' + str(SignalBus.score)

func _on_replay_button_pressed() -> void:
	get_tree().change_scene_to_file("res://world.tscn")

func _on_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://start_screen.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
