extends Node2D

@onready var houses: Node2D = $Room/Houses
@onready var businesses: Node2D = $Room/Businesses
@onready var buildings: Node2D = $Building
@onready var room: Node2D = $Room
@onready var map_1: Node2D = $Map1
@onready var player:CharacterBody2D = get_node("../Player")

var building
#HACK TYPE:
# house
# bisnis
var places: Array =[
	{
		"city": "NYE",
		"street": "FETO",
		"number": "21",
		"type": "house",
		"items":preload("res://levels/levels/1/21.tres"),
	},
	{
		"city": "NYE",
		"street": "INS",
		"number": "A1",
		"type": "bisnis",
		"items":preload("res://levels/levels/1/A1.tres"),
	},
]
#FIXME: saat use lockpick click interactable amsih mode examine inv, no pick button
#FIXME: saat use lockpick dalam ruangan, ruangan baru ketimpa ruangan lama jadinya setting interior kosong/salaj
var answer: Array =[
	{
		"who": "DRIAN",
		"why": "TO GET REVENGE",
		"how": "BY PUSHED FROM ON TOP OF BUILDING",
		"reward": 100,
	},
]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
#	pindahkan map ruangan saat tidak dimasuki
	for i in houses.get_children():
		i.position = Vector2(1500,1500) 
	for i in businesses.get_children():
		i.position = Vector2(1500,1500) 
	
#	connect signal building ke main
	for i in buildings.get_children():
		i.enter_room.connect(_on_house_enter_room)
		
#	connect interior for exit to main
	for i in houses.get_children():
		i.exit_room.connect(_on_house_exit_room)
	for i in businesses.get_children():
		i.exit_room.connect(_on_house_exit_room)
		
func _on_house_enter_room(type: Variant, items: Variant) -> void:
	if type == "house":
		building = houses.get_children().pick_random()
	elif type == "bisnis":
		building = businesses.get_children().pick_random()

	building.pos = player.global_position
	player.global_position = building.get_node("Enter").position
	building.position = Vector2(0,0)
	
	if items:
		building.setting_interior(items)
	
	map_1.position = Vector2(1500,1500)
	buildings.position = Vector2(1500,1500)
	
	get_tree().get_root().get_node("./Main").reset_ui()

func _on_house_exit_room(bangunan: Variant, pos: Variant) -> void:
	player.global_position = pos
	bangunan.position = Vector2(1500,1500)
	
	map_1.position = Vector2(0,0)
	buildings.position = Vector2.ZERO
	building.position = Vector2(1500,1500)
