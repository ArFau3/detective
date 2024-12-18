extends CanvasLayer

@onready var ui_examine: Control = $UIExamine
@onready var ui_player_inventory: Control = $UiPlayerInventory
@onready var ui_shop: Control = $UiShop
@onready var ui_chat: Control = $UiChat
@onready var ui_use_lockpick: Control = $UiUseLockpick
@onready var ui_aswer: Control = $UiAswer

var isUiEximineOpen: bool
var isUiAnswerOpen: bool
var isUiShopOpen: bool
var isUiInventoryOpen: bool
var isUiChatOpen: bool
var isUiLockpickOpen: bool
var juggleUiInvExamine: bool

func _on_player_interacting(item: Variant, isInInv: bool = false) -> void:
	if !isUiEximineOpen:
		isUiEximineOpen = true
		await ui_examine.proses_items(item, isInInv)
		ui_examine.visible = true
		get_tree().paused = true
		
	if isInInv:
		juggleUiInvExamine = true
		ui_player_inventory._on_close_pressed()

func _on_ui_examine_ui_close() -> void:
	if isUiEximineOpen:
		get_tree().paused = false
		isUiEximineOpen = false
		ui_examine.visible = false
	
	if juggleUiInvExamine:
		juggleUiInvExamine = false
		ui_player_inventory.visible = true
		isUiInventoryOpen = true
		get_tree().paused = true

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("inventory") :
		if !isUiInventoryOpen:
			open_inventory()
		else:
			ui_player_inventory._on_close_pressed()

func open_inventory()->void:
	if !isUiInventoryOpen:
		ui_player_inventory.visible = true
		ui_player_inventory.setting_inventory()
		isUiInventoryOpen = true
		get_tree().paused = true
	
func _on_ui_player_inventory_close_inv() -> void:
	if isUiInventoryOpen:
		get_tree().paused = false
		isUiInventoryOpen = false
		ui_player_inventory.visible = false

func open_shop_ui(items:Inventory) -> void:
	isUiShopOpen = true
	await ui_shop.proses_shop(items)
	ui_shop.visible = true
	get_tree().paused = true

func _on_ui_shop_ui_shop_close() -> void:
	if isUiShopOpen:
		get_tree().paused = false
		isUiShopOpen = false
		ui_shop.visible = false

func open_ui_chat(npc)-> void:
	isUiChatOpen = true
	await ui_chat.proses_chat(npc)
	ui_chat.visible = true
	get_tree().paused = true

func _on_ui_chat_close_chat() -> void:
	if isUiChatOpen:
		get_tree().paused = false
		isUiChatOpen = false
		ui_chat.visible = false

func _on_ui_examine_open_ui_lockpick(level) -> void:
	isUiLockpickOpen = true
	await ui_use_lockpick.proses_question(level)
	ui_use_lockpick.visible = true
	get_tree().paused = true

func _on_ui_use_lockpick_close_ui_lockpick() -> void:
	if isUiLockpickOpen:
		get_tree().paused = false
		isUiLockpickOpen = false
		ui_use_lockpick.visible = false

func open_answer(level)->void:
	isUiAnswerOpen = true
	await ui_aswer.proses_question(level)
	ui_aswer.visible = true
	get_tree().paused = true

func _on_ui_aswer_close_answer() -> void:
	if isUiAnswerOpen:
		get_tree().paused = false
		isUiAnswerOpen = false
		ui_aswer.visible = false

func reset_ui()->void:
	get_tree().paused = false
	
	ui_chat.visible = false
	isUiChatOpen = false
	ui_examine.visible = false
	isUiEximineOpen = false
	ui_player_inventory.visible = false
	isUiInventoryOpen = false
	ui_shop.visible = false
	isUiShopOpen = false
	ui_use_lockpick.visible = false
	isUiLockpickOpen = false

func _on_ui_aswer_pick_item() -> void:
	open_inventory()

func _on_ui_player_inventory_submit_item(item: Variant) -> void:
	ui_aswer.setting_answer(item)
