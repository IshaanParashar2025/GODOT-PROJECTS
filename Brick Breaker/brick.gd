extends StaticBody2D




func _on_area_2d_body_entered(body):
	print("hit")
	queue_free()
	Events.brick_break.emit()
