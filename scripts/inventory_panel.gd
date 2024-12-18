extends Panel

class_name InventoryGui

@onready var icon: TextureRect = $Icon
@onready var nama: Label = $Nama

var data:Item

func update()->void:
	if !data || !data.name : return
#HACK: suddenly it's works tf
	nama.text = data.name
	icon.visible = true
	icon.texture = data.texture
