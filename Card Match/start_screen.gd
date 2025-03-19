extends Node2D

@onready var start_button: Button = %StartButton
@onready var quit_button: Button = %QuitButton

func _ready() -> void:
	RenderingServer.set_default_clear_color(Color.BLACK)


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://world.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()
