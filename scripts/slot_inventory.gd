extends Button

signal item_clicked(data)
signal examining_item(item)

@onready var bg: Sprite2D = $Bg
@onready var center_container: CenterContainer = $CenterContainer

var index:int
var slotGui: InventoryGui

func insert(sg:InventoryGui)->void:
	slotGui = sg
	bg.frame = 0 #frame jika ada data
	center_container.add_child(slotGui)
	slotGui.update()

func _on_pressed() -> void:
	pass

func reset_ui():
	if slotGui:
		center_container.remove_child(slotGui)
		bg.frame = 1
		slotGui = null

func _on_gui_input(event: InputEvent) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		item_clicked.emit(self)
	elif Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT) and slotGui:
#region New Code Region HACK: bentuk data dalam dict karena awalnya pakai node obj dalam var data
		var data = {
			"data": slotGui.data
		}
#endregion
		if slotGui.data.lockpick > 0:
			Global.localpickIndex = index
			
		examining_item.emit([data])
