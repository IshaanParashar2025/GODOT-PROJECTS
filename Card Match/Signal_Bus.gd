extends Node

var score: int

signal revealed(card: Node2D)
signal score_increased
signal score_decreased
signal current_score(score: int)

func _ready() -> void:
	current_score.connect(change_score.bind())

func change_score(new_score):
	score = new_score
