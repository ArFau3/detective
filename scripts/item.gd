extends Area2D

class_name PickableItem

@export var data:Item = preload("res://interactables/items/knifeW.tres")
@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	sprite_2d.texture = data.texture
