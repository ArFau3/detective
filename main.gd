extends Node2D

@onready var canvas_layer: CanvasLayer = $CanvasLayer

func reset_ui()->void:
	canvas_layer.reset_ui()
