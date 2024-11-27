extends Camera2D

@export var player: CharacterBody2D
# Called when the node enters the scene tree for the first time.
var zoomSpeed: float = 0.07
var zoomMin: float = 1
var zoomMax: float = 4.5
var dragSens: float = 0.4

func _ready():
	zoom.x = 2.7
	zoom.y = 2.7
	limit_top = 0
	limit_left = 0

func scene_changed(tilemap:TileMap):
	var napRect = tilemap.get_used_rect()
	var tileSize = tilemap.cell_quadrant_size
	var worldSizeInPixel = napRect.size * tileSize
	limit_right = worldSizeInPixel.x
	limit_bottom = worldSizeInPixel.y

func _input(event):
	#if event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		#position -= event.relative * dragSens / zoom
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom += Vector2(zoomSpeed, zoomSpeed)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom -= Vector2(zoomSpeed, zoomSpeed)
		zoom = clamp(zoom, Vector2(zoomMin, zoomMin), Vector2(zoomMax, zoomMax))
