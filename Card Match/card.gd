extends Node2D
#check if card is already matched then make sure is is not selectable 

@onready var card_front: Sprite2D = %"Card Front"
@onready var card_back: Sprite2D = %"Card Back"
@onready var area_2d: Area2D = $Area2D

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("left_click"):
		card_back.visible = true
		SignalBus.revealed.emit(self)

func hide_card():
	card_back.visible = false

func pause_card():
	get_tree().paused = true

func unpause_card():
	get_tree().paused = false

# disconnects the card's area 2d so it can't be selected as a card if it is matched
# only called when it is matched
func is_card_matched():
	area_2d.input_event.disconnect(_on_area_2d_input_event)

func give_shape_to_this_card(shape:String):
	if shape == 'heart':
		card_back.texture = preload("res://Assets/Card Back Hearts.png")
	if shape == 'star':
		card_back.texture = preload("res://Assets/Card Back Star.png")
	if shape == 'diamond':
		card_back.texture = preload("res://Assets/Card Back Diamond.png")
	if shape == 'bolt':
		card_back.texture = preload("res://Assets/Card Back Bolt.png")
	if shape == 'hexagon':
		card_back.texture = preload("res://Assets/Card Back Hexagon.png")
	if shape == 'new_star':
		card_back.texture = preload("res://Assets/Card Back New Star.png")
