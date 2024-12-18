extends Control

signal close_inv()
signal examiningItem(item, inInv)
signal submitItem(item)

@export var playerInventory: Inventory

@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
@onready var slotGuiClass = preload("res://UI/inventory_panel.tscn")
@onready var delete_item: Button = $NinePatchRect/DeleteItem
@onready var confirmation_dialog: ConfirmationDialog = $ConfirmationDialog
@onready var gold: RichTextLabel = $NinePatchRect/HBoxContainer/Gold

var indexItem: int = -1

func _ready() -> void:
	connect_buttons()
	delete_item.self_modulate = Color(1, 0.5, 0.5)
	playerInventory.updated.connect(update)
	update()

func update():
	delete_item.self_modulate = Color(1, 0.5, 0.5)
	indexItem = -1
	gold.text = str(Global.gold)
	#looping jumlah slot di playerBackpack.tres dan ninePatchRect
	for i in range(min(playerInventory.Items.size(), slots.size())):
		var itemData:Item = playerInventory.Items[i]
		if !itemData: continue #skip jika slot[i] Buildings.tres tidak ada data BuildingData
		#buildingSlotGui = displayer untuk data building per slot
		var itemSlotGui: InventoryGui = slots[i].slotGui
#-----------------------------------
		if !itemData.name and slots[i].slotGui:
			slots[i].reset_ui() 
			continue
		#if playerBackpack.backpackSlot[i].amount == 0:
			#if buildingSlotGui :
				#slots[i].reset_ui()
			#else: continue
#-----------------------------------
		if !itemSlotGui and itemData.name:
			itemSlotGui = slotGuiClass.instantiate()
			slots[i].insert(itemSlotGui) #insert data buildingData ke buildingSlotGui
		
		#tampilkan data ke buildingSlotGui
		if slots[i].slotGui and itemData.name:
			itemSlotGui.data = itemData
			itemSlotGui.update()

func _on_close_pressed() -> void:
	delete_item.visible = true
	delete_item.self_modulate = Color(1, 0.5, 0.5)
	indexItem = -1
	close_inv.emit()
	
func connect_buttons()-> void:
	for i in range(slots.size()):
		var slot = slots[i]
		slot.index = i
		slot.item_clicked.connect(_on_slot_inventory_item_clicked)
		slot.examining_item.connect(_on_slot_inventory_examining_item)

func _on_slot_inventory_item_clicked(button: Variant) -> void:
	if button.slotGui:
		if Global.game_mode == Global.GAMEMODE.ANSWER:
			submitItem.emit(button.slotGui.data)
			_on_close_pressed()
		
		delete_item.self_modulate = Color(1, 1, 1)
		indexItem = button.index
	else:
		delete_item.self_modulate =  Color(1, 0.5, 0.5)
		indexItem = -1

func setting_inventory()->void:
	gold.text = str(Global.gold)
	if Global.game_mode == Global.GAMEMODE.ANSWER:
		delete_item.visible = false

func _on_delete_item_pressed() -> void:
	if indexItem >= 0:
		confirmation_dialog.visible = true

func _on_confirmation_dialog_confirmed() -> void:
	var item: Item = playerInventory.Items[indexItem]
	
	if !item: return #TODO: pesan kesalahan
	if item.isImportant:
		Global.pemulung_ambil_item(item)

	playerInventory.delete(indexItem)

func _on_confirmation_dialog_canceled() -> void:
	delete_item.self_modulate = Color(1, 0.5, 0.5)
	indexItem = -1

func _on_slot_inventory_examining_item(item: Variant) -> void:
	examiningItem.emit(item, true)
