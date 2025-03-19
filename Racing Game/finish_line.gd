extends Area2D




func _on_area_entered(area):
	var player_check = area.get_parent().player_control.player_check
	if Events.p1_check_points == 3 or  Events.p2_check_points == 3:
		Events.lap_done_signal_car.emit(player_check)


