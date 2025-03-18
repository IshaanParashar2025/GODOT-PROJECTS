extends Control

@onready var v_box_container: VBoxContainer = $VBoxContainer

@onready var button: Button = %Button
@onready var button_2: Button = %Button2
@onready var button_3: Button = %Button3
@onready var button_4: Button = %Button4
@onready var button_5: Button = %Button5
@onready var button_6: Button = %Button6
@onready var button_7: Button = %Button7
@onready var button_8: Button = %Button8
@onready var top_card_layer_h_box_container: HBoxContainer = $VBoxContainer/TopCardLayerHBoxContainer
@onready var bottom_card_layer_h_box_container: HBoxContainer = $VBoxContainer/BottomCardLayerHBoxContainer

var button_array: Array = []

func _ready() -> void:
	#for card : Button in top_card_layer_h_box_container.get_children():
		#if card != Button:
			#continue
		#button_array.append(card)
	#for card : Button in bottom_card_layer_h_box_container.get_children():
		#button_array.append(card)
	for child in v_box_container.get_children():
		for card in child.get_children():
			if card is Button:
				button_array.append(card)
	
	print(button_array)


func reveal() -> void:
	pass
