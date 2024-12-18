extends Control

signal close_chat()

@onready var dialog: RichTextLabel = $NinePatchRect/Dialog
@onready var nama: RichTextLabel = $NinePatchRect/Nama

func _on_close_pressed() -> void:
	close_chat.emit()

func proses_chat(npc)->void:
	nama.text = npc.nama
	dialog.text = npc.dialog
