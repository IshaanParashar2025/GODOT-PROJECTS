extends Node2D

@onready var view_port = get_viewport_transform()

func _ready():
	RenderingServer.set_default_clear_color(Color.BLACK)
