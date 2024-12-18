extends CharacterBody2D

signal interacting(item)

@export var speed:int
@export var Backpack:Resource

var interactItem:Array

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed * delta

	move_and_slide()
		
func _input(event: InputEvent) -> void:
	if interactItem and Input.is_action_just_pressed("interact"):
		interacting.emit(interactItem)
		interactItem = []
#		HACK: uji interactItem: SUCCESS
	#if Input.is_action_just_pressed("interact"):
		#interacting.emit(["a","b"])

func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("item"):
		interactItem.append(area)

func _on_hurtbox_area_exited(area: Area2D) -> void:
	if area.is_in_group("item"):
		interactItem.erase(area)

func interact()->void:
	if interactItem:
		interacting.emit(interactItem)
		interactItem = []
