extends Node2D

signal exit_room(bangunan, pos)

#@export var namaBuilding: String

var pos
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
		exit_room.emit(self, pos)
