extends Area2D

var check_point_active_p1 = true
var check_point_active_p2 = true

func _ready():
	Events.reset_check_points_p1.connect(reactivate_check_points_p1)
	Events.reset_check_points_p2.connect(reactivate_check_points_p2)

func _on_area_entered(area):
	var player_check = area.get_parent().player_control.player_check
	if check_point_active_p1 == true and player_check == "P1_passed":
		print("at cp ", player_check)
		Events.check_point_cleared.emit(player_check)
		check_point_active_p1 = false
	if check_point_active_p2 == true and player_check == "P2_passed":
		print("at cp ", player_check)
		Events.check_point_cleared.emit(player_check)
		check_point_active_p2 = false

func reactivate_check_points_p1():
	check_point_active_p1 = true


func reactivate_check_points_p2():
	check_point_active_p2 = true
