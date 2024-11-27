extends CanvasLayer

@onready var ui_examine: Control = $UIExamine

var isUiEximineOpen: bool

func _on_player_interacting(item: Variant) -> void:
	if !isUiEximineOpen:
		isUiEximineOpen = true
		await ui_examine.proses_items(item)
		ui_examine.visible = true
		get_tree().paused = true

func _on_ui_examine_ui_close() -> void:
	if isUiEximineOpen:
		get_tree().paused = false
		isUiEximineOpen = false
		ui_examine.visible = false
