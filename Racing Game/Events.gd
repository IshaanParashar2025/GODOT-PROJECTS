extends Node


var p1_check_points = 0
var p2_check_points = 0
var p1_laps = 0
var p2_laps = 0

signal check_point_cleared(player_check)
signal check_point_cleared_p1
signal check_point_cleared_p2
signal lap_done_signal_car(player_check)
signal p1_lap_done
signal p2_lap_done
signal reset_check_points_p1
signal reset_check_points_p2
signal end_game

func _ready():
	check_point_cleared_p1.connect(check_points_cleared_p1)
	check_point_cleared_p2.connect(check_points_cleared_p2)
	p1_lap_done.connect(lap_p1)
	p2_lap_done.connect(lap_p2)


func check_points_cleared_p1():
	p1_check_points += 1
	print("p1 ",p1_check_points)
	print("p2 ",p2_check_points)

func check_points_cleared_p2():
	p2_check_points += 1
	print("p1 ",p1_check_points)
	print("p2 ",p2_check_points)

func lap_p1():
	p1_check_points = 0
	p1_laps += 1
	if p1_laps == 3:
		end_game.emit()
	else:
		print("fin")
		reset_check_points_p1.emit()

func lap_p2():
	p2_check_points = 0
	p2_laps += 1
	if p2_laps == 3:
		end_game.emit()
	else:
		print("fin")
		reset_check_points_p2.emit()
