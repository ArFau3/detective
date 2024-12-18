extends Node

@onready var pemulungInv: Inventory = preload("res://npc/pemulungInventory.tres")
enum GAMEMODE {
	NORMAL,
	ANSWER,
}

var localpickIndex: int
var gold: int = 0
var game_mode = GAMEMODE.NORMAL

func pemulung_ambil_item(data: Item)-> void:
	pemulungInv.insert_pemulung(data)
	print_debug(pemulungInv.Items[pemulungInv.Items.size()-1])

func _ready() -> void:
	game_mode = GAMEMODE.NORMAL
