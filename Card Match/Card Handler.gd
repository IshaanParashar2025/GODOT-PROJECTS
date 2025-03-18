extends Node2D

var first_card
var second_card
var card_array: Array = []
var card_array_copy : Array = []
var match_1 = []
var match_2 = []
var match_3 = []
var match_4 = []

func _ready() -> void:
	SignalBus.revealed.connect(check_if_a_card_is_selected.bind())
	
	index_cards()
	
	create_matches()
	

func check_if_a_card_is_selected(card: Node2D):
	if first_card is Node2D:
		second_card = card 
		
	else:
		first_card = card
	print(first_card)
	print(second_card)

func compare_cards():
	pass

func index_cards():
	for card in get_children():
		card_array.append(card)
		
	card_array_copy += card_array

func create_matches():
	for x in card_array_copy:
		
		var match_card
		
		card_array_copy.erase(x) 
		
		match_card = card_array_copy.pick_random()
		
		if len(match_1) != 2:
			match_1.append(x)
			match_1.append(match_card)
		elif len(match_2) != 2:
			match_2.append(x)
			match_2.append(match_card)
		elif len(match_3) != 2:
			match_3.append(x)
			match_3.append(match_card)
		
		card_array_copy.erase(match_card)
		match_4 = card_array_copy
