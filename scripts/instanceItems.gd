extends Area2D

@export var Items:Array[PackedScene]

var player
var canInteract: bool

func _ready() -> void:
	for i in Items:
		i.instantiate()
	print_debug(Items)
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = body
		canInteract = true

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		canInteract = false

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact") and canInteract:
		for i in Items:
			var data = i.instantiate()
			player.interactItem.append(data)
		player.interact()
