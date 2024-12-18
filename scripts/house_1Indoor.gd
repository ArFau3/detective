extends Node2D

signal exit_room(bangunan, pos)

#@export var items: Array[PackedScene]

@onready var replaceable_items: Node2D = $ReplaceableItems
@onready var slot_item := $ReplaceableItems.get_children()
@onready var random_items: Node2D = $RandomItems

var pos: Vector2
var canExit: bool

func _ready() -> void:
	canExit = false

func _on_pintu_keluar_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		canExit = true

func _on_pintu_keluar_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		canExit = false

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact") and canExit:
		reset_interior()
		exit_room.emit(self, pos)

func setting_interior(items:Array[PackedScene])->void:
	for i in items:
		if !i: continue
#		Siapkan slot
		var lokasi = slot_item.pick_random()
		slot_item.erase(lokasi)
		
#		Instanctiate barang
		var item = i.instantiate()
		item.global_position = lokasi.global_position
		random_items.add_child(item)
		
func reset_interior()->void:
	slot_item = replaceable_items.get_children()
	
#	queue free item
	for i in random_items.get_children():
		i.queue_free()
