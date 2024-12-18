extends Area2D

@export var rightNpc: bool
@export var dialogs: Dialog
@export var nama: String

var dialog: String
var canInteract: bool

func _ready() -> void:
	if rightNpc:
		if dialogs.right_dialogs.size() > 0:
			var index = randi_range(0, dialogs.right_dialogs.size()-1)
			
			dialog = dialogs.right_dialogs[index]
			dialogs.right_dialogs.remove_at(index)
	else:
		if dialogs.wrong_dialogs.size() > 0:
			var index = randi_range(0, dialogs.wrong_dialogs.size()-1)
			
			dialog = dialogs.wrong_dialogs[index]
			dialogs.wrong_dialogs.remove_at(index)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		canInteract = true

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		canInteract = false
		
func _unhandled_input(event: InputEvent) -> void:
	if canInteract and Input.is_action_just_pressed("interact"):
		#TODO: kalau tidak ada dialog ada animasi pesan kosong
		if dialog:
			get_tree().get_root().get_node("./Main/CanvasLayer").open_ui_chat(self)
