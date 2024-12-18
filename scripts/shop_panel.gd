extends TextureRect

signal buying(item)

@onready var nama: RichTextLabel = $Nama
@onready var deskripsi: RichTextLabel = $Deskripsi
@onready var icon: TextureRect = $Icon

var data: Item

func setting_data():
	icon.texture = data.texture
	deskripsi.text = data.description
	nama.text = data.name

func _on_buy_pressed() -> void:
	buying.emit(self)
