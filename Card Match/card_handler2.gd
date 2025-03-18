extends Node2D

var first_card = 0
var second_card = 1
var card_array: Array = []
var shapes_for_matched_cards: Array = ['heart', 'heart', 'diamond', 'diamond', 'star', 'star', 'bolt', 'bolt', 'hexagon', 'hexagon', 'new_star', 'new_star']
var pairs_matched = 0

func _ready() -> void:
	randomize()
	SignalBus.revealed.connect(check_if_a_card_is_selected.bind())
	
	index_cards()
	
	create_matches()
	
	give_shapes_to_cards()
	print(card_array)

func check_if_a_card_is_selected(card: Node2D):
	if first_card is Node2D:
		second_card = card 
		if second_card == first_card:
			second_card = 0
			return
		compare_cards()
		
	else:
			first_card = card
	


func index_cards():
	for card in get_children():
		if card is Node2D:
			card_array.append(card)


func create_matches():
	card_array.shuffle()

func compare_cards():
	for x in range(len(card_array)):
		if first_card == card_array[x]:
			if x % 2 == 0:
				if second_card == card_array[x+1]:
					cards_mathced()
					return
				else:
					cards_do_not_match()
					return
			else:
				if second_card == card_array[x-1]:
					cards_mathced()
					return
				else:
					cards_do_not_match()
					return

func cards_mathced():
	pairs_matched += 1
	SignalBus.score_increased.emit()
	
# stops card from being selected
	first_card.is_card_matched()
	second_card.is_card_matched()
	clear_cards()
	if pairs_matched == 6:
		game_finished()
	print("match")

func cards_do_not_match():
	pause_other_cards(first_card, second_card)
	await get_tree().create_timer(0.5).timeout
	unpause_other_cards(first_card, second_card)
	SignalBus.score_decreased.emit()
	first_card.hide_card()
	second_card.hide_card()
	clear_cards()
	
	print("no match")

func clear_cards():
	
	first_card = 0
	second_card = 1

func pause_other_cards(y:Node2D, z: Node2D):
	for x in range(len(card_array)):
		if y != card_array[x] or z != card_array[x]:
			card_array[x].pause_card()


func unpause_other_cards(y : Node2D, z : Node2D):
	for x in range(len(card_array)):
		if y != card_array[x] or z != card_array[x]:
			card_array[x].unpause_card()

func give_shapes_to_cards():
	for x in range(len(card_array)):
		card_array[x].give_shape_to_this_card(shapes_for_matched_cards[x]) 

func game_finished():
	get_tree().change_scene_to_file("res://end_screen.tscn")
