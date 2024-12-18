extends Control

signal ui_shop_close()

@onready var shop_displayer: VBoxContainer = $NinePatchRect/ScrollContainer/ShopDisplayer
@onready var close: Button = $NinePatchRect/Close
@onready var shopPanelClass = preload("res://UI/shop_panel.tscn")
@onready var playerInventory = preload("res://player/playerInv.tres")
@onready var confirmation_dialog: ConfirmationDialog = $ConfirmationDialog

var shop_panel
var backpack: Inventory

func proses_shop(items: Inventory)->void:
	backpack = items
	
	for item in backpack.Items:
		var shop = shopPanelClass.instantiate()
		shop_displayer.add_child(shop)
		shop.buying.connect(_on_shop_panel_buying)
		shop.data = item
		shop.setting_data()

func _on_close_pressed() -> void:
	reset_ui()
	ui_shop_close.emit()

func reset_ui()->void:
	for i in shop_displayer.get_children():
		i.queue_free()
		
func _on_shop_panel_buying(data: Variant) -> void:
	shop_panel = data
	confirmation_dialog.visible = true

func _on_confirmation_dialog_confirmed() -> void:
	var item = shop_panel.data
	
	backpack.Items.erase(item)
	shop_panel.queue_free()
	
	playerInventory.insert(item)
