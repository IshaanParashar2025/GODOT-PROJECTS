extends Control

@onready var start = $VBoxContainer/start


func _ready():
	RenderingServer.set_default_clear_color(Color.BLACK)
	start.grab_focus()
	

func _on_start_pressed():
	get_tree().change_scene_to_file("res://level.tscn")


func _on_quit_pressed():
	get_tree().quit()
