extends Area2D

@onready var pemulungInventory:Inventory = preload("res://npc/pemulungInventory.tres")

var canInteract: bool

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		canInteract = true

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		canInteract = false

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact") and canInteract:
		get_tree().get_root().get_node("./Main/CanvasLayer").open_shop_ui(pemulungInventory)
