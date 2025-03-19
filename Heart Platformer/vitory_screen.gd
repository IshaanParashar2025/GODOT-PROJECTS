extends CenterContainer
@onready var main_menu_button = %MainMenuButton

func _ready():
	LevelTransition.fade_from_black()
	main_menu_button.grab_focus()

func _on_button_pressed():
	get_tree().change_scene_to_file("res://Heart-Platformer-Godot-4-main/start_menu.tscn")
