extends CharacterBody2D

var dir_to_move 

func _ready():
	var ball_direction_x: Array = [100, -100, -50, 50, -150, 200] 
	velocity.y = -200
	velocity.x = ball_direction_x.pick_random()
	Events.ball_hit.connect(destroy_ball)

func destroy_ball():
	queue_free()

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		velocity = velocity.bounce(collision.get_normal())
	
#		if collision.get_normal().y > 0:
#			dir_to_move = 1
#		elif collision.get_normal().y < 0:
#			dir_to_move = -1
#		print(collision.get_normal().y)
#		if velocity.y > 500 * dir_to_move:
#			velocity.y = 500  * dir_to_move
#		if velocity.y < 400 * dir_to_move:
#			velocity.y = 400 * dir_to_move
