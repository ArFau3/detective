extends Control

signal UiClose
signal openUiLockpick(level)

@export var playerInv:Inventory

@onready var nama: RichTextLabel = $NinePatchRect/Nama
@onready var deskripsi: RichTextLabel = $NinePatchRect/Deskripsi
@onready var next: Button = $Next
@onready var previous: Button = $Previous
@onready var simpan: Button = $NinePatchRect/Simpan
@onready var use: Button = $NinePatchRect/Use

var items: Array
var indexItem: int

func _ready() -> void:
	next.visible = false
	previous.visible = false
		
func _on_close_pressed() -> void:
	next.visible = false
	previous.visible = false
	UiClose.emit()
	
	if !simpan.visible:
		simpan.visible = true
	
func _on_simpan_pressed() -> void:
	playerInv.insert(items[indexItem].data)
	items[indexItem].queue_free()
	
	if items.size() ==1:
		_on_close_pressed()
	else:
		items.remove_at(indexItem)
		proses_items(items)

func proses_items(item:Array, isInInv:bool = false):
	items = item
	indexItem = 0
	display_item()
	use.visible = false
	if item.size() > 1:
		next.visible = true
		previous.visible = true
	else:
		next.visible = false
		previous.visible = false
	
	if isInInv:
		simpan.visible = false
		if item[0].data.lockpick > 0:
			use.visible = true
	
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

func _on_use_pressed() -> void:
	openUiLockpick.emit(items[indexItem].data.lockpick)
