extends StaticBody2D

signal enter_room(type, filler)

@export var type:String
@export var rightPlace: bool

var player: CharacterBody2D

func _ready() -> void:
	player = null

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = body

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = null

func _input(event: InputEvent) -> void:
	if player and Input.is_action_just_pressed("interact"):
		if !player.interactItem:
			enter_room.emit(type, false)
