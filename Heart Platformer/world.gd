extends Node2D

@export var next_level: PackedScene

var level_time = 0.0
var start_level_msec:float = 0.0

@onready var level_completed = $CanvasLayer/LevelCompleted
@onready var start_in = %StartIn
@onready var start_in_label = %StartInLabel
@onready var count_down_player = $CountDownPlayer
@onready var level_timer_label = %LevelTimerLabel



func _ready():
	if not next_level is PackedScene:
		level_completed.next_level_button.text = "GO TO VICTORY SCREEN"
		LevelTransition.fade_to_black()
		next_level = load("res://vitory_screen.tscn")
	
	Events.level_completed.connect(show_level_completed)
	get_tree().paused=true
	start_in.visible = true
	LevelTransition.fade_from_black()
	count_down_player.play("Countdown")
	await count_down_player.animation_finished
	get_tree().paused = false
	start_in.visible = false
	start_level_msec = Time.get_ticks_msec()
	

func _process(delta):
	level_time = Time.get_ticks_msec() - start_level_msec 
	level_timer_label.text = str(level_time/ 1000)
	

func go_to_next_level():
	
	
	await LevelTransition.fade_to_black()
	get_tree().change_scene_to_packed(next_level)
	LevelTransition.fade_from_black()
	get_tree().paused = false

func show_level_completed():
	if not next_level is PackedScene: return
	level_completed.show()
	level_completed.retry_button.grab_focus()
	get_tree().paused = true




func _on_level_completed_nextlevel():
	go_to_next_level()

func _on_level_completed_retry():
	get_tree().reload_current_scene()
