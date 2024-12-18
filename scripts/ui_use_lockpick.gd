extends Control

signal closeUiLockpick

@onready var number_input: LineEdit = $NinePatchRect/VBoxContainer/Number/NumberInput
@onready var street_input: LineEdit = $NinePatchRect/VBoxContainer/Street/StreetInput
@onready var city_input: LineEdit = $NinePatchRect/VBoxContainer/City/CityInput
@onready var playerInventory:Inventory = preload("res://player/playerInv.tres")

var level:Node
var city:String
var street:String
var number:String
var type: String
var items: Array[PackedScene]

func proses_question(levelInt:int)->void:
	var levelPath:String = "./Main/Level"+str(levelInt)
	level = get_tree().get_root().get_node(levelPath)
	print_debug(level.places)

func _on_close_pressed() -> void:
	Global.localpickIndex = -1
	closeUiLockpick.emit()

func _on_go_pressed() -> void:
	city = city_input.text.to_upper()
	street = street_input.text.to_upper()
	number = number_input.text.to_upper()
	
	if check_answer():
		return go_to(true)
	else: 
		return go_to(false)
	
func check_answer()->bool:
	for i in level.places:
		if i["city"] == city and i["street"] == street and i["number"] == number: 
			type = i["type"]
			items = i["items"].items
			return true
	return false
		

func go_to(correct:bool)->void:
	playerInventory.delete(Global.localpickIndex)
	Global.localpickIndex = -1
	if correct:
		level._on_house_enter_room(type, items)
	else :
		level._on_house_enter_room("house", [])
