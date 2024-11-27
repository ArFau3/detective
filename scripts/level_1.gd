extends Node2D

@onready var house_1: Node2D = $Room/InteriorHouse1
@onready var building: Node2D = $Building
@onready var room: Node2D = $Room
@onready var map_1: Node2D = $Map1
@onready var player:CharacterBody2D = get_node("../Player")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
#	pindahkan map ruangan saat tidak dimasuki
	house_1.position = Vector2(1500,1500) 
	
#	connect signal building ke main
	for i in building.get_children():
		i.enter_room.connect(_on_house_enter_room)
		
#	connect interior for exit to main
	for i in room.get_children():
		i.exit_room.connect(_on_house_exit_room)
		
func _on_house_enter_room(type: Variant, filler: Variant) -> void:
	if type == "house" and !filler:
		house_1.pos = player.global_position
		player.global_position = house_1.get_node("Enter").position
		house_1.position = Vector2(0,0)
		
		map_1.position = Vector2(1500,1500)
		building.position = Vector2(1500,1500)
	elif type == "bisnis":
		print_debug("masuk bisnis")

func _on_house_exit_room(bangunan: Variant, pos: Variant) -> void:
	player.global_position = pos
	bangunan.position = Vector2(1500,1500)
	
	map_1.position = Vector2(0,0)
	building.position = Vector2(0,0)
