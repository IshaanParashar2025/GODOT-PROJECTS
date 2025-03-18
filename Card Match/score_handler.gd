extends Node2D

var score : int = 0
var streak: bool = false
var score_increment = 20

func _ready() -> void:
	SignalBus.score_increased.connect(increase_score)
	SignalBus.score_decreased.connect(decrease_score)

func increase_score():
	if streak == true:
		score_increment += 10
	else:
		score_increment = 20
	
	streak = true
	score += score_increment
	SignalBus.current_score.emit(score)
	print('score : ' + str(score))

func decrease_score():
	score -= 5
	print('score : ' + str(score))
	streak = false
	SignalBus.current_score.emit(score)
