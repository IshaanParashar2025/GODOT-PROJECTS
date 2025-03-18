extends Label

func _ready() -> void:
	SignalBus.current_score.connect(change_score_on_display.bind())

func change_score_on_display(new_score):
	text = str(new_score)
