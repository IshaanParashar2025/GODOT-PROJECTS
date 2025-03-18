extends CenterContainer

@onready var retry = $VBoxContainer/Retry
@onready var victory = %Victory

func _ready():
		retry.grab_focus()


func _on_button_pressed():
	get_tree().change_scene_to_file("res://level.tscn")



func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://start_menu.tscn")

func change_victory_text():
	print("loss")

