extends Control

signal UiClose

@export var playerInv:Inventory

@onready var nama: RichTextLabel = $NinePatchRect/Nama
@onready var deskripsi: RichTextLabel = $NinePatchRect/Deskripsi
@onready var next: Button = $Next
@onready var previous: Button = $Previous

var items: Array
var indexItem: int

func _ready() -> void:
	next.visible = false
	previous.visible = false
		
func _on_close_pressed() -> void:
	next.visible = false
	previous.visible = false
	UiClose.emit()
	
func _on_simpan_pressed() -> void:
	pass # Replace with function body.

func proses_items(item:Array):
	items = item
	indexItem = 0
	display_item()
	if item.size() > 1:
		next.visible = true
		previous.visible = true
	
func _on_next_pressed() -> void:
	if(indexItem == items.size() - 1):
		indexItem = 0
	else:
		indexItem += 1
	display_item()

func _on_previous_pressed() -> void:
	if(indexItem == 0):
		indexItem = items.size() - 1
	else:
		indexItem -= 1
	display_item()

func display_item() -> void:
	nama.text = items[indexItem].data.name
	deskripsi.text = items[indexItem].data.description
